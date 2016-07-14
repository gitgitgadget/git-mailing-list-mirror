Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.5 required=3.0 tests=BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0C6472018F
	for <e@80x24.org>; Thu, 14 Jul 2016 02:09:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751188AbcGNCJo (ORCPT <rfc822;e@80x24.org>);
	Wed, 13 Jul 2016 22:09:44 -0400
Received: from mout.web.de ([212.227.17.11]:55505 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751141AbcGNCJl (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 Jul 2016 22:09:41 -0400
Received: from [192.168.0.128] ([205.189.2.14]) by smtp.web.de (mrweb103) with
 ESMTPSA (Nemesis) id 0Le4Tw-1b2QxK1szc-00ptTY; Thu, 14 Jul 2016 04:09:31
 +0200
Subject: Re: What's cooking in git.git (Jun 2016, #05; Thu, 16)
To:	Joey Hess <id@joeyh.name>
References: <xmqqk2ho33ig.fsf@gitster.mtv.corp.google.com>
 <18617acb-bcdb-607d-007e-552dabd352cb@web.de>
 <20160622210958.GA24618@kitenet.net>
 <1f76a4d3-68b1-db33-5c7b-dc5ab104a3ef@web.de>
 <20160712222054.GA10128@kitenet.net>
Cc:	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
From:	=?UTF-8?Q?Torsten_B=c3=b6gershausen?= <tboegi@web.de>
Message-ID: <af41e13f-0320-2e55-a6ac-3fdb46f0bb35@web.de>
Date:	Thu, 14 Jul 2016 04:09:02 +0200
User-Agent: Mozilla/5.0 (X11; Linux i686; rv:45.0) Gecko/20100101
 Icedove/45.1.0
MIME-Version: 1.0
In-Reply-To: <20160712222054.GA10128@kitenet.net>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K0:kvuPWPYGcDdpAmAp55IWe86hKSgH+ymoYfLwN0dSNZbcUnyuYBj
 +1OcaQc1S8BpQltTWNj8++wURsbmNNhkzDAgq3DvkVb/uobmv6zgWgQMp4F5LKEkkCNwY3q
 5B2edhJi8r5MskDeKluxyH88+gevD3+BdeijEezV8At4TW23wW93R5wngBjj4IzA+ebLDi4
 nAXsGbJA5QXu7Jnhp44Zw==
X-UI-Out-Filterresults:	notjunk:1;V01:K0:LHaIheN5YpM=:PQEsdh3jjyg1zzhmfFOkTY
 ivtf71icx4IoEzghTY/i/IEh5hWcRfo8vvSDvQATIOZ6ZtXBc0i7KJ+xTj46/66DFvueXJEpg
 CsQ83v/jIn4Rgau7y8kiFyC96gf0IjUZv+Ppm1hIUkA7ZG5SmnxB6j/iHZF52b7YcSbkicjWu
 feop0F15zeiRAQC6jbCIB86G4tTS2ANPdFxpTHgyuoZ7Bo+NDtga5f94Jmrmo6fOV0O36DTh7
 seQWkzquhrQWbhytA+u+ydJGfiy2NRqYUNz55t2Efzsn2reIU9FN4B5xmReNV1hXI3CCBltf2
 MZfY5DvBAdXQzR7hirdXowEaarGsDS7JEjoACuHoNigj0NDFaOr1jpVErD0MglA6SOPh0TrSk
 tqJ8VXU31i5iUloJb2WXPxpoRRKKxtdmzMuRrVMCNDR9w3m5WdJe/eEmCYLeXIyuAH/Mdo//u
 /yhXnFC3IXbkZCoC3AAAmZUrepeYEFhccCXtK8V6aUmZNU9U+df1Mhy7/G9kwK53q+6/cLVaH
 tOH5LYZN6APtYWbn3JgvRAN3E0spmT3tZy6gmiI5aQ1zD3uwXFoq0AJ62UtDNF8Hgf7nYuDL2
 widXL4TqXK4OwfFx9j0bHg7PUHRYWNbYFpBLATfBfwxVblY5q9FEpRBGAvJ751bo4LuSb6bEo
 /cERPNE9jwRt4q/qJg9uN4NTmeDHvmf1MsCqvsM2rQ2k92Fi4wp67TMtvHOmF+cUIId7Zp6CD
 xugx/xadrIBfCzvZvZdhu/6uVEqO+agdVo+ovKJybnx0HdzRzuD8PxINlULEKLLo+6K7SpvVY
 Fzx0bR5
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org



On 07/13/2016 12:20 AM, Joey Hess wrote:
> Torsten Bögershausen wrote re jh/clean-smudge-annex:
>> The thing is that we need to check the file system to find .gitatttibutes,
>> even if we just did it 1 nanosecond ago.
>>
>> So the .gitattributes is done 3 times:
>> -1 would_convert_to_git_filter_fd(
>> -2 assert(would_convert_to_git_filter_fd(path));
>> -3 convert.c/convert_to_git_filter_fd()
>>
>> The only situation where this could be useful is when the .gitattributes
>> change between -1 and -2,
>> but then they would have changed between -1 and -3, and convert.c
>> will die().
>>
>> Does it make sense to remove -2 ?
>
> There's less redundant work going on than at first seems, because
> .gitattribute files are only read once and cached. Verified by strace.
>
OK, I think I missed that work (not enough time for Git at the moment)
Junio, please help me out, do we have a cache here now?
I tried to figure out that following your attr branch, but failed.
> So, the redundant work is only in the processing that convert_attrs() does
> of the cached .gitattributes.
>
> Notice that there was a similar redundant triple call to convert_attrs()
> before my patch set:
>
> 1. index_fd checks would_convert_to_git_filter_fd
> 2. index_stream_convert_blob does assert(would_convert_to_git_filter_fd(path))
>    (Again redundantly since 1. is its only caller and has already
>    checked.)
> 3. in convert_to_git_filter_fd
>
> If convert_attrs() is somehow expensive, it might be worth passing a
> struct conv_attrs * into the functions that currently call
> convert_attrs(). But it does not look expensive to me.
I have that on the list, but seems to be uneccesary now.
>
> I think it would be safe enough to remove both asserts, at least as the
> code is structured now.
>
OK.
