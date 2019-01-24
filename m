Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MALFORMED_FREEMAIL,RCVD_IN_DNSWL_HI shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3E00E1F453
	for <e@80x24.org>; Thu, 24 Jan 2019 17:12:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727983AbfAXRMN (ORCPT <rfc822;e@80x24.org>);
        Thu, 24 Jan 2019 12:12:13 -0500
Received: from mout.gmx.net ([212.227.15.15]:52079 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727573AbfAXRMN (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 24 Jan 2019 12:12:13 -0500
Received: from [192.168.0.129] ([37.201.193.149]) by mail.gmx.com (mrgmx003
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0MGjfl-1gzaZv0qI5-00DUDI; Thu, 24
 Jan 2019 18:12:10 +0100
Date:   Thu, 24 Jan 2019 18:11:54 +0100 (STD)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Cody Kratzer <cody@lightingnewyork.com>
cc:     Christopher Hagler <haglerchristopher@gmail.com>,
        git@vger.kernel.org
Subject: Re:
In-Reply-To: <CAJLF3qjPyg9DKO29eYjqQaf0SZC8fJx-CMKMu29uxP9fbgqxXw@mail.gmail.com>
Message-ID: <nycvar.QRO.7.76.6.1901241811250.41@tvgsbejvaqbjf.bet>
References: <4FC35B6B-457C-4E5E-9B00-7C80F075963E@gmail.com> <CAJLF3qjPyg9DKO29eYjqQaf0SZC8fJx-CMKMu29uxP9fbgqxXw@mail.gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:76L7t9JDHH3pmvqhItY78fd5SM5tKx+cVTXeSsGWkBL7UIzB4Hb
 ScJptHAbrXDYPpy9QIMkbXXtBknYG6QwIpvtVO/7cAqV/uv6JU9q+XYSDaxlVU5b6ATnkNG
 h75P9jG6UYydQwY5/O2c7KLXDVnyObkub/3RIbbmx5vfNekzr4bYwC75ZHPFTGdnNxqUNVI
 xzYfbwPl0UO1+P2I9ox0Q==
X-UI-Out-Filterresults: notjunk:1;V03:K0:CriPi6wTlO4=:/D9kRIpVsHwNl5l6B9clOC
 t6en6oV1fm8/5Pq8MDJfRn8fYTUrXeYioT8E4DE8xzZ64ZzncUXG/rcGPfyNul8xNodlW5UC4
 Q7VNEGCFPelICNY0SkHkc0QAIZphpZ1QzS4W+td7L3ZvHmHNF+3WAe0wCP/qQhG4QlcRhAU4x
 J/9g5/3amtmxZO7f8cmOYydlyInVQ+UBNzRzk78iabvAeWYPx8Z6FNsvSVGBKrvRlb6GmSwUM
 7quxw3+cz1aSjeQeK/iC8YuW7nr2kSgEAp86j8ug81be0kLFrFEVL/JsSDPVSjZj3TV2X0nsq
 hSrc2QqocP4hp1K3koKVG0xQQN1O5LlPWX8lBRKl2OMza5mz9GEX8jEjlSejooB0YBy0fh1+d
 g4dHafnTnB6TwgWyOMfS5sMWRJi1iNNca5go+EWuEuoeFPMOpuWzWkEgBRYQqfXUlkC8uBJuv
 gvNxi18xFwNxfqUxiJTSZ92/5T3rflclZYKrbJ+FYLRMSruPEwLFS9DkZHj9v46Id8V2vrmXw
 zy6GlfNk5VO0gKec70mSMztB053wRftGNKSgvICRqR/sRFruIBDyrTbAx+ocVMPObIesHvhV1
 B+r+N22EBHjgQ58OiPe1yqT3gQ3quy5Oigvn7Fo1sxrHopDhOjSdpZoBEGbb1/DkJkM8Q/mhK
 VIimzgpOOSZPLowXEeiv/bKx0s/71vkcL+GiMmDEZJFugK01BVRmceOytoh+N3SaOW1q1cuE6
 Y4SIXjQOeWGO2+HUY/tDuDdj+egDNHCyxUtWG3MDjbD5RGx4uF/Qul/rWiGMPxJj1dseYMHs8
 q4eD4GkdW677dyhlF5U8MpldaERsCsRBA+I820vaqcQUwWROQwNlRnU3+4auagvBIeZ3+YYEn
 irv7An1ZT4Z2yRu3OeHltuVPxscmb1/LlFcIt170JF2bg5UMawXqZ7QaugK9d8z5VY5j/lnw8
 ARSa1UDFslg==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

don't send this to git@vger.kernel.org. Send it to
majordomo@vger.kernel.org instead.

Thanks,
Johannes


On Wed, 23 Jan 2019, Cody Kratzer wrote:

> I've sent this same email 3 times. I don't think it works. I'm
> researching this morning how to unsubscribe from this git group.
> 
> CODY KRATZER WEB DEVELOPMENT MANAGER
> 866-344-3875 x145
> CODY@LIGHTINGNEWYORK.COM
> M - F 9 - 5:30
> 
> 
> On Wed, Jan 23, 2019 at 5:51 AM Christopher Hagler
> <haglerchristopher@gmail.com> wrote:
> >
> > Unsubscribe git
> >
> > Sent from my iPhone
> 
