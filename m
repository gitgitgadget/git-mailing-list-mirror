From: Petr Baudis <pasky@suse.cz>
Subject: Re: PPC SHA-1 Updates in "pu"
Date: Sun, 25 Jun 2006 12:20:37 +0200
Message-ID: <20060625102037.GI29364@pasky.or.cz>
References: <7vzmg376ee.fsf@assigned-by-dhcp.cox.net> <20060624012202.4822.qmail@science.horizon.com> <7vfyhv11ej.fsf@assigned-by-dhcp.cox.net> <7vwtb6yip5.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.64.0606241147480.6483@g5.osdl.org> <7vhd2atid1.fsf@assigned-by-dhcp.cox.net> <20060625012435.GZ21864@pasky.or.cz> <7vfyhtopjm.fsf@assigned-by-dhcp.cox.net> <20060625093444.GD21864@pasky.or.cz> <Pine.LNX.4.63.0606251202320.29667@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <junkio@cox.net>,
	Linus Torvalds <torvalds@osdl.org>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jun 25 12:20:50 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FuRjO-0005YS-Sf
	for gcvg-git@gmane.org; Sun, 25 Jun 2006 12:20:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932296AbWFYKUj (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 25 Jun 2006 06:20:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932305AbWFYKUj
	(ORCPT <rfc822;git-outgoing>); Sun, 25 Jun 2006 06:20:39 -0400
Received: from w241.dkm.cz ([62.24.88.241]:11418 "EHLO machine.or.cz")
	by vger.kernel.org with ESMTP id S932296AbWFYKUj (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 25 Jun 2006 06:20:39 -0400
Received: (qmail 26246 invoked by uid 2001); 25 Jun 2006 12:20:37 +0200
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.63.0606251202320.29667@wbgn013.biozentrum.uni-wuerzburg.de>
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
User-Agent: Mutt/1.5.11
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/22605>

  Hi,

Dear diary, on Sun, Jun 25, 2006 at 12:07:21PM CEST, I got a letter
where Johannes Schindelin <Johannes.Schindelin@gmx.de> said that...
> On Sun, 25 Jun 2006, Petr Baudis wrote:
> 
> > All the modules we depend on should come bundled with Perl since 5.8.1.
> > Now, I'm not sure what our "cutoff" point is, and even if it is
> > something like 5.6.0 whether we can just require users of Perl older
> > than 5.8.1 (which should be only some rare and obscure systems anyway)
> > to install the modules from CPAN.
> 
> NO! It is _wrong_ to require users to upgrade, when a little more work on 
> our side would fix it. Requiring users to upgrade is a proactive way to 
> get rid of new users.
> 
> And old ones. If you would require me to upgrade to Perl 5.8.1, I would 
> rather stop upgrading git.

  please read it again - I'm not requiring you to upgrade to Perl 5.8.1.
I'm just saying that if you have Perl older than 5.8.1, you might need
to install some extra modules from CPAN.

  Now, if that's not acceptable either that's fine by me and I can
adapt, I just need to know at which point we _will_ require you to
upgrade or install extra modules.

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
A person is just about as big as the things that make them angry.
