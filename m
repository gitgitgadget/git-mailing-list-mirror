Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.2 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7930B1F6DC
	for <e@80x24.org>; Fri, 27 Jan 2017 11:00:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933250AbdA0LAI (ORCPT <rfc822;e@80x24.org>);
        Fri, 27 Jan 2017 06:00:08 -0500
Received: from mout.gmx.net ([212.227.17.21]:52043 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933251AbdA0LAF (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 27 Jan 2017 06:00:05 -0500
Received: from virtualbox ([37.201.192.48]) by mail.gmx.com (mrgmx101
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0MSq5p-1cyJx10ohp-00RtfW; Fri, 27
 Jan 2017 11:53:06 +0100
Date:   Fri, 27 Jan 2017 11:53:04 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     git@vger.kernel.org
cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?Q?Nguy=E1=BB=85n_Th=C3=A1i_Ng=E1=BB=8Dc_Duy?= 
        <pclouds@gmail.com>
Subject: Re: [PATCH] fixup! worktree move: new command
In-Reply-To: <4f4ae057cd4d72d5b945a856deacd921fb5e7977.1485349447.git.johannes.schindelin@gmx.de>
Message-ID: <alpine.DEB.2.20.1701271150200.3469@virtualbox>
References: <4f4ae057cd4d72d5b945a856deacd921fb5e7977.1485349447.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:kes5BL0719/MdrvgPPgWJXe8JqMRmtWZVo9vNFyG1v2d1/SVIc0
 IRAhGewQKYKP+XR5SowJojqAuR67/DPz1p1fQ493KFe5JX7OHXlkyIY4bJGEQGJP94QJpHU
 UI/GZXKizGuIBq8gcXQWM0zDK08XFDbmPe5iV4HQvN1cNGUbCayoJ/hR+ev3hEycYc+lpu+
 nksIVXQnrHNN9V4iFZ0RQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:X+cChFmDoe4=:OJQme9zYv5MNaDqTaE4Sys
 h6Wa2vtIl4bIDwsIlwhjKjZF1nr1kgqw+Tb0welxKZQgg6xU/DlonEmaQy/tWj6kSnK/4BMH3
 azoV+foQewBg5WkkKg8vQUok6gpsFbFQBfwvF3QhOZmeyel7C9HVE11QgbnmfIJ0Q7Ybont45
 RQjrdvQ2VUkRN6ehfXTIfIif+u+SOJdEJHAr022RVj5+B0iinwSnu2nd+a0eFsSjq2bRht6JK
 khdl2uXO6BrU4uA7aQMR+HbYDJ6jkRXu/uNlBzPOSnlInrnZBpqgcugqS1c5ERAyIHJ4fRrMR
 N8FZSqAQaPjoOBtQi0lrVpfMMDpEEeZc8ak+rjT1vGWqyG+DSwxHi7uT06lNi2mB15A1nAMf9
 sCyMdqQ/Y2K7oTnumcB6sejuRvAy8gBkjMFMdVBDbVXW6Ga9GbidDjKYkyiJC9tfccfkNi1FB
 jA/NjniaePaHfbADMMuDwfDzVr10JIJET0Cp5iH0Pg8xUNXRZkqJmweTZ7yW1MQ2Isb1wyhFH
 KXjWyInDNUPKHhTkE+W4KOEo8R7jqwWq3n18fV1hLOgLWz5ZlVxJaMA70wpnSwSfvayBs/Jzq
 rA3SJa4VIey9JxyIINHNu1R0qaJZjC7PGo64GoNLdPUfUmBFzUyePV3A1e7IEBnp//LLHJdJy
 ZTa7+6Tq+9njbOGblQfwLSz247C569/m3CCh7c0YjuYMxm0AgFnu2NcajIjYhTIFUyyAzZY3A
 nxvZLh+tBeIDTgFR6tKL6Ks55aLVrL4atIbFxfl8TIj/LNYWh29L5zLNu/WkhNEpcIaPnHSPs
 dWlNGWaTyvJ/MSO0CREk5xLLMiJdwfp9TrrrOBEU6HO277h/tm8pT7uhrC71bbZ4psWqYE7JF
 pPE72+QV1pSrJT9Z1xxAdbUBlbRVLBjNI+dFJOMZwJ6zwwt8DZzcaTPuuTiBVlzAROLa4r9eQ
 37bdyHEdgGNyWNG8wnvFHoL7H5HYKYn61btU7p7lUW5yy6CcIQ9DptQ9MR2drtwFMSLzlK2hS
 xTuip/5OVQKJtSMZllFIfL/fBuLgottP/lktm9kdMpRt
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

On Wed, 25 Jan 2017, Johannes Schindelin wrote:

> This is required for the test to pass on Windows, where $TRASH_DIRECTORY
> is a POSIX path, while Git works with Windows paths instead. Using
> `$(pwd)` is the common workaround: it reports a Windows path (while `$PWD`
> would report the POSIX equivalent which, however, would only be understood
> by shell and Perl scripts).
> 
> Duy, if you re-roll the `worktree-move` patch series, would you terribly
> mind squashing this in?
> 
> Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> ---

Given that you add all kinds of SQUASH patches in `pu` that have not even
always been discussed on the mailing list, I would like to kindly ask you
to please add this patch to the nd/worktree-move branch for the time being
(i.e. until Duy responds), so that I am not continuously pestered by
failing Continuous Integration builds about a problem for which I have
provided a fix already.

Thanks,
Johannes
