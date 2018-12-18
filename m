Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,BODY_8BITS,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 046D4211B3
	for <e@80x24.org>; Tue, 18 Dec 2018 21:57:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727051AbeLRV5B (ORCPT <rfc822;e@80x24.org>);
        Tue, 18 Dec 2018 16:57:01 -0500
Received: from mout.gmx.net ([212.227.15.19]:51119 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726704AbeLRV5A (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 18 Dec 2018 16:57:00 -0500
Received: from [192.168.0.129] ([37.201.193.149]) by mail.gmx.com (mrgmx002
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0MYfre-1gvqBc39gw-00VQXz; Tue, 18
 Dec 2018 22:56:58 +0100
Date:   Tue, 18 Dec 2018 22:56:43 +0100 (STD)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     =?UTF-8?B?0JjQstCw0L0g0JzQvtCz0LjRiA==?= <ivan.mogish@playrix.com>
cc:     git@vger.kernel.org,
        =?UTF-8?B?0JTQvNC40YLRgNC40Lkg0K/QutC+0LLQu9C10LI=?= 
        <yakovlev@playrix.com>
Subject: Re: Git hooks don't run while commiting in worktree via git-gui
In-Reply-To: <CACu3VMWJ_otp2D6Tu_2adq=J2wcj0nsYhsW5oWxmbidb3afuyg@mail.gmail.com>
Message-ID: <nycvar.QRO.7.76.6.1812182254250.43@tvgsbejvaqbjf.bet>
References: <CACu3VMWJ_otp2D6Tu_2adq=J2wcj0nsYhsW5oWxmbidb3afuyg@mail.gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-1307322083-1545170218=:43"
X-Provags-ID: V03:K1:6YQgUd3YmelUl83pCP3TuU+HQIpMm2LFjLGuYygkzvSUGTBvgZn
 U+uN51VIeR5Z89sSR+DTS8V/179/tLP6FlSr9qwZ5wQBOYWA6pUCDKfang4Re9w/KVh+02m
 lq0pBEiNgu/hkdJIvOvJ7KAj0A+e31sD7yE98KDOVSXJKv+uDhrkoOzwGmq+pH+M8ahP1Pr
 aqNqMg4AujbqwCEUmw1BQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:+rc4QYNTGFE=:Rx4ScvKMb3oeYVG99p4B+g
 5mHRtvrrBWFwVNWKpnN3vPS8HkigEJdNKhHXzBRDMMfMIOHvf+99i8FESFvLGl/igg8yIzGQI
 lMgCy/BwNKSvoXDjUsOKTPL/vNXagC65RK4XJ1hpVtlhQedx6PwfCbmaVqWaFBDNoscvVZl4L
 SHCDXr+AKZnCbPAgNHdav/7aJvUHGu77a/bSQ6f14xSUTF9/m4b55cKJRdbUVhvZnuRtutZlg
 i+wRpuLlcN88fsaRZ8tUCx6JgOn/pAe5ak08ONJbiXBJMTYVf3AmUTiChiCW6u31HuO/MYQgY
 U6iAbGQrjpVIgMI8fHPcUui9oQSHqPParyp3HsOLJk5PmJjDgcAtTO3eqlAYm87VHOpAcdTWH
 llXHmCkV9v9FXCgR8YhCo1oTcqKOkd/1RKtYlwNwWNBMRhJEMUNe15iR03Jj8TwSlhJJTEnBp
 RrIPzePWl61j9r3u8fIhGXa1M9Ys7DRXCu2NvDV3xk8BofCmNVUw2deoG3NgNFBJlCWLMuf+r
 fSBTOpREuPn7BMK5Dm3rLiOtdEzvmb4f35/0SZzmOvqJyFN6U4hu6BICBfEL0yL8uiLOiqjoX
 tIiiPgMW0ZF5AADR03R6NPWgih1Mamcrm+e5qTwxIEVFvJAfwXkGBlSRBxywO37bM35BnCM4f
 8hIlTwO/ufv6fu0zjqzo95tutgeYqk77FagICaEdCBHqVLMyP636QwUt2dju2ukzvgcHBQaVr
 DX3XJP0VT3VF8OJHwpyvxhQu4jHY94XhCoTfj5aUYEHnqiqZkfHelzGGupN0DJYXwY5auKsBG
 Uwsu/lMM2AQIDrLEnh42J3/8MrosHokSSJpsLxVOlernf9GOGSkie0XUwRmhZe0zWCVHXnotQ
 k4mL36geU8rkZSFCamMbb+49imuAmR6LEz09+yQBn6RNrkoGl5dSL+nAQgBz/kxVy4GKdbe28
 faXd7EYIrVA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-1307322083-1545170218=:43
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT

Hi Ivan,

On Tue, 18 Dec 2018, Иван Могиш wrote:

> Hello.
> There is a little difference in behavior when you are committing to
> the worktree from CLI or some git client (tortoisegit/sourcetree) and
> embedded git gui.
> 
> If you configure git hooks in your repository and then add a worktree
> (via git worktree add), hooks from main repository works well both in
> main directory and in worktree, if you are using CLI/third-party GUI.
> Committing in the main directory via embedded git-gui works fine too,
> hooks are running. But when you try to commit in the worktree
> directory from git-gui, hooks don't work.
> 
> I think I've found the cause of this:
> https://github.com/git/git/blob/master/git-gui/lib/commit.tcl#L238
> variable fd equals {} because proc githook_read calls proc gitdir to
> determine path to hooks.
> https://github.com/git/git/blob/master/git-gui/git-gui.sh#L626
> This proc use variable _gitdir for calculating result. This var equals
> the result of executing git rev-parse --git-dir
> https://github.com/git/git/blob/master/git-gui/git-gui.sh#L1245
> So, the path to hooks for worktree is
> path_to_main_repo/.git/worktrees/my_worktree/hooks, but there are no
> hooks. Hooks are in path_to_main_repo/.git/hooks, from where they are
> correctly (or not?) executed by git cli, while running from worktree
> directory.
> 
> If we put hooks to path_to_main_repo/.git/worktrees/my_worktree/hooks
> too, they will work both in git citool and CLI/third-party GUI. But
> they will execute different files, and it may cause some problems.

Sounds like you need https://github.com/git-for-windows/git/pull/1757
(we do not currently have a responsive maintainer for Git GUI,
unfortunately, otherwise this patch would have made it into an official
Git version already).

That patch also has the benefit of heeding core.hooksPath.

Ciao,
Johannes

> -- 
> Ivan Mogish
> Support Engineer
> Phone: +9115212057
> 
--8323328-1307322083-1545170218=:43--
