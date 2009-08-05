From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 07/13] Add a config option for remotes to specify a 
 foreign vcs
Date: Thu, 6 Aug 2009 00:12:55 +0200 (CEST)
Message-ID: <alpine.DEB.1.00.0908060012050.8306@pacific.mpi-cbg.de>
References: <alpine.LNX.2.00.0908050055500.2147@iabervon.org>  <alpine.DEB.1.00.0908052251430.8306@pacific.mpi-cbg.de> <alpine.LNX.2.00.0908051658530.2147@iabervon.org>  <alpine.DEB.1.00.0908052319210.8306@pacific.mpi-cbg.de>
 <fabb9a1e0908051446t63942d21nf71ee0673bb85b8c@mail.gmail.com>  <alpine.DEB.1.00.0908052349250.8306@pacific.mpi-cbg.de> <fabb9a1e0908051453y3bb4b2fax2ab17608436510ca@mail.gmail.com>  <alpine.DEB.1.00.0908060004300.8306@pacific.mpi-cbg.de>
 <fabb9a1e0908051505h671ece4ekef8bb887865a8488@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Daniel Barkalow <barkalow@iabervon.org>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Johan Herland <johan@herland.net>
To: Sverre Rabbelier <srabbelier@gmail.com>
X-From: git-owner@vger.kernel.org Thu Aug 06 00:12:40 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MYoit-0000n5-M3
	for gcvg-git-2@gmane.org; Thu, 06 Aug 2009 00:12:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752826AbZHEWMb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 5 Aug 2009 18:12:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752712AbZHEWMb
	(ORCPT <rfc822;git-outgoing>); Wed, 5 Aug 2009 18:12:31 -0400
Received: from mail.gmx.net ([213.165.64.20]:43277 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752697AbZHEWMa (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 5 Aug 2009 18:12:30 -0400
Received: (qmail invoked by alias); 05 Aug 2009 22:12:30 -0000
Received: from pacific.mpi-cbg.de (EHLO pacific.mpi-cbg.de) [141.5.10.38]
  by mail.gmx.net (mp068) with SMTP; 06 Aug 2009 00:12:30 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1+qNQonhSCqxWkp7EPnkUB/jOpcHtHai6MRtFIZ2k
	dJLSGAh0QGcqxj
X-X-Sender: schindelin@pacific.mpi-cbg.de
In-Reply-To: <fabb9a1e0908051505h671ece4ekef8bb887865a8488@mail.gmail.com>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.64
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/125009>

Hi,

On Wed, 5 Aug 2009, Sverre Rabbelier wrote:

> On Wed, Aug 5, 2009 at 15:04, Johannes 
> Schindelin<Johannes.Schindelin@gmx.de> wrote:
> > Yes, I agree: svn:http:// is much better.
> 
> Was that sarcasm? (I just realized that ':' is also a forbidden 
> character)

No sarcasm needed: the URL svn:http://sverre.ismy.he.ro/ is handled by the 
helper git-remote-svn (not git-remote-svn:http).

Ciao,
Dscho
