Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7BF071F453
	for <e@80x24.org>; Fri,  9 Nov 2018 16:32:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728115AbeKJCOM (ORCPT <rfc822;e@80x24.org>);
        Fri, 9 Nov 2018 21:14:12 -0500
Received: from mout.gmx.net ([212.227.17.21]:34581 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727955AbeKJCOM (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 9 Nov 2018 21:14:12 -0500
Received: from [192.168.0.129] ([37.201.193.149]) by mail.gmx.com (mrgmx103
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0MHH3P-1gGyht0xHf-00E6sJ; Fri, 09
 Nov 2018 17:32:34 +0100
Date:   Fri, 9 Nov 2018 17:32:32 +0100 (STD)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0_Bjarmason?= 
        <avarab@gmail.com>
cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Lucas De Marchi <lucas.demarchi@intel.com>,
        Stefan Beller <sbeller@google.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Stephen & Linda Smith <ischis2@cox.net>,
        =?UTF-8?Q?Martin_=C3=85gren?= <martin.agren@gmail.com>
Subject: Re: [PATCH v4 0/3] range-diff fixes
In-Reply-To: <20181109101803.3038-1-avarab@gmail.com>
Message-ID: <nycvar.QRO.7.76.6.1811091731550.39@tvgsbejvaqbjf.bet>
References: <20181107122202.1813-3-avarab@gmail.com> <20181109101803.3038-1-avarab@gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-1528228574-1541781154=:39"
X-Provags-ID: V03:K1:bTXhE0IDHz28EBIDQD1eguJwOwU7K51Xm1CnzXIqvHUHnvOwBj0
 bsWCvGw5V7rsmhnBrBz6Nrk9d1PimfEjUFos+dHPLop4Lafj71lYPV59FwjomUfUDCH4HOc
 hdQzwbeP0M0ieb/dKZLeht4p6Ft2z5eeEdXQNoAF1VTR1gihNeYi1bgEvQnBCgdDHiGKyZV
 rxc+t73mdZvomsKp3lAJw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:JFgqodJF3sc=:b9X4zXWs38cWoiO3Kg7kOm
 F9HNCNDuaTxOXan1Z+v3+C+BC5PPwx+fHVAb1f/nVmlWkKVWyudPgaVjd2tSl73Xs4ZNBacW6
 O1fMAGmCzQ69fjxK3Kf2Leor3MVliabc1U9K2lrCt9ZfOLEGYj3czXcqIoPwPbxEpbzAYA5vX
 34XcKUR0vjF6QaC3fDz33O3jgicgJZt2/TTEQieJg7aa6XD11xJpyxkgNOD+OD5UG6OTHin2e
 TXjpk/CIiT3PYz4huCPgXMk3AhxpX1ZU7rcjLbRVnSBR4hhHZFWeR0rCEQDE3eICeKGAGjUOd
 66P+Q1g5DuOWPS+NPRm80MM/NvPHTpxVxLOLjaxFT1eAxiJlbKNzuHKqAzzQfKq5KeCuwO55K
 XgvSnLvbIofD1tEz8Rfsrp1xWdjOp0KHwrF6zDN/Qc5gV3HqCtHwMcqbbtZPCrv4r8lgriEZO
 n2zYYPBZPB5bNdKjtYCV0OAZnUjMYeTo7EvZ6CQr2IeM3r9I0FpPKiSqrFL+SR4N2YzGnGqih
 tVK101GYeFA0CBF6hQEPZZmPmYGkn1D89/3fNZHLsBivUcX3BqxlHz/nhFWKkyB4elYtTASez
 fldhV7mTwwCprED7Fp7LJQX96/A23xhTuaBXpthF5lv6hEMa6v2Pe25XkusbMlvblNUOKUrCT
 T8Do7sGRsL0JRnkYIQj0ofQhSlaiQDK/GF04m//Y0OYdRqzw0eGmp1jV1VQxZOSMVJprOmCSx
 EsYKTJyfzuDNNvVx1eRMs+yRsWXlfiJtRTQpTHKHehjG5mdMqd844V8ZXsMtaB3uAv8UX/M5o
 UeS8bg0Quh0o+IFqESOmDvJHQn+U0aaccAed0fVGoW+t5xeH2zsiR1nZuPzs0OfhjFrkDwWRq
 /yX/ONgD7niyNRLhl5LJ/l5UguR1NRogUHXCmSwDaKpCyOSvQK9UH0ELNwGmM1Ncuu3LIFYVt
 hQfj7vWa5YA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-1528228574-1541781154=:39
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT

Hi Ævar,

On Fri, 9 Nov 2018, Ævar Arnfjörð Bjarmason wrote:

> Addresses feedback on v3, especially Eric's suggestion to split out
> the behavior change (which I was not aware of) into a 3/3.

For the record, I am fine with this iteration, too.

Ciao,
Dscho
--8323328-1528228574-1541781154=:39--
