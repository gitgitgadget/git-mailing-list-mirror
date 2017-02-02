Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C5AA51FAAD
	for <e@80x24.org>; Thu,  2 Feb 2017 12:03:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751308AbdBBMC7 (ORCPT <rfc822;e@80x24.org>);
        Thu, 2 Feb 2017 07:02:59 -0500
Received: from mout.gmx.net ([212.227.15.19]:63346 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750970AbdBBMC7 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 2 Feb 2017 07:02:59 -0500
Received: from virtualbox ([217.64.244.213]) by mail.gmx.com (mrgmx001
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0MGj8j-1cdOpG2fyL-00DZPq; Thu, 02
 Feb 2017 13:02:47 +0100
Date:   Thu, 2 Feb 2017 12:31:09 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     Duy Nguyen <pclouds@gmail.com>
cc:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 00/11] nd/worktree-move update
In-Reply-To: <CACsJy8CBG_a_nX_syXKrdG2-ren=NO9CNxe6tm94FGnEo1HZLQ@mail.gmail.com>
Message-ID: <alpine.DEB.2.20.1702021223320.3496@virtualbox>
References: <20170202085007.21418-1-pclouds@gmail.com> <alpine.DEB.2.20.1702021015160.3496@virtualbox> <CACsJy8B3bdokeYVt6aEyZVSzO50PiQRn+0sid9mSDTZ9q-mnww@mail.gmail.com> <alpine.DEB.2.20.1702021043110.3496@virtualbox> <CACsJy8A-tuea7W+tj6rNddtM0j_374FODjQqKsT8eHfeZ0qDZg@mail.gmail.com>
 <alpine.DEB.2.20.1702021136210.3496@virtualbox> <CACsJy8CBG_a_nX_syXKrdG2-ren=NO9CNxe6tm94FGnEo1HZLQ@mail.gmail.com>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: multipart/mixed; BOUNDARY="8323329-1655952641-1486035083=:3496"
X-Provags-ID: V03:K0:Kv3Yq6T3pntW95LJRPS6++aE2DbKrbCYU8H4hsE8O/WYH62qu6J
 xV2V8mxhaHPuDeWE04MXExDyPStghC9l6V7dyz3Kz1KFVlVgDz2CVB/Hb5PJtDJITrXyr8V
 19/v6EWitBbKtkCR3bNT12y67jzM/wp6KsiJOAbXQocdvExzn+FnusnOe+JQv7Ky47V+xT6
 +virdgIujWiQvVr7J5cBw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:P//IRo/nEjQ=:wvN7CkXsjnoguPFz5dPdC7
 9ajPgCDZrgt0YroBedvo4CTO9LXcOlzgG17V/o8w/MIE6XThcl/0H48Qh6wIdYyLo63ORd2M1
 YgIcyKgCQWwf+0ZsF8hnRFR5ovjHZYJ4WMwCU2D1hitpGRLmkGFm66VMMCuuEgBNwpR8h83M2
 6boSLMxxvMTH0dOrCZUz3wxQ3RC01WQD6nbnS2ZMacgLv0epzN+0zdKKzOXZgiiukO38Z1FX0
 PNfLWXUBxlc406RY/3VYF0qhmRKqf9Htz+z0QsvGPqDE7I3JoleRxBh0+w18UmvIjlXjbdcMx
 HTQMeNCuPlRUjq19CmRvc6fr2HS9EXRMlbLE+WdayOkwrSv/ICadCy5vF/Fk7PfEd7jtzja7p
 /Oy8aRhqwbsL7hqApo0PJiZnTSWYNxScC9of3U2SdzNeZyiB2VMmA+yvD7RygIARPBRr/8qy5
 /5mIAurJGrfiokVakiTXP4ukQsZ2VAiUySR1rbdwXnrhruj2VR8t+0MoEM3YiT9O+62zl9voF
 SD1Yol7Os8o670KmEuYzJa9hGQ6P/Vd19Ij97KKJPK0zTzksABppxzAANBSV5g40+vrsQaM+e
 SrRNzg703h88bhZOByghsGyFZmRiVNNSLOydx9I5+lBPY8nr3ibbgcvp7tb2GUPsa/NZ5aPTs
 6K9t+Ac5TCDLgwDzt/hA7AzYsLnKKGd5jk6+WyBEirrDuBF0k0yxJOVzUZNuLEN/6TrMswJTj
 E9zT1F3GAn1eGfLHZ5CTcc/KkVcyxgU4FPkJqPsw77r0CYcUUalczsw53CmJg3EVqZ3HfzxRe
 HtqyIYI
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-1655952641-1486035083=:3496
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE

Hi Duy,

On Thu, 2 Feb 2017, Duy Nguyen wrote:

> On Thu, Feb 2, 2017 at 5:37 PM, Johannes Schindelin
> <Johannes.Schindelin@gmx.de> wrote:
> >
> > On Thu, 2 Feb 2017, Duy Nguyen wrote:
> >
> >> On Thu, Feb 2, 2017 at 4:43 PM, Johannes Schindelin
> >> <Johannes.Schindelin@gmx.de> wrote:
> >> >
> >> > On Thu, 2 Feb 2017, Duy Nguyen wrote:
> >> >
> >> >> On Thu, Feb 2, 2017 at 4:16 PM, Johannes Schindelin
> >> >> <Johannes.Schindelin@gmx.de> wrote:
> >> >> >
> >> >> > On Thu, 2 Feb 2017, Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy wro=
te:
> >> >> >
> >> >> >> This squashes two changes from Johannes and Ramsay: [...]
> >> >> >
> >> >> > Sorry, I lost track of the worktree discussions... Could you
> >> >> > remind me which patch is supposed to fix my continuous reflog
> >> >> > corruption?
> >> >>
> >> >> The corruption caused by git-gc? It's not fixed. All the changes
> >> >> in this series is shown here.
> >> >
> >> > Oh sorry, I meant to ask "and if it is not in this patch series,
> >> > would you mind pointing me at the patch series that has that fix?"
> >>
> >> You meant this one [1]? There is nothing substantial since then.
> >>
> >> [1] https://public-inbox.org/git/%3C20160601104519.16563-1-pclouds@gma=
il.com%3E/
> >
> > I guess I mean that.
> >
> > Given that this results in real data loss, it is surprising that this
> > has not made it even into `pu` yet!
>=20
> I  could rebase and clean it up a bit if you need it, but I don't think
> it'll end up in 'pu' or anywhere near since Junio wanted a cleaner
> approach [1]. That means (as far as I can see) a lot more work around
> refs store and backend area before it's ready to handle "get refs from
> this worktree store" (or "get refs from every reachable stores").
>=20
> [1] https://public-inbox.org/git/xmqqshwwzyee.fsf@gitster.mtv.corp.google=
=2Ecom/

That is a big, big bummer.

We are talking about a data corrupting bug here, yes? It should be
possible to do that redesign work while having a small workaround in place
that unbreaks, say, me?

Ciao,
Johannes
--8323329-1655952641-1486035083=:3496--
