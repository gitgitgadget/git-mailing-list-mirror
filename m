Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AFDC81F609
	for <e@80x24.org>; Wed, 28 Nov 2018 09:30:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727815AbeK1Uba (ORCPT <rfc822;e@80x24.org>);
        Wed, 28 Nov 2018 15:31:30 -0500
Received: from mout.gmx.net ([212.227.15.19]:41847 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727585AbeK1Ub3 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 28 Nov 2018 15:31:29 -0500
Received: from [192.168.0.129] ([37.201.193.149]) by mail.gmx.com (mrgmx001
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0MQRWm-1fy9JE0vQy-00TnqR; Wed, 28
 Nov 2018 10:30:24 +0100
Date:   Wed, 28 Nov 2018 10:30:24 +0100 (STD)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Junio C Hamano <gitster@pobox.com>
cc:     =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0_Bjarmason?= 
        <avarab@gmail.com>, git@vger.kernel.org
Subject: Re: [ANNOUNCE] Git v2.20.0-rc1
In-Reply-To: <xmqq5zwhu9on.fsf@gitster-ct.c.googlers.com>
Message-ID: <nycvar.QRO.7.76.6.1811281026380.41@tvgsbejvaqbjf.bet>
References: <xmqqmuq25ufc.fsf@gitster-ct.c.googlers.com> <87y39w1wc2.fsf@evledraar.gmail.com> <877eh219ih.fsf@evledraar.gmail.com> <nycvar.QRO.7.76.6.1811262347360.41@tvgsbejvaqbjf.bet> <nycvar.QRO.7.76.6.1811270008580.41@tvgsbejvaqbjf.bet>
 <xmqq5zwhu9on.fsf@gitster-ct.c.googlers.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-2031371171-1543397425=:41"
X-Provags-ID: V03:K1:+P0Ra90duncmNRjaGNrYk/JtYkm+lqSoaKwVsT+5LsBeumJ0x8X
 zugxzsZMU5LVPQheJrazspsu4549v67JqNkkR49ylY05E0dsYzAbGgl6QvBejn+0wK1o9AA
 TRge4+/eHos696RBxZx1Q+5O89phj7vsYpiGw/aRcumkcIgVZzd9cTruaNiwKzhRqRZX/4Z
 qbX7/AOTodNca65BFfcHg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:imEVz1S8v1k=:O5mFTAaZ25TRy5h+0nILXJ
 wnOVsGPDE8baa4CmPZ906frttmQvVsZ39pH+ej+riKeoALLANvllLbOB13AKAJHDOn3Z+97SW
 dg6vFk9wib72s5TkMq500n0DNJ439r/s0G17UAVlpEdrCdsYjhfo/r0+yaqh/vRkyr8oIqS8Y
 TYvA5lfUwG/fDk9ylFvPBz/Ag+Woa5togiNFw80eSZksaX9XhfXQ7KdBb9pTQq+qQaZbOlXao
 Zekxmg7Ur9RJw8HipFmdH8bRYsN8KHBv2QFYmZE6nipUBZ4b+w5yOO1y7VD7CPcJVDr9KJUO9
 HF4A/GjUl0zQYYCfT2917zjXwpn6hDsshF3wWjQ8t+dBdz/0Mg6lTtB0taO1qbTqq2AhPGBHC
 wFFDazShFceUYK54o0+/l3SHsm6PjWkbp+mQMzTtkBO3ayu6pwjWO4IWmOW5uKqU18C/Vvs+u
 JE2+IJcsnUjmITn3kVJd99P/Os9ZCoXIAdCawCxN1xDCF1vTQXey1GlyTfUl4a7iiOSrh5cZY
 JUfgIylf8uV5WkSSiKPbwSWo92fHjfyqoa3CC7/hHTGSQEGZYQOXC2LgiAfYsCfQqcyWcongw
 ZmQ7D0rqJaiKCxmLAiKT9cwgrEZeksAvJ4/2UrYwSLGf5bQMAV5kLCN90+VvbP5oR1RAPtHax
 WQDXriYxlWeep6+kpuA+6OinRybDja1m6dQMFCR7+BSWNNDBNjSe1M1KjLYzFSIyWTk7FRuNc
 mjB1KIapbw6iU+/xR7gcbwwEDfyCdvRykbWoO7+sThRbCrlZsF17NugBzAHrhXfscMCw70pmO
 1PX0Z5feFflCQnzGUGvJO7UTyh9AJ2MpHPN27GlsJll0/IYBhaEUE1Nmh5SY0iiuQdTqRlWqi
 RdDC2KECdbA5AxP9sSnmUe/MnBDwUphM1WTyZPzGq6RfUfEnf9Y4HImTgSGQF+
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-2031371171-1543397425=:41
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT

Hi Junio,

On Wed, 28 Nov 2018, Junio C Hamano wrote:

> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
> 
> > ...
> > In short, even a thorough study of the code (keeping in mind the few
> > tidbits of information provided by you) leaves me really wondering which
> > code you run, because it sure does not look like current `master` to me.
> >
> > And if it is not `master`, then I have to ask why you keep suggesting to
> > turn off the built-in rebase by default in `master`.
> >
> > Ciao,
> > Johannes
> >
> > P.S.: Maybe you have a hook you forgot to mention?
> 
> Any response?  Or can I retract jc/postpone-rebase-in-c that was
> prepared as a reaction to this?

I worked with Ævar via IRC and we figured out the root cause and I
submitted https://public-inbox.org/git/pull.88.git.gitgitgadget@gmail.com/
to fix it.

Given that this is a really obscure edge case (`git rebase --stat -v -i`
onto an unrelated commit history, if you take away one of these, the bug
does not trigger), and that it was only discovered to be a bug *because*
of the built-in rebase (the scripted version had the same bug, but simply
forgot to do proper error checking), I would not think that the reported
bug is a strong argument in favor of turning off the built-in rebase by
defauly.

In other words, after understanding the bug I am even more confident than
before that the built-in rebase is actually in a pretty good shape.

I do not expect any major regressions, and if any happen: we do have that
escape hatch for corner cases while I fix those bugs.

Ciao,
Dscho
--8323328-2031371171-1543397425=:41--
