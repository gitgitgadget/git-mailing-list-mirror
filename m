From: merlyn@stonehenge.com (Randal L. Schwartz)
Subject: Re: Many gits are offline this week
Date: Sun, 07 Oct 2007 12:37:10 -0700
Message-ID: <86ve9i1ztl.fsf@blue.stonehenge.com>
References: <20071005010448.GQ2137@spearce.org>
	<863awq5p1y.fsf@blue.stonehenge.com>
	<4d8e3fd30710050214j135260cn842ee7396a3d63c7@mail.gmail.com>
	<86tzp54sez.fsf@blue.stonehenge.com>
	<20071007170153.GX2137@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Paolo Ciarrocchi <paolo.ciarrocchi@gmail.com>, git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Sun Oct 07 21:37:39 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IebwR-0002mt-6T
	for gcvg-git-2@gmane.org; Sun, 07 Oct 2007 21:37:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756139AbXJGThM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 7 Oct 2007 15:37:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753307AbXJGThM
	(ORCPT <rfc822;git-outgoing>); Sun, 7 Oct 2007 15:37:12 -0400
Received: from blue.stonehenge.com ([209.223.236.162]:41494 "EHLO
	blue.stonehenge.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754344AbXJGThL (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 7 Oct 2007 15:37:11 -0400
Received: by blue.stonehenge.com (Postfix, from userid 1001)
	id 739AE1DE6CE; Sun,  7 Oct 2007 12:37:10 -0700 (PDT)
x-mayan-date: Long count = 12.19.14.12.18; tzolkin = 13 Etznab; haab = 6 Yax
In-Reply-To: <20071007170153.GX2137@spearce.org> (Shawn O. Pearce's message of "Sun, 7 Oct 2007 13:01:53 -0400")
User-Agent: Gnus/5.1008 (Gnus v5.10.8) Emacs/21.4 (berkeley-unix)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/60212>

>>>>> "Shawn" == Shawn O Pearce <spearce@spearce.org> writes:

Shawn> What, no mention of git-gui as a porcelain?  It has more users
Shawn> than qgit according to the survey.  Maybe rephrase the porcelains
Shawn> on slide 15 as:

Shawn>   Other porcelain exists:
Shawn>     - StGit ("stacked git"), guilt
Shawn>     - tig (curses-based viewer)
Shawn>     - qgit, git-gui

git-gui should have been mentioned with "the git distro".  Fixed.

Shawn> On slide 26 you say "gitk mytopic origin" shows the changes back to
Shawn> the common ancestor.  That's what "gitk mytopic...origin" would do.
Shawn> Note the three dots instead of the space.  The space will cause
Shawn> gitk to show all history back to the beginning of time.

Darned inconsistency!  Sometimes, it's a space.  Sometimes it's two dots.
Sometimes, it's three dots.  I know, there's reasons for that, but it's still
hard for the newbie.

-- 
Randal L. Schwartz - Stonehenge Consulting Services, Inc. - +1 503 777 0095
<merlyn@stonehenge.com> <URL:http://www.stonehenge.com/merlyn/>
Perl/Unix/security consulting, Technical writing, Comedy, etc. etc.
See PerlTraining.Stonehenge.com for onsite and open-enrollment Perl training!
