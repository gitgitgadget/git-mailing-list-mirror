Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D2B3D1F424
	for <e@80x24.org>; Mon, 23 Apr 2018 19:58:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932335AbeDWT6V (ORCPT <rfc822;e@80x24.org>);
        Mon, 23 Apr 2018 15:58:21 -0400
Received: from mout.web.de ([212.227.15.4]:38611 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932306AbeDWT6V (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 23 Apr 2018 15:58:21 -0400
Received: from [192.168.209.26] ([195.198.252.176]) by smtp.web.de (mrweb003
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0M8zRF-1fGRJ12PBl-00CPzz; Mon, 23
 Apr 2018 21:58:18 +0200
Subject: Re: Is support for 10.8 dropped?
To:     Eric Sunshine <sunshine@sunshineco.com>,
        Igor Korot <ikorot01@gmail.com>
Cc:     git <git@vger.kernel.org>
References: <CA+FnnTxbg97A4P3AP7n5RT8+=W8PY0yx3644Ay2Zi9xgKD2aoA@mail.gmail.com>
 <CA+FnnTzfJMBuSMAD7PgUurRu8jOpirEgM6=+=i91zdGLWmfUpg@mail.gmail.com>
 <CAPig+cQOzKbM0R6vKTg_BU6meEbAAJWL1T0jZkaCOF0uJ=_Lmw@mail.gmail.com>
 <CA+FnnTzqaPrLgYv-8X9BDW0DR7331morN33B81w8T3vzOwn+Pw@mail.gmail.com>
 <CA+FnnTz-qdVK5482GJo06QrvMktGYhJAJ6g-Naq0BgT-uoRvEA@mail.gmail.com>
 <CAPig+cS+gf5gGM3fmnxk-6k7ezbtS=KQFqkkxVtcytHfcQApEQ@mail.gmail.com>
 <CA+FnnTwvnA90nDARKW9r7p5iraoOGTvfDJ26n6Udc68bDSUASw@mail.gmail.com>
 <CAPig+cRjYju4zEgiY_TuOOk0e7A8zNz+hu+40vQUEGDX6FGDxw@mail.gmail.com>
 <CA+FnnTzFomd91d1F6O-a28hXQ6PxOiBd44da4nSVW0MuDKgkmw@mail.gmail.com>
 <CAPig+cTw5GjB4VgFD2teDvMuyGPFFoNSCqbXbarEXCe3fVdLjQ@mail.gmail.com>
 <CA+FnnTzkZS7HP61Ck3y5p0EC7J_h=ToR5tq5cvEpJ79vYuSxZw@mail.gmail.com>
 <CAPig+cT0ogLmiviWhdZTLxDM7+VN3hk7wgkKnvX96Ym-yXR5bA@mail.gmail.com>
 <CA+FnnTxXOwORs_qYvOdSj41UX1aBfj+Hd1+kxPa8j+34xgjhgQ@mail.gmail.com>
 <CAPig+cQzX04JuoUOnxOxWtqMCpHCUi=hMOSDL+jpNuML0iE+Tw@mail.gmail.com>
From:   =?UTF-8?Q?Totsten_B=c3=b6gershausen?= <tboegi@web.de>
Message-ID: <05560086-232c-f14c-f82b-e21b7ecce1b3@web.de>
Date:   Mon, 23 Apr 2018 21:58:13 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <CAPig+cQzX04JuoUOnxOxWtqMCpHCUi=hMOSDL+jpNuML0iE+Tw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:iYQ9ZFVLH3S8++u4ytaF2P9/hqpMYmwocrnex+DuaNb/U/Au7a5
 1WmVy8tAHTj5+dzuPjImpRYfaes2qj00y3ybnxS1CAKnI4LbIt/Jvua/yTsD4r+rsus/Mus
 MDpMl3Rvhz5VC8JPPSFCYy0/03LfY0EMDNEGesAg5zuGHPJDROo2Hl3hPoL27tRyudAK/V+
 YG4LjC9bbDp+9q3vx8a+w==
X-UI-Out-Filterresults: notjunk:1;V01:K0:Lqg289ZcutU=:fEcPKHk9c2LTyCCI9gT1pa
 Hz3W9GAG+9kmYV0NTBG60ZHYriTOmKVw5Ia+b8o4f87vmL3Pj4/fWdat7LUGSJUIHLzI+aP8y
 DJCQDBSc+QYbA887vYdpnXCZIM+TNLBtJ80t9XaYjha+aCOf2jfBHv1Qp+2Rj4P1esInCnYkA
 8XyCZQ9SYvpLcU6m51QaY/CmDOwkJcxzSCYCkB6VeZjhYYsY+XliX292uXkvOlldgikE5nv4X
 oTZUDjfTgXov050N8pZeUfdu3xYymcO/d9VUBRVCrPGdTseYiDXtMB3/ypyb+rX/DYMnOgA8z
 KElAIWu98lp5LAhoyLIkcqBgBeOoS6L2qjpb+l0EvYrSnusNUVYdZJDf6cym9b0J51y49WRi7
 CIdYlffhqbHanYIrH+VapnKmUAcRpdcRZ0VvQ/5ng51SRB/VCYEnH4boM0ROWoTDj5w8joHP2
 YvF3Iz1kkXOtrXlrdWkMXpeSkdGh8cqDensKDcGVGbn3gxMeFpbVbBv0WgLpiMLfUwvzyzOww
 uJLKJ9cuTr68ATSPI+zBxtHCipmenCgk7skjv6j0XgIP0P2uaKCkyMlbxsg4a1FTQfWrBkXPS
 QDl9hSxaYI2/tc9SkeKKisKibhZcG876aL1RUDfP0ELQMFvCiQv3aBdcqoI7TIqwg4rDm4qe4
 +/5Ppm1w4Dim0ZyB2/WJ5X1qG8H76TBAIqNiFtNgNSd2puy5k1he8uox9/6+5lN8IjjOminkS
 kNiiCdnv5i5/QBJIzhMce8ARk2GJOJmgJDxui/E7vSfqOYd5+PPZ08Wt2bzmhKgMHos5bt9Lz
 9nCja1r5m8xrqw4w4NKgZlFGLyGFP7Cj7v6HtrJyz9O5a5eh8c=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 2018-04-23 18:53, Eric Sunshine wrote:
> On Mon, Apr 23, 2018 at 12:31 PM, Igor Korot <ikorot01@gmail.com> wrote:
>> 1. Is the file name "config.mak" or "config.make"?
> 
> "config.mak"

I am confused, I have these file in my tree:
config.mak.in  config.mak.uname   Makefile
Setting options is documentend in Makefile

> 
>> 2. Do I have to do "make clean" or just remove the line and o "make"?
> 
> "make clean" would not hurt.

I would actually try to install openssl / openssl-dev (or however it is 
called) via "mac ports" or "home brew".

Both should work (but I don't have a system to test on)


