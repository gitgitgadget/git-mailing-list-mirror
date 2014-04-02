From: =?UTF-8?B?UmVuw6kgU2NoYXJmZQ==?= <l.s.r@web.de>
Subject: Re: [PATCH] rev-parse: fix typo in example on manpage
Date: Wed, 02 Apr 2014 19:36:41 +0200
Message-ID: <533C4AA9.1060204@web.de>
References: <1396380443-61239-1-git-send-email-l.s.r@web.de> <xmqqk3b7vdqi.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Apr 03 13:54:21 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WVeTC-0000xS-T6
	for gcvg-git-2@plane.gmane.org; Thu, 03 Apr 2014 12:02:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932581AbaDBRhZ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 2 Apr 2014 13:37:25 -0400
Received: from mout.web.de ([212.227.15.4]:56981 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932563AbaDBRhY (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 2 Apr 2014 13:37:24 -0400
Received: from [192.168.178.27] ([79.253.132.51]) by smtp.web.de (mrweb101)
 with ESMTPSA (Nemesis) id 0MGiUP-1WIX4g178j-00DUq4; Wed, 02 Apr 2014 19:37:11
 +0200
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:24.0) Gecko/20100101 Thunderbird/24.4.0
In-Reply-To: <xmqqk3b7vdqi.fsf@gitster.dls.corp.google.com>
X-Provags-ID: V03:K0:m0JFkNzq3sIIMyDr4wu3MOyFRdzvrKKmkiw/IEEZ9YNJKJYQ7x3
 Qc/NPAn6Zwm8CK+rnK/5PINOAYnzR8E99VbvHmGuaL2FEGhmWZxHV2VWcC9FVsT+cVY5MDi
 M/jN9Cc5nqwp+ndap31qfr7ef4eHkqvzqnC1JZClI4c5JsrsVju/B/mj17MepmDhFUVT0bE
 uSLDbZ0yDchJdrJUuvZhg==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/245726>

Am 02.04.2014 19:32, schrieb Junio C Hamano:
> Ren=C3=A9 Scharfe <l.s.r@web.de> writes:
>
>> ---
>>   Documentation/git-rev-parse.txt | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> Thanks; I'll forge your Sign-off ;-)

Oops, sorry, and thanks.

Signed-off-by: Rene Scharfe <l.s.r@web.de>

>>
>> diff --git a/Documentation/git-rev-parse.txt b/Documentation/git-rev=
-parse.txt
>> index e05e6b3..377d9d7 100644
>> --- a/Documentation/git-rev-parse.txt
>> +++ b/Documentation/git-rev-parse.txt
>> @@ -363,7 +363,7 @@ usage: some-command [options] <args>...
>>       -h, --help            show the help
>>       --foo                 some nifty option --foo
>>       --bar ...             some cool option --bar with an argument
>> -    --bar <arg>           another cool option --baz with a named ar=
gument
>> +    --baz <arg>           another cool option --baz with a named ar=
gument
>>       --qux[=3D<path>]        qux may take a path argument but has m=
eaning by itself
>>
>>   An option group Header
