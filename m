Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 725C91FD09
	for <e@80x24.org>; Tue, 30 May 2017 07:37:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750938AbdE3HhU (ORCPT <rfc822;e@80x24.org>);
        Tue, 30 May 2017 03:37:20 -0400
Received: from mailhub.007spb.ru ([84.204.203.130]:43882 "EHLO
        mailhub.007spb.ru" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750871AbdE3HhT (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 30 May 2017 03:37:19 -0400
Received: from tigra (unknown [192.168.2.102])
        by hermes.domain007.com (Postfix) with ESMTP id 8FB94D400AD;
        Tue, 30 May 2017 10:37:17 +0300 (MSK)
Date:   Tue, 30 May 2017 10:37:17 +0300
From:   Konstantin Khomoutov <kostix+git@007spb.ru>
To:     The Intertainer <eminem.raunaq@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: Unable to download Git
Message-ID: <20170530073717.wg6vwrcwmpsfa7vt@tigra>
References: <CAMxySOmZxFPtwW-PZyhzqJMR-xMOUrWQzxq9jX5hXh=BrgzJYg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAMxySOmZxFPtwW-PZyhzqJMR-xMOUrWQzxq9jX5hXh=BrgzJYg@mail.gmail.com>
User-Agent: NeoMutt/20170306 (1.8.0)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, May 30, 2017 at 12:51:14PM +0530, The Intertainer wrote:

> I have been trying to download the '32-bit Git for Windows setup from
> ‘ https://git-scm.com/downloads’  latest versiion i.e. 2.13.0 but just
> cannot.
> 
> It downloadsl about 4-5mb but then says network error followed by
> Failed -Forbidden. I downloaded the file on the chrome browser online
> downloader.

All the links at https://git-scm.com/download/win actually lead to files
hosted by github.com -- you can see for yourself by hovering over the
relevant links there.

So you could possibly bring this problem in some Gitgub help channel.

Still, I've just downloaded 32-bit 2.13.0-6 whatever from there without
any problem, 35.4 MiB.  On the other hand, the Internet is highly
heterogenous structure, and we surely used different channels to
download; most probably this has nothing to do with Github.

