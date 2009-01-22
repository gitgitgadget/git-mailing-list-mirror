From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: CR codes from git commands
Date: Thu, 22 Jan 2009 17:52:27 +0100 (CET)
Message-ID: <alpine.DEB.1.00.0901221751320.3586@pacific.mpi-cbg.de>
References: <18805.64312.289059.660023@hungover.brentg.com> <alpine.LNX.1.00.0901212319310.19665@iabervon.org> <e38bce640901212334v1e672d48t81d5c81fecd929eb@mail.gmail.com> <alpine.LNX.1.00.0901220238380.19665@iabervon.org> <7vbptzahra.fsf@gitster.siamese.dyndns.org>
 <e2b179460901220204x7b6a43b5hddfee623d2425429@mail.gmail.com> <18808.39712.351656.138702@hungover.brentg.com> <alpine.LNX.1.00.0901221117110.19665@iabervon.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Brent Goodrick <bgoodr@gmail.com>,
	Mike Ralphson <mike.ralphson@gmail.com>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Daniel Barkalow <barkalow@iabervon.org>
X-From: git-owner@vger.kernel.org Thu Jan 22 17:53:51 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LQ2oR-0000KE-4I
	for gcvg-git-2@gmane.org; Thu, 22 Jan 2009 17:53:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754096AbZAVQwZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 22 Jan 2009 11:52:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753992AbZAVQwZ
	(ORCPT <rfc822;git-outgoing>); Thu, 22 Jan 2009 11:52:25 -0500
Received: from mail.gmx.net ([213.165.64.20]:43913 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753951AbZAVQwY (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 22 Jan 2009 11:52:24 -0500
Received: (qmail invoked by alias); 22 Jan 2009 16:52:21 -0000
Received: from pacific.mpi-cbg.de (EHLO pacific.mpi-cbg.de) [141.5.10.38]
  by mail.gmx.net (mp057) with SMTP; 22 Jan 2009 17:52:21 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1+jS5tMqPij58yeVpdfejqNfZVWPgc/8CiOhSBAWE
	J9F7J8xsLiCIef
X-X-Sender: schindelin@pacific.mpi-cbg.de
In-Reply-To: <alpine.LNX.1.00.0901221117110.19665@iabervon.org>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.75
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/106770>

Hi,

On Thu, 22 Jan 2009, Daniel Barkalow wrote:

> In any case, it's all done in progress.c, so it should be easy enough to 
> make changes to if you can come up with something better to do with 
> progress messages and some way to determine when it should be done.

Maybe "git --no-progress <program>" would be a sensible user interface?

Ciao,
Dscho
