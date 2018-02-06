Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C06851F404
	for <e@80x24.org>; Tue,  6 Feb 2018 16:17:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752710AbeBFQRa (ORCPT <rfc822;e@80x24.org>);
        Tue, 6 Feb 2018 11:17:30 -0500
Received: from mout.gmx.net ([212.227.17.21]:54893 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752331AbeBFQR2 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 6 Feb 2018 11:17:28 -0500
Received: from MININT-TB4PCE7.southpacific.corp.microsoft.com
 ([37.201.195.115]) by mail.gmx.com (mrgmx103 [212.227.17.168]) with ESMTPSA
 (Nemesis) id 0LnxVE-1fBXzi1lWa-00g39y; Tue, 06 Feb 2018 17:17:26 +0100
Date:   Tue, 6 Feb 2018 17:17:25 +0100 (STD)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@MININT-6BKU6QN.europe.corp.microsoft.com
To:     git-for-windows@googlegroups.com, git@vger.kernel.org,
        git-packagers@googlegroups.com
Subject: Re: [ANNOUNCE] Git for Windows 2.16.1(3)
In-Reply-To: <20180206153802.14064-1-johannes.schindelin@gmx.de>
Message-ID: <nycvar.QRO.7.76.6.1802061712430.35@ZVAVAG-6OXH6DA.rhebcr.pbec.zvpebfbsg.pbz>
References: <20180206153802.14064-1-johannes.schindelin@gmx.de>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:IY8xaLct/5BOJLZlUBRhrLv9BUXesjRBZcIqcsBiDmlQKAQKzIk
 mlgwf8ul96Eu3ZiF8kPNq98dFfTo7zB4AJl1FhCVh8mmhRCa3AAbwEn2VQBtOUclUBK/Jxo
 IjqyfXlyYY/UfUzyCqqq9faY17xkp0NuIX4bd6HzHegsU0q69feHHTjHYC1aS7LLaGf/UE7
 vEg5IDpLlfu+0p//COO4g==
X-UI-Out-Filterresults: notjunk:1;V01:K0:upKr6+n1SWo=:7EFgC+V22SwR/rIz1vOL8L
 yQlL0g0GWKhnWeM/v6kwgAnEHI74GK5RkLdCyXpHx1wclmS2oCefJRcYRbwRfgs9muAeJkEZp
 UMZo4Bq6B8N5NcDFi4uTuLyonHu9go+MbDXi0yV02tMbjD68GXAnrCNjNQcgUiASqlHJSo6RC
 w1N2R7zhhzkn+gYCik0xBpgs0gwoxqiFgh88FEKgMGGnn6pqWAMBfx6Zae0o7npF8oIYrdn/8
 2TrxNK/U3v+Mblb+u59pHlRM/LqQ8BAjsT08gFU+nt/xBF9r2PV76BSL0W4x6XZjQJ3n7xMqQ
 hxeo/CCggBfXjbDftn41HSqJHU2QqiTmhVZwtgGOd9l/ZMC50WNkLJraREr9a2RJBfpgecxqM
 cazU89siZRMHS4smiF5Nt/5IFIJ6QKgTioAlL12/0BLbqfJSjFxBx0p9/FFaxSAYPrbTqfg9Q
 1dJkQa3B8IN2VeNUCSacygebNy9mVaHNTYDw2gJgmkGo58kllhshX8x0tsXr9qBSE5bmK1+CF
 87pi+7j/asugceeoh7MjQNCTU1bPtsmW8q+coWsrjQ9bSH274rYaKv4oeNeri89wv8W4sGcl3
 J1A0xWVImwd8Qvy9+ItiDgk/7gl/rCS+qvzsu0PbuFO8yJs1KI86HPHnw3kxijhCv/VlsF8Er
 AYasYxCIbLzVMQHPedcg6JRewIPJZpEvfIoB3ApGAmKjs350RpFguRgUTr5fHwprnx38RPTga
 u7Vl3I+Krmlau3wNkTKfwqrTP+jq/CyUDroZTwgh/W7JAVCY5gTHtPEWckXygAH4K+cJyxZGs
 aQ5sfk/t0wcN8O7gVwFb8EsE3we4Z90rSZN5rtO+zhrR3rtDJ4=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Dear Git for Windows SDK users,

[This mail only concerns the *SDK* of Git for Windows, i.e. the build
environment to work on, and contribute to, Git for Windows.]

On Tue, 6 Feb 2018, Johannes Schindelin wrote:

> Changes since Git for Windows v2.16.1(2) (February 2nd 2018)
> 
> New Features
> 
>   * Git for Windows' SDK packages are now hosted on Azure Blobs, fixing
>     part of issue #1479.

To clarify what this means for any developer who wants to update or
install a Git for Windows SDK, here is some guidance.

# Fixing existing SDKs

You can fix your existing SDK (if you installed it successfully before
Friday, February 2nd 2018) by downloading either

- https://wingit.blob.core.windows.net/x86-64/git-extra-1.1.241.91af289c6-1-x86_64.pkg.tar.xz
  for 64-bit SDKs, or
- https://wingit.blob.core.windows.net/x86-64/git-extra-1.1.241.91af289c6-1-i686.pkg.tar.xz
  for 32-bit SDKs,

and then executing `pacman -U <downloaded-file>`. This will have the main
effect of updating your `/etc/pacman.conf` so that a subsequent `pacman
-Syu` will find the new home of Git for Windows' Pacman repositories.

# Initializing a new SDK

If you did not yet have a working SDK, the [installer as per Git for
Windows' home page](https://gitforwindows.org/#download-sdk) will not work
(I hope that we get all of this sorted out this week).

The idea is to support a completely new, more robust method of obtaining a
working SDK:

```cmd
git clone --depth 1 https://github.com/git-for-windows/git-sdk-64
```

(or `.../git-sdk-32` for 32-bit setups) and then call `git-bash.exe` in
the top-level directory of the checkout.

(These repositories are essentially synchronized by a scheduled job
running on Visual Studio Team Services, and the set of installed packages
was chosen so as to support the most common operations developer would
want to perform in a Git for Windows SDK.)

This does already work!

But you still have to clone https://github.com/git-for-windows/git
manually for the time being (preferred checkout location: /usr/src/git),
and maybe also https://github.com/git-for-windows/build-extra.

## Future work

I plan on doing a couple more things in the git-sdk-* repositories, and
every bit of help with those tasks will be greatly appreciated:

- add a `README.md` explaining the purpose, the most common operations,
  context and design
- modify
  [`/etc/profile.d/git-sdk.sh`](https://github.com/git-for-windows/build-extra/blob/master/git-extra/git-sdk.sh)
  so that it auto-initializes the `git`, `build-extra`, `MINGW-packages` and
  `MSYS2-packages` worktrees in `/usr/src`: they should only be `git
  init`'ed and `git add remote origin ...`, but *not* fetching anything yet.
  They can then be initialized on demand by e.g. `git -C /usr/src/git pull
  origin master`
- ensure that a regular clone works, especially 32-bit, where some of the
  files seem to be committed with incorrect line endings
- modify the git-sdk-installer to use the new method instead
- maybe add an `/etc/motd` that describes how to build stuff, how to
  bundle a custom installer, how to keep the SDK up-to-date, etc. Or maybe
  a helper. Dunno.

This blurb was copy-edited from
https://github.com/git-for-windows/git/issues/1479#issuecomment-363452826

For updates on the Git for Windows SDK front, please follow that ticket!

Thanks,
Johannes
