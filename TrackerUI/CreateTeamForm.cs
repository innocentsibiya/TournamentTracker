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
    public partial class CreateTeamForm : Form
    {
        private List<PersonModel> availableTeamMembers = GlobalConfig.Connection.GetPersonAll();
        private List<PersonModel> selectedTeamMembers = new List<PersonModel>();
        private ITeamRequester callingForm;
     public CreateTeamForm(ITeamRequester caller)
        {
            InitializeComponent();

            callingForm = caller;

            //CreateSampleData();

            WireUpLists();
        }

        public void CreateSampleData() 
        {
            availableTeamMembers.Add(new PersonModel {  FirstName = "Innoh", LastName = "Cbia"});
            availableTeamMembers.Add(new PersonModel { FirstName = "Innocent", LastName = "Sibiya" });

            selectedTeamMembers.Add(new PersonModel { FirstName = "Joe", LastName = "Doe" });
            selectedTeamMembers.Add(new PersonModel { FirstName = "John", LastName = "Smith" });

        }
        private void WireUpLists() 
        {
            selectTeamMemberDropDown.DataSource = null;

            selectTeamMemberDropDown.DataSource = availableTeamMembers;
            selectTeamMemberDropDown.DisplayMember = "FullName";

            teamMembersListBox.DataSource = null;

            teamMembersListBox.DataSource = selectedTeamMembers;
            teamMembersListBox.DisplayMember = "FullName";
        }

        private void createMemberButton_Click(object sender, EventArgs e)
        {
            if (ValidateForm()) 
            {
                PersonModel p = new PersonModel();

                p.FirstName = firstNameValue.Text;
                p.LastName = lastNameValue.Text;
                p.EmailAddress = emailValue.Text;
                p.CellphoneNumber = cellphoneValue.Text;

                p = GlobalConfig.Connection.CreatePerson(p);

                selectedTeamMembers.Add(p);

                WireUpLists();

                firstNameValue.Text = "";
                lastNameValue.Text = "";
                emailValue.Text = "";
                cellphoneValue.Text = "";

            }
            else 
            {
                MessageBox.Show("You need to fill in all of the fields");
            }

        }

        private bool ValidateForm() 
        {
            if (firstNameValue.Text.Length == 0) 
            {
                return false;
            }
            if (lastNameValue.Text.Length == 0)
            {
                return false;
            }
            if (emailValue.Text.Length == 0)
            {
                return false;
            }
            if (cellphoneValue.Text.Length == 0)
            {
                return false;
            }

            return true;
        }

        private void addMemberButton_Click(object sender, EventArgs e)
        {
            PersonModel person = (PersonModel)selectTeamMemberDropDown.SelectedItem;

            if (person != null)
            {
                availableTeamMembers.Remove(person);
                selectedTeamMembers.Add(person);

                WireUpLists(); 
            }
        
        }

        private void removeSelectedMemberButton_Click(object sender, EventArgs e)
        {
             PersonModel person = (PersonModel)teamMembersListBox.SelectedItem;

            if (person != null)
            {
                selectedTeamMembers.Remove(person);
                availableTeamMembers.Add(person);

                WireUpLists(); 
            }

        }

        private void createTeamButton_Click(object sender, EventArgs e)
        {
            TeamModel team = new TeamModel();

            team.TeamName = teamNameValue.Text;
            team.TeamMembers = selectedTeamMembers;

            GlobalConfig.Connection.CreateTeam(team);

            callingForm.TeamComplete(team);

            this.Close();
        }
    }
}
