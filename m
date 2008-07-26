From: Petr Baudis <pasky@suse.cz>
Subject: Re: Official Git Homepage change? Re: git-scm.com
Date: Sat, 26 Jul 2008 04:09:51 +0200
Message-ID: <20080726020951.GV32184@machine.or.cz>
References: <d411cc4a0807251035i7aed2ec9wef7e8f1b3ae4c585@mail.gmail.com> <20080726015314.GU32184@machine.or.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Scott Chacon <schacon@gmail.com>
X-From: git-owner@vger.kernel.org Sat Jul 26 04:11:00 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KMZFL-00042o-BJ
	for gcvg-git-2@gmane.org; Sat, 26 Jul 2008 04:10:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752162AbYGZCJy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 25 Jul 2008 22:09:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752159AbYGZCJy
	(ORCPT <rfc822;git-outgoing>); Fri, 25 Jul 2008 22:09:54 -0400
Received: from w241.dkm.cz ([62.24.88.241]:57242 "EHLO machine.or.cz"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752129AbYGZCJy (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 25 Jul 2008 22:09:54 -0400
Received: by machine.or.cz (Postfix, from userid 2001)
	id 8EB54393B32A; Sat, 26 Jul 2008 04:09:51 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <20080726015314.GU32184@machine.or.cz>
User-Agent: Mutt/1.5.16 (2007-06-09)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/90148>

  Hi,

  oops, so I decided to unbundle this question from the previous post,
but forgot to modify the subject line...

  When the git-scm.com site gets refined a bit further, it might make a
lot of sense to make http://git.or.cz/index.html a redirect to
http://git-scm.com/ and thus delegate the new site to the official Git
homepage. Of course, I would be transferring the control of the homepage
from my hands so I would like to poll the community about how do people
feel about this - opinion of core Git contributors would be especially
welcome; I find myself rather happy with the new site, so I will
implicitly take silence as an agreement.

  Here is a breakdown of possible pros and cons that come on my mind:

  + The new site has much nicer and more catchy design.
  + The new site seems to have a lot of potential to grow to a rather
comprehensive resource.
  + The new site would probably have much more active maintainer. ;-)

  - The new site is affiliated with a commercial entity - GitHub.
The website maintainer also has commercial interest in some published
Git learning materials, which might generate certain conflict of
interests; we must trust them that they handle this well.
  - Both GitHub and Scott seem to be rather distanced from the "core"
Git development community. This might or might not be an issue.
  - The new site is implemented in much more complicated way than the
old one, having a full-fledged Ruby on Rails machinery behind it and
linking to bunch of obfuscated JavaScript code; I don't think it's that
big a deal, though.

  The negatives section writeup is longer, but in fact I think the
positives win here; I also have a bit of bad conscience about not giving
git.or.cz the amount of time it would deserve...

  P.S.: To simplify matters, I talk only about index.html, but of course
it would make sense to transfer both the SVN Crash Course _AND_ the Git
Wiki along; we might keep the Cogito homepage for purely historical
interest too, I don't know.

-- 
				Petr "Pasky" Baudis
As in certain cults it is possible to kill a process if you know
its true name.  -- Ken Thompson and Dennis M. Ritchie
