From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: Make 'git show' more useful
Date: Tue, 14 Jul 2009 01:42:22 +0200 (CEST)
Message-ID: <alpine.DEB.1.00.0907140140470.3155@pacific.mpi-cbg.de>
References: <alpine.LFD.2.01.0907131425490.13838@localhost.localdomain>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Tue Jul 14 01:40:32 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MQV8G-0002GF-Sp
	for gcvg-git-2@gmane.org; Tue, 14 Jul 2009 01:40:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757636AbZGMXk0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 13 Jul 2009 19:40:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754288AbZGMXk0
	(ORCPT <rfc822;git-outgoing>); Mon, 13 Jul 2009 19:40:26 -0400
Received: from mail.gmx.net ([213.165.64.20]:57557 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1754283AbZGMXkZ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 13 Jul 2009 19:40:25 -0400
Received: (qmail invoked by alias); 13 Jul 2009 23:40:22 -0000
Received: from pacific.mpi-cbg.de (EHLO pacific.mpi-cbg.de) [141.5.10.38]
  by mail.gmx.net (mp058) with SMTP; 14 Jul 2009 01:40:22 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1+JYDBUffuJQDBR2t2SuszhX3iOy75yUZFV/e02x0
	5IFFYAIDm/XNxO
X-X-Sender: schindelin@pacific.mpi-cbg.de
In-Reply-To: <alpine.LFD.2.01.0907131425490.13838@localhost.localdomain>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.67
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/123213>

Hi,

On Mon, 13 Jul 2009, Linus Torvalds wrote:

> For some reason, I ended up doing
> 
> 	git show HEAD~5..
> 
> as an odd way of asking for a log. I realize I should just have used "git 
> log", but at the same time it does make perfect conceptual sense.

For some reason, I wrote exactly this patch some time ago, but I forgot 
why I did not send it.  Probably because I did not want to appear as a 
total moron in public.  Which apparently I end up doing anyway.

So count me in on the supporters' side of this patch,
Dscho
