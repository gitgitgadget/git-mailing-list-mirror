Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C2C5F1F404
	for <e@80x24.org>; Wed,  4 Apr 2018 21:02:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752068AbeDDVCO (ORCPT <rfc822;e@80x24.org>);
        Wed, 4 Apr 2018 17:02:14 -0400
Received: from mout.gmx.net ([212.227.17.20]:60089 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751749AbeDDVCN (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 4 Apr 2018 17:02:13 -0400
Received: from MININT-AIVCFQ2.fareast.corp.microsoft.com ([37.201.195.115]) by
 mail.gmx.com (mrgmx103 [212.227.17.168]) with ESMTPSA (Nemesis) id
 0MhQju-1erEbQ425q-00MeW0; Wed, 04 Apr 2018 23:02:11 +0200
Date:   Wed, 4 Apr 2018 23:02:10 +0200 (DST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@MININT-6BKU6QN.europe.corp.microsoft.com
To:     Mike Rappazzo <rappazzo@gmail.com>
cc:     Git List <git@vger.kernel.org>
Subject: Re: commit -> public-inbox link helper
In-Reply-To: <CANoM8SX_+UwSjFUgW77mW25d6Z1CxJJwbDduNqAkygGeKwru6A@mail.gmail.com>
Message-ID: <nycvar.QRO.7.76.6.1804042259250.55@ZVAVAG-6OXH6DA.rhebcr.pbec.zvpebfbsg.pbz>
References: <nycvar.QRO.7.76.6.1804041821420.55@ZVAVAG-6OXH6DA.rhebcr.pbec.zvpebfbsg.pbz> <CANoM8SX_+UwSjFUgW77mW25d6Z1CxJJwbDduNqAkygGeKwru6A@mail.gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:h9GVWfbTIjr2z6+jLxCxD5lR9ftogvsao4dAUzHG89wQ89a7QyR
 oT5jXcpROTUGWRP/dD99gGkoNJhGypGrS0fEGV9B3O+iwyTHpPZJsHFjoYfuao8avCQkWX7
 qiIzN4BeX1yVGmPeGq5NxzA0Qcc+j9o3wTrhOkXfjb9fURfqVSeaM2kZcN4cYsUmtvURmjT
 8o6/8w0fG0JJG1rnMPbZw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:HqsdviKL/YY=:j9Q7jQRXdwvoXqmSQOiuwF
 FP28iM+n8FiFUDStxQ3o+Qz+1bSU/0KBD39Jwd8aGI2U6NyzVOharS6laVGowjQH4s5KUQ1oH
 QlJRp/IFk5tHHClIw61Ra7eOnzYM5H01vwmAbn9jdnT7rOuQ3gzxbWWtyqIchpUbI46kW+7wv
 i7taiDbDRnEM3f9HHlw7mKGV1r31i/NnJGnW1LwJDV4jnqXQ4FRy3hYFGkg1oAQrRJRoHvI3P
 s1W0P8rfLaT56TP+2pHJDLwYYqtyopUXzFjNlsxRQMVOpmcDmq058T9o3QeAtt55liCJShKJH
 V0fZ2KsoMzi+/cAR3H2XVKaas7BmXv7vPOhMPEpH2ONqiNk2UFvhZ/Kc3AZRmbr5rrnnZYIXE
 qO5jGBFqX77xORnDXJ5JrdFfxJT+O0+VBvIA18s0F1BiUyn1xyaHlkdUxx4StkgMyShOqRyAz
 KVd37L0VDMyoqswcJTmFgf0xw5yl+MJ6f7O2BGT1KyKAC3nzw+p+T0tfB3CrVwwuH+AqKSkM2
 KRqEddB4KT/uoLFZcRBtWJE0/rBu72FChZKUfOnrl5H/sAhxWm4N4X6ogGqWiWQ2gRAIIQ/U/
 vlymPeY/cBItI93+ItZ7/iP7/lXkRZHLibXakroXy4EIjVXAeFoPy7e14uoKfGW2dtv6IZ73+
 wclK5OcwU+lxjtYdRf2w6gkEhFZYSJSqJ5lB2qil29WPiFn3AIEg4WV1kAqN8FXuh4HlhlNf0
 8ijWk2sYb8qmchH7yfV+/ObbyQEos3Dg/BE2GBMiviriKAcUJa99qgUuTNixxAbzQmeqZkA0i
 grwYDmz2+4ypjLnC/8YFNs7v+gkM2B07pMEeFK3VuEz4Vnqca9w8rVFWLPnaBQR7A5b908L
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Mike,

as I said here:

On Wed, 4 Apr 2018, Mike Rappazzo wrote:

> On Wed, Apr 4, 2018 at 12:35 PM, Johannes Schindelin
> <Johannes.Schindelin@gmx.de> wrote:
> >
> > [...]
> >
> > With --open, it opens the mail in a browser (macOS support is missing,
> > mainly because I cannot test: just add an `open` alternative to
> > `xdg-open`).
> >
> > [...]
> > open)
> >         url=https://public-inbox.org/git/$messageid
> >         case "$(uname -s)" in
> >         Linux) xdg-open "$url";;
> >         MINGW*|MSYS*) start "$url";;
> 
>          Darwin*) open "$url";;

I am aware of this alternative, but as I do not currently develop on macOS
apart from headless build agents, I did not add support for that.

Feel free to adopt the script, publish it in a GitHub repository, adapt it
to use refs/notes/amlog instead of a public-inbox mirror, and then tell me
where I can clone it ;-)

Ciao,
Johannes
