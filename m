From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [RFD] Strange patch formats (aka tricks with unified diffs)..
Date: Sat, 14 Apr 2007 10:59:44 +0200 (CEST)
Message-ID: <Pine.LNX.4.64.0704141051350.18846@racer.site>
References: <Pine.LNX.4.64.0704121436050.4061@woody.linux-foundation.org>
 <17951.6252.457936.428919@cargo.ozlabs.ibm.com>
 <46a038f90704122307i76f96029n75425410bc40ad82@mail.gmail.com>
 <7v3b34hjdh.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Sat Apr 14 11:00:54 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hce7q-0004WN-Ir
	for gcvg-git@gmane.org; Sat, 14 Apr 2007 11:00:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932244AbXDNJAv (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 14 Apr 2007 05:00:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753868AbXDNJAv
	(ORCPT <rfc822;git-outgoing>); Sat, 14 Apr 2007 05:00:51 -0400
Received: from mail.gmx.net ([213.165.64.20]:52689 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753831AbXDNJAu (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 14 Apr 2007 05:00:50 -0400
Received: (qmail invoked by alias); 14 Apr 2007 09:00:47 -0000
Received: from mail.superfast.com (EHLO [10.0.0.38]) [194.30.223.1]
  by mail.gmx.net (mp003) with SMTP; 14 Apr 2007 11:00:47 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1+huuIfahChAmpp0937LEczjkn1dND5bA/BGFNK/P
	KsV9W0hTo+EoUp
X-X-Sender: gene099@racer.site
In-Reply-To: <7v3b34hjdh.fsf@assigned-by-dhcp.cox.net>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/44454>

Hi,

On Thu, 12 Apr 2007, Junio C Hamano wrote:

> [...] the --color-words (whose implementation I happen to hate) [...]

I know that we talked about it previously. And strictly, I think it is not 
the implementation that you hate, but the rules that were implemented.

I'll have a look at what you wrote back then, and try to come up with some 
sensible alternatives, so you don't have to hate the code so much.

Ciao,
Dscho
