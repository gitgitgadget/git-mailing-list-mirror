From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: most commonly used git commands?
Date: Thu, 28 Jun 2007 15:07:17 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0706281506390.4438@racer.site>
References: <20070625064017.GA2839@mellanox.co.il>  <7vlke833wr.fsf@assigned-by-dhcp.pobox.com>
   <20070625071752.GB15343@mellanox.co.il>  <Pine.LNX.4.64.0706250846200.4059@racer.site>
  <81b0412b0706280152g5cbd777y76757d9c608ea483@mail.gmail.com>
 <Pine.LNX.4.64.0706281408280.4438@racer.site> <4683BDA5.996874EF@eudaptics.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Alex Riesen <raa.lkml@gmail.com>, git@vger.kernel.org
To: Johannes Sixt <J.Sixt@eudaptics.com>
X-From: git-owner@vger.kernel.org Thu Jun 28 16:13:52 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I3uko-00017X-Bc
	for gcvg-git@gmane.org; Thu, 28 Jun 2007 16:13:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757084AbXF1ONM (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 28 Jun 2007 10:13:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756801AbXF1ONL
	(ORCPT <rfc822;git-outgoing>); Thu, 28 Jun 2007 10:13:11 -0400
Received: from mail.gmx.net ([213.165.64.20]:40078 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1756658AbXF1ONJ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 Jun 2007 10:13:09 -0400
Received: (qmail invoked by alias); 28 Jun 2007 14:13:07 -0000
Received: from unknown (EHLO [138.251.11.74]) [138.251.11.74]
  by mail.gmx.net (mp033) with SMTP; 28 Jun 2007 16:13:07 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX19BYDECrrxBeMuTk/iF1hM+rbfzMgoFiYbC1E0L2N
	i/v9mRP1F/fB2V
X-X-Sender: gene099@racer.site
In-Reply-To: <4683BDA5.996874EF@eudaptics.com>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/51107>



On Thu, 28 Jun 2007, Johannes Sixt wrote:

> Johannes Schindelin wrote:
> > On Thu, 28 Jun 2007, Alex Riesen wrote:
> > > On 6/25/07, Johannes Schindelin <Johannes.Schindelin@gmx.de> wrote:
> > > > git update-index is really not user-friendly. That is why we have "git
> > > > add". It is commonly used as a porcelain _instead of_ update-index.
> > >
> > > which reminds me: "git-add" lacks "--chmod=[+-]x".
> > 
> > ???
> > 
> > Do you mean "chmod a+x blub && git add blub"?
> 
> No. It was meant as Alex said it. Windows (MinGW) doesn't understand
> "chmod a+x blub".

Yes, I suspected that. But I don't see a need for it on Windows (MinGW) to 
begin with.

Ciao,
Dscho
