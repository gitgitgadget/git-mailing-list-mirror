From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: Invalid dates in git log
Date: Wed, 12 Dec 2007 14:59:31 +0000 (GMT)
Message-ID: <Pine.LNX.4.64.0712121457280.27959@racer.site>
References: <34660cca0712120111k3f11769fk1a8cefda3b82683e@mail.gmail.com>
 <20071212092304.GA20799@coredump.intra.peff.net> <7vejds8ddf.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Jeff King <peff@peff.net>,
	Eirik =?utf-8?B?QmrDuHJzbsO4cw==?= <eirbjo@gmail.com>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Dec 12 16:00:22 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J2T4H-0005JQ-VW
	for gcvg-git-2@gmane.org; Wed, 12 Dec 2007 16:00:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754265AbXLLO7f (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 12 Dec 2007 09:59:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753917AbXLLO7e
	(ORCPT <rfc822;git-outgoing>); Wed, 12 Dec 2007 09:59:34 -0500
Received: from mail.gmx.net ([213.165.64.20]:49356 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753850AbXLLO7e (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 12 Dec 2007 09:59:34 -0500
Received: (qmail invoked by alias); 12 Dec 2007 14:59:32 -0000
Received: from unknown (EHLO [138.251.11.74]) [138.251.11.74]
  by mail.gmx.net (mp006) with SMTP; 12 Dec 2007 15:59:32 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1+DpwADQ7aDW2eebSYCiddNtwFUTdy02aV7xm45qH
	NZMbwmsyX0wggN
X-X-Sender: gene099@racer.site
In-Reply-To: <7vejds8ddf.fsf@gitster.siamese.dyndns.org>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/68043>

Hi,

On Wed, 12 Dec 2007, Junio C Hamano wrote:

>     Author:     Len Brown <len.brown@intel.com>
>     AuthorDate: Fri Apr 5 00:07:45 2019 -0500
>     Commit:     Len Brown <len.brown@intel.com>
>     CommitDate: Tue Jul 12 00:12:09 2005 -0400
> 
>     author Len Brown <len.brown@intel.com> 1554440865 -0500
>     committer Len Brown <len.brown@intel.com> 1121141529 -0400
> 
> [...] It looks like quite a random timestamp, and committer timestamp 
> look reasonable, relative to the other commits around it.

It is quite possible that Len Brown had a similar problem to what I 
experienced yesterday: my clock was set one hour and 22 years into the 
future, but I have no idea how that happened.  My only guess is a 
half-succeeded ntpdate call, but somehow I doubt that.

Ciao,
Dscho
