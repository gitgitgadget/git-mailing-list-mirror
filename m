From: Alex Riesen <raa.lkml@gmail.com>
Subject: Re: Git Cygwin - unable to create any repository - help!
Date: Thu, 17 Jan 2008 21:30:54 +0100
Message-ID: <20080117203054.GB3615@steel.home>
References: <a5eb9c330801151212y30cf4f63r9c294ba33da2b8f@mail.gmail.com> <200801160002.51048.robin.rosenberg.lists@dewire.com> <20080116071832.GA2896@steel.home> <a5eb9c330801160742j645ee50p72ee0a93adf8f94f@mail.gmail.com> <20080116183124.GA3181@steel.home> <a5eb9c330801161048x4b5a88dcsebd7cf9754f72ba6@mail.gmail.com> <20080116191737.GD3181@steel.home> <a5eb9c330801161344i1da447c7sb447bf6274d408e8@mail.gmail.com> <20080116234527.GA3499@steel.home> <478FA438.9010909@gmail.com>
Reply-To: Alex Riesen <raa.lkml@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Paul Umbers <paul.umbers@gmail.com>, git@vger.kernel.org,
	Junio C Hamano <junkio@cox.net>,
	Linus Torvalds <torvalds@linux-foundation.org>
To: Nicholas Wourms <nwourms@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jan 17 21:31:46 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JFbOY-000565-Dp
	for gcvg-git-2@gmane.org; Thu, 17 Jan 2008 21:31:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751645AbYAQUa5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 17 Jan 2008 15:30:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751545AbYAQUa5
	(ORCPT <rfc822;git-outgoing>); Thu, 17 Jan 2008 15:30:57 -0500
Received: from mo-p07-ob.rzone.de ([81.169.146.189]:15329 "EHLO
	mo-p07-ob.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751238AbYAQUa4 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 17 Jan 2008 15:30:56 -0500
X-RZG-CLASS-ID: mo07
X-RZG-AUTH: z4gQVF2k5XWuW3Ccul2hcNrFIbA=
Received: from tigra.home (Fa9df.f.strato-dslnet.de [195.4.169.223])
	by post.webmailer.de (klopstock mo23) (RZmta 15.4)
	with ESMTP id I05b47k0HHbFkk ; Thu, 17 Jan 2008 21:30:54 +0100 (MET)
	(envelope-from: <raa.lkml@gmail.com>)
Received: from steel.home (steel.home [192.168.1.2])
	by tigra.home (Postfix) with ESMTP id 4C9BA277AE;
	Thu, 17 Jan 2008 21:30:54 +0100 (CET)
Received: by steel.home (Postfix, from userid 1000)
	id 2C83156D22; Thu, 17 Jan 2008 21:30:54 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <478FA438.9010909@gmail.com>
User-Agent: Mutt/1.5.15+20070412 (2007-04-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/70918>

Nicholas Wourms, Thu, Jan 17, 2008 19:53:44 +0100:
> Alex Riesen wrote:
> > 
> > Something is fishy here (aside from the horrible selection of
> > information in the trace output):
> > 
> 
> That is a matter of opinion. Besides, Cygwin's strace was designed first and
> foremost with debugging the Cygwin dll in mind. Perhaps the choice of name for
> the utility was a poor one, since it implies that it ought to be the same as
> the official strace.

Perhaps. I actually did not intend debugging Cygwin dll at all and
just assumed (being used to the very useful output of linux' strace)
I get something *useful*. It was kinda usefult, just not exactly for
this problem.

As to reporting the issue to cygwin list: there are very trivial
problems which when long enough overlooked tend to give an impression
of malignant stupidity. I expect a wish to change the output of this
particular program in this particular project wont ever be granted
however long argued and whatever the arguments.

Prove me wrong (IOW: report it to cygwin and see something good happen).
