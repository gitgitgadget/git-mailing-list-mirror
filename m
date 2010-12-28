From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 16/31] rebase -i: support --stat
Date: Wed, 29 Dec 2010 00:44:03 +0100 (CET)
Message-ID: <alpine.DEB.1.00.1012290040200.1794@bonsai2>
References: <1293528648-21873-1-git-send-email-martin.von.zweigbergk@gmail.com> <1293528648-21873-17-git-send-email-martin.von.zweigbergk@gmail.com> <alpine.DEB.1.00.1012281858300.1794@bonsai2> <7vpqsltqpd.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Martin von Zweigbergk <martin.von.zweigbergk@gmail.com>,
	git@vger.kernel.org, Johannes Sixt <j.sixt@viscovery.net>,
	Christian Couder <chriscool@tuxfamily.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Dec 29 00:44:16 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PXjDC-0002f5-PD
	for gcvg-git-2@lo.gmane.org; Wed, 29 Dec 2010 00:44:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753080Ab0L1XoJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 28 Dec 2010 18:44:09 -0500
Received: from mailout-de.gmx.net ([213.165.64.22]:38261 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with SMTP
	id S1752990Ab0L1XoI (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 28 Dec 2010 18:44:08 -0500
Received: (qmail invoked by alias); 28 Dec 2010 23:44:04 -0000
Received: from ppp-88-217-111-31.dynamic.mnet-online.de (EHLO noname) [88.217.111.31]
  by mail.gmx.net (mp044) with SMTP; 29 Dec 2010 00:44:04 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/HjFcO87XHWOV7itNdoxyTH0eR1s06zxXfl7ICoK
	UhgDa7hkOS8NY1
X-X-Sender: gene099@bonsai2
In-Reply-To: <7vpqsltqpd.fsf@alter.siamese.dyndns.org>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/164297>

Hi,

On Tue, 28 Dec 2010, Junio C Hamano wrote:

> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
> 
> > On Tue, 28 Dec 2010, Martin von Zweigbergk wrote:
> >
> >> diff --git a/git-rebase.sh b/git-rebase.sh
> >> index 229e8d2..0fc580a 100755
> >
> > Hmpf... After a rebasing merge to junio/next:
> 
> The series applied cleanly near the tip of my 'master'.

Sorry, I should have been more specific. I updated to current 'next' 
(a2bc419) of git://repo.or.cz/git.git/.

> Please check tonight's 'pu' where the series is parked.

Thanks, but unfortunately I have to tend to other things now.

Ciao,
Johannes
