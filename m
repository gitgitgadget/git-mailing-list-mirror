Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D49801F404
	for <e@80x24.org>; Tue, 30 Jan 2018 12:33:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751764AbeA3Mc7 (ORCPT <rfc822;e@80x24.org>);
        Tue, 30 Jan 2018 07:32:59 -0500
Received: from mout.gmx.net ([212.227.17.20]:53235 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751611AbeA3Mc6 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 30 Jan 2018 07:32:58 -0500
Received: from MININT-KR8J64V.europe.corp.microsoft.com ([37.201.195.59]) by
 mail.gmx.com (mrgmx102 [212.227.17.168]) with ESMTPSA (Nemesis) id
 0M34eJ-1f05a31tvb-00srru; Tue, 30 Jan 2018 13:32:56 +0100
Date:   Tue, 30 Jan 2018 13:32:55 +0100 (STD)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@MININT-6BKU6QN.europe.corp.microsoft.com
To:     Duy Nguyen <pclouds@gmail.com>
cc:     Git Mailing List <git@vger.kernel.org>
Subject: Re: [PATCH 0/2] Add "git rebase --show-patch"
In-Reply-To: <CACsJy8AH+xg3AB3qaqnFud4B8HHeyaO=8DqHL+p4HTTeSx6uYg@mail.gmail.com>
Message-ID: <nycvar.QRO.7.76.6.1801301331410.35@ZVAVAG-6OXH6DA.rhebcr.pbec.zvpebfbsg.pbz>
References: <20180126095520.919-1-pclouds@gmail.com> <nycvar.QRO.7.76.6.1801291609060.35@ZVAVAG-6OXH6DA.rhebcr.pbec.zvpebfbsg.pbz> <CACsJy8AH+xg3AB3qaqnFud4B8HHeyaO=8DqHL+p4HTTeSx6uYg@mail.gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-1217544816-1517315576=:35"
X-Provags-ID: V03:K0:b6JqeLqE9k1wwmH1L5F/SKAV1z5snVSXmJnMs57i98LmchxBkcU
 KpHh3Wh4p9xZUyGsLfsXuyWgAT19uAT8qlCQHarf5RvaTqSiPFOG1h9IPpbNtQUzWo4tnPc
 mU/E1tnbUxxAn2/tu1mvoVg/9p/uXriJOhY06aQ2dESr6y5tBb5Ru3dHZ+KDhgjZkAD3Zf7
 9Yn6fc8GfdKZ7LfusYaIA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:iYx2FK/TteM=:owdltvX8PRU0ty2mTSgFDx
 loGeO5O+16Lk6pcQ5nt9punOshejLlfDik/E3m482Smgr3Oe74yTkc5C8eutmeeSH3nqd6PdV
 aTvQC+CzOLXFNmZB7nUL/+KCSmCZboUjDKuUFMrD/PbilgYzg/miGUL2f8LmVZi5QzxR/uDfw
 SsC8NS2abL5LWXHDZf6j/9Kq3OMFgV1CiKDFxW1yEmeusOOCNSl6McOBSWLcgjl+U2CXNMdga
 mN6TUcB+x6QlCsZeoO57Tclp0iQGll4I6Zi/S6bvAQf0fa4pB4Y9DPPaJbSkdxeoNl0AjlYrs
 3tQqXlc4oXIirFzRabvD6w7KCBKsp3zsrs6BzJ/virAzYmql/KmVLSOe1S9czTDtNP3yDymqE
 LLnA+5HsSMydQzZE/jxAisRceMyRQTsFJ8eDAqCtk5/EnbDQUtSjGS+1T3COc8y9dBZ/x8ZXZ
 6ql6ofiNPXDYBd9rc5BL6CyG1O6HqyyQyK4XMMZv4QdF7cFN7T9zLHRhIbgJDOiEEDy2/XvYy
 Ag9vn05EnOXE01Ts7YrK5vZB5CQkP4llAVi5idPuum++QUbznmtNT9dyH7CcJwYd656nNaig9
 U0DfiOscwhDJNMFSmcDyTVaHw8iLBdvEGwpKTNGkQEjZ6om3PyL72gLV6HydsetUZxPqFGaRl
 8+zK4p/cri9O0XK3JBpMkV7O419ZpwxMODdvDTHxNpDOkEOOMyB2DbKoQzqCDSOLVW2vg9Hef
 V7BdVbm1NWBonR8p5lkTNNCp8HX6INjIscPfkZTazQJSRM3NFGPMgU+1CMSpx1g1BuF8lrw63
 6Zkwj0dyLLo//dGWsnqOMutzvxBdh0nsdhLsMSidG4dicSoNDUbD+3zvGxIEqgLfqjY4lqs
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-1217544816-1517315576=:35
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE

Hi Duy,

On Tue, 30 Jan 2018, Duy Nguyen wrote:

> On Mon, Jan 29, 2018 at 10:09 PM, Johannes Schindelin
> <Johannes.Schindelin@gmx.de> wrote:
> > Hi Duy,
> >
> > On Fri, 26 Jan 2018, Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy wrote:
> >
> >> When a conflict happens during a rebase, you often need to look at the
> >> original patch to see what the changes are. This requires opening your
> >> favourite pager with some random path inside $GIT_DIR.
> >>
> >> This series makes that experience a bit better, by providing a command
> >> to read the patch. This is along the line of --edit-todo and --quit
> >> where you can just tell git what to do and not bother with details.
> >>
> >> My main focus is "git rebase", but because rebase uses "git am" behind
> >> the scene, "git am" gains --show-patch option too.
> >
> > Makes sense. I am not a 100% certain that 2/2 catches all rebase -i cor=
ner
> > cases, but I think the patches are good enough even for `next` already.
>=20
> Not so fast :) With Tim's suggestion about using a pseudo ref and
> AEvar complaint about potential confusion, I might actually go with
> pseudo ref for rebase (and leave "git am" in the cold for now).

The pseudo ref certainly has an appeal. For people very familiar with
Git's peculiarities such as FETCH_HEAD. Such as myself.

For users, it is probably substantially worse an experience than having a
cmdmode like --show-patch in the very command they were just running.

Ciao,
Dscho
--8323329-1217544816-1517315576=:35--
