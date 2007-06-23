From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 2/2] Teach rebase an interactive mode
Date: Sun, 24 Jun 2007 00:36:53 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0706240035180.4059@racer.site>
References: <Pine.LNX.4.64.0706240001150.4059@racer.site>
 <81b0412b0706231633yd0f19e8xbb0b7004fd7f75ef@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org, gitster@pobox.com
To: Alex Riesen <raa.lkml@gmail.com>
X-From: git-owner@vger.kernel.org Sun Jun 24 01:37:11 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I2FAE-0001Sd-GZ
	for gcvg-git@gmane.org; Sun, 24 Jun 2007 01:37:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754594AbXFWXhH (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 23 Jun 2007 19:37:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754247AbXFWXhF
	(ORCPT <rfc822;git-outgoing>); Sat, 23 Jun 2007 19:37:05 -0400
Received: from mail.gmx.net ([213.165.64.20]:57222 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1754078AbXFWXhC (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 23 Jun 2007 19:37:02 -0400
Received: (qmail invoked by alias); 23 Jun 2007 23:37:00 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO localhost) [132.187.25.13]
  by mail.gmx.net (mp033) with SMTP; 24 Jun 2007 01:37:00 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX19HqPx1KyxHDCtXP4+KPV+PIxnKlnCf2HM3978Uro
	5IPLGPzJP0ogub
X-X-Sender: gene099@racer.site
In-Reply-To: <81b0412b0706231633yd0f19e8xbb0b7004fd7f75ef@mail.gmail.com>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/50760>

Hi,

On Sun, 24 Jun 2007, Alex Riesen wrote:

> On 6/24/07, Johannes Schindelin <Johannes.Schindelin@gmx.de> wrote:
>
> > +If you want to fold two commits into one, just replace the command "pick"
> > +with "squash" for the second commit.  After squashing the commits,
> 
> Can I fold 3 commits into one? 4 and 5?

Yes, but the wording got too complicated. So I guessed that those who need 
to squash more than 2 commits into one would get the idea.

Ciao,
Dscho
