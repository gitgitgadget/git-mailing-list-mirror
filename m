From: Zabre <427@free.fr>
Subject: Force commit date
Date: Thu, 29 Jan 2009 10:30:17 -0800 (PST)
Message-ID: <1233253817209-2240539.post@n2.nabble.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jan 29 19:31:57 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LSbg1-0007MF-Kb
	for gcvg-git-2@gmane.org; Thu, 29 Jan 2009 19:31:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752340AbZA2SaT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 29 Jan 2009 13:30:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751323AbZA2SaS
	(ORCPT <rfc822;git-outgoing>); Thu, 29 Jan 2009 13:30:18 -0500
Received: from kuber.nabble.com ([216.139.236.158]:48479 "EHLO
	kuber.nabble.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751769AbZA2SaS (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 29 Jan 2009 13:30:18 -0500
Received: from tervel.nabble.com ([192.168.236.150])
	by kuber.nabble.com with esmtp (Exim 4.63)
	(envelope-from <lists+1217463532682-661346@n2.nabble.com>)
	id 1LSbeb-0006Hy-70
	for git@vger.kernel.org; Thu, 29 Jan 2009 10:30:17 -0800
X-Nabble-From: 427@free.fr
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/107708>


Hi all,

Some time ago, I used to make 7zip backups of my project directory to keep
an history of my changes. (I've kept all of them in separated 7z files) I
was then living in darkness. (Even though I tried svn but was somehow not
happy with it) Now I've found the light, and git is the best tool around
(along with Hg I guess).

I am learning git at the moment and I would like to restore all my 7zipped
backups one after the other, use meld to apply each change in the code +
directory structure and then git to commit each of them, chronologically, to
finally obtain a complete git history of my changes (I even have "commit
commentaries" in a special text file, yes I tried to do things properly with
basic tools.)

This should be feasible, but what would be very cool in this very special
case is if I could force the commit date to reflect the real date each
"commit" (read : "zip") was done with my old method in last year, and not
the date of my convertion to git.

If it is not, that's not a big deal, but I'd really like to know how to do
this, and have my different projects on a git history. (I even have one or
two "secondary branches")

There might be an option I am not aware of.
(I have seen on this forum / mailing list some people playing with dates but
it was the case of mailboxes and "git am")
http://n2.nabble.com/how-to-force-a-commit-date-matching-info-from-a-mbox---td2200613.html
Remember I'm a beginner trying to learn git, so please bear with me.

Thank you!
-- 
View this message in context: http://n2.nabble.com/Force-commit-date-tp2240539p2240539.html
Sent from the git mailing list archive at Nabble.com.
