From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] Add a manual page for git-stash
Date: Sat, 30 Jun 2007 19:44:17 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0706301943040.4438@racer.site>
References: <Pine.LNX.4.64.0706300304480.4438@racer.site>
 <200706300539.l5U5dHLh003989@mi1.bluebottle.com> <Pine.LNX.4.64.0706301644190.4438@racer.site>
 <7vps3dcp76.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.64.0706301853400.4438@racer.site>
 <7vk5tlcnuq.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: =?utf-8?B?44GX44KJ44GE44GX44Gq44Gq44GT?= <nanako3@bluebottle.com>,
	GIT <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Jun 30 20:44:26 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I4hvl-0001Vh-1D
	for gcvg-git@gmane.org; Sat, 30 Jun 2007 20:44:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754380AbXF3SoX (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 30 Jun 2007 14:44:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754376AbXF3SoW
	(ORCPT <rfc822;git-outgoing>); Sat, 30 Jun 2007 14:44:22 -0400
Received: from mail.gmx.net ([213.165.64.20]:32919 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1754144AbXF3SoW (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 30 Jun 2007 14:44:22 -0400
Received: (qmail invoked by alias); 30 Jun 2007 18:44:20 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO localhost) [132.187.25.13]
  by mail.gmx.net (mp044) with SMTP; 30 Jun 2007 20:44:20 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX197Uc54M2l7uVCIU1tDhzA3v2B8IemjqBsw2Yp61p
	WiKZO/Jnge0g++
X-X-Sender: gene099@racer.site
In-Reply-To: <7vk5tlcnuq.fsf@assigned-by-dhcp.cox.net>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/51242>

Hi,

On Sat, 30 Jun 2007, Junio C Hamano wrote:

> So perhaps we would want to drop the index tree portion from the stash.

That was actually the only reason I found it useful to write a script for 
it. Otherwise, the revised alias would do just fine.

Ciao,
Dscho
