From: Andreas Schwab <schwab@linux-m68k.org>
Subject: Re: "git archive" seems to be broken wrt zip files
Date: Wed, 14 Sep 2011 10:32:49 +0200
Message-ID: <m362kv5xse.fsf@hase.home>
References: <CA+55aFx43OxExGNrJs+AyKNtdr+KCZZoE=iaQTz8uHoUSrQv0w@mail.gmail.com>
	<20110911062206.GA29620@sigill.intra.peff.net>
	<20110911062740.GA8018@sigill.intra.peff.net>
	<m239g3i5kz.fsf@igel.home>
	<CA+55aFxsaE5btVJmM_QaUMcDzBg4df-g8X7NknC6t9UM+oQATw@mail.gmail.com>
	<CA+55aFwLk8XcCDXM0w_wf5RnoB4oGxkjJrUGLB5wgSkx385b_g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jeff King <peff@peff.net>,
	=?utf-8?Q?Ren=C3=A9?= Scharfe <rene.scharfe@lsrfire.ath.cx>,
	Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Wed Sep 14 10:33:29 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R3kuO-0001Bm-Jp
	for gcvg-git-2@lo.gmane.org; Wed, 14 Sep 2011 10:33:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753682Ab1INIdX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 14 Sep 2011 04:33:23 -0400
Received: from mail-out.m-online.net ([212.18.0.10]:38747 "EHLO
	mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752811Ab1INIdW (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 Sep 2011 04:33:22 -0400
Received: from frontend1.mail.m-online.net (frontend1.mail.intern.m-online.net [192.168.8.180])
	by mail-out.m-online.net (Postfix) with ESMTP id 344761803514;
	Wed, 14 Sep 2011 10:33:15 +0200 (CEST)
Received: from localhost (dynscan1.mnet-online.de [192.168.8.164])
	by mail.m-online.net (Postfix) with ESMTP id 055101C001A5;
	Wed, 14 Sep 2011 10:32:50 +0200 (CEST)
X-Virus-Scanned: amavisd-new at mnet-online.de
Received: from mail.mnet-online.de ([192.168.8.180])
	by localhost (dynscan1.mail.m-online.net [192.168.8.164]) (amavisd-new, port 10024)
	with ESMTP id O7rwdVCS9qHG; Wed, 14 Sep 2011 10:32:49 +0200 (CEST)
Received: from hase.home (ppp-88-217-112-193.dynamic.mnet-online.de [88.217.112.193])
	by mail.mnet-online.de (Postfix) with ESMTP;
	Wed, 14 Sep 2011 10:32:48 +0200 (CEST)
X-Yow: I'm DESPONDENT...  I hope there's something DEEP-FRIED under this
 miniature DOMED STADIUM...
In-Reply-To: <CA+55aFwLk8XcCDXM0w_wf5RnoB4oGxkjJrUGLB5wgSkx385b_g@mail.gmail.com>
	(Linus Torvalds's message of "Tue, 13 Sep 2011 23:55:39 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/181346>

Linus Torvalds <torvalds@linux-foundation.org> writes:

>> Is this problem known to the unzip developers?

I have already sent them the patch and they have acknowledged it.

Andreas.

-- 
Andreas Schwab, schwab@linux-m68k.org
GPG Key fingerprint = 58CA 54C7 6D53 942B 1756  01D3 44D5 214B 8276 4ED5
"And now for something completely different."
