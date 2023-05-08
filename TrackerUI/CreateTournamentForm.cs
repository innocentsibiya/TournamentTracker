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
    public partial class CreateTournamentForm : Form
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
            selectTeamDropDown.SelectedItem = "TeamName";

            tournamentTeamsListBox.DataSource = null;
            tournamentTeamsListBox.DataSource = selectedTeames;
            tournamentTeamsListBox.SelectedItem = "TeamName";

            prizesListBox.DataSource = null;
            prizesListBox.DataSource = selectedPrizes;
            prizesListBox.SelectedItem = "PlaceName";
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
    }
}
