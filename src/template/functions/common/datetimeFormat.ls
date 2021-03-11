F.datetimeFormat = (date)-> 
    return '' unless date
    date = new Date date
    date.toLocaleString!
