From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: GitHub linking, was Re: bbchop & Wikipedia's Bayesian search theory
 page
Date: Sun, 16 Aug 2009 19:18:48 +0200 (CEST)
Message-ID: <alpine.DEB.1.00.0908161915040.8306@pacific.mpi-cbg.de>
References: <alpine.DEB.1.00.0908161907580.8306@pacific.mpi-cbg.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
To: git@vger.kernel.org, Scott Chacon <schacon@gmail.com>,
	Ealdwulf Wuffinga <ealdwulf@googlemail.com>
X-From: git-owner@vger.kernel.org Sun Aug 16 19:18:20 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1McjN3-0006Pr-5L
	for gcvg-git-2@gmane.org; Sun, 16 Aug 2009 19:18:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754094AbZHPRSD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 16 Aug 2009 13:18:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754089AbZHPRSD
	(ORCPT <rfc822;git-outgoing>); Sun, 16 Aug 2009 13:18:03 -0400
Received: from mail.gmx.net ([213.165.64.20]:50880 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753054AbZHPRSB (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 16 Aug 2009 13:18:01 -0400
Received: (qmail invoked by alias); 16 Aug 2009 17:18:02 -0000
Received: from pacific.mpi-cbg.de (EHLO pacific.mpi-cbg.de) [141.5.10.38]
  by mail.gmx.net (mp071) with SMTP; 16 Aug 2009 19:18:02 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/1knJIMT/1ThzzSvaaZvyibZ2583WCPy4FhVK5Dc
	/TyQ/xQS4Kf690
X-X-Sender: schindelin@pacific.mpi-cbg.de
In-Reply-To: <alpine.DEB.1.00.0908161907580.8306@pacific.mpi-cbg.de>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.64
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/126065>

Hi,

On Sun, 16 Aug 2009, Johannes Schindelin wrote:

> I tried to find some documentation for Bayesian search theory, but it 
> seems those ridiculous Wikipedia admins struck once again, in their 
> mission to reduce the world's intellect to their own.

Ah, never mind, it seems that they did not delete _this_ page (it would 
have been the third I looked for this week which got deleted and made 
extra hard to find a copy of).

The problem, really, is that the link on the bbchop GitHub site is wrong:

	http://github.com/Ealdwulf/bbchop/tree/master

The issue is that the link incorrectly includes the closing parenthesis.  
It should link to

	http://en.wikipedia.org/wiki/Bayesian_search_theory

not

	http://en.wikipedia.org/wiki/Bayesian_search_theory)

Scott, is it possible to fix that?  Or is the README not magically made 
from the README in the repository (which does not contain HTML markup)?

Ciao,
Dscho
