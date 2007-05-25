From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [RFC] Fourth round of support for cloning submodules
Date: Fri, 25 May 2007 17:37:25 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0705251736400.4648@racer.site>
References: <Pine.LNX.4.64.0705240039370.4113@racer.site>
 <200705251559.53846.Josef.Weidendorfer@gmx.de>
 <alpine.LFD.0.98.0705250830220.26602@woody.linux-foundation.org>
 <200705251823.37062.Josef.Weidendorfer@gmx.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Junio C Hamano <junkio@cox.net>,
	Lars Hjemli <hjemli@gmail.com>, skimo@liacs.nl,
	"Shawn O. Pearce" <spearce@spearce.org>, git@vger.kernel.org,
	Martin Waitz <tali@admingilde.org>,
	Alex Riesen <raa.lkml@gmail.com>
To: Josef Weidendorfer <Josef.Weidendorfer@gmx.de>
X-From: git-owner@vger.kernel.org Fri May 25 18:38:01 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hrcnd-0002Mj-2p
	for gcvg-git@gmane.org; Fri, 25 May 2007 18:37:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1762889AbXEYQhf (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 25 May 2007 12:37:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1762920AbXEYQhe
	(ORCPT <rfc822;git-outgoing>); Fri, 25 May 2007 12:37:34 -0400
Received: from mail.gmx.net ([213.165.64.20]:49365 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1762889AbXEYQhb (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 25 May 2007 12:37:31 -0400
Received: (qmail invoked by alias); 25 May 2007 16:37:28 -0000
Received: from unknown (EHLO [138.251.11.74]) [138.251.11.74]
  by mail.gmx.net (mp020) with SMTP; 25 May 2007 18:37:28 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1+N6PBNR+WNhBufRnHFOup+7/60XKnHXR3YwzZy34
	QL2kq8D+5FpA9I
X-X-Sender: gene099@racer.site
In-Reply-To: <200705251823.37062.Josef.Weidendorfer@gmx.de>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/48394>

Hi,

On Fri, 25 May 2007, Josef Weidendorfer wrote:

> AFAICS the whole discussion here is about whether we need
> a further configuration level with different visibility:
> one which in not versioned together with the superproject
> history, but which can be cloned, ie. a superproject-wide
> configuration (*1*).

I smell centralization here. _Forced_ centralization.

Ciao,
Dscho
