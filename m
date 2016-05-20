From: =?UTF-8?Q?Torsten_B=c3=b6gershausen?= <tboegi@web.de>
Subject: Re: Odd Difference Between Windows Git and Standard Git
Date: Fri, 20 May 2016 18:12:47 +0200
Message-ID: <5067f10f-a12e-c6e6-493b-5ff14dae4380@web.de>
References: <nhlqd4$ekr$1@ger.gmane.org>
 <c07df4ac-08c9-8eaa-0233-06616945c857@web.de>
 <c20b9819-1b2d-6704-d870-1c0102dd9e35@gmail.com>
 <ede1c113-1ab8-6043-3e39-bbacec5db31c@web.de>
 <xmqqy474g3cv.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jon Forrest <nobozo@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?Q?Torsten_B=c3=b6gershausen?= <tboegi@web.de>
X-From: git-owner@vger.kernel.org Fri May 20 18:13:22 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b3n38-0004La-9R
	for gcvg-git-2@plane.gmane.org; Fri, 20 May 2016 18:13:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754277AbcETQNO convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 20 May 2016 12:13:14 -0400
Received: from mout.web.de ([212.227.17.11]:51202 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754059AbcETQNN (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 20 May 2016 12:13:13 -0400
Received: from birne9.local ([195.252.60.88]) by smtp.web.de (mrweb101) with
 ESMTPSA (Nemesis) id 0MORiL-1axzcb3iUv-005tKJ; Fri, 20 May 2016 18:12:48
 +0200
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.9; rv:45.0)
 Gecko/20100101 Thunderbird/45.1.0
In-Reply-To: <xmqqy474g3cv.fsf@gitster.mtv.corp.google.com>
X-Provags-ID: V03:K0:L6/yc+b2jcHILxvh7Y0ftWGDTwYFY+iVZP8uI/FpJsaDnkpQo2B
 rLgkK9DDoJwbuzL6qrlAJCFm4kL/Guqbu8bNm6RQYZQnZ6sKZtWyW6OxaDgO/oqe937BKb1
 pyKGuB086MNHBAwBvle1Ac1LXGz4rP5GcPbqkEC8pKh9kqH7mqY9hKs0XQhkH2w6CCKI8HC
 wRBJHqHc1JN1MqZHRl5Dg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:I+ox3fg9wJ4=:k2Y0UZp8Su+TRq+Z6ssPTe
 ws/+8cBvNtnCaF74x99d9eGWpADkK3EE3+lffJb0gqJIGvrBwF0URw8c8/NxW7uGpRjHRCP0l
 EQ3VNWvcAjkrH/nQ2ZhXNj/rSqZFFsEhfkb3Ol5YcH8RnFWkzhdDxSJM/w1fJPeH+uIwoPATE
 LY5QyCgJESMK6XRmGTJKM/GW3o8l11URAtrTLcHd4ealQQU0pAcue2dREm6qR6LdWpMIukx53
 UKM7HdoNTNCzF1zT39X0m9QtpaDRW28myMblsf7Ny7FKQU6lxO3g3TsRFsnbahVujQua+3wqc
 khYwWDrH6p5FOCpeMO8djz6E0eRxTz879P+TbsreQyos7u9B7QTkdscH783TfbrQ8myCUWNCa
 VvUTUJLfPfEFl17xMi0iEAVV7gIIiBDtwkDlhRHJaxxXottPP+lxX0F5yhV+kou/vTYIGErJ7
 qocRG547AOjgxfU3PGd8K+UYMBAfbBKct3OhlkzQ7RCVWDByNiwYyYwgfH3l4Nz4A4cwvRymu
 KAEDDtK1uxa/O9BHz+bGdLTFd6uHGPijEuehS8erA/rVRiFkRP2kw6B0R3guS5sG09yAZwD9g
 vNhO0aCPFneQYOoSK2hUnF0Ye2ZpWoFYJW09xclIjRePXyI1Kl0i6W9k1wJqkNyf0xKERpD/R
 BVsrc8LGE+pEbCZYjmSTNrgPQAFUxQqQvUaw4Qlwq3EqOFunIM5ZGk66cLSJCP7vI1E+Sq1fE
 zWQe2zErzmRcwn2tpyj/myGhMkhwNofojh0O4C6F4KPUj/oxGuxVHRQakk2HO7W6BSbCyyRi 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/295181>

On 20.05.16 17:23, Junio C Hamano wrote:
> Torsten B=C3=B6gershausen <tboegi@web.de> writes:
>=20
>>>> What does
>>>> git diff
>>>> say ?
>>>
>>> Great question. For all the unexpected files it says the
>>> same thing:
>>>
>>> old mode 100755
>>> new mode 100644
>>
>> So the solution is to run
>> git config  core.filemode false
>=20
> Thanks for asking a great question.  I somehow expected that we
> probe in init-db.c::create_default_files() for this when we probe
> for case sensitivity, symlinks, etc., but apparently we don't.
>=20
> I guess we don't because on some filesystems we can't.  IIRC, it
> goes something like: chmod immediately followed by lstat pretends
> that change to the executable bit stuck, until the in-core buffer at
> the vfs layer is flushed to the disk platter that holds the
> filesystem without any notion of executable bit.

We do the probing, when the repo is cloned, and then never again.
If I clone the repo under Windows, the probing gives core.filemod false=
=2E
If I clone under Linux, the probing gives core.filemod true.

Unfortunatly Git for Windows looks at core.filemode, when looking
at the working tree, even if the stat() implementation never detects
the executable bit.

A fix could look like this:
=20
static int git_default_core_config(const char *var, const char *value)
{
	/* This needs a better name */
	if (!strcmp(var, "core.filemode")) {
#ifndef GIT_WINDOWS_NATIVE
		trust_executable_bit =3D git_config_bool(var, value);
#endif
		return 0;
	}
