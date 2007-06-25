From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] Add git-save script
Date: Mon, 25 Jun 2007 08:45:17 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0706250844170.4059@racer.site>
References: <20070623220215.6117@nanako3.bluebottle.com>
 <Pine.LNX.4.64.0706231605160.4059@racer.site> <200706250632.l5P6Wu6B028140@mi0.bluebottle.com>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="8323584-1888209405-1182757517=:4059"
Cc: GIT <git@vger.kernel.org>
To: =?utf-8?q?=E3=81=97=E3=82=89=E3=81=84=E3=81=97=E3=81=AA=E3=81=AA=E3=81=93?= 
	<nanako3@bluebottle.com>
X-From: git-owner@vger.kernel.org Mon Jun 25 09:45:26 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I2jGH-00047L-OX
	for gcvg-git@gmane.org; Mon, 25 Jun 2007 09:45:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750831AbXFYHpY (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 25 Jun 2007 03:45:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750781AbXFYHpY
	(ORCPT <rfc822;git-outgoing>); Mon, 25 Jun 2007 03:45:24 -0400
Received: from mail.gmx.net ([213.165.64.20]:38479 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1750718AbXFYHpX (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 25 Jun 2007 03:45:23 -0400
Received: (qmail invoked by alias); 25 Jun 2007 07:45:22 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO localhost) [132.187.25.13]
  by mail.gmx.net (mp036) with SMTP; 25 Jun 2007 09:45:22 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1+NxIUBGWGNCEgkPe/Qhzvzm4GPDGrgSKUPa0xYe/
	52MYdS1ySoICn6
X-X-Sender: gene099@racer.site
In-Reply-To: <200706250632.l5P6Wu6B028140@mi0.bluebottle.com>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/50873>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323584-1888209405-1182757517=:4059
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT

Hi,

On Mon, 25 Jun 2007, ã~A~Wã~B~Iã~A~Dã~A~Wã~Aªã~Aªã~A~S wrote:

> Quoting Johannes Schindelin <Johannes.Schindelin@gmx.de>:
> 
> > On Sat, 23 Jun 2007, Nanako Shiraishi wrote:
> > 
> > > Here is how to use my script:
> > > 
> > >     $ git save
> > >     $ git pull
> > >     $ git save restore
> > 
> > This use case has been discussed often, under the name "git-stash".
> > 
> > Ciao,
> > Dscho
> 
> Thank you for your comments.  Do you suggest I rename the script to 
> git-stash and re-submit after fixing according to Junio's comments?

Yes.

Ciao,
Dscho

--8323584-1888209405-1182757517=:4059--
