From: Andreas Schwab <schwab@linux-m68k.org>
Subject: Re: [PATCH] Fix indentation problem in git-ls-files(1)
Date: Fri, 05 Mar 2010 11:08:50 +0100
Message-ID: <m3r5nzw05p.fsf@hase.home>
References: <m2tyswb1jp.fsf@igel.home>
	<7v3a0fr740.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Mar 05 11:09:09 2010
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NnUSu-0006wH-0v
	for gcvg-git-2@lo.gmane.org; Fri, 05 Mar 2010 11:09:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754702Ab0CEKI5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 5 Mar 2010 05:08:57 -0500
Received: from mail-out.m-online.net ([212.18.0.10]:55002 "EHLO
	mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751664Ab0CEKI4 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 5 Mar 2010 05:08:56 -0500
Received: from mail01.m-online.net (mail.m-online.net [192.168.3.149])
	by mail-out.m-online.net (Postfix) with ESMTP id A62191C0019E;
	Fri,  5 Mar 2010 11:08:53 +0100 (CET)
Received: from localhost (dynscan2.mnet-online.de [192.168.6.166])
	by mail.m-online.net (Postfix) with ESMTP id B492F902D1;
	Fri,  5 Mar 2010 11:08:52 +0100 (CET)
X-Virus-Scanned: amavisd-new at mnet-online.de
Received: from mail.mnet-online.de ([192.168.3.149])
	by localhost (dynscan2.mnet-online.de [192.168.6.166]) (amavisd-new, port 10024)
	with ESMTP id jUuW5FZMusJc; Fri,  5 Mar 2010 11:08:51 +0100 (CET)
Received: from hase.home (DSL01.83.171.174.68.ip-pool.NEFkom.net [83.171.174.68])
	by mail.mnet-online.de (Postfix) with ESMTP;
	Fri,  5 Mar 2010 11:08:51 +0100 (CET)
X-Yow: Did you GAIN WEIGHT in th' past 5 MINUTES or am I just DREAMING of two
 BROCCOLI FLORETS lying in an empty GAS TANK?
In-Reply-To: <7v3a0fr740.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
	message of "Thu, 04 Mar 2010 15:37:35 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.1 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/141572>

Junio C Hamano <gitster@pobox.com> writes:

> Both [horizontal] and three colons are something we never have used in the
> existing documentation set.  How confident are you that various versions
> of deployed AsciiDoc people would use all support this?

I'm sorry, but I have no idea.  I just looked at the user guide on the
asciidoc home page, which contais no version information.

Andreas.

-- 
Andreas Schwab, schwab@linux-m68k.org
GPG Key fingerprint = 58CA 54C7 6D53 942B 1756  01D3 44D5 214B 8276 4ED5
"And now for something completely different."
