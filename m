Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DC1791F62E
	for <e@80x24.org>; Tue, 15 Jan 2019 13:45:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729400AbfAONpK (ORCPT <rfc822;e@80x24.org>);
        Tue, 15 Jan 2019 08:45:10 -0500
Received: from mout.gmx.net ([212.227.15.18]:58599 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726886AbfAONpK (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 15 Jan 2019 08:45:10 -0500
Received: from [192.168.0.129] ([37.201.193.149]) by mail.gmx.com (mrgmx002
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0M1Ee8-1hXnit0p44-00tFxg; Tue, 15
 Jan 2019 14:45:07 +0100
Date:   Tue, 15 Jan 2019 14:44:51 +0100 (STD)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>
cc:     Lars Schneider <larsxschneider@gmail.com>, git@vger.kernel.org
Subject: Re: t0021-conversion: flaky filter process test
In-Reply-To: <20190111140408.GC840@szeder.dev>
Message-ID: <nycvar.QRO.7.76.6.1901151442420.41@tvgsbejvaqbjf.bet>
References: <20190111140408.GC840@szeder.dev>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-2135547047-1547559907=:41"
X-Provags-ID: V03:K1:1dLmCt2uvK3qN8ptnrb3CuC4XV7L0xGjU0cMLv5k+DPYUBDdW8/
 t1R+ckbS3M+kngZamaPHGBHjG66eEfSNCvzphnKV7q9dSqceVsJD8bgCWrBHZQwCKTEdJUH
 tzlBTZFJjYeZouTAGzEX3Il/NRa+oMeItX/yKDza9XZJX6KD2DdayLPPelcij8PmalVtsCl
 qEEAydOsjefzoZPBTEzdQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:jvBLjZ9Li0Q=:CrzbPJHS6SdfU6eyA8cR8C
 UPMqohSFurDy57VKcGrnLnDIlkIx/5bYnIQFP5/yiChW53cBT4QquCche/w37thvvB7d9tsfW
 2CZTI/LyKlS6e0uBtc43Y1jsxiW6bf9Qt8yjb2mnusGqbeI2MY6p1MSE9jXR7IzcXBZNc9cRz
 HYBC6Fvdz63w4cBMpxaGkngxaLQWrg8fv7UGOTHXzqxLOevbi5mGjabeJe5yR2dZuzgMCW/B4
 r84y3Vh7QYuldfYdp5Fq00+Gj1eWPXHDK/LooS0RIawDeGlyrpre0750jWNdOIC+zUFcvbKEL
 gBjFGMZVoSCUrTKocTVGIvWyCPYtklvdDm+Zg/ux2IR2XFDj9jgJiyh4YLYrQb8eMdAdQ0re+
 jNTWfg3lzVOWkjBz612MH/zlGWD5EMbWL96grK4nH9kdQ38bMGPTr5xTSNmcRaEqH+UpNWLAb
 Wg/t1Eiml7DFC8UaaTkLPeAgOrf3xJRwmcvRkqTVSmJSy96AQtlp4ITFuC6URTpKgiHvRCfHP
 T20kM/ZXdJpyg2cRfxWbvoNYxF6qvVFSMfZHUSueXP/6rm79y1iClPuOH6GYasCeTYwoJPHkP
 FmJ9TuX9nl4MSiKLsGEHtOBvRNZNAHvpej96xSXBA6kFqRL+pgmvxGvPN1RezAbrJOKFWvWAH
 gTZhuekYg4rQBD2e4E6UQMNeWgITDrnxoADqFHutS7S/UW0F55Lyt1yVxrEB+kI3x9kJyOElY
 HegJj8QVenKzbglqZbJKBbNyLETZRUXxYERSQ5j99U4Eh9QpWCCP5s3JaSUIVX/c3Dt0guxGX
 pciTWo3koPT0/oZQv2gt/6UkhvjVApg1M9ezwug9a7qnTZpQJ0RxnRNOmL5s91ZdtGNI83+7k
 N5KGgrt7nGmevO2qE9FlZpS7L9kH5vaAP7eEBeKKowAMOxQmrq2tWqPrHe4Gsg+vEJXOUAVco
 1IHPNJmAQlQ==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-2135547047-1547559907=:41
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT

Hi,

On Fri, 11 Jan 2019, SZEDER Gábor wrote:

> [...]
> 
> Now, in our tests commands are executed in rapid succession, so it's
> highly probable that those files are racily clean, and, consequently,
> 'git checkout' has to look at the contents of the files, meaning that
> it has to run the clean filter process, and then all is well: that's
> why the test succeeds most of the time.  Occasionally, however, the
> commands are executed slow enough or just at the right moment that the
> files are really clean, and 'git checkout' won't bother starting the
> clean filter process, which then won't write a 'debug.log' file,
> resulting in the above failure.

We had a similar problem in some of the VFS4Git tests, and solved it by
using `test-tool chmtime -60 .git/index`. Maybe the same strategy works
here?

Ciao,
Dscho
--8323328-2135547047-1547559907=:41--
