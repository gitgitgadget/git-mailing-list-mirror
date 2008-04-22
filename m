From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: git remote update -> rejected
Date: Tue, 22 Apr 2008 14:05:04 +0100 (BST)
Message-ID: <alpine.DEB.1.00.0804221404360.4460@eeepc-johanness>
References: <1208857733.4695.37.camel@marge.simson.net> <20080422103458.GA14751@sigio.intra.peff.net> <1208861703.18689.2.camel@marge.simson.net> <20080422111113.GB11238@sigill.intra.peff.net> <20080422124118.GA3098@mithlond.arda.local>
 <alpine.DEB.1.00.0804221354180.4460@eeepc-johanness> <20080422130122.GB27577@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Teemu Likonen <tlikonen@iki.fi>, Mike Galbraith <efault@gmx.de>,
	Junio C Hamano <gitster@pobox.com>, git <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Apr 22 15:05:59 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JoIC2-0005dV-H0
	for gcvg-git-2@gmane.org; Tue, 22 Apr 2008 15:05:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753921AbYDVNEk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 22 Apr 2008 09:04:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753521AbYDVNEk
	(ORCPT <rfc822;git-outgoing>); Tue, 22 Apr 2008 09:04:40 -0400
Received: from mail.gmx.net ([213.165.64.20]:42151 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753341AbYDVNEj (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 22 Apr 2008 09:04:39 -0400
Received: (qmail invoked by alias); 22 Apr 2008 13:04:37 -0000
Received: from cbg-off-client.mpi-cbg.de (EHLO eeepc-johanness.mpi-cbg.de) [141.5.11.5]
  by mail.gmx.net (mp003) with SMTP; 22 Apr 2008 15:04:37 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX19ooiYASGVo1mM2rBoWvbRo2jyfyuCkUGnd6wqMPz
	uD+i/qx2/HL2R5
X-X-Sender: user@eeepc-johanness
In-Reply-To: <20080422130122.GB27577@sigill.intra.peff.net>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/80113>

Hi,

On Tue, 22 Apr 2008, Jeff King wrote:

> OTOH, if you are using non-separate-remote layout, I think it makes
> sense to _not_ have the "+". OTOOH, when you call the option --mirror,
> it makes me think of "push --mirror" which implies "+".

I am glad somebody else than me finds this to be a dilemma.

Ciao,
Dscho
