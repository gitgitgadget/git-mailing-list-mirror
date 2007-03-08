From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] shortlog: prompt when reading from terminal by mistake
Date: Thu, 8 Mar 2007 18:28:12 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0703081827560.22628@wbgn013.biozentrum.uni-wuerzburg.de>
References: <7vhcsw9h8p.fsf@assigned-by-dhcp.cox.net>
 <Pine.LNX.4.64.0703080827170.10832@woody.linux-foundation.org>
 <Pine.LNX.4.63.0703081755500.22628@wbgn013.biozentrum.uni-wuerzburg.de>
 <vpqejnz3b79.fsf@olympe.imag.fr>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Matthieu Moy <Matthieu.Moy@imag.fr>
X-From: git-owner@vger.kernel.org Thu Mar 08 18:29:05 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HPMQH-0000mm-EU
	for gcvg-git@gmane.org; Thu, 08 Mar 2007 18:29:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752596AbXCHR2P (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 8 Mar 2007 12:28:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752597AbXCHR2P
	(ORCPT <rfc822;git-outgoing>); Thu, 8 Mar 2007 12:28:15 -0500
Received: from mail.gmx.net ([213.165.64.20]:37135 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752596AbXCHR2O (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 8 Mar 2007 12:28:14 -0500
Received: (qmail invoked by alias); 08 Mar 2007 17:28:12 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO wbgn013.biozentrum.uni-wuerzburg.de) [132.187.25.13]
  by mail.gmx.net (mp020) with SMTP; 08 Mar 2007 18:28:12 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1+FedUCeySFjRvAM2lOs8nx6aPGUn6nLyBDRLNOXM
	mS8W/j37mbC+R1
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
In-Reply-To: <vpqejnz3b79.fsf@olympe.imag.fr>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/41762>

Hi,

On Thu, 8 Mar 2007, Matthieu Moy wrote:

> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
> 
> > How about something totally different: "git log --shortlog". I.e.
> 
> Then, I'd say just --short.

Too easy to confuse with "--pretty=short".

Ciao,
Dscho
