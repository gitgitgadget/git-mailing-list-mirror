From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: Git Option/Subcommand Processing Library?
Date: Sun, 26 Jul 2009 01:18:25 +0200 (CEST)
Message-ID: <alpine.DEB.1.00.0907260117540.8306@pacific.mpi-cbg.de>
References: <231BD892-07B1-452C-A224-047829E21991@gmail.com> <alpine.DEB.1.00.0907251830420.8306@pacific.mpi-cbg.de> <D30CE3A7-176D-4132-88A6-23C46A4EA185@gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Michael Bergin <michaeljbergin@gmail.com>
X-From: git-owner@vger.kernel.org Sun Jul 26 01:18:34 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MUqVd-0001Hn-JY
	for gcvg-git-2@gmane.org; Sun, 26 Jul 2009 01:18:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752289AbZGYXSW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 25 Jul 2009 19:18:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752242AbZGYXSW
	(ORCPT <rfc822;git-outgoing>); Sat, 25 Jul 2009 19:18:22 -0400
Received: from mail.gmx.net ([213.165.64.20]:50546 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751618AbZGYXSV (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 25 Jul 2009 19:18:21 -0400
Received: (qmail invoked by alias); 25 Jul 2009 23:18:20 -0000
Received: from pacific.mpi-cbg.de (EHLO pacific.mpi-cbg.de) [141.5.10.38]
  by mail.gmx.net (mp070) with SMTP; 26 Jul 2009 01:18:20 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1+g4qx+y/ag6okj/wl5hpqPHfKtmiEEUnUr+POf7H
	5pLWmPQCJq1QN8
X-X-Sender: schindelin@pacific.mpi-cbg.de
In-Reply-To: <D30CE3A7-176D-4132-88A6-23C46A4EA185@gmail.com>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.71
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/124093>

Hi,

On Sat, 25 Jul 2009, Michael Bergin wrote:

> Thanks for the pointers.  I also want to create a generic library for 
> command facades like git.  For that I will probably use git.c as a guide 
> but to make it generic I would need to add/rearrange code.  GPLv2 works 
> fine for my purposes.  I hope this isn't an offensive question or 
> anything but would releasing just the library under LGPL be considered?

You need to ask all authors of all the code you reuse.  I, for one, have 
no objections.

Ciao,
Dscho
