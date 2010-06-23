From: Andreas Schwab <schwab@linux-m68k.org>
Subject: Re: Newbie question: how can I list added files?
Date: Wed, 23 Jun 2010 22:04:30 +0200
Message-ID: <m2aaqlh5wx.fsf@igel.home>
References: <AANLkTinxOE5xcP_V-PvoZGlfsxtcCafoYKy_PuBZnQnQ@mail.gmail.com>
	<7vzkylejbf.fsf@alter.siamese.dyndns.org>
	<AANLkTikE2ylLXk5XxNGvcvol6R-puSTzPurdLcNMYaZJ@mail.gmail.com>
	<20100623183050.GA20842@coredump.intra.peff.net>
	<AANLkTin-MEBUYheTkFbeKIBj5peVV-sPa7hZSg-wMgBi@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
	GIT List <git@vger.kernel.org>
To: Bruce Korb <bruce.korb@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jun 23 22:04:42 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ORWBe-0007FL-2Q
	for gcvg-git-2@lo.gmane.org; Wed, 23 Jun 2010 22:04:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751794Ab0FWUEh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 23 Jun 2010 16:04:37 -0400
Received: from mail-out.m-online.net ([212.18.0.10]:48065 "EHLO
	mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751470Ab0FWUEg (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 23 Jun 2010 16:04:36 -0400
Received: from frontend1.mail.m-online.net (unknown [192.168.8.180])
	by mail-out.m-online.net (Postfix) with ESMTP id 9A78F1C007D3;
	Wed, 23 Jun 2010 22:04:31 +0200 (CEST)
Received: from igel.home (ppp-88-217-123-134.dynamic.mnet-online.de [88.217.123.134])
	by mail.mnet-online.de (Postfix) with ESMTP id 8E40A1C000B6;
	Wed, 23 Jun 2010 22:04:31 +0200 (CEST)
Received: by igel.home (Postfix, from userid 501)
	id 3492ECA297; Wed, 23 Jun 2010 22:04:31 +0200 (CEST)
X-Yow: NATHAN...  your PARENTS were in a CARCRASH!!
 They're VOIDED - They COLLAPSED
 They had no CHAINSAWS...  They had no MONEY MACHINES...
 They did PILLS in SKIMPY GRASS SKIRTS...
 Nathan, I EMULATED them...  but they were OFF-KEY...
In-Reply-To: <AANLkTin-MEBUYheTkFbeKIBj5peVV-sPa7hZSg-wMgBi@mail.gmail.com>
	(Bruce Korb's message of "Wed, 23 Jun 2010 12:15:57 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/149545>

Bruce Korb <bruce.korb@gmail.com> writes:

>    alias git-ls-staged="git diff --cached --name-only"

Or: git config alias.ls-staged "diff --cached --name-only"

(Perhaps add --global.)

Andreas.

-- 
Andreas Schwab, schwab@linux-m68k.org
GPG Key fingerprint = 58CA 54C7 6D53 942B 1756  01D3 44D5 214B 8276 4ED5
"And now for something completely different."
