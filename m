Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 30D441F453
	for <e@80x24.org>; Mon, 15 Oct 2018 18:33:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726765AbeJPCTr (ORCPT <rfc822;e@80x24.org>);
        Mon, 15 Oct 2018 22:19:47 -0400
Received: from mout.gmx.net ([212.227.15.15]:52439 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726588AbeJPCTr (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 15 Oct 2018 22:19:47 -0400
Received: from [192.168.0.129] ([37.201.193.149]) by mail.gmx.com (mrgmx002
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0M8edX-1fQKS63vrn-00wAM4; Mon, 15
 Oct 2018 20:33:18 +0200
Received: from [192.168.0.129] ([37.201.193.149]) by mail.gmx.com (mrgmx002
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0M8edX-1fQKS63vrn-00wAM4; Mon, 15
 Oct 2018 20:33:18 +0200
Date:   Mon, 15 Oct 2018 20:33:20 +0200 (DST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Christian Couder <christian.couder@gmail.com>
cc:     Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0_Bjarmason?= 
        <avarab@gmail.com>, gitgitgadget@gmail.com,
        git <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 0/9] Offer to run CI/PR builds in Visual Studio Team
 Services
In-Reply-To: <CAP8UFD3cpXpyx-AtTybPirzduFR7TfhFf2woa-_CU46DN3RaXw@mail.gmail.com>
Message-ID: <nycvar.QRO.7.76.6.1810152032140.4546@tvgsbejvaqbjf.bet>
References: <pull.31.git.gitgitgadget@gmail.com> <8736t7dzan.fsf@evledraar.gmail.com> <CACsJy8DeA0Zko4+ZM5F2L6YO5rpvL9LX3H9NB_bVCyO2mJFUzg@mail.gmail.com> <CAP8UFD3cpXpyx-AtTybPirzduFR7TfhFf2woa-_CU46DN3RaXw@mail.gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-1500465867-1539628401=:4546"
X-Provags-ID: V03:K1:4Kbowe0+38uZQt+C1swWOArWxhpCt8tBbqYMUm5LEpME1sfokCa
 TJ1H9VM26Xn2G4ZtCgsfp2aF/wo9zLAsCJ/5pwjquxz6FLkOAXMSoNfOXROycKSTQ8fFxbo
 Ey4i3zNKmyEzvlVBqIvQSgVgiBYqgWNRc/B636CBQnnmrFGEG7gLdRH9o68dOt3B3Vk/ymj
 Dd2JMBWxNZ/tH/khdOlrQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:pFYAs1yH1r0=:7OL+1StgFPFy2r+PVmntEa
 ZHXmgjH4cqx39k4wjUOkgdZ3rzOGnVEdmpr8cJ0xGksHm8JrjF2qI0tXeWFyjN2U0KJolcykw
 FUkBLgxsJccfCbE8xP+/zw2mXAys2xne2Cct/UJrRp8vTB2d6tg1GbfhLNYdGTgDeA75Um6JM
 rW+8RsSRnfn8eGREPLDaouiYyMkc8xUVEr0jOpix76uAkgDEbIFrCBcGSvG6u/08BCcck7FkG
 rfKuaVUbefnm0J74GZkcGYJm6ugvxm/220hGqE1dLpasxCqd4aFH6PC/B3x38BiFxTNguhHDV
 4cAxUfnDF9nxCKDt87YTKICTV6y0bAvSWi4Rx+hIKb4TsCZKT4k2YZUhLWDab6nK1Gzv3VZo3
 y2rodcFq0WBz/GENTZEj3bN5F4a71B+kY7imKvlCCrVzsW/BfppTfIZ9sklWsgQiU/xs1FutQ
 1fM4IbgghC2v8JfOl2kph1YS2pN5yT+ZteAPINQkjX8Zjs5OUIKRFuS0TDs8gm39p4TRslE2s
 NTPk11XzkTYP6WlkK+vJTkxWBSuuO8CIiINE0maYkI1tPYDPE+GkdFFglPfMS2Eve2ZZ7Lj/y
 g0abFpnmeH51krON7sk0kJWOqb/76g2FP+eAdwSdScCqngZI2f6Cld1z92u0WJ5Klv7so2buT
 mh+tvuHLpl/r+sj0joDHXpaJ2K5rVbprYKkI/f9cwDnvzA22wXJeEd3LiI5cMbBaRDiNxuFuU
 XU939VZO+yEB3YETHuCqtSisAJp2wF8yLnsyaj+myi3hGZ9jo6BsQSKjknNMKKw21sR9gLawC
 /f6nlKwOyRbf+p8Md631xoV5Tbj9wcvIRjqM3c3LP5QTD4wMYI=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-1500465867-1539628401=:4546
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT

Hi team,

On Mon, 15 Oct 2018, Christian Couder wrote:

> On Mon, Oct 15, 2018 at 5:46 PM Duy Nguyen <pclouds@gmail.com> wrote:
> >
> > On Mon, Oct 15, 2018 at 5:08 PM Ævar Arnfjörð Bjarmason
> > <avarab@gmail.com> wrote:
> > > As an aside I poked Junio via private mail in late August to see if he'd
> > > be interested in pushing to gitlab.com/git/git.git too as part of his
> > > normal push-outs.
> 
> People at GitLab also have wondered if it would be possible for GitLab
> to host an official Git mirror, and I think it would be nice indeed if
> Junio could push to gitlab.com.

AFAIR Junio does not push to github.com/git/git, it is an automatic
mirror.

GitLab could easily do the same.

Ciao,
Johannes
--8323328-1500465867-1539628401=:4546--
