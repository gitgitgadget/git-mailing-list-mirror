From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: about c8af1de9 (git status uses pager)
Date: Thu, 3 Jul 2008 13:11:02 +0100 (BST)
Message-ID: <alpine.DEB.1.00.0807031303080.9925@racer>
References: <alpine.LNX.1.10.0806212319410.22036@fbirervta.pbzchgretzou.qr> <19f34abd0806211430x3d7195d8idc61b7103f899947@mail.gmail.com> <7vzlpe8nyo.fsf@gitster.siamese.dyndns.org> <alpine.LNX.1.10.0806212343560.18093@fbirervta.pbzchgretzou.qr>
 <alpine.LNX.1.10.0806221107540.15126@fbirervta.pbzchgretzou.qr> <7vtzflolis.fsf@gitster.siamese.dyndns.org> <7vtzfln5zw.fsf@gitster.siamese.dyndns.org> <20080703021541.GK18147@mail.rocksoft.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Tim Stoakes <tim@stoakes.net>
X-From: git-owner@vger.kernel.org Thu Jul 03 14:23:34 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KENqK-0002ud-1l
	for gcvg-git-2@gmane.org; Thu, 03 Jul 2008 14:23:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757496AbYGCMM7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 3 Jul 2008 08:12:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756437AbYGCMM6
	(ORCPT <rfc822;git-outgoing>); Thu, 3 Jul 2008 08:12:58 -0400
Received: from mail.gmx.net ([213.165.64.20]:36581 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1757482AbYGCMM5 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 3 Jul 2008 08:12:57 -0400
Received: (qmail invoked by alias); 03 Jul 2008 12:12:55 -0000
Received: from grape.st-and.ac.uk (EHLO grape.st-and.ac.uk) [138.251.155.28]
  by mail.gmx.net (mp020) with SMTP; 03 Jul 2008 14:12:55 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX19AE6E2EqhAF8W2lzy2W8eLZGlvq+ZF0N3xgbNkBj
	fzuSIRSqslS5ya
X-X-Sender: gene099@racer
In-Reply-To: <20080703021541.GK18147@mail.rocksoft.com>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.77
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/87272>

Hi,

On Thu, 3 Jul 2008, Tim Stoakes wrote:

> This [changing git status to use the pager automatically] was quite a 
> nasty change to sneak on people I think.

Well, I think that a command producing pages and pages of output without 
stopping is useless.  Therefore, _I_ maintain that it makes tons of sense.

Of course, if you find enough support for a patch reverting it, I might 
have to accept the fact that "git status" becomes less useful for me.

Ciao,
Dscho
