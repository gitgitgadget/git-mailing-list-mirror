From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: 100%
Date: Sat, 23 Jun 2007 11:56:19 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0706231154300.4059@racer.site>
References: <20070621030622.GD8477@spearce.org>
 <alpine.LFD.0.98.0706202031200.3593@woody.linux-foundation.org>
 <Pine.LNX.4.64.0706211248420.4059@racer.site> <20070621131915.GD4487@coredump.intra.peff.net>
 <Pine.LNX.4.64.0706220214250.4059@racer.site> <467B777D.C47BFE0E@eudaptics.com>
 <Pine.LNX.4.64.0706221122200.4059@racer.site> <86ps3oi7ma.fsf_-_@lola.quinscape.zz>
 <Pine.LNX.4.64.0706221347480.4059@racer.site> <86abusi1fw.fsf@lola.quinscape.zz>
 <Pine.LNX.4.64.0706230222330.4059@racer.site> <467CF380.6060603@lsrfire.ath.cx>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="8323584-619945066-1182596010=:4059"
Cc: David Kastrup <dak@gnu.org>, git@vger.kernel.org
To: =?ISO-8859-1?Q?Ren=E9_Scharfe?= <rene.scharfe@lsrfire.ath.cx>
X-From: git-owner@vger.kernel.org Sat Jun 23 12:56:33 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I23I5-0003kF-HV
	for gcvg-git@gmane.org; Sat, 23 Jun 2007 12:56:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753743AbXFWK42 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 23 Jun 2007 06:56:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753834AbXFWK42
	(ORCPT <rfc822;git-outgoing>); Sat, 23 Jun 2007 06:56:28 -0400
Received: from mail.gmx.net ([213.165.64.20]:53564 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753653AbXFWK41 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 23 Jun 2007 06:56:27 -0400
Received: (qmail invoked by alias); 23 Jun 2007 10:56:26 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO localhost) [132.187.25.13]
  by mail.gmx.net (mp029) with SMTP; 23 Jun 2007 12:56:26 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1+mhnd7gaumfgbURGpHOr2MiJ7JuzFkPxoXGKUk4O
	mNAeEPBsRhdY7Y
X-X-Sender: gene099@racer.site
In-Reply-To: <467CF380.6060603@lsrfire.ath.cx>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/50729>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323584-619945066-1182596010=:4059
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT

Hi,

On Sat, 23 Jun 2007, René Scharfe wrote:

> Johannes Schindelin schrieb:
> > On Fri, 22 Jun 2007, David Kastrup wrote:
> >> The people I know will expect "100% identical" or even "100.0% 
> >> identical" to mean identical, period.  They will be quite surprised to 
> >> hear that "99.95%" is supposed to be included.
> > 
> > Granted, 100.0% means as close as you can get to "completely" with 4 
> > digits. But if you have an integer, you better use the complete range, 
> > rather than arbitrarily make one number more important than others.
> > 
> > For if you see an integer, you usually assume a rounded value. If you 
> > don't, you're hopeless.
> 
> Why hopeless?  It's a useful convention to define "100%" as "complete
> (not rounded)".

By the same reasoning, you could say "never round down to 0%, because I 
want to know when there is no similarity".

You cannot be exact when you have to cut off fractions, so why try for 
_exactly_ one number?

Ciao,
Dscho

--8323584-619945066-1182596010=:4059--
