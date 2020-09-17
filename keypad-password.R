# password: string of password alphanumeric characters
# keypad: one-dimensional rowwise string representation of (n x m) keypad
# keypad_rows: number of rows (the n dimension) of keypad

# An (n x m)-dimensional keypad is laid out with an arbitrary
# assortment of mixed alphanumeric characters.  Moving from one key
# to another takes time.  Adjacent keys (including diagonals) takes 1
# second, with each additional adjacent key taking an additional 1 second
# to reach.

# Goal: how long does it take to enter an arbitrary password on an
# arbitrary keypad?

password_time <- function(password, keypad, keypad_rows) {
  keypad_length <- nchar(keypad)
  if(keypad_length %% keypad_rows > 0) stop("Keypad is not rectangular.")

  keypad_cols <- keypad_length / keypad_rows
  
  key_coords <- matrix(c(rep(1:keypad_rows, each = keypad_cols),
                         rep(1:keypad_cols, times = keypad_rows)),
                       ncol = 2,
                       dimnames = list(unlist(strsplit(keypad, "")),
                                       c("row", "col")))
  
  
  pwd <- unlist(strsplit(password, ""))
  row_coord_change <- key_coords[pwd, "row"]
  col_coord_change <- key_coords[pwd, "col"]
  
  row_diffs <- diff(row_coord_change)
  col_diffs <- diff(col_coord_change)

  time_per_movement <- pmax(row_diffs, col_diffs)
  total_time <- sum(time_per_movement)
  
  total_time
}