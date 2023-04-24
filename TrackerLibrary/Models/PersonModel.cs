using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace TrackerLibrary.Models
{
    public class PersonModel
    {
        /// <summary>
        /// The unique identifier for the person.
        /// </summary>
        public int Id { get; set; }

        /// <summary>
        /// The first name for the person
        /// </summary>
        public string FirstName { get; set; }

        /// <summary>
        /// The last name for the person
        /// </summary>
        public string LastName { get; set; }

        /// <summary>
        /// The email address for the person
        /// </summary>
        public string EmailAddress { get; set; }

        /// <summary>
        /// The cell phone number for the person
        /// </summary>
        public string CellphoneNumber { get; set; }

        public string FullName 
        {
            get 
            {
                return $"{ FirstName } { LastName }";
            }
        }
    }
}