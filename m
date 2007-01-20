From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] Lose perl dependency. (fwd)
Date: Sat, 20 Jan 2007 02:31:13 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0701200230550.22628@wbgn013.biozentrum.uni-wuerzburg.de>
References: <Pine.LNX.4.63.0701181149260.22628@wbgn013.biozentrum.uni-wuerzburg.de>
 <45AF5F83.6090207@fs.ei.tum.de> <Pine.LNX.4.63.0701181441010.22628@wbgn013.biozentrum.uni-wuerzburg.de>
 <7vps9ag58g.fsf@assigned-by-dhcp.cox.net>
 <Pine.LNX.4.63.0701200052210.12889@wbgn013.biozentrum.uni-wuerzburg.de>
 <7vvej2bkn2.fsf@assigned-by-dhcp.cox.net>
 <Pine.LNX.4.63.0701200213020.22628@wbgn013.biozentrum.uni-wuerzburg.de>
 <7vbqkubiir.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jan 20 02:31:27 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H854g-0004Fd-FP
	for gcvg-git@gmane.org; Sat, 20 Jan 2007 02:31:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965011AbXATBbP (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 19 Jan 2007 20:31:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965040AbXATBbP
	(ORCPT <rfc822;git-outgoing>); Fri, 19 Jan 2007 20:31:15 -0500
Received: from mail.gmx.net ([213.165.64.20]:42577 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S965011AbXATBbO (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 19 Jan 2007 20:31:14 -0500
Received: (qmail invoked by alias); 20 Jan 2007 01:31:13 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO dumbo2) [132.187.25.13]
  by mail.gmx.net (mp022) with SMTP; 20 Jan 2007 02:31:13 +0100
X-Authenticated: #1490710
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7vbqkubiir.fsf@assigned-by-dhcp.cox.net>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/37244>

Hi,

On Fri, 19 Jan 2007, Junio C Hamano wrote:

> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
> 
> > OTOH we can expect people _not_ to use --reverse with format-patch when 
> > they don't know what it does! I mean, I don't go and use "ls" with an 
> > option I saw in the man page, just because it has a cool ring to it.
> >
> > P.S.: Perhaps you should just stop worrying and learn to love --reverse 
> 
> I usually do not worry, especially while I am running 'next'
> myself.
> 
> It's just unintended consequences I am worried about by touching
> somewhere deep in the revision machinery after -rc1.

I have no problem resending after 1.5.0 if you prefer that.

Ciao,
Dscho
