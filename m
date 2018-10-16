Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3F6511F453
	for <e@80x24.org>; Tue, 16 Oct 2018 20:53:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726947AbeJQEpp (ORCPT <rfc822;e@80x24.org>);
        Wed, 17 Oct 2018 00:45:45 -0400
Received: from mout.gmx.net ([212.227.15.19]:38621 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726048AbeJQEpp (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 17 Oct 2018 00:45:45 -0400
Received: from [192.168.0.129] ([37.201.193.149]) by mail.gmx.com (mrgmx002
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0Ledpu-1frFIN00qc-00qUwv; Tue, 16
 Oct 2018 22:53:29 +0200
Received: from [192.168.0.129] ([37.201.193.149]) by mail.gmx.com (mrgmx002
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0Ledpu-1frFIN00qc-00qUwv; Tue, 16
 Oct 2018 22:53:29 +0200
Date:   Tue, 16 Oct 2018 22:53:31 +0200 (DST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>
cc:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 10/13] tests: include detailed trace logs with
 --write-junit-xml upon failure
In-Reply-To: <20181016160348.GM19800@szeder.dev>
Message-ID: <nycvar.QRO.7.76.6.1810162251380.4546@tvgsbejvaqbjf.bet>
References: <pull.31.git.gitgitgadget@gmail.com> <pull.31.v2.git.gitgitgadget@gmail.com> <ae3c42519abff7ef32c767f9587ef7f0160033ed.1539598316.git.gitgitgadget@gmail.com> <20181016100438.GK19800@szeder.dev> <nycvar.QRO.7.76.6.1810161455200.4546@tvgsbejvaqbjf.bet>
 <20181016160348.GM19800@szeder.dev>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-1941206298-1539723212=:4546"
X-Provags-ID: V03:K1:hntIf7SAELyGhmZz+X1y5UtCojPZXde2U+myzI3UIVCIEz5Dchl
 zZAcTRfvoeddyfiKVEXe5AMm2mZJWnBBHVDZ49F0E1IyWNvK6kWMa49DVet5Ekgg4ueoxIj
 Kbmn+7+nRjJO0oYJl2gTvVD5KNRNQJSoQ5OFmehyu5mEDBvxNA1c8PnqfHewN5xer5rfItQ
 3y5tjE3dh+Mb+J86smO+g==
X-UI-Out-Filterresults: notjunk:1;V01:K0:W1h1yc1UBIk=:OaMfaIpPQJPGXT9D5kSd46
 Ds54F9p4+Pr0Ca+Stw1GBbP2jt8aLOwMYXAgiGPD7ObXvcsmJq8L0nx2j2TdARyLP2z2eX4bX
 nvHWFhg9WxIqprzELbdL8kZKK8qHfQexN6R8mywJsv2ZVc0dTHBJi1BJqYFwx/wNllsxFV8TV
 zvgZqnKniVKID0ri1UuXOzbLhNra0/ZN1k3aov1CVmhv7NRfz1K9iRhNqEz3zkmQDCyW4nmt3
 wDS7Uq2brQ2ALczCLSAitsJwG57P3EHAcS/5ealV9d6WqhKcBKVPP40M2Jh9BSIxY2RBM2Yly
 VqHJFMvqwhoQ+FjjZjipydvL6NALJY+qd8P7+WDccfMbvB05pN3MiTDhgySnvJJCySI9OC9ya
 OWYR0k1E3nFDfu/jG4AI9xzjISsCA8XRO6iJeK9931t+zWFdd5n+1B0bo7US6KW/GiQCvCoKf
 t4NmSMsrjAr7CMk2Hx+Zjab7RLmJtjXS10EMZaKBvdq4+7whzaKebb8+79PaA/llj86S60dDI
 sLKN02FYnApQtvIACUUoClI1F7mczuLZghz3fstgPumkyGOOpty9bZyLI8FZIkiLPHnfb0q2j
 DqtMrAH6HL0EDWc5ClV1OgMNDn4KD2GgNSPiM9EVvSdSR2hWhNSlJ9TFdl+i0qWPbWa+gQSD3
 xWWVAHerf9nAEKA7dfT8+mgVAkaMfNsEjiCt/hTvHNIkK8aulOMVYBPGDDP1nuRPDIkQLqEyZ
 kNoGAijSYynHboEpTDsWux+gzJpvqFmNXHrryzhThComKAqCoXfveG9zlDBqxfyyc72Fa96xB
 Hs05Udm5h4O2xzUX0y1XhOtq99Ww4Ivy0JnU2FUSj4OO5PIEo4=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-1941206298-1539723212=:4546
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT

Hi Gábor,

On Tue, 16 Oct 2018, SZEDER Gábor wrote:

> On Tue, Oct 16, 2018 at 03:02:38PM +0200, Johannes Schindelin wrote:
>
> > So I would suggest to go forward with my proposed strategy for the
> > moment, right up until the time when we have had the resources to fix
> > t5570, for starters.
> 
> I don't really understand what the occasional failures in t5570 have
> to do with the amount of information a CI system should gather about
> failures in general.

I see it plenty of times that too many CI failures essentially render
every developer numb.

If every 3rd CI run causes a failure, and seemingly every of these
failures indicates a mistake in the regression test, rather than a
regression, developers stop paying attention.

Which is the exact opposite of what I want to achieve here.

Ciao,
Dscho
--8323328-1941206298-1539723212=:4546--
