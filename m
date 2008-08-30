From: Teemu Likonen <tlikonen@iki.fi>
Subject: Re: [kernel.org users] [RFD] On deprecating "git-foo" for builtins
Date: Sat, 30 Aug 2008 16:50:12 +0300
Message-ID: <20080830135012.GA3124@mithlond.arda.local>
References: <BD6DEBB7-4D1C-43E9-B3D2-B46E42D9771D@cs.indiana.edu> <20080828090421.GQ10360@machine.or.cz> <18219E52-E56F-43D9-B28D-0CC74E225CC5@cs.indiana.edu> <alpine.LFD.1.10.0808280934160.3300@nehalem.linux-foundation.org> <7BC51BEC-E230-48C5-BD3E-2CECE3C7FC98@cs.indiana.edu> <20080828195211.GA3545@mithlond.arda.local> <4B9831F7-3CB8-49CB-A1DB-111481A271FE@cs.indiana.edu> <20080828212346.GA27867@coredump.intra.peff.net> <06844986-44BF-4B82-A45F-0781B3513409@wincent.com> <alpine.DEB.1.10.0808300916510.28765@gandalf.stny.rr.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Wincent Colaiuta <win@wincent.com>, Jeff King <peff@peff.net>,
	Perry Wagle <wagle@cs.indiana.edu>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Petr Baudis <pasky@suse.cz>,
	Kristian H??gsberg <krh@redhat.com>,
	Matthias Kestenholz <mk@spinlock.ch>,
	Ulrich Windl <ulrich.windl@rz.uni-regensburg.DE>,
	Andi Kleen <andi@firstfloor.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Junio C Hamano <gitster@pobox.com>,
	David Woodhouse <dwmw2@infradead.org>, git@vger.kernel.org
To: Steven Rostedt <rostedt@goodmis.org>
X-From: git-owner@vger.kernel.org Sat Aug 30 15:52:25 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KZQsH-0004L1-Tu
	for gcvg-git-2@gmane.org; Sat, 30 Aug 2008 15:52:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751419AbYH3NvO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 30 Aug 2008 09:51:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750871AbYH3NvO
	(ORCPT <rfc822;git-outgoing>); Sat, 30 Aug 2008 09:51:14 -0400
Received: from mta-out.inet.fi ([195.156.147.13]:49555 "EHLO jenni1.inet.fi"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750817AbYH3NvN (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 30 Aug 2008 09:51:13 -0400
Received: from mithlond.arda.local (80.220.180.181) by jenni1.inet.fi (8.5.014)
        id 488F15340171FCAF; Sat, 30 Aug 2008 16:50:16 +0300
Received: from dtw by mithlond.arda.local with local (Exim 4.63)
	(envelope-from <tlikonen@iki.fi>)
	id 1KZQqC-00016z-6N; Sat, 30 Aug 2008 16:50:12 +0300
Content-Disposition: inline
In-Reply-To: <alpine.DEB.1.10.0808300916510.28765@gandalf.stny.rr.com>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/94378>

Steven Rostedt wrote (2008-08-30 09:24 -0400):

> But after getting use to the dash version, and having that go away,
> makes me need to retrain myself to do things another way. This feels
> more like losing a pet, and complaining about that. This is a much
> more painful change than having to live with hordes of git commands.

Don't worry, you didn't lose your pet. You have actually two pets now 
and it has become easier to play with both of them. Just shout

    PATH="$PATH:$(git --exec-path)"

and the older pet will come. However, it's preferred that you mostly 
show the new one to your neighbours.

:-)
