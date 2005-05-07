From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: How do I...
Date: Sat, 07 May 2005 10:45:03 +1000
Message-ID: <1115426703.23609.27.camel@gaston>
References: <427B3DB3.4000507@tuxrocks.com>
	 <Pine.LNX.4.58.0505060905090.2233@ppc970.osdl.org>
	 <1115397368.16187.266.camel@hades.cambridge.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: Linus Torvalds <torvalds@osdl.org>,
	Frank Sorenson <frank@tuxrocks.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat May 07 02:39:50 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DUDM9-0002xH-G9
	for gcvg-git@gmane.org; Sat, 07 May 2005 02:39:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261412AbVEGAq3 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 6 May 2005 20:46:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261413AbVEGAq3
	(ORCPT <rfc822;git-outgoing>); Fri, 6 May 2005 20:46:29 -0400
Received: from gate.crashing.org ([63.228.1.57]:48864 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S261412AbVEGAq0 (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 6 May 2005 20:46:26 -0400
Received: from gaston (localhost [127.0.0.1])
	by gate.crashing.org (8.12.8/8.12.8) with ESMTP id j470d2gJ030488;
	Fri, 6 May 2005 19:39:04 -0500
To: David Woodhouse <dwmw2@infradead.org>
In-Reply-To: <1115397368.16187.266.camel@hades.cambridge.redhat.com>
X-Mailer: Evolution 2.2.2 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

On Fri, 2005-05-06 at 17:36 +0100, David Woodhouse wrote:
> On Fri, 2005-05-06 at 09:13 -0700, Linus Torvalds wrote:
> > There has been at least two different scripts for this posted, and one C 
> > source code version.
> > 
> > I just haven't integrated them, because I'm an idiot, and too much choice 
> > makes me run around in small circles and clucking.
> > 
> > Guys - whoever wrote one of the scripts, can you please send out your 
> > current version to the git list and cc me, and explain why yours is 
> > superior to the other peoples version. Please?
> 
> I already explained why mine sucks and shouldn't be merged. It was a
> proof of concept; hoping for the stone soup effect.
> 
> I haven't seen a C version or indeed anything which actually does the
> right thing, although I outlined how it would work and _threatened_ to
> do one. I had a half-arsed attempt at it on the way home from
> linux.conf.au but my brain tends to melt while I'm on airplanes so I
> didn't get very far.

Note that paulus current dirdiff CVS can diff arbitrary revs of a git
tree afaik (or a rev against current edited content).

Ben.


