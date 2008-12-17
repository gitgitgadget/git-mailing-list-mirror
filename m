From: Henk <henk_westhuis@hotmail.com>
Subject: Announcement: Git Extensions stable (windows shell extensions)
Date: Wed, 17 Dec 2008 11:06:53 -0800 (PST)
Message-ID: <1229540813648-1669264.post@n2.nabble.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Dec 17 20:08:25 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LD1kk-0005U9-NV
	for gcvg-git-2@gmane.org; Wed, 17 Dec 2008 20:08:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751257AbYLQTG4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 17 Dec 2008 14:06:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751217AbYLQTG4
	(ORCPT <rfc822;git-outgoing>); Wed, 17 Dec 2008 14:06:56 -0500
Received: from kuber.nabble.com ([216.139.236.158]:45155 "EHLO
	kuber.nabble.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751169AbYLQTGz (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 17 Dec 2008 14:06:55 -0500
Received: from tervel.nabble.com ([192.168.236.150])
	by kuber.nabble.com with esmtp (Exim 4.63)
	(envelope-from <lists+1217463532682-661346@n2.nabble.com>)
	id 1LD1jR-0005MY-L9
	for git@vger.kernel.org; Wed, 17 Dec 2008 11:06:53 -0800
X-Nabble-From: henk_westhuis@hotmail.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/103371>


This is a shameless announcement of my latest personal project; Git
Extensions. Git Extensions is a Tortoise-like windows shell extension for
git. Yesterday I finished version 0.9, the first stable release. I included
about all git commands I know about, so I think it is pretty complete but
I'm open to suggestions. 
 
It is written mostly in C#, except for shell extension part which is written
in C++. The project is open source, the sources can be found on GitHub. In
case there is someone interrested in the sources, be warned; the sources are
not very well documented yet and the solution is a still bit messy, I will
clean this up very soon. 
 
Main features
- Shell extensions
- Visual studio plugin
- Seperate git application
 
Features:
- Browse repository (incl. visual graph)
- Add files
- Apply patch
- Checkout branch/revision
- Cherry pick
- Create branch/tag
- Delete branch/tag
- Clone
- Commit
- Create (format) patch
- Init new repository
- Merge branches
- Pull
- Push
- Run mergetool
- Stash
- View differences
 
Information about the project and a installer package can be found here:
http://sourceforge.net/projects/gitextensions/
The installation requires msysgit to be installed AND git.exe to in the
system path.

ps.
I know there is a TortoiseGit project also, I just didn't know about that at
the time I started. If I knew about TortoiseGit, I probably never started
writing my own tool.
-- 
View this message in context: http://n2.nabble.com/Announcement%3A-Git-Extensions-stable-%28windows-shell-extensions%29-tp1669264p1669264.html
Sent from the git mailing list archive at Nabble.com.
