From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: most commonly used git commands?
Date: Sat, 30 Jun 2007 15:31:48 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0706301531050.4438@racer.site>
References: <20070625064017.GA2839@mellanox.co.il> <7vlke833wr.fsf@assigned-by-dhcp.pobox.com>
 <20070625071752.GB15343@mellanox.co.il> <Pine.LNX.4.64.0706250846200.4059@racer.site>
 <81b0412b0706280152g5cbd777y76757d9c608ea483@mail.gmail.com>
 <Pine.LNX.4.64.0706281408280.4438@racer.site> <4683BDA5.996874EF@eudaptics.com>
 <Pine.LNX.4.64.0706281506390.4438@racer.site> <20070630131428.GA2866@steel.home>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Johannes Sixt <J.Sixt@eudaptics.com>, git@vger.kernel.org
To: Alex Riesen <raa.lkml@gmail.com>
X-From: git-owner@vger.kernel.org Sat Jun 30 16:31:57 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I4dzQ-0004Vb-8A
	for gcvg-git@gmane.org; Sat, 30 Jun 2007 16:31:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756854AbXF3Oby (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 30 Jun 2007 10:31:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756226AbXF3Oby
	(ORCPT <rfc822;git-outgoing>); Sat, 30 Jun 2007 10:31:54 -0400
Received: from mail.gmx.net ([213.165.64.20]:45504 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1756616AbXF3Obx (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 30 Jun 2007 10:31:53 -0400
Received: (qmail invoked by alias); 30 Jun 2007 14:31:51 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO localhost) [132.187.25.13]
  by mail.gmx.net (mp042) with SMTP; 30 Jun 2007 16:31:51 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/jpN05YobjKCbNxEowH+RcMzaFiLhbracZotuyVA
	QEmm4RdReYJuKq
X-X-Sender: gene099@racer.site
In-Reply-To: <20070630131428.GA2866@steel.home>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/51219>

Hi,

On Sat, 30 Jun 2007, Alex Riesen wrote:

> Johannes Schindelin, Thu, Jun 28, 2007 16:07:17 +0200:
> > > No. It was meant as Alex said it. Windows (MinGW) doesn't understand
> > > "chmod a+x blub".
> > 
> > Yes, I suspected that. But I don't see a need for it on Windows (MinGW) to 
> > begin with.
> > 
> 
> But it is necessary on Windows (Cygwin):

I thought that on Cygwin, filemode=1? I mean, Cygwin _never_ had problems 
with chmod under my fingers.

Ciao,
Dscho
