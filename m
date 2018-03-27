Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 57FA11F404
	for <e@80x24.org>; Tue, 27 Mar 2018 14:00:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753015AbeC0OAL (ORCPT <rfc822;e@80x24.org>);
        Tue, 27 Mar 2018 10:00:11 -0400
Received: from mout.gmx.net ([212.227.17.22]:47665 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752976AbeC0OAJ (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 27 Mar 2018 10:00:09 -0400
Received: from [192.168.0.129] ([37.201.195.115]) by mail.gmx.com (mrgmx103
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0M2cDB-1ekfKx0qSj-00sR6D; Tue, 27
 Mar 2018 16:00:02 +0200
Date:   Tue, 27 Mar 2018 16:00:00 +0200 (DST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@MININT-6BKU6QN.europe.corp.microsoft.com
To:     =?UTF-8?Q?Nguy=E1=BB=85n_Th=C3=A1i_Ng=E1=BB=8Dc_Duy?= 
        <pclouds@gmail.com>
cc:     git@vger.kernel.org, Eric Sunshine <sunshine@sunshineco.com>,
        Jeff Hostetler <git@jeffhostetler.com>,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 00/36] Combine t/helper binaries into a single one
In-Reply-To: <20180324074505.19100-1-pclouds@gmail.com>
Message-ID: <nycvar.QRO.7.76.6.1803271558380.77@ZVAVAG-6OXH6DA.rhebcr.pbec.zvpebfbsg.pbz>
References: <20180317075421.22032-1-pclouds@gmail.com> <20180324074505.19100-1-pclouds@gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-68381692-1522159202=:77"
X-Provags-ID: V03:K0:K7mL5vRHjrH86QpF2ZqjmnvayWKyY1l2RTMi9NanRdoIyul/eNr
 sBcZqjONPG/D6rImjJkL/NGYn58kn3rd/L7v/hjZe71szG+WeYU04KrEK22PQTrmcj4i+50
 30TyAnPkL+PlLcJwmhTDNLwE58QsxwylSMZ6NKOE9ldkJoM7uBS7EFODIlMiiaIgU/OsuPi
 zR2DaYlxBLuzBZOlgCXXA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:DmV/UswVJJU=:zkHx+hiYSHrsdFLNrsqB5L
 tuFxT75cmaHG1FSU8tLMqbguJbiEHviD1O1zd7PHQTeBwvO2nJTdpsX+YJgIlCpgXLF4/IcAg
 RVwmKnq4cIdoXe/4Wv1y79E9BvsWlZs3gD1hVuumj1VN0tlSeQl33wboVTmTj7FqaSuL6SAVd
 7sRHCRvp5/ruteeMTJqqXPn2WPE/CmV59zh+s0mXOr1gJVfYSOHLm5ShmolmqBeT+FPV0WUb4
 Nm0tcdGSlqYczHBmd29U6fR++vTP5Mc9YckSYZ5QK6UFSRwTaA5V6Ul1YzHVmrsYJwKwKGvWN
 c1AF49XLo0VZ9fQxNnrXS2T0O+pa3MeQ8w5I2vUK/l8Cx7qBbMM7XlmPXot4wF8XfJcAHQmnP
 qNojTjIws0Rz8SIkIn922BIqZ+7vIMaBTlE0S4oKFnD623ThtaAsrxbOnvPlTXnHO0+jlcdQE
 OpkbqA76A9edNlSS+nyOPcy9FL1qOe2NFJ4LU+MgzibWrhPAqZyuCZXDESf/gbT0K0AmHO/U+
 6qDqnPXoI7gBA6AyBvX3tGmzsFvdDEXGXoAoJSSrx8zGT8O5eBbB3J5fDaQwn3LPgPq4A6cTp
 HrjD9jgsQogQavsQxXlUytzuncLjCFpzGRo5U4LyPueQpyuu7VD6cUKrz9SxtcSbsKdeBmYBI
 aus6bqvTSQfZJLkWFUebOLMEofIFKxlxztBJVrRYU96bWZir3VZQlcqXF0P4FBiVjR77uoMfp
 84l2A+uGMK95Pez6r+DJlrWodigxEZEdkPHsYCM2LTvFu6JhLPC+N0NBEk/Z0b+UD36RGYyRd
 LbSPlF2FBxXd1OOaHqD2tFDXJTMvEj+hL1dpnew6cFJdwWjab+1axIsjH4q75QVUi/wNJ9u
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-68381692-1522159202=:77
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE

Hi Duy,

On Sat, 24 Mar 2018, Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy wrote:

> v2 fixes a couple of typos in commit messages and use the cmd__ prefix
> for test commands instead of test_, which avoids a naming conflict
> with the existing function test_lazy_init_name_hash
>=20
> [the previous v2 send out was aborted because I messed it up with some
> other patches]

This iteration, with the SQUASH??? I proposed (and that Junio will
hopefully pick up soon), works well on Windows.

Thank you,
Dscho
--8323329-68381692-1522159202=:77--
