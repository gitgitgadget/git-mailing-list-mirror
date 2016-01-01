From: =?UTF-8?Q?Torsten_B=c3=b6gershausen?= <tboegi@web.de>
Subject: Re: t6023 broken under Mac OS
Date: Fri, 1 Jan 2016 23:23:46 +0100
Message-ID: <5686FC72.8030008@web.de>
References: <56869D10.9090105@web.de> <5686B400.7000800@ramsayjones.plus.com>
 <5686BC3B.5080302@web.de> <5686EC29.3080901@ramsayjones.plus.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: Ramsay Jones <ramsay@ramsayjones.plus.com>,
	=?UTF-8?Q?Torsten_B=c3=b6gershausen?= <tboegi@web.de>,
	dev+git@drbeat.li, Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Jan 01 23:24:07 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aF87D-0002vN-26
	for gcvg-git-2@plane.gmane.org; Fri, 01 Jan 2016 23:24:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752617AbcAAWYD convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 1 Jan 2016 17:24:03 -0500
Received: from mout.web.de ([212.227.15.14]:51805 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752180AbcAAWYB (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 1 Jan 2016 17:24:01 -0500
Received: from [192.168.2.107] ([79.223.114.113]) by smtp.web.de (mrweb003)
 with ESMTPSA (Nemesis) id 0MGRYe-1aSHFa2zcO-00DKkT; Fri, 01 Jan 2016 23:23:55
 +0100
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.6; rv:38.0)
 Gecko/20100101 Thunderbird/38.5.0
In-Reply-To: <5686EC29.3080901@ramsayjones.plus.com>
X-Provags-ID: V03:K0:+9+xa2vC6xCUYQr3thpewBdEJ5QJGjSRsMwgLzsrZocY254wl9e
 SjzeP7oUDCQbnHbV1JXsGfADdw258oj1Gmry3ThnrtVlHf0p60eEUHbGgMViW4aovm1z8tF
 aX2Kp4z6FdmFkSmi1RUeM8qGuNPhYYuP1LECdaUVjdFzdOGBmL57As+wj3iS+QNC40gkb1c
 hN5i/ej6/lA7/6vCAOcug==
X-UI-Out-Filterresults: notjunk:1;V01:K0:x7YTwykXRWo=:Xt8ssoVFozwuM+yldSomwg
 Zk6vzsDlgZIGQYoc04ZNaHTdA/KaaWDirDd7OoCf7PYLs/fPtstBUBwShZ7O+YoeN6DUnJU8a
 hl5R0N9jg0gv/AfJcru96R93k4GMM327WA+sm0Hf22u+X4D04RYbK4t5gamjP1XKp5bZmnrYG
 MtTgLekcYSfaMKb/b6Rb+/3n83BAupqATV0WpBMGO18Falv/zEBqBfdZGkEMRMz5sJfjL6uwa
 nK8kncQXyBsa9hEeqwrp3f0cBB8Lve0sL0Z4MJlE36Qkmx3gGHFTI27KUb4D7RGC58xcvC9Id
 Aasp6gjKkoXRmVaDaSgPSrkavDDlbqvYQBPU1M3N3z7ONtP/ou1fsDZy4lDayl7tfV8C++DkK
 j1Kt8G8rRKmCZMnimcjyFxmUneM3q+r8W7sxqPpw+DJM8Vcbxp1N3JJxRaa2zisOwWh/wmPxJ
 qZw+Z2ejT8jiXNhFfNouaTP9wso3usLrXyPPZNGdKqwvaF3yhQqwE0FYIvIiEG/8ULM6bI1tE
 T4eqk3WOHHcnM4mUWVQU7pJgynsfSru0wWKiWy6AB5QE5mNpI/J+u2lftKyhKTWSkPinsnrX7
 RSPE262z0BREnqR94b/8qAas5r3aXm/0zAK1lbFmQ6rLtzVsk5NsjfActcLA5E9+dhY77CnT2
 UW53Mv4l6XivWXQiO7brRiW69sKJpsX0Sulr7eO0cv3mIkFVfLSi8tx1A2uODFPU+K+4+Q102
 O8CFTpJpoOqFdI5M09Se6F8K9R/TEn/TPWGELb6rYB6b+ySuT6FWqiHWZx9rX6kyj8FEqxWs 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/283262>

On 2016-01-01 22.14, Ramsay Jones wrote:
>=20
>=20
> On 01/01/16 17:49, Torsten B=C3=B6gershausen wrote:
>> On 2016-01-01 18.14, Ramsay Jones wrote:
>>> Hi Torsten,
>>>
>>> On 01/01/16 15:36, Torsten B=C3=B6gershausen wrote:
>>>> The (last) test case
>>>> 'conflict markers contain CRLF when core.eol=3Dcrlf'
>>>>
>>>> does not work as expected under Mac OS: "wc -l" is not portable an=
d the line
>>>> test $(sed -n "/\.txt\r$/p" output.txt | wc -l) =3D 3
>>>> fails.
>>>
>>> Hmm, I have never used a Mac, so I'm just guessing here, but
>>> you could try something like (obviously untested!):
>>>
>>> diff --git a/t/t6023-merge-file.sh b/t/t6023-merge-file.sh
>>> index 245359a..68b306f 100755
>>> --- a/t/t6023-merge-file.sh
>>> +++ b/t/t6023-merge-file.sh
>>> @@ -350,7 +350,7 @@ test_expect_success 'conflict at EOF without LF=
 resolved by --union' \
>>>  test_expect_success 'conflict markers contain CRLF when core.eol=3D=
crlf' '
>>>  	test_must_fail git -c core.eol=3Dcrlf merge-file -p \
>>>  		nolf-diff1.txt nolf-orig.txt nolf-diff2.txt >output.txt &&
>>> -	test $(sed -n "/\.txt\r$/p" output.txt | wc -l) =3D 3
>>> +	test $(tr "\015" Q <output.txt | sed -n "/\.txtQ$/p" | wc -l) -eq=
 3
>>>  '
>>> =20
>>>  test_done
>> Yes, this works.
>>
>>>
>>> [The 'wc -l' portability should only be a problem if you rely on th=
e
>>> exact textual form of the output, rather than the integer count.
>>> 'wc -l' is used in many many tests ...]
>>>
>>> Note that this test is not checking all conflict markers (the
>>> =3D=3D=3D=3D=3D=3D=3D marker does not have a filename appended). Sh=
ould that
>>> be fixed also?
>> This is may attempt (against pu)
>>
>> diff --git a/t/t6023-merge-file.sh b/t/t6023-merge-file.sh
>> index 68b306f..b1f8e41 100755
>> --- a/t/t6023-merge-file.sh
>> +++ b/t/t6023-merge-file.sh
>> @@ -350,7 +350,13 @@ test_expect_success 'conflict at EOF without LF=
 resolved by
>> --union' \
>>  test_expect_success 'conflict markers contain CRLF when core.eol=3D=
crlf' '
>>         test_must_fail git -c core.eol=3Dcrlf merge-file -p \
>>                 nolf-diff1.txt nolf-orig.txt nolf-diff2.txt >output.=
txt &&
>> -       test $(tr "\015" Q <output.txt | sed -n "/\.txtQ$/p" | wc -l=
) -eq 3
>> +       tr "\015" Q <output.txt | sed -n "/\.txtQ$/p" >out &&
>> +       cat >exp <<\EOF  &&
>> +<<<<<<< nolf-diff1.txtQ
>> +||||||| nolf-orig.txtQ
>> +>>>>>>> nolf-diff2.txtQ
>> +EOF
>> +        test_cmp exp out
>>  '
>>
>=20
> This still doesn't test the '=3D=3D=3D=3D=3D=3D=3D conflict marker', =
how about
> something like this (again not tested on Mac - is the re in the
> sed invocation OK on the Mac?):
sed is OK (The problem is the usage of "\r" inside sed:)

Linux:
printf "AA\r\n" | sed 's/\r$//' | od -c
0000000   A   A  \n

Mac OS:
printf "AA\r\n" | sed 's/\r$//' | od -c
0000000    A   A  \r  \n
0000004
>=20
> diff --git a/t/t6023-merge-file.sh b/t/t6023-merge-file.sh
> index 245359a..0697b22 100755
> --- a/t/t6023-merge-file.sh
> +++ b/t/t6023-merge-file.sh
> @@ -350,7 +350,14 @@ test_expect_success 'conflict at EOF without LF =
resolved by --union' \
>  test_expect_success 'conflict markers contain CRLF when core.eol=3Dc=
rlf' '
>  	test_must_fail git -c core.eol=3Dcrlf merge-file -p \
>  		nolf-diff1.txt nolf-orig.txt nolf-diff2.txt >output.txt &&
> -	test $(sed -n "/\.txt\r$/p" output.txt | wc -l) =3D 3
> +	tr "\015" Q <output.txt | sed -n "/^[<=3D>|].*Q$/p" >out.txt &&
> +	cat >expect.txt <<-\EOF &&
> +	<<<<<<< nolf-diff1.txtQ
> +	||||||| nolf-orig.txtQ
> +	=3D=3D=3D=3D=3D=3D=3DQ
> +	>>>>>>> nolf-diff2.txtQ
> +	EOF
> +	test_cmp expect.txt out.txt
>  '
> =20
>  test_done
Your fix works under Mac OS.

Micro-nit: should the sed expression use -e (is that more Git style ?)
tr "\015" Q <output.txt | sed -n -e "/^[<=3D>|].*Q$/p" >out.txt &&
Micro.nit 2:
We can simplify and use grep instead:
tr "\015" Q <output.txt | grep "^[<=3D>|]" >out.txt &&
