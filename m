Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 467951F87F
	for <e@80x24.org>; Tue, 20 Nov 2018 20:57:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727280AbeKUH2U (ORCPT <rfc822;e@80x24.org>);
        Wed, 21 Nov 2018 02:28:20 -0500
Received: from mout.gmx.net ([212.227.17.20]:54281 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725903AbeKUH2U (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 21 Nov 2018 02:28:20 -0500
Received: from [192.168.0.129] ([37.201.193.149]) by mail.gmx.com (mrgmx102
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0M5IdH-1fVzpo0qnn-00zWcE; Tue, 20
 Nov 2018 21:57:11 +0100
Date:   Tue, 20 Nov 2018 21:56:54 +0100 (STD)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Junio C Hamano <gitster@pobox.com>
cc:     git@vger.kernel.org, git-for-windows@googlegroups.com,
        git-packagers@googlegroups.com
Subject: Git for Windows v2.20.0-rc0, was Re: [ANNOUNCE] Git v2.20.0-rc0
In-Reply-To: <xmqqh8gefowy.fsf@gitster-ct.c.googlers.com>
Message-ID: <nycvar.QRO.7.76.6.1811202152290.41@tvgsbejvaqbjf.bet>
References: <xmqqh8gefowy.fsf@gitster-ct.c.googlers.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-348937918-1542747431=:41"
X-Provags-ID: V03:K1:qgj0l9Mbi8whdZwDjq370v3wi9XLVM8MLleStqgt4oQcZwxKH5F
 6BpVbn221wQFRMpDD3degJfBN6yXzwgi2DbJIcYmgSikLivku5GAosSnJRsjKVRzt9EjCTJ
 gehk7aCfypu9UGN2jiz1xOQ0AHVqzfOJLsSZL94kmPhB9kJ/e1kpU4Tg7S5tD16IYGZQJ9M
 e+0b27YcgVFrRwpxGvjGA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:sMBWS63lWTU=:MEfXPtSoxyEDHTRDbbFJcg
 tYi6fKbt3UpSF7xARCfKunWqQGmDrWIFc+AHu4HUVcHJOgsI8FHc8wNfJfMB0ZQEFO2dC/K6l
 1gmxmdYIus2OKXpaa6kgWLl3GO4w5eiRq/tS4x6Hn+aGet2a+0r9i/NLQViH4Gb+3lParJln/
 y6n487+LannJwMQn8ka5aGf9ztg6U+MpYgdoKCJNrN8SqIfhyJXrckRG7c0YDtyibSqlGduoL
 vyrBIt8NtOxXXr89vqJDzFQV9bSiMgawKGLnYr6hEMO7QT1KREco5/ApcWFI+53rTOxQPh6Jd
 UG6R81pp59w1ZIjUb4d0bW0vbU/e1ScXyNJa4SPwmguzeGGi5Iprp1H4oqcimRuDsf8naaRoU
 SWDuLejV7P/WMuuohRWBBpXr7Ysoppexj03z/2V891tpXaewkKcDbq2vbqg6oy5rdnHdsNffo
 Df3bDYlGz0fpJWACSwP0LM8aiu1mAKvJd/m+0+cY0jMoGbv+IVIZl+QiHkz/winglE2tpx6Nf
 90Vn04y9B/eVgVUcVoVh0nzz2nww/XKL+Gh2HLUW/95UJebsfpD/RFqmTB9FIjakvdGHx/xmb
 xGI/qslBC1+KpMizCW5yF1VWFCljUvv4p+2UtGM0j5Iof2tfcL8q2tPSoA3Hx4xfTlqcyBSRX
 D3PG/5sOXpLwoOdaLNWm56dceyUXbRIpfLOdy1Z7ewhhgr/5rOiQBXZNufC25Cka7pB/zKl2U
 +/sgr9Kn0NOCCiJ6ZPfejyM8i5dcg/zwEtz6CLQQKjPZxhpWvLYyHj+LfE8frgUPtbyO+Sd8s
 OSSbm3VrtrcRoAW9rEdcXr3ftXA65cP/ep0eNw6LMmG8uYX7ZU+llZ5gdhl1K8t6mDdp6y7PF
 SFgeDAASvc2iopmR/6aleDTJMdFLsKVdVRVTLIwb1t2WynEAi1s7rcFXQV8gZ2
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-348937918-1542747431=:41
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT

Team,

On Sun, 18 Nov 2018, Junio C Hamano wrote:

> An early preview release Git v2.20.0-rc0 is now available for
> testing at the usual places.  It is comprised of 887 non-merge
> commits since v2.19.0, contributed by 71 people, 23 of which are
> new faces.

The "for Windows" flavor of Git v2.20.0-rc0 is available here:

https://github.com/git-for-windows/git/releases/tag/v2.20.0-rc0.windows.1

The current change log for v2.20.0 reads like this:

Changes since Git for Windows v2.19.1 (Oct 5th 2018)

Please note: Git CMD is deprecated as of this Git for Windows version. The
default is to have git.exe in the PATH anyway, so there is no noticeable
difference between CMD and Git CMD. It is impossible to turn off CMD's
behavior where it picks up any git.exe in the current directory, so let's
discourage the use of Git CMD. Users who dislike Git Bash should switch to
Powershell instead.

New Features

  • Comes with OpenSSH v7.9p1.
  • The description of the editor option to choose Vim has been clarified
    to state that this unsets core.editor.
  • Comes with cURL v7.62.0.
  • The type of symlinks to create (directory or file) can now be
    specified via the .gitattributes.
  • The FSCache feature now uses a faster method to enumerate files,
    making e.g. git status faster in large repositories.
  • Comes with Git Credential Manager v1.18.3.
  • Comes with Git LFS v2.6.0.
  • Comes with MSYS2 runtime (Git for Windows flavor) based on Cygwin
    2.11.2.
  • The FSCache feature was optimized to become faster.

Bug Fixes

  • The 64-bit Portable Git no longer sets pack.packSizeLimit.

Thanks,
Johannes
--8323328-348937918-1542747431=:41--
