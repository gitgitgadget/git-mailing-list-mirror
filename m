From: Thomas Rast <trast@student.ethz.ch>
Subject: Re: Fix signal handler
Date: Wed, 3 Feb 2010 14:12:52 +0100
Message-ID: <201002031412.53195.trast@student.ethz.ch>
References: <4B684F5F.7020409@web.de> <20100203102915.GA25486@coredump.intra.peff.net> <4B696447.10803@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Cc: Jeff King <peff@peff.net>, <git@vger.kernel.org>
To: Markus Elfring <Markus.Elfring@web.de>
X-From: git-owner@vger.kernel.org Wed Feb 03 14:16:19 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ncf5J-0005xY-Vs
	for gcvg-git-2@lo.gmane.org; Wed, 03 Feb 2010 14:15:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757266Ab0BCNM4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 3 Feb 2010 08:12:56 -0500
Received: from gwse.ethz.ch ([129.132.178.237]:30671 "EHLO gwse.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755359Ab0BCNMz (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Feb 2010 08:12:55 -0500
Received: from CAS00.d.ethz.ch (129.132.178.234) by gws00.d.ethz.ch
 (129.132.178.237) with Microsoft SMTP Server (TLS) id 8.2.234.1; Wed, 3 Feb
 2010 14:12:53 +0100
Received: from thomas.localnet (129.132.153.233) by mail.ethz.ch
 (129.132.178.227) with Microsoft SMTP Server (TLS) id 8.2.213.0; Wed, 3 Feb
 2010 14:12:53 +0100
User-Agent: KMail/1.13.0 (Linux/2.6.31.8-0.1-desktop; KDE/4.3.98; x86_64; ; )
In-Reply-To: <4B696447.10803@web.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/138832>

On Wednesday 03 February 2010 12:55:51 Markus Elfring wrote:
> [Jeff King wrote:]
> >
> > I think it is simply impractical.
> 
> I have got the opposite opinion.

You've been wasting two regular contributors' (Avery and Peff) time on
issues they point out are impractical to fix, while demonstrating that
you have enough standards and C knowledge to do the fix yourself.

So why don't you post patches (either fixes or testcases exhibiting
the issue) instead of more mails containing the same points?  This is,
after all, an open source project.

-- 
Thomas Rast
trast@{inf,student}.ethz.ch
