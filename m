From: Andreas Schwab <schwab@linux-m68k.org>
Subject: Re: change symlink
Date: Tue, 30 Oct 2012 23:09:06 +0100
Message-ID: <m2390vobnh.fsf@igel.home>
References: <CAH_OBie-irmpBrJG6KB3W8bgYjQdyVYiUR-SvJPnx1FXUya0uA@mail.gmail.com>
	<m2mwz3odys.fsf@igel.home>
	<CAH_OBidWxkhG3o4C4OPP4OxyQQfw_fF_h4C9KR9AnoOZ27=9TQ@mail.gmail.com>
	<m2fw4vod81.fsf@igel.home>
	<CAH_OBifch3uuXYHQ1R9vS6xFu8LuY3mUfiPsHcs3F=HMvnBzyg@mail.gmail.com>
	<m27gq7ochp.fsf@igel.home>
	<CAH_OBif=Zr-3GO3CE4D6O3wJJZysB6=vvmA37K6ujTHTr-un7w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: shawn wilson <ag4ve.us@gmail.com>
X-From: git-owner@vger.kernel.org Tue Oct 30 23:09:44 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TTK0F-000851-Pc
	for gcvg-git-2@plane.gmane.org; Tue, 30 Oct 2012 23:09:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751701Ab2J3WJ3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 30 Oct 2012 18:09:29 -0400
Received: from mail-out.m-online.net ([212.18.0.9]:37062 "EHLO
	mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754310Ab2J3WJI (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 30 Oct 2012 18:09:08 -0400
Received: from frontend1.mail.m-online.net (unknown [192.168.8.180])
	by mail-out.m-online.net (Postfix) with ESMTP id 3Xrmzl3FF6z4KK2q;
	Tue, 30 Oct 2012 23:09:07 +0100 (CET)
X-Auth-Info: fPpUz0Ffkbeb7bwc4sRDIeh6YHp2HuhMDnCsywJBkg0=
Received: from igel.home (ppp-88-217-108-88.dynamic.mnet-online.de [88.217.108.88])
	by mail.mnet-online.de (Postfix) with ESMTPA id 3Xrmzl2xV1zbbj9;
	Tue, 30 Oct 2012 23:09:07 +0100 (CET)
Received: by igel.home (Postfix, from userid 501)
	id 17A6CCA2A2; Tue, 30 Oct 2012 23:09:07 +0100 (CET)
X-Yow: The fact that 47 PEOPLE are yelling and sweat is cascading
 down my SPINAL COLUMN is fairly enjoyable!!
In-Reply-To: <CAH_OBif=Zr-3GO3CE4D6O3wJJZysB6=vvmA37K6ujTHTr-un7w@mail.gmail.com>
	(shawn wilson's message of "Tue, 30 Oct 2012 22:03:36 +0000")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.2 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/208757>

shawn wilson <ag4ve.us@gmail.com> writes:

> and once it's added, status says:
> #       renamed:    t2 -> t2/one/test
>
> that's not exactly true, but...

What's wrong with it?  Both files have the same contents, which is the
link target for symlinks.

Andreas.

-- 
Andreas Schwab, schwab@linux-m68k.org
GPG Key fingerprint = 58CA 54C7 6D53 942B 1756  01D3 44D5 214B 8276 4ED5
"And now for something completely different."
