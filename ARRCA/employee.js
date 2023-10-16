frappe.ui.form.on('Employee Education', {
  graduating_year: function(frm) {
    var graduatingYear = frm.doc.graduating_year;
    if (graduatingYear) {
      var ethiopianDate = gregorianToEthiopian(graduatingYear);
      frm.set_value('ethiopian_date', `${ethiopianDate.year}-${ethiopianDate.month}-${ethiopianDate.day}`);
    }
  }
});




function gregorianToEthiopian(dateString) {
  const parts = dateString.split('-');
  const gregorianDay = parseInt(parts[0], 10);
  const gregorianMonth = parseInt(parts[1], 10);
  const gregorianYear = parseInt(parts[2], 10);

  // Calculate the Julian date for the given Gregorian date
  const jd = ( (1723856.5 + 
    (gregorianYear - 1) * 365 +
    Math.floor((gregorianYear - 1) / 4) +
    gregorianDay +
    Math.floor(367 * gregorianMonth - 362) -
    Math.floor((gregorianYear + 299) / 100) +
    Math.floor((gregorianYear + 299) / 400) ) | 0 ) - 1;

  // Calculate the Ethiopian year, month, and day
  const jdn = jd - 1723855;
  const year = Math.floor((4 * jdn + 3) / 1461);
  const day = jdn - Math.floor((1461 * year) / 4);
  const month = Math.floor((day + 2) / 30) + 1;
  const dayInMonth = day - Math.floor((month - 1) * 30) + 1;

  return { year, month, day: dayInMonth };
}
