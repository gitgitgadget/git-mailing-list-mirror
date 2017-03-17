Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 95A842095B
	for <e@80x24.org>; Fri, 17 Mar 2017 11:20:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751576AbdCQLUB (ORCPT <rfc822;e@80x24.org>);
        Fri, 17 Mar 2017 07:20:01 -0400
Received: from mout.web.de ([217.72.192.78]:62032 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751192AbdCQLTk (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 17 Mar 2017 07:19:40 -0400
Received: from [192.168.88.106] ([194.47.243.242]) by smtp.web.de (mrweb102
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0MWRzK-1chfzE03lC-00Xdzc; Fri, 17
 Mar 2017 12:18:50 +0100
Subject: Re: File names are considered case insensitive in a folder. (aBcd.py
 ==AbcD.py) Inbox x
To:     Vish Gite <vishgite@gmail.com>, git@vger.kernel.org
References: <CA+vHbJL5QMmtzRjQ8tV9Ntrh8=2bspPLeu=34RVFeDTVUhEuWw@mail.gmail.com>
From:   =?UTF-8?Q?Torsten_B=c3=b6gershausen?= <tboegi@web.de>
Message-ID: <ff2085a8-0f4b-5aa6-4ea1-ee6cab080bcf@web.de>
Date:   Fri, 17 Mar 2017 12:19:00 +0100
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.11; rv:45.0)
 Gecko/20100101 Thunderbird/45.8.0
MIME-Version: 1.0
In-Reply-To: <CA+vHbJL5QMmtzRjQ8tV9Ntrh8=2bspPLeu=34RVFeDTVUhEuWw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K0:fDPNdBReDdXPbH/U2LcVT0/GdOQ9AVVHw6Dn1xekAdRpUIO/QWf
 gTZrmZf7FNkIffjDLLf0dAMMriYJ4Glw4Xn6fmZFU6VMBiXamFJbbLvyy7MlngzKsHDRIzd
 Bdjw5bDgbv154awBcjr+3GNdb/dPjslSce/+kD6s7DsTXqWMMp76Fe18iXUII5sqIxSXvLB
 uZ2x/HFj2VfCEfqcPP+Sg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:ckhN93ejrG4=:bxI4tCbXCW3QFylC2iX2FM
 lPsMbd8Xri35Io3/v0NDgAUaBrkre9R2FOzgYzpKaacnAC83daJKKmnHAmQhOE3gDa+P9l1UG
 SlKFVbNajmNHXOt5QbAWRa/ytEGqoMZaehDhzd6oB2IuEVWTRweho5smYn+PQwhFgRArFQrKF
 uZx745N4KdDUMPYAoJRakxGe//29XJ9V2Mk1JF2kUsX13sx1IJD4UhVjHitayKMo03L0TiMjy
 VvnTBXdyi3Rn/sjvs6INb6bOxBUEzAt0FyDJR0WOV3XMmfAUGlqpFnnYCvhS6/JCs/RDZ4oMm
 VQX+IW0Ak7SSaei/4V35WO9X8zaZIDxFuzvtB4159Kros7Lho/cMNFAyaj7VrAooVeY6FvA8w
 0q9sa0S/oRoNdsaIOSy/8BnGeXH80eZ9Fzl5Kqj+Iot2j9ZHugNO3jfMwJ82qkTdAF7yQ9GIG
 PdzVGZJYD5noiTgERLYbeDI/nUS/OFfVJJriyJrIrtYKjKdBCIYCdO6vPNOEMBp4nvlFTodk9
 rTrZReQp28fZIyYH8QfApW+Lt1/gbVJbz01KQ/diz4VMRmAoCjz25tF3W75jGzFacYyuevGCt
 KNQWOx2ddgPxRZdO1vF9x1KgoO+PK0mXw6O0eraSFfxe5tS7RF5LrZW4HnOFGA1x6DAkESmfk
 qC0AMTa6EHHsb8FxKqUQL4I3f9Z8n/szT23ngwjwhfkAQzA6YvlxrO9DLecvLS67RYLo6qnUj
 lDbeTCBhAtQtdrMbnCvn3Y/okVQovhPcAJk3Sly1XosGqeh8NQKADkarDtKsjlx+x0NKwZ8IW
 y+PFHnO
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 17/03/17 10:28, Vish Gite wrote:
> Hello,
>
> Git 2.10.1 on Apple mac is treating different(uppercase/lowercase)
> files as same name(e.g ABCD.py and abcd.py)
>
> In a project where file name is same but case is different, either
> ABCD.py or abcd.py. There is always one of these files is modified.
>
> Below is the git version on my mac.
> snappy:myproject$ git version
> git version 2.10.1 (Apple Git-78)
>
> Where as git 2.7.4 on Linux Ubuntu xenial is treating ABCD.py and
> abcd.py as different files.
>
> To reproduce the issue on mac. Clone a project that has two files in
> same directory with same name but different case. ClassTest.py and
> classtest.py
>
>
> Thanks,
> Vishnu

This is a know problem, which is not caused by Git, but caused by the 
underlying file system,

which treats ABCD.py and abcd.py the same.

Git can not do anything about it.

If you want to do cross platform, the only chance to do this
is to avoid this kind of name collision.


