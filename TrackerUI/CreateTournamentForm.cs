using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;
using TrackerLibrary;
using TrackerLibrary.Models;

namespace TrackerUI
{
    public partial class CreateTournamentForm : Form, IPrizeRequester, ITeamRequester
    {
        List<TeamModel> availableTeams = GlobalConfig.Connection.GeatTeam_All();
        List<TeamModel> selectedTeames = new List<TeamModel>();
        List<PrizeModel> selectedPrizes = new List<PrizeModel>();
        public CreateTournamentForm()
        {
            InitializeComponent();
            WireUpLists();
        }


        private void WireUpLists() 
        {
            selectTeamDropDown.DataSource = null;
            selectTeamDropDown.DataSource = availableTeams;
            selectTeamDropDown.DisplayMember = "TeamName";

            tournamentTeamsListBox.DataSource = null;
            tournamentTeamsListBox.DataSource = selectedTeames;
            tournamentTeamsListBox.DisplayMember = "TeamName";

            prizesListBox.DataSource = null;
            prizesListBox.DataSource = selectedPrizes;
            prizesListBox.DisplayMember = "PlaceName";
        }

        private void addTeamButton_Click(object sender, EventArgs e)
        {
            TeamModel t = (TeamModel)selectTeamDropDown.SelectedItem;

            if (t != null) 
            {
                availableTeams.Remove(t);
                selectedTeames.Add(t);

                WireUpLists();
            }
        }

        private void createPrizeButton_Click(object sender, EventArgs e)
        {

            //Call the CreatePrizeForm
            CreatePrizeForm frm = new CreatePrizeForm(this);
            frm.Show();
        }

        public void PrizeComplete(PrizeModel model)
        {
            //Get back from the form a PrizeModel
            //Take the PrizeModel and add it into our selected prizes list

            selectedPrizes.Add(model);
            WireUpLists();
        }

        private void createNewTeamLink_LinkClicked(object sender, LinkLabelLinkClickedEventArgs e)
        {
            //Call the CreateTeamForm
            CreateTeamForm frm = new CreateTeamForm(this);
            frm.Show();
        }

        public void TeamComplete(TeamModel model)
        {
            selectedTeames.Add(model);
            WireUpLists();
        }

        private void removeSelectedTeamButton_Click(object sender, EventArgs e)
        {
            TeamModel team = (TeamModel)tournamentTeamsListBox.SelectedItem;

            if (team != null)
            {
                selectedTeames.Remove(team);
                availableTeams.Add(team);

                WireUpLists();
            }
        }

        private void removeSelectedPrizeButton_Click(object sender, EventArgs e)
        {
            PrizeModel prize = (PrizeModel)prizesListBox.SelectedItem;

            if (prize != null)
            {
                selectedPrizes.Remove(prize);

                WireUpLists();
            }
        }

        private void createTournamentButton_Click(object sender, EventArgs e)
        {
            //validate data
            decimal fee = 0;

            bool feeAcceptable = decimal.TryParse(entryFeeValue.Text, out fee);

            if (!feeAcceptable) 
            {
                MessageBox.Show("You need to enter a valid Entry Fee","Invalid Fee",MessageBoxButtons.OK,MessageBoxIcon.Error);
                return;
            }
            //create tournament model
            TournamentModel tm = new TournamentModel();
            tm.TournamentName = tournamentNameValue.Text;
            tm.EntryFee = fee;
            tm.Prizes = selectedPrizes;
            tm.EnteredTeams = selectedTeames;

            //TODO wireup matchups
            TournamentLogic.CreateRounds(tm);
            //Create tournament entry

            //create all of the prize entries

            //create all of team entries

            //create match ups

            GlobalConfig.Connection.CreateTournament(tm);

        }
    }
}
