From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] help.autocorrect: do not run a command if the command 
 given is junk
Date: Mon, 14 Dec 2009 15:17:29 +0100 (CET)
Message-ID: <alpine.DEB.1.00.0912141516180.4985@pacific.mpi-cbg.de>
References: <4B263797.5070808@viscovery.net> <81b0412b0912140529w4a15418ewf304b9d6f4c1f007@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Johannes Sixt <j.sixt@viscovery.net>,
	Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>
To: Alex Riesen <raa.lkml@gmail.com>
X-From: git-owner@vger.kernel.org Mon Dec 14 15:13:09 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NKBfV-0007nG-1m
	for gcvg-git-2@lo.gmane.org; Mon, 14 Dec 2009 15:12:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757345AbZLNOMx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 14 Dec 2009 09:12:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757323AbZLNOMw
	(ORCPT <rfc822;git-outgoing>); Mon, 14 Dec 2009 09:12:52 -0500
Received: from mail.gmx.net ([213.165.64.20]:53606 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1756318AbZLNOMw (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 14 Dec 2009 09:12:52 -0500
Received: (qmail invoked by alias); 14 Dec 2009 14:12:50 -0000
Received: from pacific.mpi-cbg.de (EHLO pacific.mpi-cbg.de) [141.5.10.38]
  by mail.gmx.net (mp048) with SMTP; 14 Dec 2009 15:12:50 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX184R/s/qfI4/2mmcz0azXAdRJIJEC5hQ/sjF8zkJp
	xR3gGZpyOAAV55
X-X-Sender: schindelin@pacific.mpi-cbg.de
In-Reply-To: <81b0412b0912140529w4a15418ewf304b9d6f4c1f007@mail.gmail.com>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.73
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/135213>

Hi,

On Mon, 14 Dec 2009, Alex Riesen wrote:

> I don't use autocorrect myself apart from the testing. I assume Johannes 
> doesn't, too

As a matter of fact, I do.  But my common mistakes are not in forgetting 
the subcommand, rather in mispelign them.  So I never hit the problem.

Ciao,
Dscho
