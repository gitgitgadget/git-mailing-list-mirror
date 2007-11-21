From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [WIP PATCH] Add 'git fast-export', the sister of 'git fast-import'
Date: Wed, 21 Nov 2007 15:47:15 +0000 (GMT)
Message-ID: <Pine.LNX.4.64.0711211546410.27959@racer.site>
References: <Pine.LNX.4.64.0711210336210.27959@racer.site> <4743E1D6.4010308@viscovery.net>
 <Pine.LNX.4.64.0711211209080.27959@racer.site> <47444A1B.4000907@op5.se>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Johannes Sixt <j.sixt@viscovery.net>, git@vger.kernel.org
To: Andreas Ericsson <ae@op5.se>
X-From: git-owner@vger.kernel.org Wed Nov 21 16:47:39 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Iurnb-0005eP-Vi
	for gcvg-git-2@gmane.org; Wed, 21 Nov 2007 16:47:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755130AbXKUPrS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 21 Nov 2007 10:47:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755206AbXKUPrS
	(ORCPT <rfc822;git-outgoing>); Wed, 21 Nov 2007 10:47:18 -0500
Received: from mail.gmx.net ([213.165.64.20]:41742 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1755042AbXKUPrR (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 21 Nov 2007 10:47:17 -0500
Received: (qmail invoked by alias); 21 Nov 2007 15:47:15 -0000
Received: from unknown (EHLO [138.251.11.74]) [138.251.11.74]
  by mail.gmx.net (mp035) with SMTP; 21 Nov 2007 16:47:15 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/A30oL/gzAPx45KD5jpFsf54WXGvTg8gWea5eEA3
	vyNAux2QQa8BFP
X-X-Sender: gene099@racer.site
In-Reply-To: <47444A1B.4000907@op5.se>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/65667>

Hi,

On Wed, 21 Nov 2007, Andreas Ericsson wrote:

> Johannes Schindelin wrote:
> > 
> > P.S.: I'll try to read up on ptrint_t, as suggested by Shawn.
> 
> I can't find a reference to ptrint_t anywhere on either my system,
> and the 10 first hits on Google finds it on typedef lines, most
> commonly like this:
> 
> 	typedef unsigned long ptrint_t;

It is really called intptr_t, and it is C99.

Ciao,
Dscho
