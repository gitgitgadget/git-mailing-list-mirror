Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E88E71F453
	for <e@80x24.org>; Tue, 23 Oct 2018 09:30:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728359AbeJWRxD (ORCPT <rfc822;e@80x24.org>);
        Tue, 23 Oct 2018 13:53:03 -0400
Received: from mout.gmx.net ([212.227.15.15]:39885 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727714AbeJWRxD (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 23 Oct 2018 13:53:03 -0400
Received: from [192.168.0.129] ([37.201.193.149]) by mail.gmx.com (mrgmx003
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0M6jIK-1fRCo30U9k-00wYKL; Tue, 23
 Oct 2018 11:30:27 +0200
Received: from [192.168.0.129] ([37.201.193.149]) by mail.gmx.com (mrgmx003
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0M6jIK-1fRCo30U9k-00wYKL; Tue, 23
 Oct 2018 11:30:27 +0200
Date:   Tue, 23 Oct 2018 11:30:29 +0200 (DST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0_Bjarmason?= 
        <avarab@gmail.com>
cc:     =?UTF-8?Q?Nguy=E1=BB=85n_Th=C3=A1i_Ng=E1=BB=8Dc_Duy?= 
        <pclouds@gmail.com>, git@vger.kernel.org,
        =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>,
        Vasco Almeida <vascomalmeida@sapo.pt>,
        Jiang Xin <worldhello.net@gmail.com>
Subject: Re: [PATCH] Poison gettext with the Ook language
In-Reply-To: <878t2pd6yu.fsf@evledraar.gmail.com>
Message-ID: <nycvar.QRO.7.76.6.1810231126470.4546@tvgsbejvaqbjf.bet>
References: <20181022153633.31757-1-pclouds@gmail.com> <878t2pd6yu.fsf@evledraar.gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-1985708206-1540287030=:4546"
X-Provags-ID: V03:K1:6qM4PHMVsh3vU/k//JTOT6VuYi6En59HZJMDA5PphsI4GLgfJc8
 Zdusg31FtsLKzDwU98IVovgJ8viv2kl+C3ht0LRNA3DRwXg8wSECtpWVPzqF+0cgXYH0mlX
 ynhpO3NKVJq6LTfcMGNTythynoA3KhE7jPBXAIdf4PWdW/WVkIjp1C2doD+RWi8cuBN8l5Y
 0ZBemAJy5AUwIPCPs8ltw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:1JKKTZCKvAw=:NHCUJalHCsAfaA9QctC8XW
 382bDfbSbnsqM8JN/NJ/APbqtGfAjJkjxuMsWUo29Za6e/90yjeqtukhZxbS9VXuTeMeuFR4g
 BivkAab3FhexXzz4URJFB/Fab4Sx+KfEspvbR5sTGyXbcPqbOzxCzaylOpo+Dt0gZwrP2Mtcz
 L4uek2JLSoa/Wcv7W84aykXfN/FRnWrLDPI6J3k14d5ZQrwLw+k0j9a3VJ1UBfLkglg9O+G/a
 6bVg4IqTEK8FCspP0qazczk/yk4yOAc20rTAEut4lRtmYP82/fa1eqXrbSC414v/ojKYmVamp
 ODYvg8Y4Yzn+q3W3vKiHoHDwJunxspfn1LL9OisdvrX6V00U17i5rNmL1HSD/u8nsyBjTZuU+
 9kpkGaEeF/HPOcAMQ5vEhQZVmVZWB5lLGsfvmGJ7awmRBGaYZ+jTT6nhUUqylhHcN+luaIoQQ
 76ZdG6BZJLyyyjOjafky/fUoUeXt229xEor27q2PSPxhVBwyjTGGG/m7QrkmcseYQj2PIETVX
 k8Rb2DQlzdl/2KjHCMv5QuyVVsMK6iTkpGM8wdGBTZXXZ4tb04bydCaCxPr7o7dVxrRfvh/y0
 mAAti32eHew6WFioyds8sxZB1J/Kg9AolTND7vRUdZyROQ6Fz/8cbjc7+6vNgXvUE2E9IT3tq
 Y5DAdO5zRixvpA/y0qM+IXuuPz8Wii/LvY5wyLa2sg53JT4Vz5wyM0SlJUExm29YYZO4ButJL
 yBCfjLzLmKAvmsqQv1mZgiulcQBK3120WQaltEALif/ERAY6JuRV6qSKR/8qKKPjnQ30Rqsaq
 ujk9K8ikM3Mn0zS4vt7rxgnne1YO01El6MDH0F6a6sonX7tmok=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-1985708206-1540287030=:4546
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT

Hi Ævar,

On Mon, 22 Oct 2018, Ævar Arnfjörð Bjarmason wrote:

> So I think the only reason to keep it [GETTEXT_POISON] compile-time is
> performance, but I don't think that matters. It's not like we're
> printing gigabytes of _() formatted output. Everything where formatting
> matters is plumbing which doesn't use this API. These messages are
> always for human consumption.

Well, let's make sure that your impression is correct before going too
far. I, too, had the impression that gettext cannot possibly be expensive,
especifally in Git for Windows' settings, where we do not even ship
translations. Yet see the commit message of cc5e1bf99247 (gettext: avoid
initialization if the locale dir is not present, 2018-04-21):

	The runtime of a simple `git.exe version` call on Windows is
	currently dominated by the gettext setup, adding a whopping ~150ms
	to the ~210ms total.

I would be in favor of your change to make this a runtime option, of
course, as long as it does not affect performance greatly (in particular
on Windows, where we fight an uphill battle to make Git faster).

Ciao,
Dscho
--8323328-1985708206-1540287030=:4546--
