Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 193761F97E
	for <e@80x24.org>; Mon, 26 Nov 2018 22:52:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727311AbeK0JsZ (ORCPT <rfc822;e@80x24.org>);
        Tue, 27 Nov 2018 04:48:25 -0500
Received: from mout.gmx.net ([212.227.17.21]:33507 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726627AbeK0JsY (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 27 Nov 2018 04:48:24 -0500
Received: from [192.168.0.129] ([37.201.193.149]) by mail.gmx.com (mrgmx102
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0Lxu7U-1fMLB40nbw-015ErF; Mon, 26
 Nov 2018 23:52:38 +0100
Date:   Mon, 26 Nov 2018 23:52:22 +0100 (STD)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0_Bjarmason?= 
        <avarab@gmail.com>
cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Subject: Re: [ANNOUNCE] Git v2.20.0-rc1
In-Reply-To: <877eh219ih.fsf@evledraar.gmail.com>
Message-ID: <nycvar.QRO.7.76.6.1811262347360.41@tvgsbejvaqbjf.bet>
References: <xmqqmuq25ufc.fsf@gitster-ct.c.googlers.com> <87y39w1wc2.fsf@evledraar.gmail.com> <877eh219ih.fsf@evledraar.gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-822438879-1543272758=:41"
X-Provags-ID: V03:K1:qhv6mcQD3oG+jfkQq6SWFS44HnN2vu9DzLBY9OUs7a7tgpd7LOc
 tWD+fQpz7FhYlNWn+RwolYk/TnD9Q5dGs/9L3HULMsPazvG4UljJYQWx9vCGTRl9i4xa9dN
 +t3YfW11OQDwJFjA7HKszfUpUu1Zw2+iFY/egagdTITNSUX1rdSTUBCi57R4DTlh5F7TyvE
 fr2B4imwkaT+X3TGwxstg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:PGhyvGhyRRY=:LTMqin4h2mzVfPBMNwO8ZD
 pyK5zlR8X2F0EOT3ttiBXxwatrymE7y804hiphrfxx+g9oOIO4Lwkk1ahtL+RELamU/8qletK
 mFQ2CMCcGQ93g6y665LRUHoWWEPxMPigZAced/1sWl4oJHQaGTj4WQr6Bc57fqZwqAulqkjaN
 tNqwZHadumN824no6QnsGnRbfdW3D2/a8qp7N3M8Jl7snQA0TrCN452Rdtu+SB4mLHgayWkmN
 hlLLvKFV4rjEyzTR+h15m51kcJf5YViwApVgljMLhJ3Jux8DKfDuxIN47c+g4krJ+4wzovcUS
 4CmTlHkBRnn3+hfQCNZgJQf6pN+hibq2/QG/gYW7p28N19GL8SeuHeGgssvfdxWY3gcisdrBi
 iUKL+WdBUFpmmJYidPM+d3lOCvoRHn5PYjXBO2XcAg7BFXyELQRo9lZUZQmDSXpEKu5sqmOi8
 C4arIG0WU4LkBAFZNlqc6dPRffbkT7VPoioz0Tu8Tz5HcWE6HbwQNLOveBkxLGqeO79RLyTK2
 x/TKeCeV6pbAHOPenZsRiEPk1DBT9cjofm8GRADNDUI3EkNyAD61OXQFEbYTDm4w+4EGCfCb2
 c2Qjvc+HMtZa48uyTLJ6/kUErCXiNJFdWwi7ZhuzmVNS0TGp5Tvz5FE5g+mG/Ptla6kj1rMsA
 0VxQQucbNXnsbkcLFkUCfIgVs3NaLs4i2HBtf635aIg01YYc7Gj35h5K401NZrvrTuIS5Xtcz
 Jq40+ZeAoTM5dQOCXih0nuFIRINS6T9KKDPRuk3rmG5kdLLUpdh/crys1saQOb8MKEb3QFshk
 G0Zjz9/ITqr2hMSa+RXtXXJoBi/G+QyaaXZEAvS1SDhUfqtXMPhdGsFL4SO10t5Q8ZGOf2PXO
 0N2lJWHfQQpw/C3tLME9fGQhQ+vNbZdjW9Z+8PvajlbG81mrmZjkboPjkB/woe
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-822438879-1543272758=:41
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT

Hi Ævar,

On Sat, 24 Nov 2018, Ævar Arnfjörð Bjarmason wrote:

> On Wed, Nov 21 2018, Junio C Hamano wrote:
> 
> >  * "git rebase" and "git rebase -i" have been reimplemented in C.
> 
> Here's another regression in the C version (and rc1), note: the
> sha1collisiondetection is just a stand in for "some repo":
> 
>     (
>         rm -rf /tmp/repo &&
>         git init /tmp/repo &&
>         cd /tmp/repo &&
>         for c in 1 2
>         do
>             touch $c &&
>             git add $c &&
>             git commit -m"add $c"
>         done &&
>         git remote add origin https://github.com/cr-marcstevens/sha1collisiondetection.git &&
>         git fetch &&
>         git branch --set-upstream-to origin/master &&
>         git rebase -i
>     )
> 
> The C version will die with "fatal: unable to read tree
> 0000000000000000000000000000000000000000". Running this with
> rebase.useBuiltin=false does the right thing and rebases as of the merge
> base of the two (which here is the root of the history).

Sorry, this bug does not reproduce here:

$ git rebase -i
Successfully rebased and updated refs/heads/master.

> I wasn't trying to stress test rebase. I was just wanting to rebase a
> history I was about to force-push after cleaning it up, hardly an
> obscure use-case. So [repeat last transmission in
> https://public-inbox.org/git/87y39w1wc2.fsf@evledraar.gmail.com/ ]

Maybe you can give me the full details so that I can verify that this is
indeed a bug in the builtin C and not just a regression caused by some
random branches being merged together?

In short: please provide me with the exact URL and branch of your git.git
fork to test. Then please make sure to specify the precise revision of the
sha1collisiondetection/master rev, just in case that it matters.

Ideally, you would reduce the problem to a proper test case, say, for
t3412 (it seems that you try to rebase onto an unrelated history, so it is
*vaguely* related to "rebase-root").

Ciao,
Dscho
--8323328-822438879-1543272758=:41--
