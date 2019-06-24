/*
* Copyright (c) {{yearrange}} Alex ()
*
* This program is free software; you can redistribute it and/or
* modify it under the terms of the GNU General Public
* License as published by the Free Software Foundation; either
* version 2 of the License, or (at your option) any later version.
*
* This program is distributed in the hope that it will be useful,
* but WITHOUT ANY WARRANTY; without even the implied warranty of
* MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
* General Public License for more details.
*
* You should have received a copy of the GNU General Public
* License along with this program; if not, write to the
* Free Software Foundation, Inc., 51 Franklin Street, Fifth Floor,
* Boston, MA 02110-1301 USA
*
* Authored by: Alex Angelou <>
*/
using Granite;
using Granite.Widgets;
using Gtk;

namespace View.Widgets {

    public class InfoSectionMisc : InfoSection {

        private SimpleMenu menu;

        public InfoSectionMisc (string title) {
            base (title);
        }

        construct {
            menu = new SimpleMenu (add_button);
            foreach (var data in DataHelper.Type.MISC) {
                menu.append (data.to_string ());
            }
            menu.poped_down.connect ((data) => {
                var parsed_data = DataHelper.Type.parse (data);
                switch (parsed_data) {
                    case NICKNAME:
                    case NOTES:
                    case WEBSITE:
                        new_entry_without_type ("", data);
                    break;
                    case BIRTHDAY:
                        new_entry_calendar (null, null, null, DataHelper.Type.BIRTHDAY.to_string ());
                        break;
                }
            });
        }

        protected override void add_button_action () {
            menu.popup ();
            menu.show_all ();
        }

        public void new_entry_without_type (string data, string type) {
            var entry = new EditableLabelNoType (data, type);
            _new_entry (entry);
        }

        public void new_entry_calendar (uint? day, uint? month, uint? year, string type) {
            var entry = new EditableLabelDate (day, month, year, type);
            _new_entry (entry);
        }
    }
}
