From: Petr Baudis <pasky@suse.cz>
Subject: Re: [PATCH] Make git-send-pack exit with error when some refs cou ldn't be pushed out
Date: Wed, 14 Dec 2005 20:01:46 +0100
Message-ID: <20051214190146.GI22159@pasky.or.cz>
References: <20051214023005.GS10680@pasky.or.cz> <1134576909.2478.53.camel@cashmere.sps.mot.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Dec 14 20:04:39 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Embt6-0005XD-8Q
	for gcvg-git@gmane.org; Wed, 14 Dec 2005 20:02:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964835AbVLNTBy (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 14 Dec 2005 14:01:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964865AbVLNTBy
	(ORCPT <rfc822;git-outgoing>); Wed, 14 Dec 2005 14:01:54 -0500
Received: from w241.dkm.cz ([62.24.88.241]:44755 "EHLO machine.or.cz")
	by vger.kernel.org with ESMTP id S964835AbVLNTBy (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 14 Dec 2005 14:01:54 -0500
Received: (qmail 32738 invoked by uid 2001); 14 Dec 2005 20:01:46 +0100
To: Jon Loeliger <jdl@freescale.com>
Content-Disposition: inline
In-Reply-To: <1134576909.2478.53.camel@cashmere.sps.mot.com>
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
User-Agent: Mutt/1.5.11
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/13637>

Dear diary, on Wed, Dec 14, 2005 at 05:15:09PM CET, I got a letter
where Jon Loeliger <jdl@freescale.com> said that...
> On Tue, 2005-12-13 at 20:30, Petr Baudis wrote:
> > Jonas only reported it on IRC as weird cg-commit behaviour (which it
> 
> Gah.  Are we IRCing now too these days?  Did I miss a step
> or an announcment?

I mentioned the #git channel on the FreeNode network in several Cogito
announcements, but this problem report was actually in a different
channel (#elinks, since it occurred during work on ELinks) and it
wouldn't make a difference if it was on a query or in a private mail.

> I thought we were all doing a reasonably good job of communicating
> here on list...

Sure, all important things are going on here, but it's often much more
convenient to do some troubleshooting and stuff over IRC, and way too
many people also mail me privately (sometimes it makes sense, sometimes
they would be better off cc'ing the list).

#git serves mainly as quick help wrt. GIT usage, sometimes people report
problems there (but for non-Cogito problems, I usually redir them to the
mailing list), and sometimes (but quite rarely) larger feature-wise
discussion spins out; but if it's about to get anything near real, it
usually hits the mailing list anyway. Oh, and CIA reports Cogito commits
on the channel.

The only IRC-only effort ever (so far) was I believe adding the
cg-switch command.

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
VI has two modes: the one in which it beeps and the one in which
it doesn't.
