Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 44A551F85D
	for <e@80x24.org>; Wed, 11 Jul 2018 23:09:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388152AbeGKXPm (ORCPT <rfc822;e@80x24.org>);
        Wed, 11 Jul 2018 19:15:42 -0400
Received: from mout.gmx.net ([212.227.15.19]:35459 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732281AbeGKXPm (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 11 Jul 2018 19:15:42 -0400
Received: from [192.168.0.129] ([37.201.195.87]) by mail.gmx.com (mrgmx001
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0MLNpK-1fcq020E7O-000fRC; Thu, 12
 Jul 2018 01:09:04 +0200
Date:   Thu, 12 Jul 2018 01:08:48 +0200 (DST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Alban Gruin <alban.gruin@gmail.com>
cc:     Git List <git@vger.kernel.org>,
        Christian Couder <christian.couder@gmail.com>,
        Stefan Beller <sbeller@google.com>,
        Pratik Karki <predatoramigo@gmail.com>,
        Paul-Sebastian Ungureanu <ungureanupaulsebastian@gmail.com>
Subject: Re: [GSoC] GSoC with git, week 10
In-Reply-To: <d6b9e84b-4d9e-ff1d-e726-56aa58a6b358@gmail.com>
Message-ID: <nycvar.QRO.7.76.6.1807120108180.75@tvgsbejvaqbjf.bet>
References: <d6b9e84b-4d9e-ff1d-e726-56aa58a6b358@gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:EBXmjLlraZRroVETEWJ2v2Pr8/lCf8p7XjlMQ3OOQziwLC0FYyo
 BtbwaxTR12NhWOSPlLK9r3luOgzyE3f7KMSPeQ70YQVzrfFQ8QHQKj2ZDGuXS6Qy5r71ASN
 VUNrIggYBNLdTjfLh+QaXRJCTZhpbK7FZgQ4EoACwYJyYZfX08ngs2RqySnl8gop14onls2
 t+8Ec4HzHP6hiQp+g9xvg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:zPBFB8vdu38=:K8P1YSylshzXoYSVt1H5RB
 gM2Jv5+bKP7IVJ3bVaPsXO5tP+rnawlzVM3C4g+veu3S8fUIGouTdqVUHFP7i7F8TW6i28dvM
 NHi2xH3Di1Tw6FHorAOLyCilNQ8Gby31ENqmD9WBZHD5KXcRperdZ/MXusRGnymJRRK/nKj07
 yEJxqGVAFFaawv51hX0CjlthyqZP3euvZchfZ9AbfjzbvBLVKPSQTcefRYfjblIfikwCtBwuq
 SWztuEGwvxCt2D91lqN8VGymCYEmkTzIijlrFvaW57VxNroAO+GQrs024VJ2rvpEDNy8qIHKc
 JVUdw1/OoUHfteKqgzVuxpNnK9h84mUMlEl3JWfliqSaq46x64DwCRrE4nFgMRzKyXKcPS7rR
 2P0IfX97BYvVJzgih8kwxZTqGVnXSZYWIrFwMO33ei6kmeAKXZYEfrAVSSXJHbwkVgQ+jM9HF
 BIOdEWie3AT3L7cPNJW5z4bGVl7vTIRdpI2k5t+5/7RdpwJ0w/MO6jxLT80s1BjJyWbjpwnTT
 2lBQ+JpxU5mBl6/HH1x8wxO+N8yRMc6Zqy6KHX1Jh9EtuL8QUMWhLgSdX5s3Hu5MZ0TberB/O
 JAs2RFseznHhTAEqDI4SA9el/dsiySGYpQTXFfrlf3gwTn/27uTksVrbqhopRbSpOjNBhZYAR
 LCtqnl6XsM+Y3bqEzxcSVPAJFuyFAyFTTikTPwyGLZVsESj/L7IeW4BuU43JuGjDmXmqk5cFv
 IeMkMJHTRTafMj9xZNhAUsbaS26iAWzoEySFDoR9MmzTOGIc+CkuRwDHjyDkBUPT2LmF3o+z6
 XUijYMM
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Alban,

On Tue, 10 Jul 2018, Alban Gruin wrote:

> I published a new blog post:
> 
>     https://blog.pa1ch.fr/posts/2018/07/10/en/gsoc2018-week-10.html

Very pleasant read, and awesome news about the current state of your
project!

Thanks,
Dscho
