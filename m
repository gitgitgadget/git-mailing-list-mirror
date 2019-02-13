Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6CDB41F453
	for <e@80x24.org>; Wed, 13 Feb 2019 10:20:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388598AbfBMKUm (ORCPT <rfc822;e@80x24.org>);
        Wed, 13 Feb 2019 05:20:42 -0500
Received: from mout.gmx.net ([212.227.15.19]:42115 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728843AbfBMKUm (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 13 Feb 2019 05:20:42 -0500
Received: from [192.168.0.129] ([37.201.193.149]) by mail.gmx.com (mrgmx003
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0LlV71-1hTC0d07E7-00bJFK; Wed, 13
 Feb 2019 11:20:40 +0100
Date:   Wed, 13 Feb 2019 11:20:24 +0100 (STD)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     William Chargin <wchargin@gmail.com>
cc:     Git Mailing List <git@vger.kernel.org>
Subject: Re: Workflow for GitHub branch model interop: advice?
In-Reply-To: <CAFW+GMDA9gkih-7n=R2N_5edNK=b4X28qqPgRd7soGG160t94w@mail.gmail.com>
Message-ID: <nycvar.QRO.7.76.6.1902131115230.41@tvgsbejvaqbjf.bet>
References: <CAFW+GMDA9gkih-7n=R2N_5edNK=b4X28qqPgRd7soGG160t94w@mail.gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-315037363-1550053240=:41"
X-Provags-ID: V03:K1:CZVaWCzev4EMJE0pv8LDLhxRBTNbodwKalp376lPUIwC8Id8o4s
 fF+P37TU6HPGYdQEMMXePnZmgWSCgTX0KgQmZaqShzogAVr5/CHvwlrku4XR8tgdcZQW5bx
 BjRPeSt43jDBxVAXXeh/SZr2kGdkUh0+TU+lbwI/c2FYpndv60z+EiL9IBb3WHG0GZzv/Jy
 aBE7ega2Gz/1h4zGklWtg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:9frww+9gGU4=:a6RyBNusMwUbCp6zmeKH/P
 yUZ03Bp965Jj16ARYxRkW7opNCuZ4gaRcZ4zDFiTHX3gNNYvJrvtgwhYJKEhpCpdMl7LjzFOP
 RbzDwb45pqEtRjT1RSHXo9CWd8rdDfM3DHoX0FgRhCUOY0u1KyO1vFBj3eNHECiPR/xvHR5mu
 ohLFewhSA+v/ehkJblwEB3U4Qm0eWvcfzDvaI+9B4xsMaSPdrwcO/i+zNF1md1jII+vnGFa6K
 VF+KwS/mlSGKBuD5eQDtEukQyrEcrxy6Ac0yV1yIWv8HzyyPV6lsX/jGfCd1I5c/7fQC+1ykV
 FcmylfcRs7SGlYNvMkWrsTuK8C9bLseJQAKcHGVweL99ki9nl0ISvyF2xWbX8+8qRcarGHJRm
 syb15ZARnTn5J95w+XIVWgjTjy/lWX+M2hedkuMw71g6Xo8zbtzRLNX0Xg6k/Xs7moNaLI0PS
 lKXl81QrBymqlkhye7GTP95Pr6JZXP33NGOzfRSr1tGWPYn0wWT4txooU1C+A9hmTRt99Y4KU
 uYdMPuyqQ32OqJrIZ+qwztGxvgDWilVPWNhoRg34Z62bBVZGtjgDVwvU9qcHwA1fiN7EsBlv+
 NMBB468lPooNuH0PIZDe4HyNIA09WNzYQdF7HBPb/wi7prWdsyE8vK3/qUQnaqHF0/aqg6xqI
 afQimmtTaP220D6xlLvOX1+mV4Nuh1UXdt1Zvkrg9uIbtpClRQF/m8xpok4XCsz/EVLVqntBc
 qT2k8b440zcGBweGUhEqcZCMwsPUpKuMDX8QV7N2DlJtrRsfgEc+ldOyqk1lgeKR7vInlJurC
 w1CYPTDW6do3Zo+CSTdE20puLJmCf8GllxQud9uQvHQ0LQ86JDLxQUbpSp2Em8C7YSmGLCrnx
 8OFPbpVdXk0I/sZ1haaIc+PNrMB3C7PY7/O1gwcM1dR10YvmgUBP9XWw8ctjInINwqj0107DC
 DcjGkAucJersvhN0CSb22ZypzaHguhJM=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-315037363-1550053240=:41
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT

Hi William,

On Sat, 9 Feb 2019, William Chargin wrote:

> [...] creating a whole worktree is a bit heavy-handed.  Creating a new
> worktree for linux.git takes about 6 seconds on my laptop, which is not
> terrible considering that repository’s size, but would be nice to avoid
> if possible.

Agreed.

> It would be great if I could create a “lazy worktree” and only check out
> files actually needed for the merge.

I do use the `git worktree add --no-checkout` trick in one of my scripts
to have a "super light-weight" worktree.

To make it work in your case, you'd then have to inspect the changes you
want to replay, e.g. via `git log --name-only <range>` to craft an
appropriate `sparse-checkout` file (but don't forget to *also* set the
config variable `core.sparseCheckout`) before checking out any files. I am
sure you can even automate generating that `sparse-checkout`.

> Would the partial clone feature added in v2.19 be helpful here?

I doubt it. The partial clone still needs you to know which files you
want.

VFS for Git would help you here. But something tells me that you're on
Linux, and there is no official VFS for Git on Linux yet.

Ciao,
Johannes
--8323328-315037363-1550053240=:41--
