Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1A6FE1F453
	for <e@80x24.org>; Tue,  2 Oct 2018 20:22:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727011AbeJCDHE (ORCPT <rfc822;e@80x24.org>);
        Tue, 2 Oct 2018 23:07:04 -0400
Received: from mout.gmx.net ([212.227.17.22]:38957 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726642AbeJCDHE (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 2 Oct 2018 23:07:04 -0400
Received: from [192.168.0.171] ([37.201.193.149]) by mail.gmx.com (mrgmx102
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0MgpmG-1gKYBX3UjA-00M4kz; Tue, 02
 Oct 2018 22:21:55 +0200
Received: from [192.168.0.171] ([37.201.193.149]) by mail.gmx.com (mrgmx102
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0MgpmG-1gKYBX3UjA-00M4kz; Tue, 02
 Oct 2018 22:21:55 +0200
Date:   Tue, 2 Oct 2018 22:21:57 +0200 (DST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: dscho@gitforwindows.org
To:     Taylor Blau <me@ttaylorr.com>
cc:     Zachary Bryant <Zachary@admiralfeb.net>, git@vger.kernel.org
Subject: Re: v2.19.0 Git install doesn't allow VS Code as an editor
In-Reply-To: <20180914183523.GG55140@syl>
Message-ID: <nycvar.QRO.7.76.6.1810022221120.2034@tvgsbejvaqbjf.bet>
References: <CANrLuF4aTda+WDEZSc1MmTM0u9M04ZsWruXD-GDW6wXVVX2EJA@mail.gmail.com> <20180914183523.GG55140@syl>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:qhylu7FIdYO1VA36nDGOkydJdPZCSJNz4oHbU7Pxk+/ZCtaLw3u
 Hne/vfD3cvX7Q/4lLND1Ge0Ji6bpPzOq9NxC0R4vBhyY2GK7tYgRBziyMxHl+WhcnylRLhc
 6XQSN/5jPzAepoI9yVB8gcWmxnfEO1s7KmiNCR/+ZCZBT1EfSDal/iboXiNsXpxrvpunYCC
 2FM/EFSTF249j+lKfLpyQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:2RHyMo+cki0=:7XWcHxTTkd3IYXFEWLnuN/
 Ey37xGPybeRUIsymPshLr+r6J88nOu5pmPJ64uR+SF3yaRzhIeFYyUeNKKHOXa2jPYLwPl91F
 1lyXD1ItnvOAqUsCjf+YbHWvqOCnpS+YIv7CRy/wFOo9itlLDF9TQARJOTNB1s9yd+P6JGcpm
 rF1xpmfYa00evrFpQELLXo8zsEW4NBtDXwaOV7EOPpHKv2YzgEMi6Cyea2xXStdxUvhRpwfnb
 IUuJnzE+4NkIocBF+wcRIgWQiJQiPVsKeTDzHuTJPc+3CWBYKwrIoE8jBkdtzlgPD5PAEJNAa
 l876+sgIFPCJDZvJbWB24AXOMxTq2/381LMT3ZS7pxAwsPXRJjiyFm1C8lKO1vTl3wGdAPr6v
 Q26K3g4zBbNlL4PeVgc4mgs2aFbUQRBhMPJnLXMoR3QNYZEiWCJTtE9TCWHrtvKrL0ulULDI/
 QWi9/i4hVD6PhrVBNagvT6McaoPWS3ABq1IVKB6b36h594uEpQ/VkFxL8h++uQz/S4A5BXJJC
 L7cDl0ARxhzhziS89+xoUqC0r2hGiz4wShnNclm3OxWHnokaXrZk9pUi5xz8l8FJ1Kp/aYLFx
 Gvm5f63MhwxpXzfNGL76BjDkgvnNaRdwuUUZxaRcDee/N5SxG7I+tR0j9pYc42FTUVgxnzkrV
 vu2hNsE5k85MsdZHx3nm4+j4buQvjYzaJrAuFNsCF25C+yN5YupBM0seIHxlbiI70/TVvUSTB
 jGNCOeA4kVqM74JA6nw/5zqczdMcxxdSDzZmFOonSN1uDhBiivG23NzFJmnDWsG9c/mROxB1E
 Q8bNhNVMHwfQjIyMwJ0v5WC+Z2gRAJekHqL3oVJlt0u3Waiyy8=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

On Fri, 14 Sep 2018, Taylor Blau wrote:

> Hi Zachary,
> 
> On Fri, Sep 14, 2018 at 09:43:43AM -0500, Zachary Bryant wrote:
> > When the installer asks for a default editor, it defaults to vim and
> > when I select either VS Code option, it won't allow me to proceed.
> 
> It sounds like this is an issue pertaining to Git for Windows, which
> uses an issue tracker that is separate from the mailing list here. Their
> tracker is at [1], but I'm cc-ing the maintainer here to let him know.

see https://github.com/git-for-windows/build-extra/pull/200

Ciao,
Johannes
