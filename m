Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 45BDC1F453
	for <e@80x24.org>; Tue, 23 Oct 2018 11:07:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727873AbeJWTaG (ORCPT <rfc822;e@80x24.org>);
        Tue, 23 Oct 2018 15:30:06 -0400
Received: from mout.gmx.net ([212.227.15.18]:41985 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726953AbeJWTaG (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 23 Oct 2018 15:30:06 -0400
Received: from [192.168.0.129] ([37.201.193.149]) by mail.gmx.com (mrgmx001
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0MgbTj-1fzsbt0deB-00O1fV; Tue, 23
 Oct 2018 13:07:06 +0200
Received: from [192.168.0.129] ([37.201.193.149]) by mail.gmx.com (mrgmx001
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0MgbTj-1fzsbt0deB-00O1fV; Tue, 23
 Oct 2018 13:07:06 +0200
Date:   Tue, 23 Oct 2018 13:07:04 +0200 (DST)
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
In-Reply-To: <8736sxc6gt.fsf@evledraar.gmail.com>
Message-ID: <nycvar.QRO.7.76.6.1810231305520.4546@tvgsbejvaqbjf.bet>
References: <20181022153633.31757-1-pclouds@gmail.com> <878t2pd6yu.fsf@evledraar.gmail.com> <nycvar.QRO.7.76.6.1810231126470.4546@tvgsbejvaqbjf.bet> <8736sxc6gt.fsf@evledraar.gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-2051807888-1540292829=:4546"
X-Provags-ID: V03:K1:QhPAFsi0wVNnnPLxmQD3djA5HtfeWJDUBfG2T4hrtiwv9h1mNkZ
 EcNggumYr3gaz06MUigthRajJuVLsj2kCScASPxOsJjeAPyb00RbBCnovGwowUMusRC28m0
 1YEEkh62vx5Cfn9IBybBgHT56YSBQmPmie3bWWqrjrHXxAsL2MqW06rQWT5Gbcj0Mdgdiv8
 HCIHXrbfMB1p/A5IzURjQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:ojNee09UZdI=:XQayBU7LDzvd4s0/5XU9PU
 eH85yOWDSWdV8Oe52cvaUgDSaAtbKOKHM2GU5N0IR0A6M3xnYKs0Zz8z4D8dkW3MyYmvMX7mA
 5tKi0+AZMRh5x8E7basIcgbryvE1oGwMYY9XNtq1ETAVY3B6X8cclfO+1xZrDtJlB58Cb5pvd
 fbO5udgJvDVNPPAGumSi12vtD+opLutdi6XNx/MzP6lbu+ylkE56+ZyT9jtVL3NtOFTvwvs3h
 nrsBevgGiW0jmYmgpyXpC55si1EB0s5EESW1oHiX3mX+hQoTpShSArlMPW4xA98tRrisMUIF1
 tz4f86LGxsOP+6P88KTKAi5zDQvxKFKZWmn5oTLvVcRtj1BCevcfIMbc/mcJ+yQzCqac5KSn3
 lSHh0D53Tkfw0+yxEpSGAftpwDP+yo69P/7881KxwJLCod9/q0iQ1BsO6I6TNYByLYxuVvvxB
 f063VdisWwCm0VNkrCaOivAzLhgSPbDeYKIqsBmGB8RF/sscRF0qeC1m+7gxaVKLl9NiBPB1A
 qxFrEAwS7K76GMTH3Uh9ml+PzMnEIeknZ5KyGT1+va0T/2IP/chubBsZYJrfjTZQCVAN7bMOI
 qQCDKiaOOzOWN9q90AgeWfAto0d+RJZe0xuh38EfLioTa0lXX9/cDXvdnf30udOrYce6eN1qA
 /2ffbX0PFlYLRZEEW9Tgf2zqUWRkXolVrS5HgrP8Ba9UTVy7Agd0Q2CwLu3Lvm/EsVVTYn7MW
 aE/R0gKh3vbfrWUjk94VjBSjHuQU+TZLURu1cargM877bUYj+yj6E9l9QoLOqBVs5pd58gIcR
 m5IPrccYHVE0kif7/1cj6JOO/Iyu416QTU5oDMeFxbsdDA+wZ0=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-2051807888-1540292829=:4546
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT

Hi Ævar,

On Tue, 23 Oct 2018, Ævar Arnfjörð Bjarmason wrote:

> On Tue, Oct 23 2018, Johannes Schindelin wrote:
> 
> > On Mon, 22 Oct 2018, Ævar Arnfjörð Bjarmason wrote:
> >
> >> So I think the only reason to keep it [GETTEXT_POISON] compile-time is
> >> performance, but I don't think that matters. It's not like we're
> >> printing gigabytes of _() formatted output. Everything where formatting
> >> matters is plumbing which doesn't use this API. These messages are
> >> always for human consumption.
> >
> > Well, let's make sure that your impression is correct before going too
> > far. I, too, had the impression that gettext cannot possibly be expensive,
> > especifally in Git for Windows' settings, where we do not even ship
> > translations. Yet see the commit message of cc5e1bf99247 (gettext: avoid
> > initialization if the locale dir is not present, 2018-04-21):
> >
> > 	The runtime of a simple `git.exe version` call on Windows is
> > 	currently dominated by the gettext setup, adding a whopping ~150ms
> > 	to the ~210ms total.
> >
> > I would be in favor of your change to make this a runtime option, of
> > course, as long as it does not affect performance greatly (in particular
> > on Windows, where we fight an uphill battle to make Git faster).
> 
> How expensive gettext() may or may not be isn't relevant to the
> GETTEXT_POISON compile-time option.
> 
> The effect of what I'm suggesting here, and which my WIP patch in
> <875zxtd59e.fsf@evledraar.gmail.com> implements is that we'd do a
> one-time getenv() for each process that prints a _() message that we
> aren't doing now, and for each message call a function that would check
> a boolean "are we in poison mode" static global variable.

Yep, you are right, we are *already* going through _() as a function,
whether gettext() is initialized or not. My bad.

> Perhaps some of that's expensive on Windows, but given the recent
> patches by Microsoft employees to add GIT_TEST_* env options I assumed
> not, but in any case it won't have anything to do with how expensive
> gettext may or may not be, you'll already be paying that cost now (or
> not, with NO_GETTEXT).

Indeed, we want to measure performance better, and that's what those
environment variables are for.

Thanks,
Dscho
--8323328-2051807888-1540292829=:4546--
