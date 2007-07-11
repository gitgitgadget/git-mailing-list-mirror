From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] Document git-filter-branch
Date: Wed, 11 Jul 2007 18:03:02 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0707111800230.4516@racer.site>
References: <Pine.LNX.4.64.0707031746400.4071@racer.site>
 <20070703220540.GN12721@planck.djpig.de> <Pine.LNX.4.64.0707040004200.4071@racer.site>
 <f731u9$1ir$1@sea.gmane.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Frank Lichtenheld <frank@lichtenheld.de>, git@vger.kernel.org
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jul 11 19:10:52 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I8fiF-0002Wr-HO
	for gcvg-git@gmane.org; Wed, 11 Jul 2007 19:10:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755224AbXGKRKs (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 11 Jul 2007 13:10:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754751AbXGKRKs
	(ORCPT <rfc822;git-outgoing>); Wed, 11 Jul 2007 13:10:48 -0400
Received: from mail.gmx.net ([213.165.64.20]:60385 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1754647AbXGKRKr (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 Jul 2007 13:10:47 -0400
Received: (qmail invoked by alias); 11 Jul 2007 17:10:45 -0000
Received: from unknown (EHLO [138.251.11.74]) [138.251.11.74]
  by mail.gmx.net (mp057) with SMTP; 11 Jul 2007 19:10:45 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1+8bu10uD284kfyE4SruzyAwUO87rH6EcDbb4bg/W
	sMerdjE692A0ex
X-X-Sender: gene099@racer.site
In-Reply-To: <f731u9$1ir$1@sea.gmane.org>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/52176>

Hi,

On Wed, 11 Jul 2007, Jakub Narebski wrote:

> Johannes Schindelin wrote:
> > On Wed, 4 Jul 2007, Frank Lichtenheld wrote:
> 
> >>> +Note that since this operation is extensively I/O expensive, it might
> >>> +be a good idea to redirect the temporary directory it off-disk, e.g. on
> 
> By the way, could git-filter-branch use git-fast-import to reduce I/O?

That idea has been kicked around.  But since skimo promised that he works 
on rewrite-commits, which will be much faster.  So I do not see any point 
in working on filter-branch any more.

BTW good to see you back on the list!

Ciao,
Dscho
