// /* extension.js
//  *
//  * This program is free software: you can redistribute it and/or modify
//  * it under the terms of the GNU General Public License as published by
//  * the Free Software Foundation, either version 2 of the License, or
//  * (at your option) any later version.
//  *
//  * This program is distributed in the hope that it will be useful,
//  * but WITHOUT ANY WARRANTY; without even the implied warranty of
//  * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
//  * GNU General Public License for more details.
//  *
//  * You should have received a copy of the GNU General Public License
//  * along with this program.  If not, see <http://www.gnu.org/licenses/>.
//  *
//  * SPDX-License-Identifier: GPL-2.0-or-later
//  */

// /* exported init */

const MessageTray = imports.ui.messageTray;

const _originalCreateBanner = MessageTray.Notification.prototype.createBanner;

function _customCreateBanner() {
  const banner = this.source.createBanner(this);
  banner.actor.setIcon(null);
  return banner;
}

function enable() {
  MessageTray.Notification.prototype.createBanner = _customCreateBanner;
}

function disable() {
  MessageTray.Notification.prototype.createBanner = _originalCreateBanner;
}

function init() {
}
