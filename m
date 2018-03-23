Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 30BCD1F404
	for <e@80x24.org>; Fri, 23 Mar 2018 17:06:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752173AbeCWRGV (ORCPT <rfc822;e@80x24.org>);
        Fri, 23 Mar 2018 13:06:21 -0400
Received: from mout.gmx.net ([212.227.15.18]:34499 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751907AbeCWRGU (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 23 Mar 2018 13:06:20 -0400
Received: from [192.168.0.129] ([37.201.195.115]) by mail.gmx.com (mrgmx003
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0MfVYB-1fF9sX0759-00P8WM; Fri, 23
 Mar 2018 18:06:18 +0100
Date:   Fri, 23 Mar 2018 18:06:17 +0100 (STD)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@MININT-6BKU6QN.europe.corp.microsoft.com
To:     Paul-Sebastian Ungureanu <ungureanupaulsebastian@gmail.com>
cc:     Christian Couder <christian.couder@gmail.com>,
        Git Mailing List <git@vger.kernel.org>
Subject: =?UTF-8?Q?Re=3A_=5BGSoC=5D_Convert_=E2=80=9Cgit_stash=E2=80=9D_?=
 =?UTF-8?Q?to_builtin_proposal?=
In-Reply-To: <1521760546.11809.20.camel@gmail.com>
Message-ID: <nycvar.QRO.7.76.6.1803231754390.77@ZVAVAG-6OXH6DA.rhebcr.pbec.zvpebfbsg.pbz>
References: <1521576562.2188.10.camel@gmail.com>  <CAP8UFD3NKCSN8mVDiCUzvor5uZh4nFCAw4T0zgxpvHLf9AWmyA@mail.gmail.com> <1521760546.11809.20.camel@gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-2146151303-1521824778=:77"
X-Provags-ID: V03:K0:D01wv4pnp+q4rUo8KE3iIT9kysNEO1LqAgdS8fB+MYDxesNIC5w
 Y6ewRSgKwlps2/Lc26xhmvnpar17wiv+4FzvAuGTrsEkObk+B7us2l8oiQzofCkQqDQmnup
 4AoyuxAdTMhgaFduYdW518SKDzoUZKkwUaBG0ZqOhaq0ngwey3f7CFgFVbkq4fcVU9iNs5V
 oOTR23pa6wMl48VTOt7SA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:Cdv5I9dpDjM=:2wKuaow1/SpiBCU0431l1S
 AyamQMyeX2HKpAVhyaPqOJazymuOygbRMhRuRA/RGRc2dEiR7h8jbhNOU3JB1cnWZW1EoUc+J
 q8HAF4DrFn/dOcvJ5HbGTumn5N4wqlQ8vdLCP2+H0ypVwb/W7VOIZpLDPrfwOFP4/h+EYaiMG
 EUgrpjKL383jhh9tPIvepTM07xxh+ikwTJ+LtTvNCLfdHVClcJ+PL25RYRUw/BwgUrubC09g+
 OsDqEsBDmsvaPNE6Gv/7eEOtBvWriY/zsgWGwxIQxqgFqJqnHRgx0LDlzaqVm8bJnpZ21V0hs
 G3NAG37qdLHY4Y9WBa233jdRI4lV8BxR+jylLg4fYo6YFAR8I6hEYm5m63xA5K9JnBbrKI40o
 SL5+rfiya8fVc8i8EUcijJJ3+NEES9bfQATvdN0F/+k9k3dpWjTyaykX2wBVgk14KO/mGZhvA
 ABaSuXaX7rNDG2GwxETqMUgo7VkM4aMo+Pb56yUE1cj3myMYhnVxr+fr2lPnwT7TEbU/W21f4
 zb5gHBhXw74RvK0i15ryWdqVmRZuu7QSZJEmwcsfAItM5L0x7hOYR64wWLHoLtcvlZzKx/2Bj
 r4viQOVps5i5TApv4YgqE/DeMxiLwwaZGZgyUKUTHe7DgshKTvhmsVKAyHTSzuVMx/z8/JM25
 Kqsrjx/UNJ65qIvM0+Om44QCVmPeqTmz5k0YJU04/xuM+rMZAZhxUb60K23GKgH8zwBDH8hDl
 5IqK/FES1D0Q9POE0JKskLDWY+Z3R6O15M3RxLrKrixtuDSCn1MN2EbelJSDgEqegtdSwcA/3
 IXBbGPsK5WD5mGKMY8fjvkFmRRHJOpa1TmBK7nfEsFWcxjBhic=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-2146151303-1521824778=:77
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE

Hi Paul-Sebastian,

On Fri, 23 Mar 2018, Paul-Sebastian Ungureanu wrote:

> On Tue, 2018-03-20 at 23:08 +0100, Christian Couder wrote:
> > Hi,
> >=20
> > On Tue, Mar 20, 2018 at 9:09 PM, Paul-Sebastian Ungureanu
> > <ungureanupaulsebastian@gmail.com> wrote:
> > >=20
> > > * Convert function: this step is basically makes up the goal of
> > > this
> > > project.
> >=20
> > Could you explain a bit more how you would convert a function? Or
> > could you explain for example how you would convert "git stash list"
> > below?
>=20
> In order to convert a command, all the functions which are used by the
> command must be converted first. The conversion will start with the
> bottom-level functions, which do not have any dependencies.
>=20
> For example, to convert "git stash list", the parser will call
> =E2=80=9Clist_stash=E2=80=9D, which will call =E2=80=9Chave_stash=E2=80=
=9D. The conversion of these
> functions will be made in reverse order they were mentioned (have_stash
> first and then list_stash).
>=20
> It is very important to know the Git source well in order to avoid
> reimplementing functionality. In this case =E2=80=9Chave_stash()=E2=80=9D=
 is somehow
> already implemented as =E2=80=9Cget_oid(ref_stash, &obj)=E2=80=9D.=20

Very good

> [... proposal ...]

This is a pretty good proposal. The initial draft at converting `stash
list` is a good start (it will need to be converted to avoid spawning an
extra process, but that is something we can do incrementally, together).

Ciao,
Johannes
--8323329-2146151303-1521824778=:77--
