Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.0 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,PI_DNOT,RCVD_IN_DNSWL_HI shortcircuit=no
	autolearn=no autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7AA391F453
	for <e@80x24.org>; Tue, 19 Feb 2019 14:47:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726546AbfBSOro (ORCPT <rfc822;e@80x24.org>);
        Tue, 19 Feb 2019 09:47:44 -0500
Received: from mout.gmx.net ([212.227.15.18]:35697 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726246AbfBSOrn (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 19 Feb 2019 09:47:43 -0500
Received: from [192.168.0.129] ([37.201.195.16]) by mail.gmx.com (mrgmx003
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0LbMF8-1hL25k0V0k-00kv1n; Tue, 19
 Feb 2019 15:47:26 +0100
Date:   Tue, 19 Feb 2019 15:47:08 +0100 (STD)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     =?UTF-8?Q?Michal_Such=C3=A1nek?= <msuchanek@suse.de>
cc:     Senol Yazici <sypsilon@googlemail.com>,
        Junio C Hamano <gitster@pobox.com>,
        "Randall S. Becker" <rsbecker@nexbridge.com>, git@vger.kernel.org,
        jpyeron@pdinc.us
Subject: Re: [RFE] Demilitarize Documentation (was RE: Delivery Status
 Notification (Failure))
In-Reply-To: <20190219103906.3fc4c231@naga.suse.cz>
Message-ID: <nycvar.QRO.7.76.6.1902191540220.41@tvgsbejvaqbjf.bet>
References: <001601d4c7aa$460c0e70$d2242b50$@nexbridge.com> <xmqqimxh2b61.fsf@gitster-ct.c.googlers.com> <CAFacdQ_9=2hbC8-5+N=RdrGs=Anu2ku+TAj7x07OQNpa1b+gcg@mail.gmail.com> <20190219103906.3fc4c231@naga.suse.cz>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-1633460252-1550587646=:41"
X-Provags-ID: V03:K1:nuxr5Fo41i63boTzxFKD1SqPuvOboZsEEHIFkYbpGHsbiRpaPn/
 0OxzGC+e4bKaLCslsfNPNigurOMGLsrlPO/E8f5XzYLdtG+K2y/2Utev/Cp332HnxjFgz1r
 fCWoNJxh6ByYAZqVQU8hvE4UHDncm/5jlMfUHkcCwO9IN2dlHtDBvgzIkcGgfwyX+ue3j+X
 3l61crm6blBtDZbYwwUPA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:U7F4wYA3OZs=:VXBkmloE7DpRG+YuOhundb
 gDJiIbRIMZq1rzXO7i5m8VFm/SC4hSdw1WgEnbtGNlN3E2O1waWgtT0gO/P9zIYsFFaNuqOjj
 A4Dk80jZxgvKsnuq2DVfcv6mhY/hBusK/spdFeyLbl2HfgJkDVLsA7l6iV49KTS/kmDtnIQrU
 Zo2A1JHyQ4+Iy7bdUhUUqVHDR7WBZljvhl6Rtzhd3/9NzJu2qZ9LIHhV92HQaFATkhqHEexVG
 /kwqSsqFlaHSAOgUmlzjZWSv6sgzf/MR8qgmFESrt5xep7QBdjPXxABu+/TEVWolgVgIJf+l4
 NXTjbRdQculHeYsHMhSZ6aXNzcZcfPJexpN5AhxhyFLGZNLHaE8nP65mhvZvM3wYH7rzYyzRK
 iDEu+vtsVLPXQrOfYsy4v/AWOSvaQiEmIgmj7cAB6PbgX8L+/7qsQgIcQReLFh118uJsEMu1Z
 NeHb7hHvv+3FgDgCQquOPJAUkzkHnRLgXO9i4Z0D6SWAn3GwPBlhFcO7rhM3bnckEjHtt59O/
 fLJ/hvbSFsYv6Q+OdmApRjqCPZEx7ldqTkxRo+Xgvo8BNAganltC8RCMesEu4V+jH7bVi0/lE
 Rs8kDdTc7rzvcbA/m6iArmizHH9NHD76z/0hcMDXqhUwWQ78IYIw9xI2xBjI9I4BN7rt7anQN
 FP02/hLFkzpxmZvTAdROAT8edi/SQOE8BKMrIVF2sYNGLQEZ19Tp8AeNNPKg2hsrz3Fvt/GOi
 essUbaVcK02AcRcqegpuXvFnSJXEZUkbs9rMfN0WhqrO/XY6nhBEyZI7kWARVCN5Wqo9Td5sy
 Q91Rg7fIeR3sIAagVpk3HANluj7mKZdHrxICT7zs9ic3riGYF1oRWh907JTar58xYb/LIIz99
 1vxcaD4q/KeA/dX1K3MsVVWv4cW6EchFi+Ip7eRsy9HX6oeZP57eGS/esg4J9V3YRe/L9XGmw
 7/COJUblBpg==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-1633460252-1550587646=:41
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT

Hi Michal,

On Tue, 19 Feb 2019, Michal Suchánek wrote:

> On Tue, 19 Feb 2019 09:02:43 +0100
> Senol Yazici <sypsilon@googlemail.com> wrote:
> 
> > Suggestion for substitution: Assistant or assistant integrator.
> 
> So now the terms sound a lot like a corporate lingo. Is it now turn for
> enthusiasts and entrepreneurs to feel excluded because git is meant
> only for corporations, and for people who had bad experience as
> corporate employees to feel offended?

The concern that was raised is a valid one. Words can do real harm, and we
should try not to keep perpetrating that same harm. We still have language
in our very README that puts off some people, for no good reason
whatsoever.

I find your comments quite offensive, as they seem to all try to downplay
the importance of words, when all you could say is that *you* have the
insane luck of being in a time and place where *you personally* are not
affected. But to belittle others who do not share that privilege is quite
out of line.

So let's give voice to those who have kind words, and rest our combative
language.

In other words, I welcome Senol's contribution, and hope that it will
cumulate in a Pull Request that fixes the website.

Ciao,
Johannes
--8323328-1633460252-1550587646=:41--
