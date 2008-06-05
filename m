From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] use natural ordering to display list of branches.
Date: Thu, 5 Jun 2008 20:43:02 +0100 (BST)
Message-ID: <alpine.DEB.1.00.0806052042341.21190@racer>
References: <d45085aa0806051041y42ce467fq2e07371d225ccca3@mail.gmail.com> <alpine.DEB.1.00.0806051946100.21190@racer> <7vprqv1y0w.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Cedric Vivier <cedricv@neonux.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Jun 05 21:46:28 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K4LOl-00070i-W0
	for gcvg-git-2@gmane.org; Thu, 05 Jun 2008 21:45:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754361AbYFEToa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 5 Jun 2008 15:44:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753309AbYFEToa
	(ORCPT <rfc822;git-outgoing>); Thu, 5 Jun 2008 15:44:30 -0400
Received: from mail.gmx.net ([213.165.64.20]:40725 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751466AbYFETo3 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 5 Jun 2008 15:44:29 -0400
Received: (qmail invoked by alias); 05 Jun 2008 19:44:27 -0000
Received: from pacific.mpi-cbg.de (EHLO [10.8.0.10]) [141.5.10.38]
  by mail.gmx.net (mp039) with SMTP; 05 Jun 2008 21:44:27 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/VZaFs9rjVmdjeRhkAW3aBeRWXGt/+ptk9DL4azt
	rsQ+axeGpv4uoW
X-X-Sender: gene099@racer
In-Reply-To: <7vprqv1y0w.fsf@gitster.siamese.dyndns.org>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/83963>

Hi,

On Thu, 5 Jun 2008, Junio C Hamano wrote:

> Perhaps, as long as we somehow mark clearly the new files added with this
> patch as "borrowed code" and not part of git proper, so that people do not
> imitate tons of style issues these files have.

Right.  Maybe compat/?

Ciao,
Dscho
