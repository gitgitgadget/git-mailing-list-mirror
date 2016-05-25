From: =?UTF-8?Q?Torsten_B=c3=b6gershausen?= <tboegi@web.de>
Subject: Re: Odd Difference Between Windows Git and Standard Git
Date: Wed, 25 May 2016 06:36:09 +0200
Message-ID: <57452BB9.5090500@web.de>
References: <nhlqd4$ekr$1@ger.gmane.org>
 <c07df4ac-08c9-8eaa-0233-06616945c857@web.de>
 <c20b9819-1b2d-6704-d870-1c0102dd9e35@gmail.com>
 <ede1c113-1ab8-6043-3e39-bbacec5db31c@web.de>
 <xmqqy474g3cv.fsf@gitster.mtv.corp.google.com>
 <xmqqfutcg0pe.fsf@gitster.mtv.corp.google.com>
 <alpine.DEB.2.20.1605231310190.4122@virtualbox>
 <xmqqeg8sa9oq.fsf@gitster.mtv.corp.google.com> <5743DE28.5070000@web.de>
 <alpine.DEB.2.20.1605241352361.4449@virtualbox>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, Jon Forrest <nobozo@gmail.com>,
	git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	=?UTF-8?Q?Torsten_B=c3=b6gershausen?= <tboegi@web.de>
X-From: git-owner@vger.kernel.org Wed May 25 06:37:01 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b5QZ2-0003Sa-0d
	for gcvg-git-2@plane.gmane.org; Wed, 25 May 2016 06:37:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753590AbcEYEgu convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 25 May 2016 00:36:50 -0400
Received: from mout.web.de ([212.227.15.3]:51711 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750786AbcEYEgt (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 25 May 2016 00:36:49 -0400
Received: from [192.168.88.199] ([194.47.243.242]) by smtp.web.de (mrweb004)
 with ESMTPSA (Nemesis) id 0M4lkz-1bST5D0xC9-00yzaz; Wed, 25 May 2016 06:36:42
 +0200
User-Agent: Mozilla/5.0 (X11; Linux i686; rv:38.0) Gecko/20100101
 Icedove/38.7.0
In-Reply-To: <alpine.DEB.2.20.1605241352361.4449@virtualbox>
X-Provags-ID: V03:K0:xDcvJjN4d0bed7i0XwpKkVzTOaA4T33yNdFWurRs9pEWn7c9PCf
 KEuF2oAzOziH3/7uSO11PSVOoSSElqibs+6M9WEKQupCK+q6DImFkl3loFImdUi8zKKBJVZ
 fwHcXzrBzLwQ1mMvTdHsY3YuMiNJSjIqjn4jI1Mp0Rq7fEcxMBdgss5Dts0FglpPxAkGDea
 X8EEyBDdZ4pAGcCCx/5Qw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:+fR0/m6WIcc=:DRCOnEOx/nicV63vRA4xAo
 Vsy8I4I0TOv4MGI/EXrsjamdmhCbhWQtS8oXSXijNYswVKBlC/vRZmwEn5oB0YyTTtzGZ3Pv4
 n1WCNX1vBe1Sm2Y+0wAD5TN5XzOcI6bQyj8gJPTLzMIaGNWqJ7WRqwwgKFUvQ4dfjo8HlwEBC
 kncnMudxfegG8sKlqOCu3MHVnroZmM0fIc5yabZfgQ70bDrIreLHTChBokgKd9vePzTbHGJqo
 hGQ3kLr6+HnO8i1gQvfQGb/E9MzyGiCq27GOkoHbsop4tbb2etaC/Ll7eXlewJPTD/DQIhAdh
 MJnoNGmjviwil6I1t1A6FNrm4GJJEf52yzixXv7+tZ8LfNBZoINxtGlMO7fAcs/7JrwIXwBRz
 q7Ao3ysIfjdrfbsiiK6g/lioSChrFHR5Pxu1OrEoGN8ZrjJ1XPiVg5Ba15JvTrb1yNI7WSZ+J
 7UKDVa5uNNAlR3yoROSCznBRq1VAY7wOQFX11llL+t/dBuWeqFxlGeqCcW5h5Bt3k7wpzzkQU
 m6sX3p/sDtjh7SuRZ7caXV2ZbAxHwH2YkU94tfhUcnY2cK4mJ+RYX8LwgxEL0mEOpCYSd799w
 8FZfE+JSbIREWEFKVsraWoVaewqpALlY8+Ueveya5xbckiSUVKd2CKw0V7g2ruheL6Ry6AVXW
 JvU2LwhIO1xflpuiVJmGPH9POPwpau8y52Qcu6BNGslk04YvGsYEq/FLzpUDTyfRu+HEBFQqD
 /ro8hy8Q8t/jQGghaPLNaWh1aZMEzzTeLC9oS3B2TwhSPjU4DbAN1LG1ov2ljjTJoUFXgQQq 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/295555>

On 05/24/2016 01:57 PM, Johannes Schindelin wrote:
> Hi,
>
> On Tue, 24 May 2016, Torsten B=C3=B6gershausen wrote:
>
>> On 05/23/2016 08:52 PM, Junio C Hamano wrote:
>>> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
>>>
>>>>> Of course, if you are doing network mount between systems with an=
d
>>>>> without filemode support, the result would depend on where you di=
d
>>>>> the "git init", so that would not help.
>>>>>
>>>>> Which means that other probed things like symlink support and cas=
e
>>>>> sensitivity are likely to be wrong in the .git/config that the
>>>>> user may want to fix.
>>>> What we could do is to make the default config setting
>>>> platform-dependent, a la CRLF_NATIVE.
>>>>
>>>> I imagine that we would want this for core.filemode, core.ignoreca=
se and
>>>> core.symlinks.
>>>>
>>>> What do you think?
>>> The reason why we probe for filemode, icase, etc. at repository
>>> creation time and record the result in the configuration is because=
 we
>>> do not to want to do the auto-probing at runtime, every time we run
>>> any Git command.
> Right, I missed this of course. My idea was to have saner defaults *i=
ff
> the config variables are not set explicitly*. But they *are* set, of
> course. Just not in a way that makes sense when the very same working
> directory is accessed from different Operating Systems.
>
>> if core.filemode is true, Git for Windows could:
>> a) Behave as today, report changed files (filemode)
>> b) Give warning to the user (and report changed filemode)
>> c) Error out, saying misconfigured worktree
>> d) use core.filemode =3D false anyway.
>> e) Give a warning and use core.filemode =3D false anyway.
>>
>> At the moment I tend for c), as it makes it clear what is going wron=
g,
>> what do you think ?
> The problem with that is that we would need to probe again.
The probing for the filemode:
Wouldn't it be enough to run lstat() on .git/ ?
If the user-execuatable bit is not set, but core.filemode is true, erro=
r=20
out ?
That would not cost too much.
>   Or dictate for
> all eternity that Git for Windows cannot determine the executable bit=
 (but
> who knows for certain?)
Can we can limit the eternity until the day when Windows can determine=20
the executable
bit ?
