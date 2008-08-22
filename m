From: Stephan Beyer <s-beyer@gmx.net>
Subject: Re: [GSoC] What is status of Git's Google Summer of Code 2008
	projects?
Date: Sat, 23 Aug 2008 01:03:39 +0200
Message-ID: <20080822230339.GA14684@leksak.fem-net>
References: <200807080227.43515.jnareb@gmail.com> <200808140457.56464.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Sam Vilain <sam@vilain.net>,
	Joshua Roys <roysjosh@gmail.com>,
	Sverre Rabbelier <alturin@gmail.com>,
	Sverre Rabbelier <sverre@rabbelier.nl>,
	David Symonds <dsymonds@gmail.com>,
	Lea Wiemann <LeWiemann@gmail.com>,
	John Hawley <warthog19@eaglescrag.net>,
	Marek Zawirski <marek.zawirski@gmail.com>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	Miklos Vajna <vmiklos@frugalware.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Christian Couder <chriscool@tuxfamily.org>,
	Daniel Barkalow <barkalow@iabervon.org>
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Sat Aug 23 01:04:52 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KWfgW-00061p-U3
	for gcvg-git-2@gmane.org; Sat, 23 Aug 2008 01:04:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754359AbYHVXDo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 22 Aug 2008 19:03:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753763AbYHVXDo
	(ORCPT <rfc822;git-outgoing>); Fri, 22 Aug 2008 19:03:44 -0400
Received: from mail.gmx.net ([213.165.64.20]:37480 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1754328AbYHVXDn (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 22 Aug 2008 19:03:43 -0400
Received: (qmail invoked by alias); 22 Aug 2008 23:03:42 -0000
Received: from q137.fem.tu-ilmenau.de (EHLO leksak.fem-net) [141.24.46.137]
  by mail.gmx.net (mp033) with SMTP; 23 Aug 2008 01:03:42 +0200
X-Authenticated: #1499303
X-Provags-ID: V01U2FsdGVkX1/JZ5BThcrJ15AGIMVU8MMm2hArSJ2ywUalgH71m8
	XoDtyOKEd4nKQX
Received: from sbeyer by leksak.fem-net with local (Exim 4.69)
	(envelope-from <s-beyer@gmx.net>)
	id 1KWffP-0006Xx-CN; Sat, 23 Aug 2008 01:03:39 +0200
Content-Disposition: inline
In-Reply-To: <200808140457.56464.jnareb@gmail.com>
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.61
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/93393>

Hi,

Jakub Narebski wrote:
> 6. git-sequencer
> 
> Student: Stephan Beyer

The Google Open Source blog had an article about this thread[1]
and I noted that I forgot to inform you about my project here.

 1. http://google-opensource.blogspot.com/2008/08/git-and-google-summer-of-code.html

Until Sunday, Aug 17, I have been on testing, code cleanup and
bugfixing of the builtin-sequencer. Then I've sent this version
of the patchset to my mentors for a final review before the real
hard one (on the list *g*) and then I went away for three days.
That's perhaps why I forgot about this thread :)

That's also why there's not yet a patchset on the list.

I know there are a few people that already use (or at least used) the
(builtin) sequencer.  For the other curious people: the branches
"seq-builtin-dev" (development branch) or "seq-builtin-rfc" (rebased
patchset) on repo.or.cz[2] can be used, because I currently do not
know how long it will take until I send it to the list but I hope
it will be soon.

 2. http://repo.or.cz/w/git/sbeyer.git (seq-builtin-rfc, seq-builtin-dev)

(The last commit in seq-builtin-rfc is a test and I don't really like
it atm. It's reverted in the -dev branch.)

What else to say?
I will have not *much* time for git each day until the end of September
because of some other work and, especially, an important exam. But I
also try to take some time for git.
I also intend to keep contributing (at least small stuff) after the
builtin sequencer got into git. (I expect this is still some hard work
until the last one who has doubts is somehow satisfied.)

Kind regards,
  Stephan

-- 
Stephan Beyer <s-beyer@gmx.net>, PGP 0x6EDDD207FCC5040F
