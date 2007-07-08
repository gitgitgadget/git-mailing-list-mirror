From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: git cvsimport branches not consistent with CVS branches
Date: Sun, 8 Jul 2007 12:47:16 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0707081246040.4248@racer.site>
References: <46903396.1010507@heydon.com.au> <20070708054520.GD4087@lavos.net>
 <200707081253.06129.robin.rosenberg.lists@dewire.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Brian Downing <bdowning@lavos.net>,
	Gordon Heydon <gordon@heydon.com.au>, git@vger.kernel.org
To: Robin Rosenberg <robin.rosenberg.lists@dewire.com>
X-From: git-owner@vger.kernel.org Sun Jul 08 13:55:27 2007
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I7VML-0006YB-2r
	for gcvg-git@gmane.org; Sun, 08 Jul 2007 13:55:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752743AbXGHLzG (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 8 Jul 2007 07:55:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754214AbXGHLyy
	(ORCPT <rfc822;git-outgoing>); Sun, 8 Jul 2007 07:54:54 -0400
Received: from mail.gmx.net ([213.165.64.20]:37898 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752743AbXGHLys (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 8 Jul 2007 07:54:48 -0400
Received: (qmail invoked by alias); 08 Jul 2007 11:54:46 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO localhost) [132.187.25.13]
  by mail.gmx.net (mp047) with SMTP; 08 Jul 2007 13:54:46 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/3+V0Nnf73tcVQGKc27iWQxGBXp5B9h0fsesF908
	LmzLO3cnBvPN44
X-X-Sender: gene099@racer.site
In-Reply-To: <200707081253.06129.robin.rosenberg.lists@dewire.com>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/51875>

Hi,

On Sun, 8 Jul 2007, Robin Rosenberg wrote:

> Corecode's fromcvs is pretty fast and incremental and AFAIK accurate.

The only problem is that it is a misnomer: it is not fromcvs, but fromrcs, 
since you have to have access at the _files_. This is not always 
possible.

Ciao,
Dscho
