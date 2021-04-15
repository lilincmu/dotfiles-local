MACBOOK_MONITOR = 'Retina Display'
MIDDLE_MONITOR = 'LG Ultra HD'

LAYOUT_HOME = {
    {'Calendar', MACBOOK_MONITOR, 1, hs.geometry.unitrect(0, 0, 1, 1)},
    {'Google Chrome', MIDDLE_MONITOR, 1, hs.geometry.unitrect(0, 0, 1, 1)},
    {'Microsoft OneNote', MIDDLE_MONITOR, 3, hs.geometry.unitrect(0, 0, 1, 1)},
    {'Terminal', MIDDLE_MONITOR, 3, hs.geometry.rect(300, 150, 650, 800)},
    {'Code', MIDDLE_MONITOR, 2, hs.geometry.unitrect(0, 0, 1, 1)},
}

LAYOUT_LAPTOP = {
    {'Calendar', MACBOOK_MONITOR, 1, hs.geometry.unitrect(0, 0, 1, 1)},
    {'Google Chrome', MACBOOK_MONITOR, 1, hs.geometry.unitrect(0, 0, 1, 1)},
    {'Microsoft OneNote', MACBOOK_MONITOR, 3, hs.geometry.unitrect(0, 0, 1, 1)},
    {'Terminal', MACBOOK_MONITOR, 3, hs.geometry.rect(150, 0, 650, 800)},
    {'Code', MACBOOK_MONITOR, 2, hs.geometry.unitrect(0, 0, 1, 1)},
}