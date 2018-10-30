Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 880311F453
	for <e@80x24.org>; Tue, 30 Oct 2018 10:16:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727020AbeJ3TJi (ORCPT <rfc822;e@80x24.org>);
        Tue, 30 Oct 2018 15:09:38 -0400
Received: from mout.gmx.net ([212.227.15.15]:58431 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726247AbeJ3TJi (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 30 Oct 2018 15:09:38 -0400
Received: from [192.168.0.129] ([37.201.193.149]) by mail.gmx.com (mrgmx002
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0McEkx-1g1p6K2uEJ-00JXmi; Tue, 30
 Oct 2018 11:16:43 +0100
Received: from [192.168.0.129] ([37.201.193.149]) by mail.gmx.com (mrgmx002
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0McEkx-1g1p6K2uEJ-00JXmi; Tue, 30
 Oct 2018 11:16:43 +0100
Date:   Tue, 30 Oct 2018 11:16:54 +0100 (STD)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Junio C Hamano <gitster@pobox.com>
cc:     Eric Sunshine <sunshine@sunshineco.com>,
        Git List <git@vger.kernel.org>
Subject: Re: js/mingw-http-ssl, was Re: What's cooking in git.git (Oct 2018,
 #05; Fri, 26)
In-Reply-To: <xmqqtvl40zbw.fsf@gitster-ct.c.googlers.com>
Message-ID: <nycvar.QRO.7.76.6.1810301116410.4546@tvgsbejvaqbjf.bet>
References: <xmqqo9bhcf89.fsf@gitster-ct.c.googlers.com> <nycvar.QRO.7.76.6.1810261407030.4546@tvgsbejvaqbjf.bet> <xmqqftwsdevm.fsf@gitster-ct.c.googlers.com> <nycvar.QRO.7.76.6.1810291418300.4546@tvgsbejvaqbjf.bet> <xmqqftwo2nig.fsf@gitster-ct.c.googlers.com>
 <CAPig+cTJR4Qhqf_VVCihNW91tGt8Mbi2Oy99jzg8NmAksKoXVA@mail.gmail.com> <xmqqtvl40zbw.fsf@gitster-ct.c.googlers.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:8gpSvn8VHLaGG7a8PQzQRjGVE1XiiMr9hJz1LjEJT+j88Ybv5fm
 QD9tOLYu/n6dvlNGTV4Ox5K6QN5RmmkwMF0Fq38FxihSzWcgw9E/kHznSW5aNpxwukzET/K
 7is12TIFMWsB5aCvy/NTLDL6EvjPaOdUG0yLEeWVbbP33HM1BvQ6plJ2oKZk6Yf+hCP1WDU
 zdh6TZe57m1memTTOWVCw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:8KRWb8hwPIc=:UzHKlWhgryX1zHGzMqnG2X
 RegX3D9jpPRi7zrPlHgGWu4s/1PzY2gkLAHMwjZeRzZglFI/AQciWt4ie4BEIc27jaKLmLkuO
 RiPSLUMD+rFxRrsImDZsc+s4H6ct2MLIL8ROdSVhQLAyfqYCojH2ltxl3CMDq2yXfR9k2sPm7
 rmXS40X0VksB4xJkhXGtGR1evl16KNWS0jxOUs2oFHkwlT0JK2zyj6jZctsL8jXh02V3Rx9t3
 4xqvkzjvkHQ8zfrxnfbX5DSCEo6mGmEwfWtovrSrgAasU6LXMiz1ym/1dcNvhVi53K/tkjDN9
 DUrNfblsA3X6ExNWF8faL25wSj81oNfcs5cZaxC+gHFAJGDsiTELoAjXynTp4+6L000ph1rhd
 TqJleG95Eik9EU5fwKbk/GLFbaajf7Me2HFVXT2c0CH47Ff4G96K1r9b+BX9hfThIi+/SDMDC
 PpE8n669qw9bD0lhJmSzjazOIPC24l3mowEwNka2ZxYGuXxDIOQjDbrC0jCOlLiFv3WwJqh9P
 O8/KOvUDqQiKi4f48KyT2qvedk1+mI3/NGSWXdiNYZDyaGjPAlt5sZisujjo/iosMQEzbKZnh
 2tP5VQUojFa2v+VXvM1xjtfjt28LKmS+w6lpuzNLRcLKyrhBlh0z0JMIwdAeI0v2ctsWhnKKE
 BvgfDtTLHmkH5XqSJm82zIIH4/pTQ/BMjil3nez7hqYPgLJEq8GgVFyh6KnLpsFzBtU2ZW9rj
 VBbnNtKPOFWSuxsWc04gjLaRTTfpnz+dZeDyIvaDmu/oSc4wY3rTsYdC/SUz81oNCZHkQMhJ/
 DKyUioaOKx3ZmCVC7WT3C1N2yU6qX1MhrtZjhYGKvZtNNNF08o=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

On Tue, 30 Oct 2018, Junio C Hamano wrote:

> Eric Sunshine <sunshine@sunshineco.com> writes:
> 
> > On Mon, Oct 29, 2018 at 10:10 PM Junio C Hamano <gitster@pobox.com> wrote:
> >> How's this?
> >>
> >>     On platforms with recent cURL library, http.sslBackend configuration
> >>     variable can be used to choose different SSL backend at runtime.
> >
> > s/choose/& a/
> >
> >>     The Windows port uses this mechanism to switch between OpenSSL and
> >>     Secure Channel while talking over the HTTPS protocol.
> 
> Thanks.
> 
> By the way, I am beginning to like this phrasing quite a lot.  It
> encourages those with other ports like Linux and Mac to see if they
> want a similar runtime switching by singling out Windows port, which
> was what I wanted to achive with the original one, but I think the
> updated text does so more effectively.

I like it, too!

Thanks,
Dscho
