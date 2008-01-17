From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: FYI: Reply from HP-UX
Date: Thu, 17 Jan 2008 18:24:29 +0000 (GMT)
Message-ID: <alpine.LSU.1.00.0801171823500.5731@racer.site>
References: <20080117141143.38a88c7a@pc09.procura.nl> <alpine.LSU.1.00.0801171655570.5731@racer.site> <20080117185514.621525a6@pc09.procura.nl> <alpine.LSU.1.00.0801171811480.5731@racer.site> <20080117192154.5634c62d@pc09.procura.nl>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org,
	Richard Lloyd <richard.lloyd@connectinternetsolutions.com>
To: "H.Merijn Brand" <h.m.brand@xs4all.nl>
X-From: git-owner@vger.kernel.org Thu Jan 17 19:25:09 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JFZQF-0004jZ-6H
	for gcvg-git-2@gmane.org; Thu, 17 Jan 2008 19:25:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751542AbYAQSYf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 17 Jan 2008 13:24:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751482AbYAQSYf
	(ORCPT <rfc822;git-outgoing>); Thu, 17 Jan 2008 13:24:35 -0500
Received: from mail.gmx.net ([213.165.64.20]:52332 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751456AbYAQSYe (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 17 Jan 2008 13:24:34 -0500
Received: (qmail invoked by alias); 17 Jan 2008 18:24:32 -0000
Received: from unknown (EHLO [138.251.11.74]) [138.251.11.74]
  by mail.gmx.net (mp058) with SMTP; 17 Jan 2008 19:24:32 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX18Av5Qlv+wAjxA+FvB4mv2xodOfoNrVNt+UJhVCRK
	+A4mxXZD6xjRbl
X-X-Sender: gene099@racer.site
In-Reply-To: <20080117192154.5634c62d@pc09.procura.nl>
User-Agent: Alpine 1.00 (LSU 882 2007-12-20)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/70893>

Hi,

On Thu, 17 Jan 2008, H.Merijn Brand wrote:

> On Thu, 17 Jan 2008 18:14:00 +0000 (GMT), Johannes Schindelin
> <Johannes.Schindelin@gmx.de> wrote:
> 
> > On Thu, 17 Jan 2008, H.Merijn Brand wrote:
> > 
> > > $ ./configure --prefix=/pro/local --disable-nls --without-iconv --with-perl=/pro/bin/perl
> > 
> > I guess that my suggestion doesn't work... Your perl is not in 
> > /usr/local/bin...
> 
> This was *my* CONF, not Richard's!

The point is: it should not be part of the Makefile if not most of the 
people have that setup.

Ciao,
Dscho
