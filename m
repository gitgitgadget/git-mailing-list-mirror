From: Petr Baudis <pasky@ucw.cz>
Subject: Re: ~/.git/config ?
Date: Sat, 27 May 2006 04:57:50 +0200
Message-ID: <20060527025750.GM11941@pasky.or.cz>
References: <20060526152837.GQ23852@progsoc.uts.edu.au> <20060526193325.d2a530a4.tihirvon@gmail.com> <20060526163829.GB10488@pasky.or.cz> <1148697382.5599.1.camel@dv>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Timo Hirvonen <tihirvon@gmail.com>,
	Anand Kumria <wildfire@progsoc.uts.edu.au>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat May 27 04:57:30 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FjozY-0006rX-C1
	for gcvg-git@gmane.org; Sat, 27 May 2006 04:57:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751280AbWE0C51 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 26 May 2006 22:57:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751281AbWE0C50
	(ORCPT <rfc822;git-outgoing>); Fri, 26 May 2006 22:57:26 -0400
Received: from w241.dkm.cz ([62.24.88.241]:1727 "EHLO machine.or.cz")
	by vger.kernel.org with ESMTP id S1751280AbWE0C50 (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 26 May 2006 22:57:26 -0400
Received: (qmail 9852 invoked by uid 2001); 27 May 2006 04:57:51 +0200
To: Pavel Roskin <proski@gnu.org>
Content-Disposition: inline
In-Reply-To: <1148697382.5599.1.camel@dv>
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
User-Agent: Mutt/1.5.11
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/20831>

Dear diary, on Sat, May 27, 2006 at 04:36:22AM CEST, I got a letter
where Pavel Roskin <proski@gnu.org> said that...
> On Fri, 2006-05-26 at 18:38 +0200, Petr Baudis wrote:
> > Dear diary, on Fri, May 26, 2006 at 06:33:25PM CEST, I got a letter
> > where Timo Hirvonen <tihirvon@gmail.com> said that...
> > > I backup my $HOME using git, so there's a .git directory in ~.
> > 
> > Then it should be called ~/.gitconfig. :-)
> 
> No, make it .gitrc for compatibility with .cvsrc, .lynxrc and others.

~/.gitrc might get useful for actually doing what ~/.cvsrc or ~/.cgrc
does, that is providing default options for git commands. ~/.gitconfig
would just give you per-user defaults for the repository config file.

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
A person is just about as big as the things that make them angry.
