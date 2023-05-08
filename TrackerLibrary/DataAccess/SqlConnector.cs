using Dapper;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using TrackerLibrary.Models;

namespace TrackerLibrary.DataAccess
{
    public class SqlConnector : IDataConnection
    {
        private const string db = "Tournaments";
        public PersonModel CreatePerson(PersonModel model)
        {
            using (IDbConnection connection = new System.Data.SqlClient.SqlConnection(GlobalConfig.ConString(db)))
            {
                var p = new DynamicParameters();
                p.Add("@FirstName", model.FirstName);
                p.Add("@LastName", model.LastName);
                p.Add("@EmailAddress", model.EmailAddress);
                p.Add("@CellphoneNumber", model.CellphoneNumber);
                p.Add("@Id", 0, dbType: DbType.Int32, direction: ParameterDirection.Output);

                connection.Execute("dbo.spPeople_Insert", p, commandType: CommandType.StoredProcedure);

                model.Id = p.Get<int>("@Id");

                return model;
            }
        }

        /// <summary>
        /// Saves a new prize to the database
        /// </summary>
        /// <param name="model">the prize information</param>
        /// <returns>The prize information, including the unique identifier</returns>
        public PrizeModel CreatePrize(PrizeModel model)
        {
            //using this prevents memory leaks by closing the sql connection when done using Tournaments
            using (IDbConnection connection = new System.Data.SqlClient.SqlConnection(GlobalConfig.ConString(db)))
            {
                var p = new DynamicParameters();
                p.Add("@PlaceNumber",model.PlaceNumber);
                p.Add("@PlaceName", model.PlaceName);
                p.Add("@PrizeAmount", model.PrizeAmount);
                p.Add("@PrizePercentage", model.PrizePercentage);
                p.Add("@Id", 0, dbType: DbType.Int32, direction: ParameterDirection.Output);

                connection.Execute("dbo.spPrizes_Insert", p, commandType: CommandType.StoredProcedure);

                model.Id = p.Get<int>("@Id");

                return model;
            }
        }

        public TeamModel CreateTeam(TeamModel model)
        {
            using (IDbConnection connection = new System.Data.SqlClient.SqlConnection(GlobalConfig.ConString(db)))
            {
                var p = new DynamicParameters();
                p.Add("@TeamName", model.TeamName);
                p.Add("@Id", 0, dbType: DbType.Int32, direction: ParameterDirection.Output);

                connection.Execute("dbo.spTeam_Insert", p, commandType: CommandType.StoredProcedure);

                model.Id = p.Get<int>("@Id");

                foreach (PersonModel tm in model.TeamMembers)
                {
                    p = new DynamicParameters();
                    p.Add("@TeamName", model.Id);
                    p.Add("@PersonId", tm.Id);

                    connection.Execute("dbo.spTeamMembers_Insert", p, commandType: CommandType.StoredProcedure);
                }
                return model;
            }
        }

        public void CreateTournament(TournamentModel model)
        {

            using (IDbConnection connection = new System.Data.SqlClient.SqlConnection(GlobalConfig.ConString(db)))
            {
                SaveTournament(connection,model);
                SaveTournamentPrizes(connection, model);
                SaveTournamentEntries(connection, model);

            }
        }

        private void SaveTournament(IDbConnection connection,TournamentModel model) 
        {
            var p = new DynamicParameters();
            p.Add("@TournamentName", model.TournamentName);
            p.Add("@EntryFee", model.EntryFee);
            p.Add("@Id", 0, dbType: DbType.Int32, direction: ParameterDirection.Output);

            connection.Execute("dbo.spTournaments_Insert", p, commandType: CommandType.StoredProcedure);

            model.Id = p.Get<int>("@Id");
        }
        private void SaveTournamentPrizes(IDbConnection connection, TournamentModel model)
        {
            var p = new DynamicParameters();
            foreach (PrizeModel pz in model.Prizes)
            {
                p = new DynamicParameters();
                p.Add("@TournamentId", model.Id);
                p.Add("@PrizeId", pz.Id);
                p.Add("@Id", 0, dbType: DbType.Int32, direction: ParameterDirection.Output);

                connection.Execute("dbo.spTournamentPrizes_Insert", p, commandType: CommandType.StoredProcedure);
            }
        }
        private void SaveTournamentEntries(IDbConnection connection, TournamentModel model)
        {
            var p = new DynamicParameters();
            foreach (TeamModel team in model.EnteredTeams)
            {
                p = new DynamicParameters();
                p.Add("@TournamentId", model.Id);
                p.Add("@TeamId", team.Id);
                p.Add("@Id", 0, dbType: DbType.Int32, direction: ParameterDirection.Output);

                connection.Execute("dbo.spTournamentEntries_Insert", p, commandType: CommandType.StoredProcedure);
            }
        }
        public List<TeamModel> GeatTeam_All()
        {
            List<TeamModel> output;

            using (IDbConnection connection = new System.Data.SqlClient.SqlConnection(GlobalConfig.ConString(db)))
            {
                output = connection.Query<TeamModel>("dbo.spTeam_GetAll").ToList();

                foreach (TeamModel team in output)
                {
                    var p = new DynamicParameters();
                    p.Add("@TeamId", team.Id);
                    team.TeamMembers = connection.Query<PersonModel>("dbo.spTeamMembers_GetByTeam",p, commandType: CommandType.StoredProcedure).ToList();
                }
            }

            return output;
        }

        public List<PersonModel> GetPersonAll()
        {
            List<PersonModel> output;

            using(IDbConnection connection = new System.Data.SqlClient.SqlConnection(GlobalConfig.ConString(db)))
            {
                output = connection.Query<PersonModel>("dbo.spPeople_GetAll").ToList();
            }

            return output;
        }
    }
}
