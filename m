Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.2 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_WEB,RP_MATCHES_RCVD shortcircuit=no
	autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DB316201A7
	for <e@80x24.org>; Mon, 15 May 2017 12:19:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751253AbdEOMTj (ORCPT <rfc822;e@80x24.org>);
        Mon, 15 May 2017 08:19:39 -0400
Received: from mout.gmx.net ([212.227.15.19]:50717 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750822AbdEOMTi (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 15 May 2017 08:19:38 -0400
Received: from virtualbox ([37.201.192.198]) by mail.gmx.com (mrgmx001
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0M5dMm-1duLH624Bk-00xdvz; Mon, 15
 May 2017 14:19:28 +0200
Date:   Mon, 15 May 2017 14:19:27 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     Junio C Hamano <gitster@pobox.com>
cc:     =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0_Bjarmason?= 
        <avarab@gmail.com>, Git Mailing List <git@vger.kernel.org>
Subject: Re: [PATCH] fixup! log: add exhaustive tests for pattern style
 options & config
In-Reply-To: <xmqqbmquyiae.fsf@gitster.mtv.corp.google.com>
Message-ID: <alpine.DEB.2.21.1.1705151418000.146734@virtualbox>
References: <92c10618c688bb8cb1f31ee2a93110c581974468.1494586245.git.johannes.schindelin@gmx.de> <CACBZZX7MXh_9mG1EROZVEEGapBwjzRWzr3S57f6rWLnQe9L+XA@mail.gmail.com> <xmqqbmquyiae.fsf@gitster.mtv.corp.google.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-1285961049-1494850768=:146734"
X-Provags-ID: V03:K0:8VJ7g3HmQPpeWS4WaCoKYl1omI0IUOB7s5oMt9UbGvhEYl8xWzB
 LcjXJK88r6ZhvHdLoKlsQXIGjGS4+egH/XoAgsXTEMjJYOtbTrpAatx4/K7lA9T8gfzpUKE
 XAAGT51b7ta8H3y6vKi9iW4nbGt+cPaPTYatdQ97PRifU4vTJMoKSAALUNi6MY22c7jLuPP
 pPsdS4OM7G26L7jI5M7Iw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:b6dPYLi05pg=:o1XcMwv0R9SKgLdYjXlzMG
 jUzEfnkNo1Of0DHhNK0DlOokuCb0HkXXKyDKzalBWl0yt5AdLtKeA9TFAgIjCP42JQZ2emulP
 TEtkc4IW1k1OYUtZzLelvxX/907EtlRo5fB3pLzD5pYnsWcJKooFz0uIiDvLWOg9bPXeOoE+A
 UNEA8aqd5Dg3FBF48vXnMvWpjncQpOo7mBiomkIdDdnAaTZQMSVuQyYluKNG5DNltLh8xxCDd
 1xN2+vqRnEZlv/bPWSa91sqt22hKToLKZIEUlU2dfJKBTGEB6Bwt/c3mRq3xiDwh3KUk0MvWq
 WNkAAZ0FvzjJHI4zd29uKh1bkmnXSVSb6UKfZO0tMSys6LNhZ/g0kIuj7EfU5Lu1R61FW4z/h
 QuMEiUjgIrVtkrbKlpEFNf9mlYZFHy7ktwlctlw/Mu2yzIUKhILGkPr1oVj04YBpxQqyqawm2
 4D1mq4oMXvZM/8ZnPRKuVCHv/kwtql1jlySi0TiosHM2bsy9CdydIZ3wTkY4OXg/qA+QcnlgD
 lbSW4vb+Z/mqVwrzyWvmPSLVqYVJOHX0m1ONj43ld+26X8OZDRDomGDSwwpBM50gFHZz7Fv+Z
 TZBg0TfEJQbaFuAZA3q4uo91ww2+pi7pvubvIDxUnQL1Y/GQ7gQjdExuhGkM6k6e+Nf2sysTt
 4seQoo3Hvm9UZLdO/EwicWc2Mso02wzkFXdXxHFqkqKFNPBuxfR1Oe3aAL4oerN9PWoPDASKm
 1iYNKF3VxBPaWsSsT9HvMVCychcxVb+mNDT3qCGbhqwFhFJkA7S1/mHFieNAbiD1pFr4Z2m6i
 Q1k1eu6
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-1285961049-1494850768=:146734
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE

Hi Junio,

On Mon, 15 May 2017, Junio C Hamano wrote:

> =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:
>=20
> > Thanks for the hotfix. I'll fix this in my v2, but do it differently
> > in such a way that I can still run these tests on windows.
> >
> > I.e. the actual test here just needs these odd characters in the
> > commit message. It's just an unintended implementation detail of
> > test_commit that a tag is being created.
>=20
> My knee-jerk reaction matched Dscho's, but grep is about contents,
> and we should be able to test this if we used a sensible tagnames or
> didn't use any.  Glad to see somebody can step back and think ;-)

Maybe somebody should step back even further and think even more, as we
could adjust test_commit to mangle the argument into a tag name that is
legal even with a refs backend relying on NTFS.

Ciao,
Dscho
--8323329-1285961049-1494850768=:146734--
