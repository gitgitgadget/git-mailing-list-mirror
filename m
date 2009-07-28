From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 0/3 v2] Improve your performance with our patch
Date: Tue, 28 Jul 2009 15:29:22 +0200 (CEST)
Message-ID: <alpine.DEB.1.00.0907281528260.8306@pacific.mpi-cbg.de>
References: <alpine.LNX.2.00.0907280131230.2147@iabervon.org>  <alpine.DEB.1.00.0907281307380.8306@pacific.mpi-cbg.de> <3f4fd2640907280550g22e922fue0bbeeed36fba497@mail.gmail.com>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="8323328-97692666-1248787762=:8306"
Cc: Daniel Barkalow <barkalow@iabervon.org>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Reece Dunn <msclrhd@googlemail.com>
X-From: git-owner@vger.kernel.org Tue Jul 28 15:29:26 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MVmk8-0002c0-Ks
	for gcvg-git-2@gmane.org; Tue, 28 Jul 2009 15:29:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754095AbZG1N3O (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 28 Jul 2009 09:29:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753945AbZG1N3O
	(ORCPT <rfc822;git-outgoing>); Tue, 28 Jul 2009 09:29:14 -0400
Received: from mail.gmx.net ([213.165.64.20]:36895 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753263AbZG1N3N (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 28 Jul 2009 09:29:13 -0400
Received: (qmail invoked by alias); 28 Jul 2009 13:29:12 -0000
Received: from pacific.mpi-cbg.de (EHLO pacific.mpi-cbg.de) [141.5.10.38]
  by mail.gmx.net (mp011) with SMTP; 28 Jul 2009 15:29:12 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/u7Ut1J4XuZZccXzQDcb4lFmIFyV66oCMf3GTrDl
	NG0t+0dpehy4B3
X-X-Sender: schindelin@pacific.mpi-cbg.de
In-Reply-To: <3f4fd2640907280550g22e922fue0bbeeed36fba497@mail.gmail.com>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.63
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/124250>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-97692666-1248787762=:8306
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT

Hi,

On Tue, 28 Jul 2009, Reece Dunn wrote:

> 2009/7/28 Johannes Schindelin <Johannes.Schindelin@gmx.de>:
>
> > On Tue, 28 Jul 2009, Daniel Barkalow wrote:
> >
> >>  Documentation/git-shim.txt           |   37 +++++++++
> >
> > May I re-register my complaint about the naming?
> >
> > I mean, yes, I could think of something even worse when it comes to the
> > (ridiculously bad!) tradition of naming things "porcelain", "plumbing" and
> > "potty", especially when it comes to "pushing objects" and
> > then "pulling".
> >
> > But now that we had a good laugh, it is time to get serious again, and
> > give this child a _way_ better name.
> >
> > I mean, you already had a good name for your foreign scm series.  Why did
> > you give that up in favor of this lousy naming?
> 
> How about git-http?

If 'git-fetch' learns to search for a helper by the name of the protocol 
(as it should learn), this will obviously fail with svn://.

Ciao,
Dscho

--8323328-97692666-1248787762=:8306--
