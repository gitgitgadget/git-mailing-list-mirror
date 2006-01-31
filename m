From: Carl Baldwin <cnb@fc.hp.com>
Subject: Re: [Census] So who uses git?
Date: Tue, 31 Jan 2006 08:24:29 -0700
Organization: Hewlett Packard
Message-ID: <20060131152429.GA26817@hpsvcnb.fc.hp.com>
References: <46a038f90601251810m1086d353ne8c7147edee4962a@mail.gmail.com> <Pine.LNX.4.64.0601272345540.2909@evo.osdl.org> <46a038f90601272133o53438987ka6b97c21d0cdf921@mail.gmail.com> <1138446030.9919.112.camel@evo.keithp.com> <7vzmlgt5zt.fsf@assigned-by-dhcp.cox.net> <20060130185822.GA24487@hpsvcnb.fc.hp.com> <Pine.LNX.4.63.0601311127250.25248@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <junkio@cox.net>, Keith Packard <keithp@keithp.com>,
	Martin Langhoff <martin.langhoff@gmail.com>,
	Linus Torvalds <torvalds@osdl.org>,
	Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Jan 31 16:26:25 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1F3xN7-0001vY-4z
	for gcvg-git@gmane.org; Tue, 31 Jan 2006 16:24:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750931AbWAaPYg (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 31 Jan 2006 10:24:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750932AbWAaPYg
	(ORCPT <rfc822;git-outgoing>); Tue, 31 Jan 2006 10:24:36 -0500
Received: from atlrel7.hp.com ([156.153.255.213]:43141 "EHLO atlrel7.hp.com")
	by vger.kernel.org with ESMTP id S1750926AbWAaPYf (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 31 Jan 2006 10:24:35 -0500
Received: from smtp1.fc.hp.com (smtp2a.fc.hp.com [15.15.136.127])
	by atlrel7.hp.com (Postfix) with ESMTP id 7B3DF34AC8;
	Tue, 31 Jan 2006 10:24:34 -0500 (EST)
Received: from hpsvcnb.fc.hp.com (hpsvcnb.fc.hp.com [15.6.94.42])
	by smtp1.fc.hp.com (Postfix) with ESMTP
	id 18ADE38234; Tue, 31 Jan 2006 15:24:30 +0000 (UTC)
Received: by hpsvcnb.fc.hp.com (Postfix, from userid 21523)
	id ED365BF81; Tue, 31 Jan 2006 08:24:29 -0700 (MST)
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Mail-Followup-To: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Junio C Hamano <junkio@cox.net>, Keith Packard <keithp@keithp.com>,
	Martin Langhoff <martin.langhoff@gmail.com>,
	Linus Torvalds <torvalds@osdl.org>,
	Git Mailing List <git@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.63.0601311127250.25248@wbgn013.biozentrum.uni-wuerzburg.de>
X-Origin: hpsvcnb.fc.hp.com
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/15318>

Its difficult to explain because it breaks away from the precedent set
by other SCMs.  I wouldn't call it a show-stopper for this reason.  In
fact, some who have wrapped their heads around the concept might call it
a valuable feature.  I, myself, have found it a handy thing in certain
circumstances.  In other circumstances I simply bypass it by adding -a
to the command-line.

This doesn't fit my definition of a show-stopper.

Carl

On Tue, Jan 31, 2006 at 11:27:34AM +0100, Johannes Schindelin wrote:
> Hi,
> 
> On Mon, 30 Jan 2006, Carl Baldwin wrote:
> 
> > In general, I think it is grasping the reason for the index file and how 
> > git commands like git-commit and git-diff interact with it.
> 
> IMHO this is the one big showstopper. I had problems explaining the 
> concept myself.
> 
> For example, I had a hard time explaining to a friend why a git-add'ed 
> file is committed when saying "git commit some_other_file", but not 
> another (modified) file. Very unintuitive.
> 
> Ciao,
> Dscho
> 
> 

-- 
- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
 Carl Baldwin                        RADCAD (R&D CAD)
 Hewlett Packard Company
 MS 88                               work: 970 898-1523
 3404 E. Harmony Rd.                 work: Carl.N.Baldwin@hp.com
 Fort Collins, CO 80525              home: Carl@ecBaldwin.net
- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
