From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] t3411: Fix test 1 for case-insensitive file systems
Date: Tue, 3 Feb 2009 21:16:13 +0100 (CET)
Message-ID: <alpine.DEB.1.00.0902032115570.9822@pacific.mpi-cbg.de>
References: <1233244816-67565-1-git-send-email-benji@silverinsanity.com> <7vocxqf2sf.fsf@gitster.siamese.dyndns.org> <673CE949-5DF9-4970-A739-AA09FCD26D24@silverinsanity.com> <1E104E1B-BFCC-4CFC-9D53-CE89299C9600@silverinsanity.com>
 <alpine.DEB.1.00.0902031752230.6573@intel-tinevez-2-302> <2D4586A6-ADAC-4B6E-8B42-2CBD76E0304C@silverinsanity.com> <alpine.DEB.1.00.0902031817260.6573@intel-tinevez-2-302> <5FE034E8-422F-4692-AD37-5633C91A4B98@silverinsanity.com>
 <alpine.DEB.1.00.0902031918520.9822@pacific.mpi-cbg.de> <34FE2049-0A81-4615-AE3D-46DE35A44011@silverinsanity.com> <7vy6wn9wdj.fsf@gitster.siamese.dyndns.org> <DB993E35-9F82-4451-B681-D1BFE3E9BD45@silverinsanity.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <gitster@pobox.com>, Git List <git@vger.kernel.org>
To: Brian Gernhardt <benji@silverinsanity.com>
X-From: git-owner@vger.kernel.org Tue Feb 03 21:17:11 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LURhm-0003Z8-Cd
	for gcvg-git-2@gmane.org; Tue, 03 Feb 2009 21:17:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751204AbZBCUPn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 3 Feb 2009 15:15:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751117AbZBCUPn
	(ORCPT <rfc822;git-outgoing>); Tue, 3 Feb 2009 15:15:43 -0500
Received: from mail.gmx.net ([213.165.64.20]:42474 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751012AbZBCUPm (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 Feb 2009 15:15:42 -0500
Received: (qmail invoked by alias); 03 Feb 2009 20:15:40 -0000
Received: from pacific.mpi-cbg.de (EHLO pacific.mpi-cbg.de) [141.5.10.38]
  by mail.gmx.net (mp019) with SMTP; 03 Feb 2009 21:15:40 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1+2QkAku8e2AgFC38rpPIwW+T7NYpTPKRoGFJax07
	8BjTDK6/aAZJnw
X-X-Sender: schindelin@pacific.mpi-cbg.de
In-Reply-To: <DB993E35-9F82-4451-B681-D1BFE3E9BD45@silverinsanity.com>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.67
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/108247>

Hi,

On Tue, 3 Feb 2009, Brian Gernhardt wrote:

> On Feb 3, 2009, at 2:02 PM, Junio C Hamano wrote:
> 
> >Brian Gernhardt <benji@silverinsanity.com> writes:
> >
> > >I was irritated by your statement that I "did not look far" because _I
> > >read all those files_.  I gave you the result of reading them which
> > >you seem to have completely ignored, as it was the part of my last e-
> > >mail that you did not quote.
> > >
> > >If you want to double-check me, fine.  But do not claim I did not do
> > >the work.
> >
> >Thanks, both, and let's not be unnecessarily un-nice to each other.
> >
> >I agree that Dscho's "far enough" comment was not the best way to say "I
> >really want to make sure you did verify the way I would myself", but
> >please just let it pass, pretend that he just expressed frustration on his
> >lack of time to do the verification himself with that comment.  Ok?
> 
> Fair enough.  My own word choice wasn't exactly wise, either.  This has been
> an especially frustrating day for me in many other respects and it's affected
> my commentary here.
> 
> Dscho, my apologies.

Accepted, and mine to you.

Ciao,
Dscho
