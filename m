Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MALFORMED_FREEMAIL,RCVD_IN_DNSWL_HI shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 360B720248
	for <e@80x24.org>; Fri,  8 Mar 2019 15:42:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726294AbfCHPmb (ORCPT <rfc822;e@80x24.org>);
        Fri, 8 Mar 2019 10:42:31 -0500
Received: from mout.gmx.net ([212.227.17.22]:43181 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726249AbfCHPmb (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 8 Mar 2019 10:42:31 -0500
Received: from [192.168.0.129] ([37.201.195.16]) by mail.gmx.com (mrgmx101
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0MTfZc-1hSmhh0nNA-00QUiQ; Fri, 08
 Mar 2019 16:42:29 +0100
Date:   Fri, 8 Mar 2019 16:42:13 +0100 (STD)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Adrian Godong <adrian.godong@gmail.com>
cc:     git@vger.kernel.org
Subject: Re: git reset error on Windows
In-Reply-To: <CANNTdjSdTiNcM+UzF+2ZH_2JOyDZM0E6RFCDwsT3Y7F=G7YdOA@mail.gmail.com>
Message-ID: <nycvar.QRO.7.76.6.1903081641120.41@tvgsbejvaqbjf.bet>
References: <CANNTdjSRB+_1Ue6LLxMcAdLmdg5TrihZ4CeZhvnpgwnEP=SQ3A@mail.gmail.com> <CANNTdjSdTiNcM+UzF+2ZH_2JOyDZM0E6RFCDwsT3Y7F=G7YdOA@mail.gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:MBxu1/HlETuN1C1NbtG/IFhD5M5AJ0PUwrhMZ5b+d4Hg7WoH80x
 OjTcYS2T2NocGIBpUp7165MkgtiHL58fzbaj7+H9vcAXob7XahHWSuW7hF7TP1i0m0s3yR9
 nB+S/HIHhP2cjpbOjTWWpi3GZNxwVfjgER/WeGE/Yzl5F4wPRaxEABGFNOWez3xu/tFHZXB
 enQsD2Ft42bm9a3W2OlJg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:5BWJjtRwaTw=:iBjZ6IF9ZvS0bbbhcQyhvd
 wl/ybm0bU/Lz3LdHZHpJX14t8TurjAO2IXj/jg5cEB/6knwuXzGNKWnvpOj0YinMOzCOVG0ca
 VA11R7ki+5EuPdHbEaW9OHGvs2uymdykgNYUogJ4Ww0WjqdR9O3xOgVgCfQBzQnpKel7IN90K
 X8H4A4IrXqEtH3cu6gKJ7A6PsJ6n8m5aJOOi+OmpsMnfCOHxqZpHmsyI9YxaivWkLpWDDVcI3
 wQRVLHYdsl/edJ3Ehc4E1OjiUhueify4vDHM8dnVvrgAiFAI1qqak7zG2g3vKU8WWy+5ntn89
 toR1e+a0r6WBJy6cRBh1O4htgselx/y0yKqD4/STHso0OPrA9CQq1VEZ4/+7eZ2GTCQ1k6ZrU
 6UtIzVuYXBgbVHAczBV822E+NATdaHkPFoAu+jd4wd3UvLkOTE+pSEokPZu5FCqYwC8ZdTjgV
 lOmCZhplELNaDj7p3fVk5xNsR5tn0QH0TxTVrwalFPArJhylWYVEbjqFTY8TH81n4rOqvGFMD
 6nGvPEi6yxxkLjBOnOFdY/zE0Dmn9bb6Xtw/Eb5wREcmOMvKGofdaxj3yrG+Qi6qnmG3xGziE
 Z9AHKB+82U0kkSO56IFZqA1MqlWSFd3V0fUT6Hm8VIy5GnqUMvKW5zltZkUHY7Q5L6lV3PW2q
 CnVvM3kh9cADnnjP5ZnJGGYfFuQloIt28XvXaUP8CQgDn0tYcRsrZshJOiKuPTvz9mN2ofLxA
 N6JzLaN3Mo5RvyQOvxwy2b+ZSeJAdBaFIuqIu6uFWqY473eYvgViO9QNk/0qkEVSlSbYS6ylO
 +d+UAtN8ckjwEZPiQKQFrAuJh/huTHY8ItZrui3b5Ls7Dd0gMHU1DK3F6O6byBTd6hxX3oH18
 M7NLvDhg7C7KZGUkHXePjfxjcGJxWV6UA9OyC3n7kMgDJnmwsYBZbZiI4yEbeoHQDXoQl/O9h
 HypDI9mu0Rw==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Adrian,

On Thu, 7 Mar 2019, Adrian Godong wrote:

> Windows 10, git version 2.21.0.windows.1
> 
> git reset tries to delete folder when last file is removed but failed
> to do so if shell is in the deleted folder.
> 
> Repro steps (powershell):
> mkdir test
> cd test
> git init
> mkdir dir
> cd dir
> add-content .\file ""
> git add .
> git commit -m "1"
> git mv .\file .\file2
> git commit -m "2"
> git reset --hard HEAD^
> > Deletion of directory 'dir' failed. Should I try again? (y/n)
> 
> Choosing y will repeat the same prompt. Choosing n will complete the
> operation correctly.

In contrast to Linux, it is not possible to delete a current working
directory (unless you delve into horrible hacks like Cygwin does).

So this is a restriction of the platform on which you are working, and
there is nothing we can do about it, at least as far as I can think of.

Ciao,
Johannes
