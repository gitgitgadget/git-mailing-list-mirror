From: =?UTF-8?Q?Torsten_B=c3=b6gershausen?= <tboegi@web.de>
Subject: Re: Odd Difference Between Windows Git and Standard Git
Date: Fri, 20 May 2016 17:57:22 +0200
Message-ID: <b6ab2200-30a1-d0ce-4d4e-097838b74781@web.de>
References: <nhlqd4$ekr$1@ger.gmane.org>
 <c07df4ac-08c9-8eaa-0233-06616945c857@web.de>
 <c20b9819-1b2d-6704-d870-1c0102dd9e35@gmail.com>
 <ede1c113-1ab8-6043-3e39-bbacec5db31c@web.de>
 <ba34485d-43cc-ef35-ebc0-67b944a420a7@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: Jon Forrest <nobozo@gmail.com>,
	=?UTF-8?Q?Torsten_B=c3=b6gershausen?= <tboegi@web.de>,
	git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri May 20 17:57:33 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b3mns-0001M3-Gp
	for gcvg-git-2@plane.gmane.org; Fri, 20 May 2016 17:57:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754005AbcETP52 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 20 May 2016 11:57:28 -0400
Received: from mout.web.de ([212.227.15.3]:56600 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752809AbcETP51 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 20 May 2016 11:57:27 -0400
Received: from birne9.local ([195.252.60.88]) by smtp.web.de (mrweb003) with
 ESMTPSA (Nemesis) id 0LuuSf-1blg6k0CB7-0108Mk; Fri, 20 May 2016 17:57:23
 +0200
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.9; rv:45.0)
 Gecko/20100101 Thunderbird/45.1.0
In-Reply-To: <ba34485d-43cc-ef35-ebc0-67b944a420a7@gmail.com>
X-Provags-ID: V03:K0:xSJx4/zSpaJB8rRUr3Kb5Y/0AaknWx/fMLxFWya7B4hjKeZLnRO
 ynBGpKgEMzBqJryr7ziGB7dljinStwjXVb7wC7Z3klwdoeW9//AwL7WW/lD7cp3cfMlHuoF
 o3JIbbFGOJJQH+HE1Eng81UkbgZZE8oOLMZkSkUwrVrU6b3IEasE/TxVQsK3eZV0qzBtB1n
 k6e2eGP5xSrZqa7YI+Anw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:r+hfoLBGIZo=:SoDRk1BKt1lEDS58dxUUGz
 RzyU/cPlZfP28dILssFw4RbsQmMowKtj7QLFsFzh0qbI5BKU2sffkLZsrCp1Fc/tNIl0c6VgC
 /T5OSnNgJ2L1R8R4+jBllWcFhidEZCS4Xn3RGSFo/FmR5CfZfgzovbnw3iDxpHk0TocGLzydr
 vkxRgl0ash+JFkxqtjqGF0HslD5mCkQydiz+F6ixIftN2LU0ElP8+l6OZYSn+iHRodmbkQRDw
 zPUT0otq/EkKEaHcJvVSbDxlbFpb0w7EeCzogUiuCzJakgXQGlh1pXagjtTyw+DeB56ckeUke
 TFAjHFg+VwIR7BIqvaXi8+A//dhwdTxM/hGfGlCbk4AF2DsqlBNBE7sYvOcA3se+q5ii169oO
 hfJUQAKhxyaxtM1pzWgGAVR7UBGXKHBPx41gFkZrMqut6Ke7SqVQ6wEYRGVaQOzWxNMlyrFZ2
 2ATIl1K4qbiWXqygQLc4+geSuc8Ak9aNqRckZV7WlpAb+oDpQwcFf2Np8Jvh6u9BgDDuetAek
 uRH3nWxik+QG+wtS6DOg0Kt6czxmZKNhSIlLW6bXn8rinXU9bipg5/phQsSiQKTQODoBtSBw0
 ZgIbUvWnhH+Stf6Rxdk5KgrWBoS1YyU8TK0hYXdG/uSMQ2bC3V7649b+6iKDeliwkwsu3cyW1
 3NizFc5dtROq4KKTvhfJPPW7h18Mfr/BdU8aZc46YqgmIArwhvfMCqgb2T0iAU82MHIEJ6ObY
 E/CCjFzmbi6amaVWeA0VV2AgM1vOaVhYGJmm7bBAk6AetHIRiLfUjvjtlINCXof/AWFOElBk 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/295177>

On 20.05.16 16:28, Jon Forrest wrote:
>=20
>=20
> On 5/20/2016 7:19 AM, Torsten B=C3=B6gershausen wrote:
>=20
>>> Great question. For all the unexpected files it says the
>>> same thing:
>>>
>>> old mode 100755
>>> new mode 100644
>>
>> So the solution is to run
>> git config  core.filemode false
>=20
> This worked perfectly!
>=20
> I wonder if this should be the default for Git for Windows.

It is.
But you need to clone the repo under Windows.

I probably submit a patch some day, that core.filemode will be ignored
under Windows.
