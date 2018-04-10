Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 426681F42D
	for <e@80x24.org>; Tue, 10 Apr 2018 22:39:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932649AbeDJWjv (ORCPT <rfc822;e@80x24.org>);
        Tue, 10 Apr 2018 18:39:51 -0400
Received: from mout.gmx.net ([212.227.17.22]:53321 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932119AbeDJWjs (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 10 Apr 2018 18:39:48 -0400
Received: from [192.168.0.129] ([37.201.195.115]) by mail.gmx.com (mrgmx101
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0MY3Ho-1f1eDh1arI-00Utvi; Wed, 11
 Apr 2018 00:39:37 +0200
Date:   Wed, 11 Apr 2018 00:39:20 +0200 (DST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@MININT-6BKU6QN.europe.corp.microsoft.com
To:     Stefan Beller <sbeller@google.com>
cc:     gitster@pobox.com, git@vger.kernel.org, jonathantanmy@google.com,
        jrnieder@gmail.com, l.s.r@web.de, pclouds@gmail.com,
        sandals@crustytoothpaste.net, sunshine@sunshineco.com
Subject: Re: [PATCH 0/6] Rename files to use dashes instead of underscores
In-Reply-To: <20180410212621.259409-1-sbeller@google.com>
Message-ID: <nycvar.QRO.7.76.6.1804110038230.56@ZVAVAG-6OXH6DA.rhebcr.pbec.zvpebfbsg.pbz>
References: <xmqqbmer4vfh.fsf@gitster-ct.c.googlers.com> <20180410212621.259409-1-sbeller@google.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:/Y6dJ7OuENCLqDd54IEsBe5FokENj6SxWiewE47POvvsx6zROVY
 zvjv3SX0qqyO/BaCcowuh3+3Zz4SgwQ6laQPzItnRB9l9KcOVWh3v7RqTEs2TaLGPBkeDVm
 hlJqox6llVtXqFkylc31QORUAi2Uj1PzX0kBuWhWbun5UmOEcYuxtIkO6X08uzDW2UwO+Uh
 QQltoOg0WILEdM/onFs+A==
X-UI-Out-Filterresults: notjunk:1;V01:K0:SpONKSYWyfk=:zmJS8+DOpO7YtrmkiDktP8
 lFcbzwQlD7W0mf3EY8EwP7z7jpW3kPQzRRjC3feT9OW0HaTNVjxpgG6vid0545dfrYE14kYHe
 8IAjB5K0K0X75RzPK/wMHoU94E5x5drbSWalYs0H9W3AB4VoBP1KTDYoiL5bPrI8zNjeKJeih
 9n124MtrWy9qxRU1KsmyRUSou4eP4sjVH9Zmx98bapdTCsFQlFIlTHhFV1dB6ptvBx8auM9m9
 9PB33UVcaW+/R5hKXg+UZfM5tO44v4ufmMAjO0akP4fIaWlllFK6G+0MnzZOi/gaQDWoos3S5
 CxYHI0YAqe75VGpcQGBIwf6m/Tcm0aYQ/d11AD19+2s/NpIbbYLLt2/RVVMdD+mOd6UCjneel
 FB1J84Ia5BXWIxDA5mwHefmjWVaPBMsoU1MgCQ92x+LotV/mRsZ9Wz857OCJODLePqrTtXTzh
 U1yfoe2t+q8sx24pB2qnjwsB9izrXOQjBm5S69xCDSb47n9HiRPZdnUfS06c9mS0AcY4Qjhtp
 4epz6q54I9Y9v6OKaNdQ34dHLMUTH++UX2LcX2MyR5VJwFtH+ZgVm/x7OjaY0NGx+eW5Z9veK
 ubC4YOts5XUrfl1CazpzI3hxjgQ4JuC7UWh1AlMhUfjqST55z1qPmQb/TsADJPTS2+uUvuL6o
 kCKsIsSmKWWKZJI/jCihszRJS50hfqGigE/f9Ok9AxkJAdS7utKyNAf6zaC4ls+tDm3eajQj8
 qr5qtPWV661vRyOKpdzWkJl6X/+4JxaP6iA3KGaQ1/xNOfOy/D9U2gpE+xCwxPgxE9ll0nEd7
 ESw0PN7sQ9FJTpzPFhnoAToeoHqVE3RtH+tP4Z1mJ1i+qHhZ1c=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Stefan,

On Tue, 10 Apr 2018, Stefan Beller wrote:

> This is the followup for 
> https://public-inbox.org/git/xmqqbmer4vfh.fsf@gitster-ct.c.googlers.com/
> 
> We have no files left with underscores in their names.

Yaaay!

> Stefan Beller (6):
>   write_or_die.c: rename to use dashes in file name
>   unicode_width.h: rename to use dash in file name
>   exec_cmd: rename to use dash in file name
>   sha1_name.c: rename to use dash in file name
>   sha1_file.c: rename to use dash in file name
>   replace_object.c: rename to use dash in file name

These are all obviously correct (I did not apply the series and used `git
grep` to verify that nothing underscored is left there, but I trust you to
have done that already).

Ciao,
Dscho
