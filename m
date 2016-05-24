From: =?UTF-8?Q?Torsten_B=c3=b6gershausen?= <tboegi@web.de>
Subject: Re: Odd Difference Between Windows Git and Standard Git
Date: Tue, 24 May 2016 06:52:56 +0200
Message-ID: <5743DE28.5070000@web.de>
References: <nhlqd4$ekr$1@ger.gmane.org>
 <c07df4ac-08c9-8eaa-0233-06616945c857@web.de>
 <c20b9819-1b2d-6704-d870-1c0102dd9e35@gmail.com>
 <ede1c113-1ab8-6043-3e39-bbacec5db31c@web.de>
 <xmqqy474g3cv.fsf@gitster.mtv.corp.google.com>
 <xmqqfutcg0pe.fsf@gitster.mtv.corp.google.com>
 <alpine.DEB.2.20.1605231310190.4122@virtualbox>
 <xmqqeg8sa9oq.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Cc: =?UTF-8?Q?Torsten_B=c3=b6gershausen?= <tboegi@web.de>,
	Jon Forrest <nobozo@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Tue May 24 06:53:21 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b54LI-0000iQ-Nr
	for gcvg-git-2@plane.gmane.org; Tue, 24 May 2016 06:53:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752757AbcEXExR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 24 May 2016 00:53:17 -0400
Received: from mout.web.de ([212.227.15.4]:54341 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752028AbcEXExQ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 May 2016 00:53:16 -0400
Received: from [192.168.88.199] ([194.47.243.242]) by smtp.web.de (mrweb002)
 with ESMTPSA (Nemesis) id 0MS1xS-1axsH217xC-00THHr; Tue, 24 May 2016 06:52:58
 +0200
User-Agent: Mozilla/5.0 (X11; Linux i686; rv:38.0) Gecko/20100101
 Icedove/38.7.0
In-Reply-To: <xmqqeg8sa9oq.fsf@gitster.mtv.corp.google.com>
X-Provags-ID: V03:K0:wylJKCw6aB50Pfh+4nY/r9G9rGzULZiQdmt+i7BsOChYgPMGW0X
 PLBjcjYE248YDv3NiFAelBuPNLIgetb4Mk2/+q0p8vTaYtXb18qDms25gatp2UNAw2olkcr
 igkt7zG4FKC1D/muRWQFe+8BIs53KOaX7Yc2nTL5yAperrg4FOHbOLwFIhZ1PjrvRy//aZh
 LvehgzIL/2vf88mfzilvw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:rw57/7acfks=:NabXQ1i4rl1QGZuIk4CjS9
 L3c03+v9oUWhkz1dHgOm0kE9wYiqtOASitMr6vEAYfDh5OMVut7O6OnhZJCLxpmRQ8L88XkMM
 HJyhHi1ROPTcPGH5GA3xAIOq8OvbaYq1jDRY4tIIgP4NCp6m2I8GFXP3iI8zxYCYtVy8329Ck
 y/gprlL+eZS41Z14U8HB1Er3gh7ukjVHDTHD/AW5QL0BBFnt4OU9tXGBsHUI8gFmRtZEWrxmV
 Xv4B/ie1fCX3DVkMMIUNToxjkhArDWKReYJLyxiQ4X41/0/40wkGmVXcKeLNccXNDyMpbJaMc
 plFoS9MbCvNjeu3+y93s+f/UB6PSxc6QhtI0BP9mE8owUSGu7zpVWl7dKfX2DG/z/P1bqJRQw
 oJKC48QS/S/fFw7TSnPVA6EhNq9IQrzxrTvBSUSGxIVy82jxt4floYH3lAzF9guRAm/EvJgFO
 QOvazQbyWyo/Ux25Cm8f3p/oW55gmFQ1CMf/twYzLd3wlXYev39dfv1O8WjoKawhGgh2oIlzf
 Trbw+sfLCL9czXbrFr+ARj1mUTmLJysAl5pqyMkyEwdPf272dkm71WVLgPuf7YUG6zjLSLHGP
 axCda3ZlN8VQXIWxc9+3Lq5l/JYc90Q/6TJKIk7qZY7oTDPPDH7Y8rvGAEJOIthBsoR41W39Q
 TBmNmIlnnCfcHCv9ijvWHVSzJPuseUmUGlYPdkansLOdB8zANSkhBNPHiZbsVrH0orGT5GjMQ
 BICkfH/xdeNskF5NjNu1iJAqLg7YCFa8tvThXxK2M9KqNDNf/BdnEqdVa+E2Gi0rkM0PvnVi 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/295416>

On 05/23/2016 08:52 PM, Junio C Hamano wrote:
> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
>
>>> Of course, if you are doing network mount between systems with and
>>> without filemode support, the result would depend on where you did
>>> the "git init", so that would not help.
>>>
>>> Which means that other probed things like symlink support and case
>>> sensitivity are likely to be wrong in the .git/config that the user
>>> may want to fix.
>> What we could do is to make the default config setting platform-dependent,
>> a la CRLF_NATIVE.
>>
>> I imagine that we would want this for core.filemode, core.ignorecase and
>> core.symlinks.
>>
>> What do you think?
> The reason why we probe for filemode, icase, etc. at repository
> creation time and record the result in the configuration is because
> we do not to want to do the auto-probing at runtime, every time we
> run any Git command.  You may be able to say "On this platform, no
> matter what filesystem is in use, you will always get icase and you
> will never have executable bit", and a build on such a platform can
> hardcode these three values.  But on other platforms these may be
> per-filesystem properties, and their binaries would not be able to
> hardcode the choices, which would mean we would record these three
> in .git/config on these platforms when a repository is created.
>
> Git built for Windows may have core.filemode=false as "the default
> config setting platform-dependent, a la CRLF_NATIVE"; how would that
> interact with a configured core.filemode value in .git/config?
if core.filemode is true, Git for Windows could:
a) Behave as today, report changed files (filemode)
b) Give warning to the user (and report changed filemode)
c) Error out, saying misconfigured worktree
d) use core.filemode = false anyway.
e) Give a warning and use core.filemode = false anyway.

At the moment I tend for c), as it makes it clear what is going wrong,
what do you think ?

[skip ignorecase for a second]
