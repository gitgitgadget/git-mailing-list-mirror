From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] Allow HTTP proxy to be overridden in config
Date: Mon, 3 Dec 2007 11:13:24 +0000 (GMT)
Message-ID: <Pine.LNX.4.64.0712031113030.27959@racer.site>
References: <1195776420-22075-1-git-send-email-sam.vilain@catalyst.net.nz>
 <7voddl24b7.fsf@gitster.siamese.dyndns.org> <47464A90.4030509@catalyst.net.nz>
 <7vhcj387jh.fsf@gitster.siamese.dyndns.org> <4753C7AD.3000406@op5.se>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <gitster@pobox.com>,
	Sam Vilain <sam.vilain@catalyst.net.nz>, git@vger.kernel.org,
	francois@debian.org
To: Andreas Ericsson <ae@op5.se>
X-From: git-owner@vger.kernel.org Mon Dec 03 12:14:10 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Iz9FY-0002cU-NR
	for gcvg-git-2@gmane.org; Mon, 03 Dec 2007 12:14:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752247AbXLCLNs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 3 Dec 2007 06:13:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752195AbXLCLNs
	(ORCPT <rfc822;git-outgoing>); Mon, 3 Dec 2007 06:13:48 -0500
Received: from mail.gmx.net ([213.165.64.20]:47855 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751907AbXLCLNr (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 3 Dec 2007 06:13:47 -0500
Received: (qmail invoked by alias); 03 Dec 2007 11:13:46 -0000
Received: from unknown (EHLO openvpn-client) [138.251.11.103]
  by mail.gmx.net (mp044) with SMTP; 03 Dec 2007 12:13:46 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1+yNzRXUdmyd4dZ8EqNqQrTtDKRY7GC3jCuOB7QRQ
	b+xsB0CPVgsDyL
X-X-Sender: gene099@racer.site
In-Reply-To: <4753C7AD.3000406@op5.se>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/66910>

Hi,

On Mon, 3 Dec 2007, Andreas Ericsson wrote:

> Junio C Hamano wrote:
> > 
> > [Footnote]
> > 
> > *1* git(7) calls "git" itself as "git potty".  Is this word still used?
> > I also notice that Andreas's name is misspelled there.
> 
> 
> AFAIR I sort of invented that to disambiguate git-the-program from 
> git-the-project while working on writing the program in C. I haven't 
> heard/seen it a lot since then, except on a few occasions where it 
> helped serve that same purpose.

I always spell it "git wrapper".

Ciao,
Dscho
