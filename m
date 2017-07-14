Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.3 required=3.0 tests=AWL,BAYES_00,BODY_8BITS,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C552120357
	for <e@80x24.org>; Fri, 14 Jul 2017 12:35:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753573AbdGNMfJ (ORCPT <rfc822;e@80x24.org>);
        Fri, 14 Jul 2017 08:35:09 -0400
Received: from mout.web.de ([217.72.192.78]:62019 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753124AbdGNMfI (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 14 Jul 2017 08:35:08 -0400
Received: from [192.168.88.103] ([195.198.252.176]) by smtp.web.de (mrweb103
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0MhDgb-1dJ7kh2bFh-00MLVb; Fri, 14
 Jul 2017 14:34:58 +0200
Subject: Re: Git on macOS shows committed files as untracked
To:     Elliot Chandler <worldpeacehaven@gmail.com>
Cc:     Lutz Roeder <lutz.noreply@gmail.com>, peff@peff.net,
        git@vger.kernel.org
References: <CANmutwCSGgLxESPmTJZXkid6P1N6HwwOTaz=7QHOsSPrrHQ4EQ@mail.gmail.com>
 <914898a3-24da-403a-8e1c-e90b53df46a9@web.de>
 <CAHVrscDg8bc-CYm6dSJFgdPSv1vJ0=AC0s3y26CHctKkYAvJyA@mail.gmail.com>
From:   =?UTF-8?Q?Torsten_B=c3=b6gershausen?= <tboegi@web.de>
Message-ID: <8b5fc22c-4d65-d34a-a84c-c913f454c771@web.de>
Date:   Fri, 14 Jul 2017 14:35:52 +0200
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.11; rv:52.0)
 Gecko/20100101 Thunderbird/52.2.1
MIME-Version: 1.0
In-Reply-To: <CAHVrscDg8bc-CYm6dSJFgdPSv1vJ0=AC0s3y26CHctKkYAvJyA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K0:KfGCjOytgUTvnJbdkIsjcuJrjsMtd8/wifBhLny+saIvUzQzLvd
 e8hPOBJQjznm6qJqWspa4HlnkbxC9bcByPfp3ua4z9BKJ5FyS8j8xN246yfHDT/ELjJM0SV
 G1SlR039jySyA/XEX6pOE2LQoYfOjLPXQt6iRU6inqE3Q9UToGv1JQBWD6FI1Go5ydnVtnr
 5GenVtiqNfnYLf/waR5ww==
X-UI-Out-Filterresults: notjunk:1;V01:K0:UKXivRV2JV0=:h+6QzAskiQLHpnq75HEUPg
 bGe8suGYdccxsuGJBdq8/b6h8t2w/HecawggtoudDTPtKY4+q9v7QLNiRaFtMIvPNIKplJWRg
 MTAGA7O2Ra2luxj5JgsquMWuntzl1FyuLwDF8H40tCdubJGhfMYz+IVM+We6Y5JSmGxP6vCEo
 ny5Tmq4r+cQf39Ns3KWtYlcPzHbFLCPd++GRHJOsfh0PR3QuJqOY+1pn+bG0ZrO96Js+ZCLXz
 7A+1tYhci0yKwFxs7hds95FGObAbOXI0GwoTcnBkmKjDXrXAuqb7BJgFOnS1uf9PL/szUevUJ
 rvaYWq2pem623EzjGeuwUyqA78a9p1WdMqtWFf4n8kdTyXAf7pTBO+lj4BaMhQIwOAtoq+IIR
 zmGRCh+Qa5BYEECm5TRTdM5Bnt3wGFmpeg3550z7NVt5lhyLYE/J+nOMR7weOMcqeQcM+tUeI
 NdLXi/RQ72j4I9hZqZ8misKQVLDUPawd/wfMEbubyZ4QIUeiH5tqcQFlUTzwnASW6oPNI6IIv
 GlDDTfpwoa4VUEIPVj0lwnHBqNnA0gty2BqX7owoDGGlra/8k25XAlw/sJNKbLPARXDdeh/sR
 PBeRLiveG2nO2+60l1c6BpYtDQzucVYd1/QX7AxPjHw7mea54xFrDfR6dU8gUXFtPOZ6GZPyA
 axoTQwV943GEo1WbmS0gFSSKflRaQYWWag0cW02SX3uZ57VpcIyfiOADbLUGc3Tf4PK93W1Mi
 VRa7OwO2eM8zrpAi59Yw1xczXu1DyKvaAiDgb//cV2CRfD0HRq1uzVdTX7fb+7/SAAKODehX5
 +ChuNA+IiTs3PDgKzOibkp3m8a1Bq9HC01X6Fe9kFx0Aij3l/4=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


(Please no top-posting)
On 14/07/17 11:45, Elliot Chandler wrote:
> For what it's worth, the file looks normal in Gentoo GNU/Linux (name appears 
> "ḋἲ╓εﮯ𒑏○╓Ӳ" and it seems to work like any other directory).
> 
Thanks for testing -
Normal and Normal ;-)
For me the 6th code point does look strange
The "box" with 04142F:
Code point 4142F is unassigned and is outside any currently defined block range.

So this is not valid Unicode, so we have a problem here under MacOS -
not much Git can do about it.



> On Fri, Jul 14, 2017 at 4:41 AM, Torsten Bögershausen <tboegi@web.de 
> <mailto:tboegi@web.de>> wrote:
> 
> 
> 
>     On 14/07/17 06:49, Lutz Roeder wrote:
> 
>         Using precomposeunicode still reproduces the issue:
> 
>         Repro steps:
> 
>         1. Download
>         https://www.dropbox.com/s/0q5pbpqpckwzj7b/gitstatusrepro.zip?dl=0
>         <https://www.dropbox.com/s/0q5pbpqpckwzj7b/gitstatusrepro.zip?dl=0>
>         2. unzip gitstatusrepro.zip && cd gitstatusrepro
>         3. git reset --hard
>         4. git -c core.precomposeunicode=true status
> 
>         On branch master
>         Untracked files:
>             (use "git add <file>..." to include in what will be committed)
> 
> 
>     A (short) investigation shows that this seems to be invalid unicode,
>     at least from a MacOSX point of view ?
> 
>     Unzipping your repo shows this:
>       git status -u
>        deleted:
>     "\341\270\213\341\274\262\342\225\223\316\265\357\256\257\360\222\221\217\342\227\213\342\225\223\323\262/test.txt"
> 
> 
>     ===============
>     If I run this:
>       xx=$(printf
>     "d\314\207\316\271\314\223\314\200\342\225\223\316\265\357\256\257\360\222\221\217\342\227\213\342\225\223\320\243\314\213/")
> 
>     echo   $xx | iconv -f UTF-8-MAC -t UTF-16 | xxd
> 
>     iconv: (stdin):1:5: cannot convert
>     0000000: feff 1e0b 1f32 2553 03b5 fbaf            .....2%S....
>     ===============================
>     So I don't know if we can do something in Git to improve your repo.
>     How did  you end up with such a directory name ?
>     And would it be possible to rename it ?
> 
> 
> 
