From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] symlinks.c: small style cleanup
Date: Sun, 7 Jun 2009 16:16:47 +0200 (CEST)
Message-ID: <alpine.DEB.1.00.0906071616060.26154@pacific.mpi-cbg.de>
References: <1244374385-5253-1-git-send-email-barvik@broadpark.no>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Kjetil Barvik <barvik@broadpark.no>
X-From: git-owner@vger.kernel.org Sun Jun 07 16:16:01 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MDJAG-0003Zy-Ok
	for gcvg-git-2@gmane.org; Sun, 07 Jun 2009 16:16:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752859AbZFGOPw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 7 Jun 2009 10:15:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752413AbZFGOPv
	(ORCPT <rfc822;git-outgoing>); Sun, 7 Jun 2009 10:15:51 -0400
Received: from mail.gmx.net ([213.165.64.20]:49551 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751018AbZFGOPv (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 7 Jun 2009 10:15:51 -0400
Received: (qmail invoked by alias); 07 Jun 2009 14:15:52 -0000
Received: from pacific.mpi-cbg.de (EHLO pacific.mpi-cbg.de) [141.5.10.38]
  by mail.gmx.net (mp060) with SMTP; 07 Jun 2009 16:15:52 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1+28ulDV7q2qsiE6EBfLaM7kM8orQRBAq3oT4g46R
	5xdWUNlVxubzaH
X-X-Sender: schindelin@pacific.mpi-cbg.de
In-Reply-To: <1244374385-5253-1-git-send-email-barvik@broadpark.no>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.74
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/120974>

Hi,

On Sun, 7 Jun 2009, Kjetil Barvik wrote:

> Add {}-braces around an else-part, where the if-part already has
> {}-braces.

This is the wrong way round.  We prefer _not_ to add unnecessary braces, 
but do tolerate them from time to time.

Hth,
Dscho
