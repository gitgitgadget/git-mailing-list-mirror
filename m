Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3F0AF1F404
	for <e@80x24.org>; Mon, 19 Feb 2018 12:28:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752709AbeBSM2G (ORCPT <rfc822;e@80x24.org>);
        Mon, 19 Feb 2018 07:28:06 -0500
Received: from mout.gmx.net ([212.227.15.15]:57605 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752657AbeBSM2F (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 19 Feb 2018 07:28:05 -0500
Received: from [192.168.0.129] ([37.201.195.115]) by mail.gmx.com (mrgmx003
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0M9JYE-1euwcc1nMU-00CiDn; Mon, 19
 Feb 2018 13:27:56 +0100
Date:   Mon, 19 Feb 2018 13:27:40 +0100 (STD)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@MININT-6BKU6QN.europe.corp.microsoft.com
To:     Bryan Turner <bturner@atlassian.com>
cc:     git-for-windows@googlegroups.com, Git Users <git@vger.kernel.org>,
        git-packagers@googlegroups.com
Subject: Re: Please test Git for Windows' latest snapshot
In-Reply-To: <CAGyf7-GK+HgYx0AjRQXPhbxNTaohN1K2NFf3eWPjLsxHC6CvtQ@mail.gmail.com>
Message-ID: <nycvar.QRO.7.76.6.1802191326350.31@ZVAVAG-6OXH6DA.rhebcr.pbec.zvpebfbsg.pbz>
References: <nycvar.QRO.7.76.6.1802170018250.31@ZVAVAG-6OXH6DA.rhebcr.pbec.zvpebfbsg.pbz> <CAGyf7-GK+HgYx0AjRQXPhbxNTaohN1K2NFf3eWPjLsxHC6CvtQ@mail.gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:WfUYDShZaX1X586CLnFzNYB1gv1Tqt/MywitmorDMDIqOYiDrTG
 rsG8Pm9xrM+e7P+BzSD2pYwsvtp7WSimsyEWvRmz0Gg111qEkmupBy20S9ENTWcTg52SjRu
 zT9hYo9DsrG3dA1Bo1yzaih8Zt7Se9MgA5R1HKzBhZILQl3LK5VtgL5IB4fh4RaU2dfu123
 /lORn/gic2L5vQ4PO+4MA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:6gtfcvpTnaU=:Y/PXGpA4DAAWFEI1QyYA3h
 Ra2q0t2/QVdlBP3WpTknbm3G6tSAHdOereuwknr4VQCU9ESev3gNN8iN3e2UNOPekAgiBNfvi
 u+JbrCISmX61WdD4ErQywIiM7kqRecJ+cfI5SHwZbGNatQbGznLhw4B8/dCQCSR9GkeB5rspo
 EH1+N1VUTROWcJ0PYkt4qahj2CFtWHXIO/aZ7swZKjMEoDevBe8oGB/IZ+jZ65Wn7BsBwOo0f
 uNmmmwfkQ9HVQNjWULexuqN+xHGO2LI1Pe69yB2K8um9gAjfn1vrIyXNL4IsqUcrzelTvzzXk
 yKJTMfEpuHJEYCd5KQrE+RwJQG1j8TBABP0V19KCb63VBCcsTIbynftB58QoYcJ4Zk+s4tQ3R
 VPQ6AOYxijbpIemCE8Z+wtiTDqhqSYMfUy+IJyVEha3qBIERegw005WjGM4nNffLfdiGYK+ki
 WoYbYBLTpepKO1IKXfG8+wxP/K8fc6zj0zWTPcocFI5v7eOIsP7X15VVtJx4pMYnFdOiQhnRs
 klCXM05sBX2QoZQVjsHgABWUG/lcFE/HQfuwfQ7AQtnJHBvK03F/0k0Uw9W25ySK17h/G/IsL
 Q8xNvveJ7RLlKT/MSEe4hFMqEvBAUSiY3xo7wlnQKJYBScoP1XLKAAGKZ/fQ9+RpcbB7qt8k5
 7IGVJZ0QnFJzXSFIiMz7SumQqNJJBO3mvTFur+ITuGVZnuKDEzIQRnZFFNN0yMeywbAe6GeWv
 XJDSVmDfgMrGiteJhM73SsPQf07TN8N1A1kir1ls717DJVk5n5tKG1lslGKyXGhoOctJ1asUZ
 s+2psfbUGenbKwnGqK/zNntDLWT6CLRe0DcWS8WuXk8qlBM/vw=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Bryan,

On Fri, 16 Feb 2018, Bryan Turner wrote:

> On Fri, Feb 16, 2018 at 3:30 PM, Johannes Schindelin
> <Johannes.Schindelin@gmx.de> wrote:
> > Hi team,
> >
> > I am unwilling to release Git for Windows v2.16.2 on a Friday night, but I
> > have something almost as good. There is a snapshot available here:
> >
> >         https://urldefense.proofpoint.com/v2/url?u=https-3A__wingit.blob.core.windows.net_files_index.html&d=DwIBAg&c=wBUwXtM9sKhff6UeHOQgvw&r=uBedA6EFFVX1HiLgmpdrBrv8bIDAScKjk1yk9LOASBM&m=xZghHWteeNbJ2bu5ySDq9WwqnfX8X7FZ_CWsV9gAyJU&s=NzSYCFSWWokPP9A9FA_EmJO5yu8qtRKw5M-Ep_qooUc&e=
> >
> > That snapshot brings quite a few updated components apart from Git proper
> > (such as an updated MSYS2 runtime), and I would love to ask y'all to give
> > this snapshot a proper "tire kicking".
> 
> I've run Bitbucket Server's full Git test suite (~1,500 tests) against
> the Portable Git snapshot (e1848984d1), no failures to report.

Thank you as always!

Sadly, another user found out that `git svn` is completely broken in the
32-bit versions, and that's what I am trying to figure out right now. Not
a problem in Git itself, of course, but in the way the Subversion Perl
bindings were built.

Ciao,
Dscho
