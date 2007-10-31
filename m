From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: Recording merges after repo conversion
Date: Wed, 31 Oct 2007 15:03:59 +0000 (GMT)
Message-ID: <Pine.LNX.4.64.0710311503120.4362@racer.site>
References: <Pine.LNX.4.64.0710090807060.26773@ds9.cixit.se>
 <200710311343.58414.johan@herland.net> <Pine.LNX.4.64.0710311340500.4362@racer.site>
 <200710311537.30384.johan@herland.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org, Peter Karlsson <peter@softwolves.pp.se>,
	Lars Hjemli <hjemli@gmail.com>,
	Benoit SIGOURE <tsuna@lrde.epita.fr>
To: Johan Herland <johan@herland.net>
X-From: git-owner@vger.kernel.org Wed Oct 31 16:05:04 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1InF7s-0007Yu-9w
	for gcvg-git-2@gmane.org; Wed, 31 Oct 2007 16:05:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756960AbXJaPEo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 31 Oct 2007 11:04:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756648AbXJaPEn
	(ORCPT <rfc822;git-outgoing>); Wed, 31 Oct 2007 11:04:43 -0400
Received: from mail.gmx.net ([213.165.64.20]:33091 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1755985AbXJaPEn (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 31 Oct 2007 11:04:43 -0400
Received: (qmail invoked by alias); 31 Oct 2007 15:04:41 -0000
Received: from unknown (EHLO [138.251.11.74]) [138.251.11.74]
  by mail.gmx.net (mp036) with SMTP; 31 Oct 2007 16:04:41 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX19eR3pAvFFeP8JvHdFbvdyKWnlwlsEU2dxIYngDIE
	HVov4ib3p4Ve0T
X-X-Sender: gene099@racer.site
In-Reply-To: <200710311537.30384.johan@herland.net>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/62841>

Hi,

On Wed, 31 Oct 2007, Johan Herland wrote:

> On Wednesday 31 October 2007, Johannes Schindelin wrote:
>
> > All this does not change the fact that installing a graft and 'git gc 
> > --prune'ing gets rid of the old history.  D'oh.
> 
> So will rebasing and --prune'ing, or pulling a rebased branch and 
> --prune'ing. Git already gives you _plenty_ of different ropes to hang 
> yourself with. The question is whether adding yet another one is worth 
> it.

But that is not the question here.  The question here is: are users 
allowed to hang _others_?  I say: no.

Ciao,
Dscho
