From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] user.default: New config to prevent using the default
 values for user.*
Date: Sat, 8 Mar 2008 03:22:26 +0100 (CET)
Message-ID: <alpine.LSU.1.00.0803080321380.3975@racer.site>
References: <1204744684-2043-1-git-send-email-sbejar@gmail.com> <20080305204414.GB4877@steel.home> <8aa486160803061345k690af0dcv14fe5d62b310ad6f@mail.gmail.com> <20080307164111.GB4899@steel.home> <8aa486160803071613pdacc88fkabc10f52da56ad5d@mail.gmail.com>
 <alpine.LSU.1.00.0803080223030.3975@racer.site> <7v7igeynl5.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: =?ISO-8859-15?Q?Santi_B=E9jar?= <sbejar@gmail.com>,
	Alex Riesen <raa.lkml@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Mar 08 03:23:29 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JXoib-0004RG-C2
	for gcvg-git-2@gmane.org; Sat, 08 Mar 2008 03:23:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756702AbYCHCWZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 7 Mar 2008 21:22:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756448AbYCHCWY
	(ORCPT <rfc822;git-outgoing>); Fri, 7 Mar 2008 21:22:24 -0500
Received: from mail.gmx.net ([213.165.64.20]:47521 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1754727AbYCHCWY (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 7 Mar 2008 21:22:24 -0500
Received: (qmail invoked by alias); 08 Mar 2008 02:22:22 -0000
Received: from host86-138-198-40.range86-138.btcentralplus.com (EHLO racer.home) [86.138.198.40]
  by mail.gmx.net (mp057) with SMTP; 08 Mar 2008 03:22:22 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/Dfn9MVcrD5nMr6zBt1EFArHWLtLeyA62ABpbNIv
	Mgt7/YSw14creZ
X-X-Sender: gene099@racer.site
In-Reply-To: <7v7igeynl5.fsf@gitster.siamese.dyndns.org>
User-Agent: Alpine 1.00 (LSU 882 2007-12-20)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/76543>

Hi,

On Fri, 7 Mar 2008, Junio C Hamano wrote:

> So I'd even argue that Santi's change to the message is an improvement 
> that removes geekspeak that is not particularly useful to the end user 
> in this context.
> 
> However, I would also say that this message improvement does not belong 
> to user.default or whatever the configuration variable is called in this 
> round of proposal.  It should be a separate patch, and it would be a 
> much easier sell than the rest of the patch series.

That was the whole point of Alex' criticism.  I was slightly irritated 
that his comments elicited a criticism of their own.

Sorry for that,
Dscho

