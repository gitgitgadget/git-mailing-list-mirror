Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B78C820C11
	for <e@80x24.org>; Mon, 27 Nov 2017 21:27:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752109AbdK0V1U (ORCPT <rfc822;e@80x24.org>);
        Mon, 27 Nov 2017 16:27:20 -0500
Received: from mout.gmx.net ([212.227.15.19]:56136 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751443AbdK0V1T (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 27 Nov 2017 16:27:19 -0500
Received: from virtualbox ([37.201.193.73]) by mail.gmx.com (mrgmx003
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0MJBRC-1eHn2W1e5y-002oD9; Mon, 27
 Nov 2017 22:27:14 +0100
Date:   Mon, 27 Nov 2017 22:27:13 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     Liam Beguin <liambeguin@gmail.com>
cc:     git@vger.kernel.org, gitster@pobox.com, avarab@gmail.com
Subject: Re: [PATCH 1/5] Documentation: move rebase.* configs to new file
In-Reply-To: <20171127045514.25647-2-liambeguin@gmail.com>
Message-ID: <alpine.DEB.2.21.1.1711272226500.6482@virtualbox>
References: <20171127045514.25647-1-liambeguin@gmail.com> <20171127045514.25647-2-liambeguin@gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:vgy5rv6/fDdtzQLKmu3NeKNTsAJM6SZ1hCkwmCkjXsd7bdYPg1m
 XwhGYoCvttjh4hxU6kML1Ni/u3TrBcrC765gQ6QnNz3i5inmGUJeLgjPH/6ZSG/osptLV/Z
 4YM75ejhNRJbvtqxpNR83N6TJdMFd4qUygEWnm8M3Ls43Eo7SHEZeO83Gy90oF9rJhjyrOP
 g2iFJN2/23tpA9HRBXt8g==
X-UI-Out-Filterresults: notjunk:1;V01:K0:wBK1fTavzkY=:Iou20raPdmVI5NHJpKToaP
 TyM4yAqdiRM2K5sK10CDLheCU27cuBI+YI3+PrXz9FyDs8iwhKa7YddR13yZ2IKKayJD41E0D
 hokXxOThNJwqRvwWPs/R0lRfFcWKNxrnFLSrT3WE+bAf+Riq/GGRSnwk2Vt96IcHuaB93mFa2
 NpReBnhWxGntmAIN2SJ8BU6LYdefcAvd58zx4QRSsWvqcicg2fVYgWbBGIsln0+njvduQ+BZ3
 xGPUjzBY3Dw8r+vViVC9dL1LfhZSN4Nan7joMpyV1kJquE2OhL7KpZQQNtM0hL8F/0Ec0UCXT
 elRRKTHD2upIVVvO7jtIdjxRk+h8M0SECtl334DijkIUmLWUmWIhdizxxA8pJziCEluknxE/c
 aNlDrktNYm4ZkKlh+Z4egtwvA/oAFJqPnTyLEj11NtPGS5Begf6WJ+/KmhENx5/DKHSNirBMI
 8i4EgSsYZLaORiXJyAGrN4+LJ6qgPlcye8cLFMWwbK0MjF1qvLWuSxuRpyCNxuZUm7yYfUpG1
 Bak7FxEiaOho62tJ+GZlt/CTswh63sBv5b+KCQ/9GbZI5zWG3uLowZSkyGxh5OK82GRs7lRK3
 lh5IbIJuc5fKuze2JzMQheowrblWiQXCZVRsmDUA66cA4IxJod/iSD6C5rfdTrQatnoT1akUZ
 vQ9D3fse4gMcePvOEafuLM+dS6p3V3YTuOEO3sdYGodcZpVHrzXAZYm5AAbjgCxKof3auoNb7
 dPAoPZRNNfxHw3GvFt6z22bdMCx3sAEaNUnfBPIo6q9ESeOKMrpWRSM5l+q53KNlB8a7nILa1
 bWMHNbnXvivaMw4+QTBkTzozU2JN5eyg5pKV0aEb/g/uIHylf0=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Liam,

On Sun, 26 Nov 2017, Liam Beguin wrote:

>  3 files changed, 34 insertions(+), 48 deletions(-)

Very nice!
Johannes
