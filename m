From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 0/5] some shell portability fixes
Date: Tue, 6 Nov 2007 23:25:35 +0000 (GMT)
Message-ID: <Pine.LNX.4.64.0711062324590.4362@racer.site>
References: <20071106201518.GA6361@ins.uni-bonn.de> <7v8x5bgl04.fsf@gitster.siamese.dyndns.org>
 <20071106210210.GA32159@glandium.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <gitster@pobox.com>,
	Ralf Wildenhues <Ralf.Wildenhues@gmx.de>, git@vger.kernel.org
To: Mike Hommey <mh@glandium.org>
X-From: git-owner@vger.kernel.org Wed Nov 07 00:26:51 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IpXok-0005Yn-Av
	for gcvg-git-2@gmane.org; Wed, 07 Nov 2007 00:26:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753500AbXKFX0b (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 6 Nov 2007 18:26:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753502AbXKFX0b
	(ORCPT <rfc822;git-outgoing>); Tue, 6 Nov 2007 18:26:31 -0500
Received: from mail.gmx.net ([213.165.64.20]:35504 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753079AbXKFX0b (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 6 Nov 2007 18:26:31 -0500
Received: (qmail invoked by alias); 06 Nov 2007 23:26:29 -0000
Received: from unknown (EHLO openvpn-client) [138.251.11.103]
  by mail.gmx.net (mp017) with SMTP; 07 Nov 2007 00:26:29 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/viDZRCMbvnL8xSFHjqPFzXRv0Tn673wv9lE216g
	r3d4d6acIIbsbV
X-X-Sender: gene099@racer.site
In-Reply-To: <20071106210210.GA32159@glandium.org>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/63748>

Hi,

On Tue, 6 Nov 2007, Mike Hommey wrote:

> On Tue, Nov 06, 2007 at 12:46:35PM -0800, Junio C Hamano wrote:
> > [5/5] Again, have you covered all of them?  I am not opposed to
> >       this one, although I am a bit curious who lacks -a/-o in
> >       practice.
> 
> Solaris's /bin/sh, but it already doesn't support $() and other stuff
> used all over the place in git, so it's not like it's changing anything.
> 
> Maybe some other obscure old crappy shell ?

As Junio commented in the part you did not quote, there are better shells 
in Solaris.  Use those.

Ciao,
Dscho
