Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 64C211F6AC
	for <e@80x24.org>; Mon,  9 Jul 2018 19:09:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933683AbeGITJu (ORCPT <rfc822;e@80x24.org>);
        Mon, 9 Jul 2018 15:09:50 -0400
Received: from mout.gmx.net ([212.227.15.19]:44325 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933353AbeGITJt (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 9 Jul 2018 15:09:49 -0400
Received: from MININT-6BKU6QN ([89.204.155.168]) by mail.gmx.com (mrgmx002
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0MQR3s-1fX9Sl1ZG8-00TmYl; Mon, 09
 Jul 2018 21:09:35 +0200
Date:   Mon, 9 Jul 2018 21:09:34 +0200 (DST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Daniel Harding <dharding@living180.net>
cc:     "brian m. carlson" <sandals@crustytoothpaste.net>,
        git@vger.kernel.org
Subject: Re: [PATCH 2/2] t3430: update to test with custom commentChar
In-Reply-To: <13a876a2-7fbc-de05-2e82-814c782e8a80@living180.net>
Message-ID: <nycvar.QRO.7.76.6.1807092107260.75@tvgsbejvaqbjf.bet>
References: <20180708184110.14792-1-dharding@living180.net> <20180708184110.14792-3-dharding@living180.net> <20180708210200.GA4573@genre.crustytoothpaste.net> <nycvar.QRO.7.76.6.1807090944400.75@tvgsbejvaqbjf.bet>
 <13a876a2-7fbc-de05-2e82-814c782e8a80@living180.net>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:YipGH0RuceccavWlLYnRl+MH95nRqzIpwd5LnR78V9myjJqNeRH
 btwmGbcqyWJiT5CBxQtleiAXfgx7KXM50MBz0zYQVp41QN/8VlNGsZ1Z4cqEs0GCEbES5jk
 AEIigdukKGJzLmfA5p4+W/1OldLZ7iVJCqigA7sk/vL+60uV0zamhIKoUKTJ7LIpngv1suf
 iKRSgRkEk+mg6Pc7o7ReA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:9hWMeqMj/3A=:qVw+COExLf5K/RkDR8UsBA
 5J0NyEIQX9UpSsNwJfRNu94oXwoL7N+oS3H//r/ELu0DE3BIU8fmme+/5Y6Zyf1ucN6izhCMr
 ci1bA8DocOCakCA5ptaWt390B5n8d3mpBLZmj4rzMn+9kNCqPq/9e5w4gyPbLyPemZ8g59Sbb
 sJHx4EECc0aQD5uUVSgxmPnLaAg43/WyYLdC465SE4yslP4WZJXwFLURCGx7tjISLL6ECh5pO
 xVuOboXt6Er9PrzvxtG8vJ8AOaByfntF8clAVlgmVXCDW6rxnHqz9Qbj/+A0+Vy9wDzeVF3I+
 GEuSCJEsV3tChwSKXmxt+zA2GoUTmQrWoP20CnIj5Sny28N87wsS9KP0rlQk4NvhZU08NeNaU
 Jb55FXQUiGApLZqEcCo99WnP0j7OF0UlYw9DKUFUySKMzsXXEssIus666P3AZBRP4pEhkUBEc
 /QxXooHNMVSaBVmuBDLuKsM9a8XPnotzv0nCGBzTIEAEF80zsMRgljIvp5TZZUFsH64mqWECk
 iVUG3OKMOPFCi3pnLg8mJThcq9Q8S2RNpMiSA4BvnhAfDB1Xl1Rg8kTNytY6zA5pOYvrB3Gox
 BUwt5wC096xMLvB3PnM3ocINIqaEm/xE3BcNOVkZwUWkaYJXrYUmK7gDsyHac/8Xl0amhHYcb
 i+xkxU11ImEJ0JIkmsd97QuTKkMa2PRxt+Hm+aK7AfOUVVsXo2FaCGEAJ8EK02cnyKb9v30Ts
 ZvNujDKr6bJVaxwVrIZTYY66yQRLB0D5H0D8hIjMmyDZWAFm4jJJaDfEXVZfsJftieHjFJbv0
 Vr8IUIm
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Daniel,

On Mon, 9 Jul 2018, Daniel Harding wrote:

> One question about my original patch - there I had replaced a "grep -v"
> call with a "git stripspace" call in the 'generate correct todo list'
> test.  Is relying on "git stripspace" in a test acceptable, or should
> external text manipulation tools like grep, sed etc. be preferred?

I personally have no strong preference there; I tend to trust the
"portability" of Git's tools more than the idiosyncrasies of whatever
`grep` any setup happens to sport. But I am relatively certain that it is
the exact opposite for, say, Junio (Git's maintainer), so...

Ciao,
Johannes
