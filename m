From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: is there an easier way to do this ?
Date: Thu, 1 Jan 2009 17:55:43 +0100 (CET)
Message-ID: <alpine.DEB.1.00.0901011754130.30769@pacific.mpi-cbg.de>
References: <gjc52u$ehc$4@ger.gmane.org> <m3k59hb6xr.fsf@localhost.localdomain> <gjeacg$3r5$4@ger.gmane.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Zorba <cr@altmore.co.uk>
X-From: git-owner@vger.kernel.org Thu Jan 01 17:56:43 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LIQqf-000378-NS
	for gcvg-git-2@gmane.org; Thu, 01 Jan 2009 17:56:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756383AbZAAQzU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 1 Jan 2009 11:55:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756372AbZAAQzU
	(ORCPT <rfc822;git-outgoing>); Thu, 1 Jan 2009 11:55:20 -0500
Received: from mail.gmx.net ([213.165.64.20]:54473 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1756343AbZAAQzT (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 1 Jan 2009 11:55:19 -0500
Received: (qmail invoked by alias); 01 Jan 2009 16:55:16 -0000
Received: from pacific.mpi-cbg.de (EHLO pacific.mpi-cbg.de) [141.5.10.38]
  by mail.gmx.net (mp049) with SMTP; 01 Jan 2009 17:55:16 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1+iM2gx4+Kiow4TWDcAr8Dc/lTiSlXxYXIqLj0+v4
	TyUoa21LL6SgVs
X-X-Sender: schindelin@pacific.mpi-cbg.de
In-Reply-To: <gjeacg$3r5$4@ger.gmane.org>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.61
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/104303>

Hi,

A: Because it messes up the order in which people normally read text.
Q: Why is top-posting such a bad thing?
A: Top-posting.
Q: What is the most annoying thing on usenet and in e-mail?

On Tue, 30 Dec 2008, Zorba wrote:

> > "Zorba" <cr@altmore.co.uk> writes:
> >
> >> ok, now I'm in this for real, archiving versions of our website project 
> >> (5k
> >> files approx)
> >>
> >> so here is the workflow:
> >>
> >> - copy version 1 files into GIT dir
> >>
> >> - open git bash
> >>
> >> $ git init
> >>
> >> $ git add .
> >>
> >> $ git commit -m "version1"
> >>
> >> all vanilla ? cool
> >> next job = store version 2 [...]
> >
> > Check out contrib/fast-import/import-tars.perl
>
> thanks Jakub, but I don't mind copying the versions in by hand and 
> running the git commits on them sequentially.

It's not only about how much work you are doing.  It's also about 
preserving as much metadata as possible.

Ciao,
Dscho
