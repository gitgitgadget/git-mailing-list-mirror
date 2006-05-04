From: Petr Baudis <pasky@suse.cz>
Subject: [ANNOUNCE] Revamped Git homepage
Date: Thu, 4 May 2006 02:35:18 +0200
Message-ID: <20060504003518.GT27689@pasky.or.cz>
References: <20060502232553.GL27689@pasky.or.cz> <7virooj92i.fsf@assigned-by-dhcp.cox.net> <4d8e3fd30605030139k33c5a404k54861fdd02c87134@mail.gmail.com> <20060503090007.GM27689@pasky.or.cz> <4d8e3fd30605030213r625ce87fw5cbee554f1c20fbd@mail.gmail.com> <Pine.LNX.4.64.0605030934220.28543@localhost.localdomain> <20060503142957.GA9056@spearce.org> <4458C5D7.8010501@op5.se> <Pine.LNX.4.64.0605030817580.4086@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Andreas Ericsson <ae@op5.se>, Shawn Pearce <spearce@spearce.org>,
	Nicolas Pitre <nico@cam.org>,
	Paolo Ciarrocchi <paolo.ciarrocchi@gmail.com>,
	Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu May 04 02:34:28 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FbRnR-0007oB-Qm
	for gcvg-git@gmane.org; Thu, 04 May 2006 02:34:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750805AbWEDAeT (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 3 May 2006 20:34:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750815AbWEDAeT
	(ORCPT <rfc822;git-outgoing>); Wed, 3 May 2006 20:34:19 -0400
Received: from w241.dkm.cz ([62.24.88.241]:44489 "EHLO machine.or.cz")
	by vger.kernel.org with ESMTP id S1750805AbWEDAeS (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 3 May 2006 20:34:18 -0400
Received: (qmail 11549 invoked by uid 2001); 4 May 2006 02:35:18 +0200
To: Linus Torvalds <torvalds@osdl.org>
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0605030817580.4086@g5.osdl.org>
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
User-Agent: Mutt/1.5.11
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/19537>

Dear diary, on Wed, May 03, 2006 at 05:30:26PM CEST, I got a letter
where Linus Torvalds <torvalds@osdl.org> said that...
> However, I think the _real_ issue is that Mercurial has a much nicer 
> introductory phase. The standard mercurial web-page is so much more 
> professional and nice to look at than any git page I have ever seen, and 
> let's face it: first looks _do_ count.

Yes, I've already learned earlier that this made quite a bad impression
on many people and had the homepage revamp on top of my TODO list for
the last few weeks.

Well, here we go, I've just uploaded a new version of the Git homepage;
I wonder how you feel about it now.

Obviously, it still feels rather empty and I'm certainly not much of
a webmaster myself, but I take patches and pull requests; see
http://git.or.cz/community.html for the Git homepage git repository
information.

I've borrowed Jonas Fonseca's ELinks homepage design first, but the
contents ended up almost entirely rewritten as well (except the Related
Tools section, which stayed mostly as it was). Git now poses as a real
version control system and the plumbing stuff is mentioned only in the
bottom paragraphs. ;-)


BTW, if anyone is into CSS and stuff, after half an hour of beating it
I couldn't manage to make the top bar look right - everything is shifted
slightly to the top. :/

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
Right now I am having amnesia and deja-vu at the same time.  I think
I have forgotten this before.
