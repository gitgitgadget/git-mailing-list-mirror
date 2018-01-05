Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5B0C41F428
	for <e@80x24.org>; Fri,  5 Jan 2018 21:10:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751788AbeAEVKp (ORCPT <rfc822;e@80x24.org>);
        Fri, 5 Jan 2018 16:10:45 -0500
Received: from mout.gmx.net ([212.227.15.15]:60356 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751484AbeAEVKp (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 5 Jan 2018 16:10:45 -0500
Received: from ggw-xinxiao-xx.fareast.corp.microsoft.com ([37.201.193.20]) by
 mail.gmx.com (mrgmx003 [212.227.17.190]) with ESMTPSA (Nemesis) id
 0Lbujs-1fEITf0Qwm-00jJdK; Fri, 05 Jan 2018 22:10:43 +0100
Date:   Fri, 5 Jan 2018 22:10:42 +0100 (STD)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@johannes-schindelin.gitforwindows.org
To:     Matthew Orres <matthew.orres@gmail.com>
cc:     git@vger.kernel.org
Subject: Re: Git 2.15.0 on OSX 10.12.6: gui multi-select stage
In-Reply-To: <CAKbB5OxZ1Mua0zNMpe8nt8cQbasUyfz0uNzOXL9FJXWrsqPN-g@mail.gmail.com>
Message-ID: <nycvar.QRO.7.76.6.1801052209330.1337@wbunaarf-fpuvaqryva.tvgsbejvaqbjf.bet>
References: <CAKbB5OwxQ4XtLXuu2w3QmuKryA=3iHupz=y0m2E1NH+Dwzd8Xw@mail.gmail.com> <alpine.DEB.2.21.1.1711012254380.6482@virtualbox> <CAKbB5OxZ1Mua0zNMpe8nt8cQbasUyfz0uNzOXL9FJXWrsqPN-g@mail.gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:NwvQL33bxWTiTqTZJksBop/wfj76azVTX3whAq8K8y6B1fY9nt2
 GpSRiRHz8sGhHsIggivAcIBaylXQKyXkjkw4VAvC/62MZkTaJYQOphmPHzlW8r6RJjGlja4
 kE+egkZoAq3IgTTSqrSwOnNsi92XUoOKIrnvrii68xSG+wC6b2m13UdrWyKVNJ92CFLTXkZ
 s67pj4C+/VRrrHO2Lv1kQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:r3TX6mmQ7O8=:bUSVxNHfV+80mwLQ0+vc4X
 XMoUpSYC8TtaBHMgdM1eWogfmkh6JRVY7Db5PAARLji9A2xhkwS6cWK8oIH4UBavmGJup3Lk5
 x6Qa/l0grnwxMNcSPmh6Awe0gdUc4gX/LIV7aa2kmx7MzA+UHsXfjYxhxVZITJvfCpPSXA+h3
 qHVLj03tosuzYC31SM4P8bTnLP1prdbftIPJ1DoSB8iUDye1VdToDZQHbbcxHHoOSyuqXb8rD
 Y8nlXOO/vDm4pN5WYAhFQC4wyF6hXNKRfeMkjR1VUHcve9ayeQB4BJrpqkqsf6vJGDteDgLrS
 40k2ztcPw6dShHZoLFzITUiiRJqyzWvOqHT5RK3JBuN39VhTN353Vpm81sEbdCE+du+Df+ttO
 7JoUXe6VajW47VkgR0F461Yko+kenvlyqSGw3JboG+Z9NXBlm8YB6afsOaI0dzq5X7rQFkloo
 4rbk/3c6LfvZBp6JTx6I0c0h3MbvhK0qo/W/gOrsK2U4Iq9TZyd64NipbPW1a4208LN20MchJ
 oPN/cN4Z0gUPIim6Mr3tIopR+dBEkn4yAfmcZIILrCV5NeMZJyfvHXEw5LaiWimoFHnq4o0Yc
 xwM0jwGzsO7bfmaQJ3SCOMZHihhXIYCgaUK9++qwLT3SPt0kve4IjkUkxErnTDMwJTcSEprQ1
 V9eeTvLcI0N7z5cvHhJNpoSGyeIQIVIvhgFp6o88LMKM4TlM/qQiVRkmnbXeKQJHlCp24YOo8
 LZoXQLpK15v/Apbnk1tbeDeMtwAyAJVN1ZG41NH3FWStc5jEc2ghpRN165cpdhyQ0ZUpFVUro
 Cjzt7Kv5PXhSwWklcfsuQ3tL3DTFMUm69h4KrLtsw/bWqQEqCQ7dDLD0LULEPsdV8+LJqn7
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Matthew,

On Fri, 5 Jan 2018, Matthew Orres wrote:

> I'd be glad to give it a try - but am unfamiliar with how portable a
> manual build of Git can be used along side the version I have
> installed via Homebrew - do I just use full paths to reference the
> compiled executable from within my repository folder?

No. If you want to avoid installing Git, and instead want to run it
in-place after building it, you have to use --exec-path, like so:

$HOME/my-git-checkout/git --exec-path=$HOME/my-git-checkout gui

Ciao,
Johannes
