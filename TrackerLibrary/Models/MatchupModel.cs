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
        /// The winner of this match
        /// </summary>
        public TeamModel winner { get; set; }
        
        /// <summary>
        /// The numeric value of the current match up round
        /// </summary>
        public int MatchupRound { get; set; }
    }
}