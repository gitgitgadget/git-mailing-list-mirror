From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: perl t9700 failures?
Date: Sun, 29 Jun 2008 22:55:07 +0100 (BST)
Message-ID: <alpine.DEB.1.00.0806292253050.9925@racer>
References: <alpine.LFD.1.10.0806291241210.27776@hp.linux-foundation.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>,
	Lea Wiemann <LeWiemann@gmail.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Sun Jun 29 23:58:04 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KD4uJ-0002xh-V5
	for gcvg-git-2@gmane.org; Sun, 29 Jun 2008 23:58:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752473AbYF2V5I (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 29 Jun 2008 17:57:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752470AbYF2V5H
	(ORCPT <rfc822;git-outgoing>); Sun, 29 Jun 2008 17:57:07 -0400
Received: from mail.gmx.net ([213.165.64.20]:60654 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752376AbYF2V5F (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 29 Jun 2008 17:57:05 -0400
Received: (qmail invoked by alias); 29 Jun 2008 21:57:03 -0000
Received: from 87.113.36.200.plusnet.pte-ag1.dyn.plus.net (EHLO racer.local) [87.113.36.200]
  by mail.gmx.net (mp002) with SMTP; 29 Jun 2008 23:57:03 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX19RiI1zGlZRRCOuaQ9uUhoxMOGdGCTVv0yLOVcyTE
	8iNP1WZ3eVVsf3
X-X-Sender: gene099@racer
In-Reply-To: <alpine.LFD.1.10.0806291241210.27776@hp.linux-foundation.org>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/86838>

Hi,

On Sun, 29 Jun 2008, Linus Torvalds wrote:

> 	Can't locate Test/More.pm in @INC (@INC contains: ...)

I cannot say that I am really surprised.  And given that I _actively_ 
warned that something like this is prone to happen, I have to say that I 
am actually a little pleased, too, since it shows I am not actually a 
complete moron having warned, even if people laughed in my face because of 
my concerns.

Ciao,
Dscho
