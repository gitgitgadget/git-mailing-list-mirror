From: Andreas Schwab <schwab@linux-m68k.org>
Subject: Re: [Query] Can we ignore case for commiters name in shortlog?
Date: Fri, 30 Nov 2012 14:07:16 +0100
Message-ID: <m27gp3jl2z.fsf@igel.home>
References: <CAOh2x==NBeeoE2=PhaDC143ZF_xHKD5m=Po+-DS2X43CEeGiEQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: viresh kumar <viresh.kumar@linaro.org>
X-From: git-owner@vger.kernel.org Fri Nov 30 14:07:39 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TeQJf-0004TB-6r
	for gcvg-git-2@plane.gmane.org; Fri, 30 Nov 2012 14:07:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030200Ab2K3NHY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 30 Nov 2012 08:07:24 -0500
Received: from mail-out.m-online.net ([212.18.0.10]:34090 "EHLO
	mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932223Ab2K3NHX (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 30 Nov 2012 08:07:23 -0500
Received: from frontend1.mail.m-online.net (frontend1.mail.intern.m-online.net [192.168.8.180])
	by mail-out.m-online.net (Postfix) with ESMTP id 3YCbVF4d1rz3hjNS;
	Fri, 30 Nov 2012 14:07:17 +0100 (CET)
X-Auth-Info: mFVibkdknAMstmIznzjthCWgbHXWBqbNVDt86kusDec=
Received: from igel.home (ppp-88-217-110-32.dynamic.mnet-online.de [88.217.110.32])
	by mail.mnet-online.de (Postfix) with ESMTPA id 3YCbVF436szbbh7;
	Fri, 30 Nov 2012 14:07:17 +0100 (CET)
Received: by igel.home (Postfix, from userid 501)
	id EE74ECA2A4; Fri, 30 Nov 2012 14:07:16 +0100 (CET)
X-Yow: Now KEN is having a MENTAL CRISIS because his "R.V." PAYMENTS are
 OVER-DUE!!
In-Reply-To: <CAOh2x==NBeeoE2=PhaDC143ZF_xHKD5m=Po+-DS2X43CEeGiEQ@mail.gmail.com>
	(viresh kumar's message of "Fri, 30 Nov 2012 07:39:03 +0530")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.2.90 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/210922>

viresh kumar <viresh.kumar@linaro.org> writes:

> I was just thinking if we can ignore case for commiter name while
> listing stuff here?
> So, that we get over any manual mistakes from commiter.

See git-shortlog(1), section Mapping Authors.

Andreas.

-- 
Andreas Schwab, schwab@linux-m68k.org
GPG Key fingerprint = 58CA 54C7 6D53 942B 1756  01D3 44D5 214B 8276 4ED5
"And now for something completely different."
