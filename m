From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [ANNOUNCE] ugit: a pyqt-based git gui // was: Re: If you would
 write git from scratch now, what would you change?
Date: Wed, 12 Dec 2007 18:15:30 +0000 (GMT)
Message-ID: <Pine.LNX.4.64.0712121814260.27959@racer.site>
References: <402731c90712110548k67f28b64w5afa93ee908ce73b@mail.gmail.com> 
 <e5bfff550712111020k51829c03n5d64a94ce7c7ac2a@mail.gmail.com> 
 <31e9dd080712111114t2bbdba60m18b7d6210f3f9174@mail.gmail.com> 
 <e5bfff550712111133j66c4b9adx9f57661cc720aa41@mail.gmail.com> 
 <402731c90712111254q1cb99c6al47538971d93b4592@mail.gmail.com> 
 <31e9dd080712111329j2c8b22ebs38ab727a5fbe85fb@mail.gmail.com> 
 <20071212041002.GN14735@spearce.org>  <31e9dd080712112113u44b30c62ja012951fba958c5d@mail.gmail.com>
  <20071212052329.GR14735@spearce.org> <31e9dd080712120702k36a959cfh3e2a5c5fb076d922@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: "Shawn O. Pearce" <spearce@spearce.org>, David <davvid@gmail.com>,
	Marco Costalba <mcostalba@gmail.com>,
	Andy Parkins <andyparkins@gmail.com>, git@vger.kernel.org
To: Jason Sewall <jasonsewall@gmail.com>
X-From: git-owner@vger.kernel.org Wed Dec 12 19:16:12 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J2W7m-0005ok-57
	for gcvg-git-2@gmane.org; Wed, 12 Dec 2007 19:16:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752473AbXLLSPg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 12 Dec 2007 13:15:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752495AbXLLSPf
	(ORCPT <rfc822;git-outgoing>); Wed, 12 Dec 2007 13:15:35 -0500
Received: from mail.gmx.net ([213.165.64.20]:45925 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752359AbXLLSPe (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 12 Dec 2007 13:15:34 -0500
Received: (qmail invoked by alias); 12 Dec 2007 18:15:31 -0000
Received: from unknown (EHLO [138.251.11.74]) [138.251.11.74]
  by mail.gmx.net (mp035) with SMTP; 12 Dec 2007 19:15:31 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX18Sb8xBPrQSa0w5FP9sjfyBQxp311Yuaq66CmVvf0
	E5/cQtXe54hxqp
X-X-Sender: gene099@racer.site
In-Reply-To: <31e9dd080712120702k36a959cfh3e2a5c5fb076d922@mail.gmail.com>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/68079>

Hi,

On Wed, 12 Dec 2007, Jason Sewall wrote:

> On Dec 12, 2007 12:23 AM, Shawn O. Pearce <spearce@spearce.org> wrote:
> > > I use git-gui and gitk for my git graphical needs because they rock 
> > > and at the end of the day, the fonts and antialiasing aren't that 
> > > big of a deal, especially since I'm usually doing quick scans and 
> > > searches over the information those tools display, not reading 
> > > novels in them.
> >
> > Good points.  Features win over pretty most of the time.  But at some 
> > point pretty is important; especially to new user adoption. Plus if 
> > you are looking at it all day long it shouldn't be jarring to the 
> > eyes.  But git-gui still isn't even where I want it ot be 
> > feature-wise.  E.g. I'd *love* to teach it inotify support, so you 
> > don't even need to have that Rescan button.
> 
> On that note, did you see what I wrote above, about having "split hunk" 
> functionality?

I had a patch for splitting hunks in git-gui in August, but there were 
some issues that I did not yet resolve.  If you want to work on it, I'll 
gladly share that patch with you.

Ciao,
Dscho
