Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.0 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4774E2101D
	for <e@80x24.org>; Tue,  5 Jul 2016 06:11:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754060AbcGEGKv (ORCPT <rfc822;e@80x24.org>);
	Tue, 5 Jul 2016 02:10:51 -0400
Received: from mout.gmx.net ([212.227.15.15]:61728 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754595AbcGEGKt (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 5 Jul 2016 02:10:49 -0400
Received: from virtualbox ([37.24.141.253]) by mail.gmx.com (mrgmx003) with
 ESMTPSA (Nemesis) id 0MN1C4-1bDivu1J3Q-006c3r; Tue, 05 Jul 2016 08:10:46
 +0200
Date:	Tue, 5 Jul 2016 08:10:45 +0200 (CEST)
From:	Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:	Christoph Michelbach <michelbach94@gmail.com>
cc:	git@vger.kernel.org
Subject: Re: Missing Package in git Installation Instructions (git-scm.com)
In-Reply-To: <1467670411.13990.4.camel@gmail.com>
Message-ID: <alpine.DEB.2.20.1607050807320.8378@virtualbox>
References: <1467670411.13990.4.camel@gmail.com>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: multipart/mixed; BOUNDARY="8323329-540508235-1467699046=:8378"
X-Provags-ID: V03:K0:z1Q4JWdlev6Zs+urjjjMLojlW+xrDWwSDMOrcGst0ZYGjVez2+S
 UUTzvpJKL1eVg+cAwXVcmQg1rAvM7e6JeK1+RkFOYpaFeFfiYkKCpwx3wQxITb2izmCZCp6
 IMQmV2Oj2LwZoW844Kvgr9FBtZZZLq+gH3rv8LvxF796o8GtSrFcfBBZ+fxDcYf1ryn8CC8
 Cpn1b8ENwcLtqTLZWxKWA==
X-UI-Out-Filterresults:	notjunk:1;V01:K0:QTdaRoougyA=:Fd0A74FyN84sSvMf0+B72R
 Cdus6wLHKsUgmXkfSoUWMRX8OD8qCofjHKx8pbICfJmB355xDSeV6+FbrOTueH7acnOpIGIiK
 0d5nERPrzUKpOvNPdV8cvNgvprlOxNMy+yV4MHIsEg7i7sSl8TCCbYF+6gi20XMalTXBej+R3
 0O0d2uH9cFumd0ez2ywG5LVe/fFISZgdDyhqT715sOoYtFulWyf7qUKKmpLKuPOITHAw+vV96
 vMo/1KAES93plzbmB3DbM12O4koEQ0FLmS8zaDXbeqf7TVBy/iLG3CjgE4AGLH0tCSdEtjdIq
 gwCnr4wCgff5IViXsxvGrYciys9eFeW8dsDmsFiuJJljiBkmDXM8q4yZeLLWEF2+FzZN1D60w
 DLuff0GdKfhnuL+XyMmLEeeHDdzoLtaMKVqk27Q/8JHToL6Xq7aL2qOV7R3aj2+UEdBz4yBPd
 ROhhkFInV42DcvCpDW93INAa0xwpVR8JXcxR5E1XiFdrpwYTUUpgJ+g9FcxP6UfoYXtDJ3ywX
 05GzVQ7bUVJ14qiQvmECGctjaeNES7S8uhjWRDBoS/Y98HW3RCtE4LqruR5n2b2qfsEvgcenf
 +VVFeU61Ot3plDbYNpjpAadMQJqng/LOgF49ANhkEQtujyGXzyFMdmElGwQy6Zmt+Pwn4L/F/
 icf+COd1N4uBiPln5OUel8n7bOxuxwh923/tqSBFveHsSQcxZTLZdw9ehgZBomYTAx6Afi2F/
 VcCMS7lMfi2383xHQVZro0RVQBvQbAaVnOfnDp6oLAGRQweuVbvbzl8oeGWmMWLLDZNQ3Zond
 P7Zws5O
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-540508235-1467699046=:8378
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE

Hi Chris,

On Tue, 5 Jul 2016, Christoph Michelbach wrote:

> Hi, I noticed that the instructions on=C2=A0https://git-scm.com/book/en/v=
2/G
> etting-Started-Installing-Git=C2=A0don't work without=C2=A0dh-autoreconf
> installed on an apt-get system which isn't listed on that site. Can you
> fix that or tell me whom to tell about this? The website doesn't offer
> contact information. Just tried this on a fresh Ubuntu 16.04
> installation.

When you follow that link, do you see this text on the left side?

=09The source of this book is hosted on GitHub.
=09Patches, suggestions and comments are welcome.

It links to https://github.com/progit/progit2 and I am sure your bug
report would make an excellent contribution to the bug tracker ("Issues")
in that repository.

It would probably be even better if you cloned said repository, found the
respective file via `git grep apt-get`, fixed it, and opened a Pull
Request.

Ciao,
Johannes
--8323329-540508235-1467699046=:8378--
