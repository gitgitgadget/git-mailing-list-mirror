From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [TOY PATCH] git bisect: introduce 'fixed' and 'unfixed'
Date: Tue, 24 Jun 2008 15:55:48 +0100 (BST)
Message-ID: <alpine.DEB.1.00.0806241555300.9925@racer>
References: <alpine.DEB.1.00.0806241515460.9925@racer> <20080624144254.GG5528@leksak.fem-net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Stephan Beyer <s-beyer@gmx.net>
X-From: git-owner@vger.kernel.org Tue Jun 24 16:59:58 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KB9zk-0007T5-Co
	for gcvg-git-2@gmane.org; Tue, 24 Jun 2008 16:59:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759560AbYFXO5w (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 24 Jun 2008 10:57:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756700AbYFXO5v
	(ORCPT <rfc822;git-outgoing>); Tue, 24 Jun 2008 10:57:51 -0400
Received: from mail.gmx.net ([213.165.64.20]:37062 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1758256AbYFXO5v (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 Jun 2008 10:57:51 -0400
Received: (qmail invoked by alias); 24 Jun 2008 14:57:49 -0000
Received: from almond.st-and.ac.uk (EHLO almond.st-and.ac.uk) [138.251.155.241]
  by mail.gmx.net (mp037) with SMTP; 24 Jun 2008 16:57:49 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX18+DLZh8Ec+LADA8AKLsgEt/4a1eoBWOCemK4LzCE
	tNNrwuDFAOBWii
X-X-Sender: gene099@racer
In-Reply-To: <20080624144254.GG5528@leksak.fem-net>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/86068>

Hi,

On Tue, 24 Jun 2008, Stephan Beyer wrote:

> > So introduce the commands 'git bisect fixed' and 'git bisect unfixed'.
> 
> Are they intentionally undocumented to not raise confusion?

Umm.  Which part of "TOY" is unclear?

Ciao,
Dscho
