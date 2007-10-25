From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: best git practices, was Re: Git User's Survey 2007 unfinished
 summary continued
Date: Thu, 25 Oct 2007 13:58:53 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0710251239590.25221@racer.site>
References: <8fe92b430710221635x752c561ejcee14e2526010cc9@mail.gmail.com>
 <92320AA3-6D23-4967-818D-F7FA3962E88D@zib.de> <Pine.LNX.4.64.0710231155321.25221@racer.site>
 <90325C2E-9AF4-40FB-9EFB-70B6D0174409@zib.de> <20071024192058.GF29830@fieldses.org>
 <471F9FD1.6080002@op5.se> <20071024194849.GH29830@fieldses.org>
 <86784BB7-076F-4504-BCE6-4580A7C68AAC@zib.de> <20071024203335.GJ29830@fieldses.org>
 <471FB3D0.4040800@op5.se> <20071024212854.GB6069@xp.machine.xx>
 <05B279A2-98A3-45F1-9661-AB361F7CAA37@zib.de> <Pine.LNX.4.64.0710242258201.25221@racer.site>
 <008A7EF9-6F58-47AE-9AA0-B466797F6B1D@zib.de> <Pine.LNX.4.64.0710250021430.25221@racer.site>
 <47204297.5050109@op5.se> <Pine.LNX.4.64.0710251112390.25221@racer.site>
 <472070E5.4090303@op5.se>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Steffen Prohaska <prohaska@zib.de>,
	Peter Baumann <waste.manager@gmx.de>,
	"J. Bruce Fields" <bfields@fieldses.org>,
	Jakub Narebski <jnareb@gmail.com>,
	Federico Mena Quintero <federico@novell.com>,
	git@vger.kernel.org
To: Andreas Ericsson <ae@op5.se>
X-From: git-owner@vger.kernel.org Thu Oct 25 14:59:39 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Il2JF-0005oA-Oh
	for gcvg-git-2@gmane.org; Thu, 25 Oct 2007 14:59:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753009AbXJYM70 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 25 Oct 2007 08:59:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753166AbXJYM70
	(ORCPT <rfc822;git-outgoing>); Thu, 25 Oct 2007 08:59:26 -0400
Received: from mail.gmx.net ([213.165.64.20]:51273 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753056AbXJYM7Z (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 25 Oct 2007 08:59:25 -0400
Received: (qmail invoked by alias); 25 Oct 2007 12:59:23 -0000
Received: from unknown (EHLO [138.251.11.74]) [138.251.11.74]
  by mail.gmx.net (mp048) with SMTP; 25 Oct 2007 14:59:23 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX18e2X8/RskeOU28AFC0cTnA0khqMIPAUzj4DTS4ea
	B2WZ4Q3lgLwftH
X-X-Sender: gene099@racer.site
In-Reply-To: <472070E5.4090303@op5.se>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/62315>

Hi,

On Thu, 25 Oct 2007, Andreas Ericsson wrote:

> Johannes Schindelin wrote:
> 
> > When you're done with a topic, why do you leave it around?  
> > Cluttering up your "git branch" output?
> 
> We have 91 repositories at work. Roughly 60 of those are in active use.
> The active repos are organized pretty much like the git repo with
> 'master', 'next' and 'maint'. We *do* work on all branches, but not
> every day, ofcourse. They're NOT topic branches.

I already explained in another mail (wasn't it even the one you replied 
to?) how this can be done more efficiently.

Ciao,
Dscho
