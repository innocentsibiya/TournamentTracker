using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace TrackerLibrary.Models
{
    public class MatchupModel
    {
        /// <summary>
        /// The unique identifier for the match.
        /// </summary>
        public int Id { get; set; }
        
        /// <summary>
        /// The list of teams that are involved in this match
        /// </summary>
        public List<MatchupEntryModel> Entries { get; set; } = new List<MatchupEntryModel>();

        /// <summary>
        /// The Id from the database that will be used to identify winner
        /// </summary>
        public int WinnerId { get; set; }

        /// <summary>
        /// The winner of this match
        /// </summary>
        public TeamModel Winner { get; set; }
        
        /// <summary>
        /// The numeric value of the current match up round
        /// </summary>
        public int MatchupRound { get; set; }
    }
}