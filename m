From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: git-branch -m interprets first argument differently when two
 are   supplied
Date: Thu, 14 Feb 2008 17:50:55 +0000 (GMT)
Message-ID: <alpine.LSU.1.00.0802141720100.30505@racer.site>
References: <47B3497A.9050703@nrlssc.navy.mil> <47B3EFC4.1020808@viscovery.net> <47B46C8E.5030905@nrlssc.navy.mil> <alpine.LSU.1.00.0802141648120.30505@racer.site> <47B477B8.5030209@nrlssc.navy.mil>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Johannes Sixt <j.sixt@viscovery.net>,
	Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>
To: Brandon Casey <casey@nrlssc.navy.mil>
X-From: git-owner@vger.kernel.org Thu Feb 14 18:51:52 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JPiFE-0007gr-84
	for gcvg-git-2@gmane.org; Thu, 14 Feb 2008 18:51:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753145AbYBNRvA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 14 Feb 2008 12:51:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753093AbYBNRvA
	(ORCPT <rfc822;git-outgoing>); Thu, 14 Feb 2008 12:51:00 -0500
Received: from mail.gmx.net ([213.165.64.20]:50980 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752510AbYBNRu7 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 14 Feb 2008 12:50:59 -0500
Received: (qmail invoked by alias); 14 Feb 2008 17:50:56 -0000
Received: from unknown (EHLO [138.251.11.74]) [138.251.11.74]
  by mail.gmx.net (mp023) with SMTP; 14 Feb 2008 18:50:56 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/EXDI7X03EKJG8Wu2bJrPgrJEMNwhuZBScDGNpJ/
	HPWxMHcjBbLSu4
X-X-Sender: gene099@racer.site
In-Reply-To: <47B477B8.5030209@nrlssc.navy.mil>
User-Agent: Alpine 1.00 (LSU 882 2007-12-20)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/73899>

Hi,

On Thu, 14 Feb 2008, Brandon Casey wrote:

> Johannes Schindelin wrote:
> > 
> > On Thu, 14 Feb 2008, Brandon Casey wrote:
> > 
> >> It's the two argument case that both expects its arguments in a 
> >> different order than other commands _and_ is dangerous in the case of 
> >> -M.
> > 
> > The order was specifically requested, as "mv" also has that order.
> 
> Did you even read the original message? You point this out like it 
> hasn't already been mentioned.

Yes, I had read it, but I had the impression that the rationale for the 
current behaviour made a heck of a lot of sense.

> >Don't use it, if you don't know what you're doing.
> 
> Gee, thanks for the advice.

You're welcome, as always.

Ciao,
Dscho
