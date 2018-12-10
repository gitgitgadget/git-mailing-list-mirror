Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1B44020A1E
	for <e@80x24.org>; Mon, 10 Dec 2018 08:27:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726490AbeLJI1y (ORCPT <rfc822;e@80x24.org>);
        Mon, 10 Dec 2018 03:27:54 -0500
Received: from mout.gmx.net ([212.227.15.18]:45909 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726170AbeLJI1y (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 10 Dec 2018 03:27:54 -0500
Received: from [192.168.0.129] ([37.201.193.149]) by mail.gmx.com (mrgmx001
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0Lrek1-1hT1iQ29ef-013Li7; Mon, 10
 Dec 2018 09:27:47 +0100
Date:   Mon, 10 Dec 2018 09:27:50 +0100 (STD)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Junio C Hamano <gitster@pobox.com>
cc:     Kyle Meyer <kyle@kyleam.com>, git@vger.kernel.org
Subject: Re: [PATCH] rebase docs: drop stray word in merge command
 description
In-Reply-To: <xmqqk1ki2h32.fsf@gitster-ct.c.googlers.com>
Message-ID: <nycvar.QRO.7.76.6.1812100927150.43@tvgsbejvaqbjf.bet>
References: <20181208231541.1341999-1-kyle@kyleam.com> <nycvar.QRO.7.76.6.1812092040320.43@tvgsbejvaqbjf.bet> <xmqqk1ki2h32.fsf@gitster-ct.c.googlers.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:wfNTmtIdt/+ydU0w4ivMT3WBlT9x244NDH1bwpGf9pvJTeBtlxU
 5gMz+Yqa6u4E3T+IHb7hnifQ+j9MyTbuPxBLjtIH+EGH415x0ITgITKGTmShfia5SJP18gy
 0t2mKVCwIUFg9ZanKUMXsBaMkliWd1DS56uvtn7MqlpUvbNDX5qLKsOZqivX6a88C2slk+S
 Zv1s+adyBi+ra3CA1TRjg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:XugHB9q//9g=:y11icXbX/C/2HQEY5ptAqa
 8kz15zN1/dGxgKejbNlkU72a3cgGowdGW8JScCIioVPAOFeIrnCsoKBAcFwiDcppUExkb9dFE
 Hc6/5ioUNM8qN1jMANfu146l8ZsPWtuYdTf9O+ioYdybYeehf2H0DCeJOKLMae5oPK7wAhXLn
 jakmHr378dLSOo6i0eDMsuhl5769wj2hp7L9w5NofEioq6FBcNlKdExxYAeIFP5FYt09BhlIW
 vcMxJIKLZLwdi0ULpZczzIpb78qZJkz3KPUkld9QIP5U87DDOKwgazINgdkh35rhNEsMz0TvY
 IXPf/MCWRGEXLHyR5UCXH+gdiS/IHZYgs10SVAFnhoJCmHHW5IvWUKwztxBprXKvOni4bXptF
 fXoZqz5d89DRihb9pXowB83ckbgH9/UNYM0p8vjxOiCGVJH3ozGtU0XQB6guktjgozPqAESEL
 s5oRQdRCa2NascUn4J7HJ140vNOF7rjVm0XhaAJhmK3ogFohaaLtgwyxvHI7+5Qp1XzSXS8aT
 MWcS6HN9UwNDSWfE+qduyEqXVKVYuXy2HtJQYcPRoBJHuOFwiLXvV8SwHnsrOpNPA0PFKeant
 GLVOK4zPZNa0uWIf+fxXryoQNkvNffk/d4Xut52z9poT+6NqLl3fpqavy+8jYED5wL6ZYhAAL
 6UUaB+jUmsb3rsVku7Ic1VbNCSQt1Tw8G5c9Y7iy/5QMPveOgeOOeGE/r2vrZZdt+VtRX8kOM
 CCj4bTAeQM9OMvgsF7SHd5Ooa5jM0sD/vXmmVR3Clj3OzEi9Q+1594rsrORFgFc+b0Ez21Px0
 zNZeXrZglrPK0/gxxruD9/NezBk/fxhpLR5ZOt1BhwQnkuU9on5/wkwqdZnRHAraJtieFzjRy
 +Vr7I9SwFpeZTnyvsfO4ibhSC4w38d0ThSugXpAfgFLTS9tNDGqIEajpmrJYiYGiLvFNIdEBk
 ro/2W0wXXng==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

On Mon, 10 Dec 2018, Junio C Hamano wrote:

> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
> 
> > Hi Kyle,
> >
> > On Sat, 8 Dec 2018, Kyle Meyer wrote:
> >
> >> Delete a misplaced word introduced by caafecfcf1 (rebase
> >> --rebase-merges: adjust man page for octopus support, 2018-03-09).
> >> 
> >> Signed-off-by: Kyle Meyer <kyle@kyleam.com>
> >
> > ACK.
> 
> Thanks.
> 
> > Too bad this did not make it into v2.20.0, but at least it can make it
> > into a future version.
> 
> The right way to fix it is to prepare a topic that can be merged
> down to the 2.19.x track, and proceed normally to percolate it down
> via 'next', 'master' and 'maint' as any other fixes.  That is
> already happening.
> 
> The original documentation bug is older than where the 2.20 track
> forked; the bug is in 2.19.  Any such old bugs, users have survived
> without it being fixed for a cycle already, and the fix is not that
> urgent to interrupt the release engineering that is already underway
> and redo it.
> 
> A regression that appears only in -rc and a known bug in a new
> feature that appears only in -rc are different matters.  It is
> prudent to always first access how serious they are and we must be
> prepared to even delay the final as necessary.  But I do not think
> this one is.

You are right, of course, this was not as critical a bug fix as others you
integrated last minute.

Thanks,
Dscho
