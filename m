From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 1/6] Rename path_list to string_list
Date: Tue, 11 Mar 2008 17:26:18 +0100 (CET)
Message-ID: <alpine.LSU.1.00.0803111725480.3873@racer.site>
References: <alpine.LSU.1.00.0802290144130.22527@racer.site> <alpine.LSU.1.00.0802290144410.22527@racer.site> <7vprugfrgw.fsf@gitster.siamese.dyndns.org> <alpine.LSU.1.00.0802290214150.22527@racer.site> <alpine.LSU.1.00.0803011313020.22527@racer.site>
 <alpine.LSU.1.00.0803011315180.22527@racer.site> <87iqztz0z5.fsf@lysator.liu.se>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="8323584-1533844090-1205252778=:3873"
Cc: git@vger.kernel.org
To: =?ISO-8859-15?Q?David_K=E5gedal?= <davidk@lysator.liu.se>
X-From: git-owner@vger.kernel.org Tue Mar 11 17:27:37 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JZ7Jc-0007OC-CE
	for gcvg-git-2@gmane.org; Tue, 11 Mar 2008 17:27:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751538AbYCKQ0O (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 11 Mar 2008 12:26:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751519AbYCKQ0O
	(ORCPT <rfc822;git-outgoing>); Tue, 11 Mar 2008 12:26:14 -0400
Received: from mail.gmx.net ([213.165.64.20]:45369 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751499AbYCKQ0N (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 11 Mar 2008 12:26:13 -0400
Received: (qmail invoked by alias); 11 Mar 2008 16:26:11 -0000
Received: from unknown (EHLO [138.251.11.74]) [138.251.11.74]
  by mail.gmx.net (mp042) with SMTP; 11 Mar 2008 17:26:11 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1+XHp5eHimX1iQPUDyZBsWUPqDJlvvWTMW3zIhLGN
	rJ8wwPP1V4TH8L
X-X-Sender: gene099@racer.site
In-Reply-To: <87iqztz0z5.fsf@lysator.liu.se>
User-Agent: Alpine 1.00 (LSU 882 2007-12-20)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/76878>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323584-1533844090-1205252778=:3873
Content-Type: TEXT/PLAIN; charset=utf-8
Content-Transfer-Encoding: 8BIT

Hi,

On Tue, 11 Mar 2008, David Kågedal wrote:

> The following message is a courtesy copy of an article
> that has been posted to gmane.comp.version-control.git as well.

I hate having to readd the Cc: to the list.

> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
> 
> > diff --git a/Documentation/technical/api-path-list.txt b/Documentation/technical/api-path-list.txt
> > index d077683..8892cf0 100644
> > --- a/Documentation/technical/api-path-list.txt
> > +++ b/Documentation/technical/api-path-list.txt
> > @@ -1,7 +1,7 @@
> > -path-list API
> > +string-list API
> >  =============
> 
> Looks like you'll want to add two = here.

Yes.

Ciao,
Dscho

--8323584-1533844090-1205252778=:3873--
