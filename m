Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DE9041F453
	for <e@80x24.org>; Tue,  2 Oct 2018 15:06:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728755AbeJBVul (ORCPT <rfc822;e@80x24.org>);
        Tue, 2 Oct 2018 17:50:41 -0400
Received: from mout.gmx.net ([212.227.15.19]:55877 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727451AbeJBVul (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 2 Oct 2018 17:50:41 -0400
Received: from [192.168.0.171] ([37.201.193.149]) by mail.gmx.com (mrgmx001
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0MBmvH-1fysDO2RiZ-00Ar3G; Tue, 02
 Oct 2018 17:06:41 +0200
Received: from [192.168.0.171] ([37.201.193.149]) by mail.gmx.com (mrgmx001
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0MBmvH-1fysDO2RiZ-00Ar3G; Tue, 02
 Oct 2018 17:06:41 +0200
Date:   Tue, 2 Oct 2018 17:06:42 +0200 (DST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: dscho@gitforwindows.org
To:     Jeff King <peff@peff.net>
cc:     =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0_Bjarmason?= 
        <avarab@gmail.com>,
        =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>,
        Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v6 17/21] range-diff: populate the man page
In-Reply-To: <20180910133704.GC5233@sigill.intra.peff.net>
Message-ID: <nycvar.QRO.7.76.6.1810021652420.2034@tvgsbejvaqbjf.bet>
References: <pull.1.v5.git.gitgitgadget@gmail.com> <pull.1.v6.git.gitgitgadget@gmail.com> <8c5543a0667fffe0cb0684427f726fdfb75b28d0.1534159977.git.gitgitgadget@gmail.com> <87lg8a7wj2.fsf@evledraar.gmail.com> <20180909165431.GA17224@localhost>
 <87k1nu7fm0.fsf@evledraar.gmail.com> <20180910133704.GC5233@sigill.intra.peff.net>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-825645290-1538492803=:2034"
X-Provags-ID: V03:K1:T+sugwSjWBg0ukUa1E4Uz1+ohJHoi3e5pnTHH6jyOgY7mh8sIS4
 LEh6x7SzGgNhaREHEbama9emr14pMpXSLeQURB6GG9z9bRyyWPoY0YmpbUBwp4B3qeQuqAv
 t7IaZPzBOIu9RSu5JB81Sq5CffIVzl1sP6ClSKNKJWWviLe5kW/eTNeNxPylGVQapF8NzRa
 WzPx9sz5dHdgsCQ/XgGOw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:QXuxH+GHWAw=:35tZwxEYl8BUE+GwpzBFIT
 fWbXo9iOFRCSykn9yJBoIjQbUQITV1KzdBGoA7pqq2lS02UVdOdAbCOrbRujvUSdbn7oNIih3
 ThXKg/TY1bWlLi9dD2P9Ex6YzIOEm+ADA/Cj3aLP7QjcIL3R0B2uV2+ODqiYkgldCIvARSQgT
 wVJHZy4j4m7fRkbqSiLyMJEMK3sMQ6xJ3b1gc0ZAVvneVBnse8/SBiKGwZAbndjj/xo+ItUuQ
 9d7eHRrIriDU7w7b4d1fd4rfLPEoyTKT96iMTaButDEQ8/2IMGMofVfHMS/UgRVa7gLXyLkEB
 /ou7MIMac3IvlvlwRmdmz+vFt2YoTOi8VmmYWOx70+8LcTA2vOxcYk2nJ6QfsP6lduDtGq9/G
 Vc8RTLV2uQdyFvigMSBVZO0fPAYlk6BFucvScKCLCuLq1fpY2wpcQDO34xqfS/EQuqo82H7aw
 9mL86G40lDSclvFbP3gq2GKxHh74K0wU0H68cwYl2ClWuNUGxuseCKWD1xhBaCJfjLW/7g74H
 RxKG5qp9hrD5m4gWbZ+vb/DjDjykdA/otX86gEQmaLYcaeK0QD6W3gyqAc8CZQLdFnnZ3OzCT
 roUuk/7AYoUc9i29BFQwY/bOUyiXWV+Z+li1sBEJCx9hTgpPO2bH9lgaZ77MhZQn6Agsgr0C0
 2vSJdQEtUq2mAuRM90ygWiA0ScL9uSxSEcdFsp9e+nzA/u296G8P2q94QGsmjYf0kJ2VPNB82
 apXAheyxHYSIbKRHGqz+psUJ3g01dKUlu5wzWoTYzRjuwKNA89y3GaC1eUioRz4B92xjvyKlh
 l3UDW0j5eLpTsZSMKnPwqEYuew07h+YAbT/xXmGVUgty2nxA3s=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-825645290-1538492803=:2034
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE

Hi Peff,

On Mon, 10 Sep 2018, Jeff King wrote:

> On Sun, Sep 09, 2018 at 07:19:51PM +0200, =C3=86var Arnfj=C3=B6r=C3=B0 Bj=
armason wrote:
>=20
> > >> And then I turn that into:
> > >>
> > >>     # @{u} because I happen to be on 'master' and it's shorter to ty=
pe
> > >>     # than origin/master...
> > >>     git range-diff @{u} 38b5f0fe72...718fbdedbc
> > >
> > > I don't understand what you want with that @{u} or 'origin/master' in
> > > the first place.  It's unnecessary, the three-dot notation on its own
> > > works just fine.
> >=20
> > Maybe I've been using the wrong mode all along, I passed over by habits
> > from tbdiff, which were surely copy/pasted from somewhere.
> >=20
> > Looking at the git-range-diff manpage though it recommends <base> <rev1=
>
> > <rev2> over <rev1>...<rev2> when the topic has been rebased, which is
> > usually the case for e.g. a topic that's submitted to git.git (usually
> > be the time feedback has been gathered & a re-submission has been made
> > Junio has pushed another "master").
> >=20
> > So isn't "<base> <rev1> <rev2>" the right thing to use over
> > "<rev1>...<rev2>" for git.git use? I think so, but I'm not sure.
>=20
> The problem with <rev1>...<rev2> is that it finds the actual merge base,
> not the beginning of the topic.

That is actually not true, not for `range-diff`. If it sees `A...B`, it
will automatically generate `B..A A..B` from it.

That matters if the branches `A` and `B` have multiple merge bases.

> So if you have a 5-patch topic, but the first two patches weren't
> changed in the rebase, it won't show them at all!  I made this mistake
> in [1], for example.

Yep, that is very easy to do.

Another thing to note is that often `A...B` is not doing the right thing
with branches that go into `pu` because some of us contributors rebase
to `master` (or `next`) between iterations. For such a use case, I
myself prefer the `@{u}` version that =C3=86var wants to use. (Although I
leave off the three dots, in which case everything works quite
magically.)

> For a force-push, though, you may not care about seeing the topic as a
> whole, and that mid-topic merge-base could be just fine. So pasting just
> the "A...B" works.
>=20
> I don't think your "@{u} A...B" makes any sense. You're giving _two_
> bases, which is weird. But even if you wanted to ignore the "..." base
> as a convenience to users of fetch, @{u} does not necessarily have
> anything to do with the @{upstream} of the topic at "A". You really want
> branch@{u}, which is on a separate part of the fetch output line (and
> your branch@{u} and the remote's are not necessarily the same, either;
> in this case you probably do not even have that branch checked out).

While `@{u}` in general does not relate to `A` nor `B`, it is quite
possible that it always does in =C3=86var's scenario. I would not want to
limit them in how they want to use Git from this point of view.

However, I would have a little bit of a problem with special-casing the
two-arg version when there are no dots in the first arg, and three dots
in the second one.

The problem here: the two-arg version already has a meaning: two commit
ranges. And it *is* conceivable that somebody wants to compare, say, the
full history of `git-gui.git` with a certain symmetric range in `pu`.
Granted, that is very obscure a use case, but it would be hard to
explain why the two-arg case refers to two commit ranges in some cases,
and in other cases not.

Ciao,
Dscho

>=20
> -Peff
>=20
> [1] https://public-inbox.org/git/20180821195102.GB859@sigill.intra.peff.n=
et/
>=20
--8323328-825645290-1538492803=:2034--
