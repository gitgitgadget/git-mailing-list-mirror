From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 2/4] Move the --decorate option from builtin-log.c to
 revision.c.
Date: Fri, 13 Jul 2007 16:38:53 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0707131626200.14781@racer.site>
References: <Pine.LNX.4.64.0707110220340.4047@racer.site>
 <Pine.LNX.4.64.0707110229120.4047@racer.site> <7v4pk9v4tp.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Jul 13 17:39:31 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I9NEw-0007cR-Jf
	for gcvg-git@gmane.org; Fri, 13 Jul 2007 17:39:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759055AbXGMPj0 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 13 Jul 2007 11:39:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757806AbXGMPj0
	(ORCPT <rfc822;git-outgoing>); Fri, 13 Jul 2007 11:39:26 -0400
Received: from mail.gmx.net ([213.165.64.20]:56241 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1756195AbXGMPjZ (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 13 Jul 2007 11:39:25 -0400
Received: (qmail invoked by alias); 13 Jul 2007 15:39:23 -0000
Received: from wbgn128.biozentrum.uni-wuerzburg.de (EHLO [192.168.0.57]) [132.187.25.128]
  by mail.gmx.net (mp048) with SMTP; 13 Jul 2007 17:39:23 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/CArp4xoDC5uHazKFj5wN9HudVCDCPuZcmJd5zLa
	r5uPsTYOgujBbx
X-X-Sender: gene099@racer.site
In-Reply-To: <7v4pk9v4tp.fsf@assigned-by-dhcp.cox.net>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/52399>

Hi,

On Thu, 12 Jul 2007, Junio C Hamano wrote:

> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
> 
> > ---decorate::
> > -	Print out the ref names of any commits that are shown.
> > -
> > ...
> > +
> > +--decorate::
> > +	When a commit is shown, and it matches a ref, print that ref name
> > +	in brackets after the commit name.
> 
> The character-pair ( and ) are usually called parentheses, not
> brackets.

Okay.  You want me to resend, or will you fix it?

Ciao,
Dscho
