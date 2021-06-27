MACBOOK_MONITOR = 'Retina Display'
MIDDLE_MONITOR = 'LG Ultra HD'
LEFT_MONITOR = 'L28u'

LAYOUT_OFFICE = {
    {'zoom.us', MACBOOK_MONITOR, 1, hs.geometry.rect(160, 0, 1080, 780)},
    {'Google Chrome', MIDDLE_MONITOR, 1, hs.geometry.unitrect(0, 0, 1, 1)},
    {'Terminal', MIDDLE_MONITOR, 1, hs.geometry.rect(700, 150, 1010, 1133)},
    {'IntelliJ IDEA', MIDDLE_MONITOR, 2, hs.geometry.unitrect(0, 0, 1, 1)},
    {'Slack', LEFT_MONITOR, 1, hs.geometry.unitrect(0.2, 0, 1, 1)},
    {'Microsoft OneNote', LEFT_MONITOR, 2, hs.geometry.unitrect(0, 0, 0.35, 1)},
    {'Atom', LEFT_MONITOR, 2, hs.geometry.unitrect(0.35, 0, 1, 1)},
}

LAYOUT_HOME = {
    {'Calendar', MIDDLE_MONITOR, 1, hs.geometry.unitrect(0, 0, 1, 1)},
    {'Google Chrome', MIDDLE_MONITOR, 2, hs.geometry.unitrect(0, 0, 1, 1)},
    {'Terminal', MIDDLE_MONITOR, 2, hs.geometry.rect(600, 150, 650, 750)},
    {'Code', MIDDLE_MONITOR, 3, hs.geometry.unitrect(0, 0, 1, 1)},
    {'Microsoft OneNote', MIDDLE_MONITOR, 4, hs.geometry.unitrect(0, 0, 1, 1)},
}

LAYOUT_LAPTOP = {
    {'Calendar', MACBOOK_MONITOR, 1, hs.geometry.unitrect(0, 0, 1, 1)},
    {'Google Chrome', MACBOOK_MONITOR, 2, hs.geometry.unitrect(0, 0, 1, 1)},
    {'Terminal', MACBOOK_MONITOR, 2, hs.geometry.rect(300, 0, 650, 750)},
    {'Code', MACBOOK_MONITOR, 3, hs.geometry.unitrect(0, 0, 1, 1)},
    {'Microsoft OneNote', MACBOOK_MONITOR, 4, hs.geometry.unitrect(0, 0, 1, 1)},
}