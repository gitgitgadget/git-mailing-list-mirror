Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8CBF41F453
	for <e@80x24.org>; Tue, 16 Oct 2018 08:48:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727040AbeJPQiE (ORCPT <rfc822;e@80x24.org>);
        Tue, 16 Oct 2018 12:38:04 -0400
Received: from mout.gmx.net ([212.227.17.20]:49709 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726165AbeJPQiE (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 16 Oct 2018 12:38:04 -0400
Received: from [192.168.0.129] ([37.201.193.149]) by mail.gmx.com (mrgmx101
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0MbKXI-1fthfw2DH2-00Ikcu; Tue, 16
 Oct 2018 10:48:08 +0200
Received: from [192.168.0.129] ([37.201.193.149]) by mail.gmx.com (mrgmx101
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0MbKXI-1fthfw2DH2-00Ikcu; Tue, 16
 Oct 2018 10:48:08 +0200
Date:   Tue, 16 Oct 2018 10:48:10 +0200 (DST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Eric Sunshine <sunshine@sunshineco.com>
cc:     gitgitgadget@gmail.com, Git List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 12/13] README: add a build badge (status of the Azure
 Pipelines build)
In-Reply-To: <CAPig+cSf9byf_T696_dzgQLE2X0-61PNXFxX65Ff_RZBGEuD+w@mail.gmail.com>
Message-ID: <nycvar.QRO.7.76.6.1810161047510.4546@tvgsbejvaqbjf.bet>
References: <pull.31.git.gitgitgadget@gmail.com> <pull.31.v2.git.gitgitgadget@gmail.com> <d112b3fe86e2d5168161cd3edf9616ff7bec3319.1539598316.git.gitgitgadget@gmail.com> <CAPig+cSf9byf_T696_dzgQLE2X0-61PNXFxX65Ff_RZBGEuD+w@mail.gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:Y+LZDetfR3tKabfQ9NMzMwhwVlid2Dah8MRfn8wy78zfXumcIip
 1TWVTgCv8nvHh5xzxigw20lTnGK44EJsyIK7IjwCCf8GxusXnC0NeX+xWgGXbDC85WCuZpV
 9hgt71j9aLSM5gaOBhM5pKFZ62owNN3WZUuNOwdRYffsJTQsgruLA0+aHS/+53EZVxFPdww
 Nxwt1vyjqZUyp3e24HCNw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:+WtpagRqdWc=:ibzsdF3rv6fh6m1cNMYBnK
 DP8rnNAWuKkFsPNoPZceyC2wKdjV2hU69OKXM09O0r5m5WQaUkor5+NcznGIqsMJMhF7Y15LX
 cu4Lo8a+GVklU5yS/y9iXpc4AzMZEREesspyONPtayjYRcn+kt25fB8NHtnb/w5FHYSYZoyiZ
 ohleh++l9gaBULVwyVf0cALFyR+EwHez4CN++TFb5iXK3yuPnVKz4fD0WUAYKKfguh340Q7iN
 EaXq+mnB4ViYD/HSW6VAFwOsS5pWNRWR5rhX+Zb8FYsEeYgV42ofO3QnS0PPwDl8eXpkFOGys
 /Pec8d41KRlcTQsiUC7g6WIpf4IE3MdCQ8Fqjykc+k+FwLPFHCUQFoeuOJ5rViX/U2PkElggx
 FPwH2f2lXXzEhJgQDg859OA+CIth7uAZQngyYMMHtqcU/sSHUZu7C+EeAg6t7yiKeMMyzi5AP
 SE0ZHi8eeNN0u72/YMRNPv06t24OIqTZfueNPzAm7YK8HmcG/CPIs02Plyis16lwShBZsqPnc
 BbZKyoVBK6VyyZZupWWV0qjDyEk/VSp2B902OmIoXsCrXKcUIFtTtdjt6+pQzfXvHxtz7GI0o
 3PKhcM8Bu7u9qeG1OHs+n2Qg0AzQO3z3SB9wcn21fswy2h8Gfbhl+mpDAVSuS8oGikfQboT2l
 qi05jv69LYzL7/YxvhPneti74xhfLq0GwYDpJ8pLyL/Ha0COJUwms7hRFu22W2AYsdS8SPMLw
 FFjpNkCDpSz17OdmUPfsbephxeDgPrbJA2qDKF7ww83Ha+MxDgRrOiJR19b8DmG+YesK/ox46
 GZc6oaewjcWQkS6sLV2mYzVrXzAPZSAbpI2xHjr3JSCFZJdsNQ=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Eric,


On Mon, 15 Oct 2018, Eric Sunshine wrote:

> On Mon, Oct 15, 2018 at 6:12 AM Johannes Schindelin via GitGitGadget
> <gitgitgadget@gmail.com> wrote:
> > Just like so many other OSS projects, we now also have a build badge.
> >
> > Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> > ---
> > diff --git a/README.md b/README.md
> > @@ -1,3 +1,5 @@
> > +[![Build Status](https:/dev.azure.com/git/git/_apis/build/status/test-git.git)](https://dev.azure.com/git/git/_build/latest?definitionId=2)
> 
> The first URL is broken "https:/..." rather than "https://...".

I *swear* I fixed this already. Darn.

Thank you,
Dscho
