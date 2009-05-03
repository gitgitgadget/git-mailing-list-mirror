From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [JGIT PATCH 0/6] Diff processing utilities
Date: Sun, 3 May 2009 16:24:52 +0200 (CEST)
Message-ID: <alpine.DEB.1.00.0905031623060.18521@pacific.mpi-cbg.de>
References: <1241230127-28279-1-git-send-email-spearce@spearce.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Robin Rosenberg <robin.rosenberg@dewire.com>, git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Sun May 03 16:24:41 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M0ccS-0002lj-DV
	for gcvg-git-2@gmane.org; Sun, 03 May 2009 16:24:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754178AbZECOY2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 3 May 2009 10:24:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752408AbZECOY2
	(ORCPT <rfc822;git-outgoing>); Sun, 3 May 2009 10:24:28 -0400
Received: from mail.gmx.net ([213.165.64.20]:47369 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751791AbZECOY1 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 3 May 2009 10:24:27 -0400
Received: (qmail invoked by alias); 03 May 2009 14:24:26 -0000
Received: from pacific.mpi-cbg.de (EHLO pacific.mpi-cbg.de) [141.5.10.38]
  by mail.gmx.net (mp003) with SMTP; 03 May 2009 16:24:26 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX189UTxqQc890YwuDBelxj/u6AfwPirco3f/lY0Y5D
	H8H6JJPSqQsAzi
X-X-Sender: schindelin@pacific.mpi-cbg.de
In-Reply-To: <1241230127-28279-1-git-send-email-spearce@spearce.org>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.67
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/118176>

Hi,

On Fri, 1 May 2009, Shawn O. Pearce wrote:

> To be clear, this series *does not* contain a way to create a diff. 
> Dscho wrote much more code which is not yet ready for inclusion.

Indeed.  I'm on it.

> Dscho, can you give us yea-or-nay for SBO lines for the patches
> I've attributed to you?

Yays!

(I had only time to look over them once, but as I am working on the diff 
stuff again, I think I'll be able to find bugs on the go ;-)

Many thanks to you and Robin for finding bugs early!

Ciao,
Dscho
