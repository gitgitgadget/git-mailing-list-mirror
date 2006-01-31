From: Petr Baudis <pasky@suse.cz>
Subject: Re: [Census] So who uses git?
Date: Wed, 1 Feb 2006 00:36:12 +0100
Message-ID: <20060131233612.GC31278@pasky.or.cz>
References: <46a038f90601251810m1086d353ne8c7147edee4962a@mail.gmail.com> <Pine.LNX.4.64.0601272345540.2909@evo.osdl.org> <46a038f90601272133o53438987ka6b97c21d0cdf921@mail.gmail.com> <1138446030.9919.112.camel@evo.keithp.com> <7vzmlgt5zt.fsf@assigned-by-dhcp.cox.net> <20060130185822.GA24487@hpsvcnb.fc.hp.com> <Pine.LNX.4.63.0601311127250.25248@wbgn013.biozentrum.uni-wuerzburg.de> <Pine.LNX.4.64.0601311750270.25300@iabervon.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Carl Baldwin <cnb@fc.hp.com>, Junio C Hamano <junkio@cox.net>,
	Keith Packard <keithp@keithp.com>,
	Martin Langhoff <martin.langhoff@gmail.com>,
	Linus Torvalds <torvalds@osdl.org>,
	Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Feb 01 00:36:02 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1F452V-00079u-9Z
	for gcvg-git@gmane.org; Wed, 01 Feb 2006 00:35:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932134AbWAaXf4 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 31 Jan 2006 18:35:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932131AbWAaXf4
	(ORCPT <rfc822;git-outgoing>); Tue, 31 Jan 2006 18:35:56 -0500
Received: from w241.dkm.cz ([62.24.88.241]:9368 "EHLO machine.or.cz")
	by vger.kernel.org with ESMTP id S932142AbWAaXfz (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 31 Jan 2006 18:35:55 -0500
Received: (qmail 15694 invoked by uid 2001); 1 Feb 2006 00:36:12 +0100
To: Daniel Barkalow <barkalow@iabervon.org>
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0601311750270.25300@iabervon.org>
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
User-Agent: Mutt/1.5.11
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/15364>

Dear diary, on Wed, Feb 01, 2006 at 12:16:26AM CET, I got a letter
where Daniel Barkalow <barkalow@iabervon.org> said that...
> On Tue, 31 Jan 2006, Johannes Schindelin wrote:
> 
> > Hi,
> > 
> > On Mon, 30 Jan 2006, Carl Baldwin wrote:
> > 
> > > In general, I think it is grasping the reason for the index file and how 
> > > git commands like git-commit and git-diff interact with it.
> > 
> > IMHO this is the one big showstopper. I had problems explaining the 
> > concept myself.
> > 
> > For example, I had a hard time explaining to a friend why a git-add'ed 
> > file is committed when saying "git commit some_other_file", but not 
> > another (modified) file. Very unintuitive.
> 
> I sort of suspect that "git commit some_other_file" should really read 
> HEAD into a temporary index, update "some_other_file" in that (and the 
> main index), and commit it.

FWIW, this is also what cg-commit does.

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
Of the 3 great composers Mozart tells us what it's like to be human,
Beethoven tells us what it's like to be Beethoven and Bach tells us
what it's like to be the universe.  -- Douglas Adams
