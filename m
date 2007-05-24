From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [RFC] Fourth round of support for cloning submodules
Date: Thu, 24 May 2007 14:14:43 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0705241414280.4648@racer.site>
References: <Pine.LNX.4.64.0705240039370.4113@racer.site> 
 <7vtzu3yrh9.fsf@assigned-by-dhcp.cox.net> <20070524072216.GE942MdfPADPa@greensroom.kotnet.org>
  <20070524072945.GO28023@spearce.org> <20070524073652.GH942MdfPADPa@greensroom.kotnet.org>
  <Pine.LNX.4.64.0705241039200.4648@racer.site> <20070524105112.GI942MdfPADPa@greensroom.kotnet.org>
  <Pine.LNX.4.64.0705241201270.4648@racer.site> <20070524111645.GK942MdfPADPa@greensroom.kotnet.org>
  <Pine.LNX.4.64.0705241230410.4648@racer.site> <20070524114354.GN942MdfPADPa@greensroom.kotnet.org>
 <Pine.LNX.4.64.0705241315290.4648@racer.site> <465583C7.32BC66BB@eudaptics.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Sven Verdoolaege <skimo@kotnet.org>, git@vger.kernel.org
To: Johannes Sixt <J.Sixt@eudaptics.com>
X-From: git-owner@vger.kernel.org Thu May 24 15:14:59 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HrD9b-0003jY-DI
	for gcvg-git@gmane.org; Thu, 24 May 2007 15:14:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755994AbXEXNOw (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 24 May 2007 09:14:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756066AbXEXNOw
	(ORCPT <rfc822;git-outgoing>); Thu, 24 May 2007 09:14:52 -0400
Received: from mail.gmx.net ([213.165.64.20]:36990 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1755994AbXEXNOv (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 24 May 2007 09:14:51 -0400
Received: (qmail invoked by alias); 24 May 2007 13:14:49 -0000
Received: from unknown (EHLO [138.251.11.74]) [138.251.11.74]
  by mail.gmx.net (mp032) with SMTP; 24 May 2007 15:14:49 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX18/kDIr/Gw/7Ps3FItmNYovH36JVsPcA7I08lk4Gw
	YYGe2xWu3VSI1D
X-X-Sender: gene099@racer.site
In-Reply-To: <465583C7.32BC66BB@eudaptics.com>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/48257>

Hi,

On Thu, 24 May 2007, Johannes Sixt wrote:

> Johannes Schindelin wrote:
> > I was more thinking about something like this:
> > 3fa7ded19a8da868d3af7c942f86358e6720f0c7        refs/heads/submodule^{URL:/home/sverdool/public_html/cloog.git}
> 
> where 3fa7ded... is the commit (gitlink) that appears in the tree?

Yes.

Ciao,
Dscho
