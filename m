From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH/RFC] builtin-checkout: suggest creating local branch when
 appropriate to do so
Date: Fri, 16 Oct 2009 13:48:39 +0200 (CEST)
Message-ID: <alpine.DEB.1.00.0910161346560.4985@pacific.mpi-cbg.de>
References: <0016e68fd0123a175304754694b4@google.com> <7vhbu2syi6.fsf@alter.siamese.dyndns.org> <alpine.DEB.1.00.0910140108110.4985@pacific.mpi-cbg.de> <200910141133.11386.trast@student.ethz.ch>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Johannes Sixt <j.sixt@viscovery.net>, Euguess@gmail.com,
	Mikael Magnusson <mikachu@gmail.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Jay Soffian <jaysoffian@gmail.com>, git@vger.kernel.org
To: Thomas Rast <trast@student.ethz.ch>
X-From: git-owner@vger.kernel.org Fri Oct 16 13:49:12 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MylIo-0003kB-IC
	for gcvg-git-2@lo.gmane.org; Fri, 16 Oct 2009 13:48:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758868AbZJPLqm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 16 Oct 2009 07:46:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758845AbZJPLqm
	(ORCPT <rfc822;git-outgoing>); Fri, 16 Oct 2009 07:46:42 -0400
Received: from mail.gmx.net ([213.165.64.20]:53145 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1758843AbZJPLqm (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 16 Oct 2009 07:46:42 -0400
Received: (qmail invoked by alias); 16 Oct 2009 11:45:54 -0000
Received: from pacific.mpi-cbg.de (EHLO pacific.mpi-cbg.de) [141.5.10.38]
  by mail.gmx.net (mp071) with SMTP; 16 Oct 2009 13:45:54 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX19pnN55+ZZp2FE6WnWcWaMNzk0pADu7xY7H2oImIG
	FqnuWa4AbiUUP+
X-X-Sender: schindelin@pacific.mpi-cbg.de
In-Reply-To: <200910141133.11386.trast@student.ethz.ch>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.71
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/130481>

Hi,

On Wed, 14 Oct 2009, Thomas Rast wrote:

> [On the other hand, some users appear unwilling to learn something new 
> because they "just want to version control this" or "just need to make a 
> commit to this project".]

Frankly, if the choice is between "I just want to make a commit to this 
project" and "Then I'll not use version control at all", I'd rather choose 
the former.

Which is exactly what I did the other day, having to write a non-trivial 
script to allow the user to do what he wants to do.

Ciao,
Dscho
