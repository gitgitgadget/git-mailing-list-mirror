Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7C02F1F404
	for <e@80x24.org>; Fri,  9 Feb 2018 17:06:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752086AbeBIRGt (ORCPT <rfc822;e@80x24.org>);
        Fri, 9 Feb 2018 12:06:49 -0500
Received: from mout.gmx.net ([212.227.15.15]:34987 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751126AbeBIRGs (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 9 Feb 2018 12:06:48 -0500
Received: from MININT-TB4PCE7.southpacific.corp.microsoft.com
 ([37.201.195.115]) by mail.gmx.com (mrgmx003 [212.227.17.190]) with ESMTPSA
 (Nemesis) id 0M2tXS-1f12IP3FNG-00sffr; Fri, 09 Feb 2018 18:06:43 +0100
Date:   Fri, 9 Feb 2018 18:06:42 +0100 (STD)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@MININT-6BKU6QN.europe.corp.microsoft.com
To:     =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0_Bjarmason?= 
        <avarab@gmail.com>
cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Subject: Re: What's cooking in git.git (Jan 2018, #04; Wed, 31)
In-Reply-To: <87mv0tm0l7.fsf@evledraar.booking.com>
Message-ID: <nycvar.QRO.7.76.6.1802091805590.35@ZVAVAG-6OXH6DA.rhebcr.pbec.zvpebfbsg.pbz>
References: <xmqqd11pr0he.fsf@gitster-ct.c.googlers.com> <87mv0tm0l7.fsf@evledraar.booking.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-1835828300-1518196003=:35"
X-Provags-ID: V03:K0:s7TR8QKNXqOQOxmU4zom3PY3creUe2x0FRPpjc6/zhYhma8dx+H
 WjeQvaFRhanh1winrFRSBJa9DsvDe1Wk6kcL5LRyTwlhLNlM/+nQ+L8OJFBN0E7+OLg36Gn
 xfuBqnVig3rKzHeQB9Q0fbP+7w3Z1vErMTMWgENs219iWsov8iQQriFnUoMIJmLMHebDPEv
 dXM5vpNqDOa/rKJhHIsSg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:U1IRaw1Jhow=:+zNAuE48gxo969izKGJ0fw
 A703orxJRnvSsh3bp+G+CONoSuorZsMyfAEgzg+aqX8EYYjN7xFJ8alw1bYvvZlO5Z/J9QIs7
 b0N40FzIW14l7eVaOmbl5snEFCnHK/vih9J8xrGwU8oA8ctOu6BdJaxYVyERMtRggswgN3OM2
 I+0rhO1Qti4iUAazmJXNmqcG83ATKBHsDYb7QIoQGjhvFtdMM4jEte8EOVC3sHzcu8GnRtx7z
 okb1UgN+IW3r+QQA1xYxWu/A+H4V+rD5l+QpSeGsrOLs3lk/Bc55WSvWhfjCqTh95Dj3Bscra
 pg/wY8jV2BEdMqDyYQ8aMY5yVo6cGG469GpS0UN5IXcjK8qQouUcfQeR5AgLJJ2PyJJZG2btb
 m1AlzfAVmvUMrKAOrm4XgZVFBGSKh185gfQEKILPpzZUcnZQmKD2G8oX50aYlMm+NC+zcf41Y
 VIttONUyRqDzj0Zpx1iLWiW4vE9YmJlM3pL4nx+Patdszwnjv3AXcRvPMmYPhTIK+WXwEu5jS
 esIlsFJzPn+e1r7s5gg2THJJOZelOh60h2jutjH1nTAgHMlHQQCCKNcY7NNePb5J3lMbfwmdH
 K0yn/+iFevC5ihM8WzHNv1qWhl1Uqi4lZy2cDYK0VSdHzGSAXvcia0UO3Ogc92ugz2tn7Vcyi
 sonWi+o405WhFoyWgwXDt/u9X830cCoJVdsllMYe6OUaHF9QzoaGTbcwEp+YR0eoYICkgXzmu
 Qfb6gAo5HoqTwMsmzPgm8OkiGuirxaWWNDfJ8zLe14f9rq6AjSzzHkhYUweHcXcjCfJ/Q1a0V
 kVJQ5voODkqRJn+I8HgzXHGF6kQbOaN4Y/URIfNehf1O5Yf2Pc=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-1835828300-1518196003=:35
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE

Hi,

On Thu, 1 Feb 2018, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:

> On Thu, Feb 01 2018, Junio C. Hamano jotted:
>=20
> > * ab/wildmatch-tests (2018-01-30) 10 commits
> >  - wildmatch test: mark test as EXPENSIVE_ON_WINDOWS
> >  - test-lib: add an EXPENSIVE_ON_WINDOWS prerequisite
> >  - wildmatch test: create & test files on disk in addition to in-memory
> >  - wildmatch test: perform all tests under all wildmatch() modes
> >  - wildmatch test: use test_must_fail, not ! for test-wildmatch
> >  - wildmatch test: remove dead fnmatch() test code
> >  - wildmatch test: use a paranoia pattern from nul_match()
> >  - wildmatch test: don't try to vertically align our output
> >  - wildmatch test: use more standard shell style
> >  - wildmatch test: indent with tabs, not spaces
> >
> >  More tests for wildmatch functions.
> >
> >  Expecting an update.
> >  cf. <87vaga9mgf.fsf@evledraar.gmail.com>
>=20
> The 2018-01-30 series is the update mentioned in
> 87vaga9mgf.fsf@evledraar.gmail.com. You probably noticed this / just
> didn't adjust the note since you queued in in pu already, but just in
> case: the known issues in it have been resolved, but hopefully Johannes
> Schindelin can test it on Windows & report.

Sorry, I did not have time to look at this. All I can say is that the `pu`
builds are green for a couple of days already. Which I celebrate!

Ciao,
Dscho
--8323329-1835828300-1518196003=:35--
