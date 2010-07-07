From: Andreas Schwab <schwab@linux-m68k.org>
Subject: Re: [PATCH] t/t0006: specify timezone as EST5 not EST to comply with POSIX
Date: Thu, 08 Jul 2010 00:59:27 +0200
Message-ID: <m2tyoasxtc.fsf@igel.home>
References: <20100704110017.GA23121@sigill.intra.peff.net>
	<upBu73z-yHJSTQ58c-Br0BxGwDzKGa1fPzZXA71AfI3kG3dMsRRPOX76JRJVhEOcDGoNaf1z9Lg@cipher.nrlssc.navy.mil>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: peff@peff.net, gitster@pobox.com, git@vger.kernel.org,
	Brandon Casey <drafnel@gmail.com>
To: Brandon Casey <casey@nrlssc.navy.mil>
X-From: git-owner@vger.kernel.org Thu Jul 08 00:59:38 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OWdab-0005Tr-F2
	for gcvg-git-2@lo.gmane.org; Thu, 08 Jul 2010 00:59:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756988Ab0GGW7c (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 7 Jul 2010 18:59:32 -0400
Received: from mail-out.m-online.net ([212.18.0.9]:50504 "EHLO
	mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752334Ab0GGW7b (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 7 Jul 2010 18:59:31 -0400
Received: from frontend1.mail.m-online.net (unknown [192.168.8.180])
	by mail-out.m-online.net (Postfix) with ESMTP id 3FAA91C159E0;
	Thu,  8 Jul 2010 00:59:28 +0200 (CEST)
Received: from igel.home (ppp-88-217-107-219.dynamic.mnet-online.de [88.217.107.219])
	by mail.mnet-online.de (Postfix) with ESMTP id 3219C1C00240;
	Thu,  8 Jul 2010 00:59:28 +0200 (CEST)
Received: by igel.home (Postfix, from userid 501)
	id C0370CA297; Thu,  8 Jul 2010 00:59:27 +0200 (CEST)
X-Yow: I think my CAREER is RUINED!!
In-Reply-To: <upBu73z-yHJSTQ58c-Br0BxGwDzKGa1fPzZXA71AfI3kG3dMsRRPOX76JRJVhEOcDGoNaf1z9Lg@cipher.nrlssc.navy.mil>
	(Brandon Casey's message of "Tue, 6 Jul 2010 18:34:20 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/150514>

Brandon Casey <casey@nrlssc.navy.mil> writes:

> I guess 'EST' is an alias? for EST5EDT?  Linux and Solaris both grok EST
> just fine.  POSIX says the offset is required.  I don't see any mention of
> aliases.

It's a backward-compatible alias in the Olsen database.

Andreas.

-- 
Andreas Schwab, schwab@linux-m68k.org
GPG Key fingerprint = 58CA 54C7 6D53 942B 1756  01D3 44D5 214B 8276 4ED5
"And now for something completely different."
