From: Andreas Schwab <schwab@linux-m68k.org>
Subject: Re: change remote to track new branch
Date: Sat, 03 Aug 2013 18:41:46 +0200
Message-ID: <87iozmhgl1.fsf@igel.home>
References: <20130803024032.GA28666@analysisandsolutions.com>
	<m2d2pvp7nw.fsf@linux-m68k.org>
	<20130803162821.GA945@analysisandsolutions.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Git Mailing List <git@vger.kernel.org>
To: Daniel Convissor <danielc@analysisandsolutions.com>
X-From: git-owner@vger.kernel.org Sat Aug 03 18:41:58 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V5etw-00055X-2q
	for gcvg-git-2@plane.gmane.org; Sat, 03 Aug 2013 18:41:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751558Ab3HCQlw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 3 Aug 2013 12:41:52 -0400
Received: from mail-out.m-online.net ([212.18.0.10]:59980 "EHLO
	mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751044Ab3HCQlv (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 3 Aug 2013 12:41:51 -0400
Received: from frontend1.mail.m-online.net (frontend1.mail.intern.m-online.net [192.168.8.180])
	by mail-out.m-online.net (Postfix) with ESMTP id 3c6rcF0Gfsz3hhYD;
	Sat,  3 Aug 2013 18:41:48 +0200 (CEST)
Received: from localhost (dynscan1.mnet-online.de [192.168.6.68])
	by mail.m-online.net (Postfix) with ESMTP id 3c6rcD4JttzbbgW;
	Sat,  3 Aug 2013 18:41:48 +0200 (CEST)
X-Virus-Scanned: amavisd-new at mnet-online.de
Received: from mail.mnet-online.de ([192.168.8.180])
	by localhost (dynscan1.mail.m-online.net [192.168.6.68]) (amavisd-new, port 10024)
	with ESMTP id d88cIkmggrpk; Sat,  3 Aug 2013 18:41:46 +0200 (CEST)
X-Auth-Info: rBRrC9ZzDUsvHHUbL3s+ZyWRsyjuX8S8RgmIbY4hfes=
Received: from igel.home (ppp-93-104-143-60.dynamic.mnet-online.de [93.104.143.60])
	by mail.mnet-online.de (Postfix) with ESMTPA;
	Sat,  3 Aug 2013 18:41:46 +0200 (CEST)
Received: by igel.home (Postfix, from userid 1000)
	id 9B20F2C13A4; Sat,  3 Aug 2013 18:41:46 +0200 (CEST)
X-Yow: I guess it was all a DREAM..  or an episode of HAWAII FIVE-O...
In-Reply-To: <20130803162821.GA945@analysisandsolutions.com> (Daniel
	Convissor's message of "Sat, 3 Aug 2013 12:28:21 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/231603>

Daniel Convissor <danielc@analysisandsolutions.com> writes:

> Thanks.  Those commands were introduced in 1.8.  Is there a way to do it
> in 1.7, please?

Use git config.

Andreas.

-- 
Andreas Schwab, schwab@linux-m68k.org
GPG Key fingerprint = 58CA 54C7 6D53 942B 1756  01D3 44D5 214B 8276 4ED5
"And now for something completely different."
