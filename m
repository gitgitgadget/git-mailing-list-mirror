From: Nicolas Pitre <nico@cam.org>
Subject: Re: [OT] Re: C++ *for Git*
Date: Sun, 23 Sep 2007 10:23:47 -0400 (EDT)
Message-ID: <alpine.LFD.0.9999.0709231018450.32185@xanadu.home>
References: <ABE0ABE82AE84593A2B71B0281F4C814@ntdev.corp.microsoft.com>
 <46F5318A.4030103@krose.org> <877imishdp.fsf@catnip.gol.com>
 <46F55E03.2040404@krose.org>
 <5e4707340709221550o6d0a6062qd51c16a278727c29@mail.gmail.com>
 <20070923020951.GF24423@planck.djpig.de>
 <20070923062527.GA8979@old.davidb.org> <851wcpsv4z.fsf@lola.goethe.zz>
 <e5bfff550709230229t79004ce2j5ce8c2ae7744a7f2@mail.gmail.com>
 <20070923104525.GC7118@artemis.corp>
 <e5bfff550709230642v7fa5e837s7a5b9082b043672d@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Pierre Habouzit <madcoder@debian.org>, David Kastrup <dak@gnu.org>,
	Frank Lichtenheld <frank@lichtenheld.de>,
	Alex Unleashed <alex@flawedcode.org>,
	Kyle Rose <krose@krose.org>, Miles Bader <miles@gnu.org>,
	Dmitry Kakurin <dmitry.kakurin@gmail.com>,
	Git <git@vger.kernel.org>
To: Marco Costalba <mcostalba@gmail.com>
X-From: git-owner@vger.kernel.org Sun Sep 23 16:23:59 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IZSNH-00025G-FZ
	for gcvg-git-2@gmane.org; Sun, 23 Sep 2007 16:23:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753736AbXIWOXu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 23 Sep 2007 10:23:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753911AbXIWOXt
	(ORCPT <rfc822;git-outgoing>); Sun, 23 Sep 2007 10:23:49 -0400
Received: from relais.videotron.ca ([24.201.245.36]:60048 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753701AbXIWOXt (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 23 Sep 2007 10:23:49 -0400
Received: from xanadu.home ([74.56.106.175]) by VL-MH-MR002.ip.videotron.ca
 (Sun Java System Messaging Server 6.2-2.05 (built Apr 28 2005))
 with ESMTP id <0JOT00CE0RZNMR10@VL-MH-MR002.ip.videotron.ca> for
 git@vger.kernel.org; Sun, 23 Sep 2007 10:23:48 -0400 (EDT)
In-reply-to: <e5bfff550709230642v7fa5e837s7a5b9082b043672d@mail.gmail.com>
X-X-Sender: nico@xanadu.home
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/58964>

On Sun, 23 Sep 2007, Marco Costalba wrote:

> From a Linus recent thread:
> 
> > - inefficient abstracted programming models where two years down the road
> >  you notice that some abstraction wasn't very efficient, but now all
> >   your code depends on all the nice object models around it, and you
> >   cannot fix it without rewriting your app.
> >
> >In other words, the only way to do good, efficient, and system-level and
> >portable C++ ends up to limit yourself to all the things that are
> >basically available in C. And limiting your project to C means that people
> >don't screw that up, and also means that you get a lot of programmers that
> >do actually understand low-level issues and don't screw things up with any
> >idiotic "object model" crap.
> 
> Perhaps I have misunderstood, but the idea I got is that for Linus OO
> brings in more problems than what it tries to fix.

You must have misunderstood.  Why?  The linux kernel is itself very 
heavily "object oriented" already, even if it is written in C.  You 
don't need C++ for that.


Nicolas
