class Helm
  # The C array in the original
  # C(9,2), in which the direction was the first dimension,
  # and the offsets were stored in the second dimension, with
  # 1 = y and 2 = x for some reason.
  CALCULATOR = {
    1 => { x: 1, y: 0 },
    2 => { x: 1, y: -1 },
    3 => { x: 0, y: -1 },
    4 => { x: -1, y: -1 },
    5 => { x: -1, y: 0 },
    6 => { x: -1, y: 1 },
    7 => { x: 0, y: 1 },
    8 => { x: 1, y: 1 },
    9 => { x: 1, y: 0 }
  }
end
