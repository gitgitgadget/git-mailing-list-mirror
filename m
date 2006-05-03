From: Sam Ravnborg <sam@ravnborg.org>
Subject: Re: [ANNOUNCE] Git wiki
Date: Thu, 4 May 2006 00:39:32 +0200
Message-ID: <20060503223932.GA28081@mars.ravnborg.org>
References: <7virooj92i.fsf@assigned-by-dhcp.cox.net> <4d8e3fd30605030139k33c5a404k54861fdd02c87134@mail.gmail.com> <20060503090007.GM27689@pasky.or.cz> <4d8e3fd30605030213r625ce87fw5cbee554f1c20fbd@mail.gmail.com> <Pine.LNX.4.64.0605030934220.28543@localhost.localdomain> <20060503142957.GA9056@spearce.org> <4458C5D7.8010501@op5.se> <Pine.LNX.4.64.0605030817580.4086@g5.osdl.org> <20060503164732.GB9820@thunk.org> <Pine.LNX.4.64.0605030958370.4086@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Theodore Tso <tytso@mit.edu>, Andreas Ericsson <ae@op5.se>,
	Shawn Pearce <spearce@spearce.org>,
	Nicolas Pitre <nico@cam.org>,
	Paolo Ciarrocchi <paolo.ciarrocchi@gmail.com>,
	Petr Baudis <pasky@suse.cz>, Junio C Hamano <junkio@cox.net>,
	git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu May 04 00:39:50 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FbQ0O-0000kO-7Z
	for gcvg-git@gmane.org; Thu, 04 May 2006 00:39:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751349AbWECWjd (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 3 May 2006 18:39:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751380AbWECWjd
	(ORCPT <rfc822;git-outgoing>); Wed, 3 May 2006 18:39:33 -0400
Received: from pasmtp.tele.dk ([193.162.159.95]:38928 "EHLO pasmtp.tele.dk")
	by vger.kernel.org with ESMTP id S1751349AbWECWjc (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 3 May 2006 18:39:32 -0400
Received: from mars.ravnborg.org (0x50a0757d.hrnxx9.adsl-dhcp.tele.dk [80.160.117.125])
	by pasmtp.tele.dk (Postfix) with ESMTP id BC5161EC31C;
	Thu,  4 May 2006 00:39:25 +0200 (CEST)
Received: by mars.ravnborg.org (Postfix, from userid 1000)
	id D255B43C069; Thu,  4 May 2006 00:39:32 +0200 (CEST)
To: Linus Torvalds <torvalds@osdl.org>
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0605030958370.4086@g5.osdl.org>
User-Agent: Mutt/1.5.11
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/19527>

On Wed, May 03, 2006 at 10:06:25AM -0700, Linus Torvalds wrote:
> Even the "everyday git in 20 commands" actually starts out scaring people 
> with listing commands that they don't need to know about immediately.

20 commands is much more than I use in my daily use of git.

Lets see:
git clone
git diff
git reset --hard
git ls-files
git grep
git add
git rm
cg-commit
cg-restore
git push
git am

I may have missed one or two - but this is it. Lees then 20.
And I never use pack or fsck.

It is not that difficult. A few cogito commands creeped in also. I just
find them easier to use.

In other words - the tutorials are covering too much as stated by
others.

	Sam
