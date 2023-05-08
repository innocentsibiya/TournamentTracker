using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace TrackerLibrary.Models
{
    public class TeamModel
    {
        /// <summary>
        /// The unique identifier for this team.
        /// </summary>
        public int Id { get; set; }
        /// <summary>
        /// The name given to this team
        /// </summary>
        public string TeamName { get; set; }
        /// <summary>
        /// The list of members in this team 
        /// </summary>
        public List<PersonModel> TeamMembers { get; set; } = new List<PersonModel>();
    }
}