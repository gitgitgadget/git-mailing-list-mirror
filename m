From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] git-gui: Improve the application icon on Windows.
Date: Wed, 28 Nov 2007 12:08:51 +0000 (GMT)
Message-ID: <Pine.LNX.4.64.0711281207200.27959@racer.site>
References: <1196177124-13601-1-git-send-email-johannes.sixt@telecom.at>
 <Pine.LNX.4.64.0711271539310.27959@racer.site> <200711272147.22511.johannes.sixt@telecom.at>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org, "Shawn O. Pearce" <spearce@spearce.org>
To: Johannes Sixt <johannes.sixt@telecom.at>
X-From: git-owner@vger.kernel.org Wed Nov 28 13:09:32 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IxLjH-0008B5-4O
	for gcvg-git-2@gmane.org; Wed, 28 Nov 2007 13:09:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752444AbXK1MJB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 28 Nov 2007 07:09:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752420AbXK1MJB
	(ORCPT <rfc822;git-outgoing>); Wed, 28 Nov 2007 07:09:01 -0500
Received: from mail.gmx.net ([213.165.64.20]:47974 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1750918AbXK1MJA (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 28 Nov 2007 07:09:00 -0500
Received: (qmail invoked by alias); 28 Nov 2007 12:08:58 -0000
Received: from unknown (EHLO [138.251.11.74]) [138.251.11.74]
  by mail.gmx.net (mp055) with SMTP; 28 Nov 2007 13:08:58 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX18BkT8RgSEB/UQkvtH/lpVscSz9FkkUL5y3Kkunyg
	o7gYx3HSJxYhZb
X-X-Sender: gene099@racer.site
In-Reply-To: <200711272147.22511.johannes.sixt@telecom.at>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/66295>

Hi,

On Tue, 27 Nov 2007, Johannes Sixt wrote:

> On Tuesday 27 November 2007 16:40, Johannes Schindelin wrote:
> > Hi,
> >
> > On Tue, 27 Nov 2007, Johannes Sixt wrote:
> > > Previusly, there was only a 16x16 image, which looked very distorted.
> > > Here we add a 32x32 version, and also make the image sharper.
> > >
> > > Signed-off-by: Johannes Sixt <johannes.sixt@telecom.at>
> > > ---
> > > 	I'm by far not an artist, but improving the previous version
> > > 	was not difficult at all. ;)
> >
> > Why did you not just use the svg contained in msysGit?
> 
> Because I cannot find one?
> 
> $ GIT_PAGER=cat git grep -i svg 4msysgit/devel
> 4msysgit/devel:attr.c:   * attributes, e.g. "*.svg      merge=special-...

Sorry, it is in msysgit.git, not 4msysgit.git's 
master:share/resources/gitlogo.svg.

Or in the Downloads, as Steffen already said.

Hth,
Dscho
