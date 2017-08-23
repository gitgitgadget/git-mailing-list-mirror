Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4055520899
	for <e@80x24.org>; Wed, 23 Aug 2017 17:06:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932251AbdHWRGz (ORCPT <rfc822;e@80x24.org>);
        Wed, 23 Aug 2017 13:06:55 -0400
Received: from bsmtp8.bon.at ([213.33.87.20]:37370 "EHLO bsmtp8.bon.at"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932204AbdHWRGz (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 23 Aug 2017 13:06:55 -0400
Received: from dx.site (unknown [93.83.142.38])
        by bsmtp8.bon.at (Postfix) with ESMTPSA id 3xcv3d1yg7z5tlB;
        Wed, 23 Aug 2017 19:06:53 +0200 (CEST)
Received: from [IPv6:::1] (localhost [IPv6:::1])
        by dx.site (Postfix) with ESMTP id 8EF052079;
        Wed, 23 Aug 2017 19:06:52 +0200 (CEST)
Subject: Re: How to force a push to succeed?
To:     noloader@gmail.com
Cc:     Stefan Beller <sbeller@google.com>, Git List <git@vger.kernel.org>
References: <CAH8yC8=A0-geqduTNNJw0yb1BREqsB75_bKSp+06Rb5fY6oiuQ@mail.gmail.com>
 <CAGZ79kYyO4zvmTvMpxpFyBEs4f=xoy_-UeSbmi9W-OCFz0kCwQ@mail.gmail.com>
 <CAH8yC8nu7zDmkQMZ99SpePXL1WpvvcOdQDAtwdo4WXiPiR3tOQ@mail.gmail.com>
 <CAH8yC8nHnbWTG4hxD+mEHKPS6eWcBb7yMsgN886=aTWaBRhE5A@mail.gmail.com>
 <CAH8yC8=HuAZ0tJbRGnp83-Th5OkQ0-cdSOBrMU23y6NyB0Ax3g@mail.gmail.com>
From:   Johannes Sixt <j6t@kdbg.org>
Message-ID: <6d9c7dd4-f1ad-8f5b-1e7b-2dcc5b9baf7e@kdbg.org>
Date:   Wed, 23 Aug 2017 19:06:51 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.3.0
MIME-Version: 1.0
In-Reply-To: <CAH8yC8=HuAZ0tJbRGnp83-Th5OkQ0-cdSOBrMU23y6NyB0Ax3g@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 23.08.2017 um 00:26 schrieb Jeffrey Walton:
> You know, I look at how fucked up yet another simple workflow is, and
> all I can do is wonder. It is absolutely amazing. Its like the project
> goes out of its way to make simple tasks difficult.

No, no. So simple your task might look, in the end you have LOST DATA! 
It is a design goal of Git to make it difficult to lose data.

-- Hannes
