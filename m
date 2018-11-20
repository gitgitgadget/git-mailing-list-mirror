Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 01F4F1F87F
	for <e@80x24.org>; Tue, 20 Nov 2018 05:21:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726941AbeKTPtK (ORCPT <rfc822;e@80x24.org>);
        Tue, 20 Nov 2018 10:49:10 -0500
Received: from mout.web.de ([212.227.15.4]:46017 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726794AbeKTPtJ (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 20 Nov 2018 10:49:09 -0500
Received: from localhost ([195.198.252.176]) by smtp.web.de (mrweb002
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0LpfJW-1flmJI2rWI-00fQqd; Tue, 20
 Nov 2018 06:21:54 +0100
Date:   Tue, 20 Nov 2018 06:21:54 +0100
From:   Torsten =?iso-8859-1?Q?B=F6gershausen?= <tboegi@web.de>
To:     Orgad Shaneh <orgads@gmail.com>
Cc:     git <git@vger.kernel.org>
Subject: Re: grep issues
Message-ID: <20181120052154.GB16814@tor.lan>
References: <CAGHpTB+fQccqR8SF2_dS3itboKd79238KCFRe4-3PZz6bpr3iQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAGHpTB+fQccqR8SF2_dS3itboKd79238KCFRe4-3PZz6bpr3iQ@mail.gmail.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-Provags-ID: V03:K1:K5ceJkbI40lt9O6ocj8vrwaHwM8mvEVt6Y+CkZoWoMr8kXzQ/5N
 wXDrNveegawKFhpnpjBlQJwV/Io4nLDL63SNBLsYzLAaFYec/BfNMmkh+30s6ltGxC8xtpE
 OR/4fWjGh2n4s+MW2H6BNcxxoZNP+e4mQaxA7+a5Q710y84R9n0infe9Xj6VZIjzf8LOu8d
 X+RSo3Q91dKlxqqH1VQ3Q==
X-UI-Out-Filterresults: notjunk:1;V01:K0:Jo1XC5e2Y40=:6V61PAOKoZpe37IOAoNx8+
 ZgJb5FJ8C0uPvyUquhP8kLDNdLELhHRfRKZIwha9KQnUwn1WW+8E1ZsGB2oEw64JxzzT9WAaU
 oaeV5p62zusjsg3WxXSEU9No+4dF2NPpLCF0jWdpcXRers4oQn0TKSpoGj7BR1YmKoYlIqEJV
 FEbXrLxctzWI9+LBb56d/M0EW9VZKAFTiNEk4OmQwv4R+biw58IbFz1BmrkuPntX0Gdtm+ugL
 MsGCDys1Z51BHLnZJzL5XFOXNOM679WXfase3fSm8L9d/EJOf/OYTxrSorMwkwiJcq+Qg2axt
 j0H4J+Re1ytsv0uqBxqe8+hNeMmL9f5TwBDEaGHijMH2pSz8mJ6No+sVbVoEzFJZuoxdJjmag
 aDYwbvARLUnPlUp89qh54AIHsh1meadPaFOv23Mh4TFwqxFOJC33VsRfIlrsV7ru5vYOkVE4Z
 cka/jnqPgURtBClpuqdkbPm4DILA9ODwj9ohzNrtXolqKRJrxdDEl1l3u8fJrINai7hrXxRpC
 y52ivh/RjB/JzburN43XpgdLSrjAH2F3LYrtCp6Y+nelGDH3xdUCr6PjyYqXk74JNCiaN1Jeh
 DblCe73VM/lfu/0xiyTVhrN6KQ2Z6QO38p5WRcupdaMiUgfbUT3sFfMCXr6lzbO4/dExHIehW
 9CF557NvyafKoopgorIbO9QTCCl7d+ZdldPYtoxPy1TpuV0Kh4waHadRQ4+sdc8UvYK/B82Wf
 w8BvuumoBPGIEPpdXVN3xi1kOO5nYJT+bw5o4GIMQg3oUtaJ7iytcBO+oGwdfQO9Kyz+aG5/k
 UIM3VOCHls8w4vjn4QrDI2WluRHiBMuqCDqmKXfwEyUkWeaf2bhpFx4isZYYXLNgO288woBG5
 TOpk7aFwbvr6dpukyV2IwEjU/5+PztKt44kGMBUuA=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Nov 11, 2018 at 03:17:50PM +0200, Orgad Shaneh wrote:
> Hi,
> 
> I found 2 bugs in grep, using Git for Windows 2.19.1 (but noticed
> these several versions ago):
> 
> 1. git grep --recursive on a worktree (without rev) always matches
> against the submodule's HEAD, not its worktree, as it should.
> 2. When core.autocrlf (or eol=crlf) is used, and a file in the
> worktree has CRLF, git grep fails to match $ against EOL.
> 
> For example:
> git init
> echo 'file eol=crlf' > .gitattributes
> echo ABCD > file
> git add file
> git commit -m 'CRLF'
> rm file
> git checkout -f file
> git grep 'D$' file # Nothing
> git grep 'D$' HEAD -- file # Found!
> 
> - Orgad

I can confirm the "2. When core.autocrlf" bug, or should we call
it a non-implemented feature.
It seems as if a convert_to_git() is needed in grep.c,
but I haven't found the time to dig deeper.
Does anybody wants to work on this ?
