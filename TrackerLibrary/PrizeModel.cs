using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace TrackerLibrary
{
    public class PrizeModel
    {
        /// <summary>
        /// The unique identifier for the prize.
        /// </summary>
        public int Id { get; set; }
        /// <summary>
        /// The numeric identifier for the position (3 for third position etc.)
        /// </summary>
        public int PlaceNumber { get; set; }

        /// <summary>
        /// The string identifier for positon name (third position, second position etc)
        /// </summary>
        public string PlaceName { get; set; }

        /// <summary>
        /// The fixed amount this position earns or zero if it is not used
        /// </summary>
        public decimal PrizeAmount { get; set; }

        /// <summary>
        /// The number that represents the percentage of the overall take or
        /// zero if it is not used.
        /// </summary>
        public double PrizePercentage { get; set; }
        public PrizeModel()
        {

        }

        public PrizeModel(string placeName, string placeNumber, string przeAmount, string prizePercentage) 
        {
            PlaceName = placeName;

            int placeNumberValue = 0;
            int.TryParse(placeNumber,out placeNumberValue);
            PlaceNumber = placeNumberValue;

            decimal prizeAmountValue = 0;
            decimal.TryParse(przeAmount, out prizeAmountValue);
            PrizeAmount = prizeAmountValue;

            double prizePercentageValue = 0;
            double.TryParse(prizePercentage,out prizePercentageValue);
            PrizePercentage = prizePercentageValue;


        }
    }
}