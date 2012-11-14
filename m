From: Andreas Schwab <schwab@linux-m68k.org>
Subject: Re: [regression] Newer gits cannot clone any remote repos
Date: Thu, 15 Nov 2012 00:15:03 +0100
Message-ID: <m28va3epzc.fsf@igel.home>
References: <CACYvZ7jPd0_XD6YVdfJ2AnKRnKewmzX4uu7w3zt+_gK+qU49gQ@mail.gmail.com>
	<50A2978D.6080805@ramsay1.demon.co.uk> <50A2B2DF.1080704@web.de>
	<m2pq3h9ll1.fsf@igel.home>
	<CACYvZ7jwjVsW4=QSbxFVL8N269DE4=tv8_WvZ0gVOw6B+WLP=w@mail.gmail.com>
	<mvmvcd8f8ml.fsf@g208.suse.de>
	<CACYvZ7g7nCgQmcnwJYxvx5hJ+Y8rCQOBQyWYLZOt8NT5BTwTrw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Torsten =?utf-8?Q?B=C3=B6gershausen?= <tboegi@web.de>,
	Ramsay Jones <ramsay@ramsay1.demon.co.uk>, git@vger.kernel.org
To: Douglas Mencken <dougmencken@gmail.com>
X-From: git-owner@vger.kernel.org Thu Nov 15 00:15:29 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TYmB4-0005O4-2n
	for gcvg-git-2@plane.gmane.org; Thu, 15 Nov 2012 00:15:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1945934Ab2KNXPK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 14 Nov 2012 18:15:10 -0500
Received: from mail-out.m-online.net ([212.18.0.9]:46418 "EHLO
	mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1945923Ab2KNXPJ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 Nov 2012 18:15:09 -0500
Received: from frontend1.mail.m-online.net (unknown [192.168.8.180])
	by mail-out.m-online.net (Postfix) with ESMTP id 3Y21kx26wnz4KK74;
	Thu, 15 Nov 2012 00:15:05 +0100 (CET)
X-Auth-Info: EQL03PddJRER2Gbes1Txz5LppEgeReeQF+OkFcBssLk=
Received: from igel.home (ppp-93-104-155-125.dynamic.mnet-online.de [93.104.155.125])
	by mail.mnet-online.de (Postfix) with ESMTPA id 3Y21kx1PvpzbcZJ;
	Thu, 15 Nov 2012 00:15:05 +0100 (CET)
Received: by igel.home (Postfix, from userid 501)
	id D7E69CA2A4; Thu, 15 Nov 2012 00:15:04 +0100 (CET)
X-Yow: I am KING BOMBA of Sicily!..I will marry LUCILLE BALL next Friday!
In-Reply-To: <CACYvZ7g7nCgQmcnwJYxvx5hJ+Y8rCQOBQyWYLZOt8NT5BTwTrw@mail.gmail.com>
	(Douglas Mencken's message of "Wed, 14 Nov 2012 13:01:01 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.2 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/209757>

Douglas Mencken <dougmencken@gmail.com> writes:

>>>> I cannot reproduce the problem (on openSUSE 12.2).
>>>
>>> You do need multiple CPU/multi-core machine, as I got it.
>>
>> Which is what I have.
>
> Then try to build *vanilla* git 1.8.0,

Which is what I did.

> not OpenSuSE's one (with a lot of patches inside srcrpm).

Which lot of patches?

Andreas.

-- 
Andreas Schwab, schwab@linux-m68k.org
GPG Key fingerprint = 58CA 54C7 6D53 942B 1756  01D3 44D5 214B 8276 4ED5
"And now for something completely different."
