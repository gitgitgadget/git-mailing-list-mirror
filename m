From: Kai Schlamp <schlamp@gmx.de>
Subject: Change git gui language (+ some other suggestions)
Date: Fri, 17 Apr 2009 16:32:36 +0200
Message-ID: <49E89304.9060303@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Apr 17 16:41:10 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LupFW-0000wS-A5
	for gcvg-git-2@gmane.org; Fri, 17 Apr 2009 16:41:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760944AbZDQOjc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 17 Apr 2009 10:39:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756821AbZDQOjc
	(ORCPT <rfc822;git-outgoing>); Fri, 17 Apr 2009 10:39:32 -0400
Received: from ne31036.nerionics.de ([85.88.31.36]:55945 "EHLO
	ne31036.nerionics.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756560AbZDQOjb (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 17 Apr 2009 10:39:31 -0400
X-Greylist: delayed 402 seconds by postgrey-1.27 at vger.kernel.org; Fri, 17 Apr 2009 10:39:30 EDT
Received: (qmail 24543 invoked from network); 17 Apr 2009 14:32:46 +0000
Received: from p54a8f090.dip.t-dialin.net (HELO ?192.168.2.33?) (84.168.240.144)
  by ne31036.nerionics.de with SMTP; 17 Apr 2009 14:32:46 +0000
User-Agent: Thunderbird 2.0.0.21 (Windows/20090302)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/116740>

Hello.

I know this had been discussed before
(http://article.gmane.org/gmane.comp.version-control.git/61884/match=git+gui+language), 


but in my opinion there is no acceptable solution yet.
When I set LANG=en it also changes my keyboard layout and thats quite
confusing. But the German terms used in git gui are even more confusing
(I was even shocked when starting it the first time). People using git
generally know what e.g. "commit" is. But the german translation
("Eintragen") seems to me a bad joke. I had to look at some screenshots
of the english gui to find out what it is all about.
I would suggest to keep the git idenfiers (like commit, push, pull,
....) in foreign languages.
And please have an option to choose the language of the complete gui.
Most developers I know of like to use tools in english, even if that is
not their native language.
Another thing I miss a bit is an option to select old commit messages
(like the TortoiseHg client of the Mercurial project has).
And a last one. It would be nice to have a menu item to add all
untracked files at once. I had to add my own "Tool" for that.
But apart from that (to not only nag ;-)), git gui is quite comfortable.

Fine regards,
Kai
