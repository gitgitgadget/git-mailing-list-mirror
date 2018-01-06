Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7B2071F406
	for <e@80x24.org>; Sat,  6 Jan 2018 22:01:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752209AbeAFWBa (ORCPT <rfc822;e@80x24.org>);
        Sat, 6 Jan 2018 17:01:30 -0500
Received: from mout.gmx.net ([212.227.15.15]:50001 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751399AbeAFWB3 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 6 Jan 2018 17:01:29 -0500
Received: from [192.168.0.129] ([37.201.193.20]) by mail.gmx.com (mrgmx003
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0M8laO-1ek54Y3ppU-00CAst; Sat, 06
 Jan 2018 23:01:23 +0100
Date:   Sat, 6 Jan 2018 23:01:22 +0100 (STD)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@johannes-schindelin.gitforwindows.org
To:     Junio C Hamano <gitster@pobox.com>
cc:     git@vger.kernel.org, git-packagers@googlegroups.com,
        git-for-windows@googlegroups.com
Subject: Re: [ANNOUNCE] Git v2.16.0-rc1
In-Reply-To: <nycvar.QRO.7.76.6.1801061354430.1337@wbunaarf-fpuvaqryva.tvgsbejvaqbjf.bet>
Message-ID: <nycvar.QRO.7.76.6.1801062248160.1337@wbunaarf-fpuvaqryva.tvgsbejvaqbjf.bet>
References: <xmqqbmi7ano1.fsf@gitster.mtv.corp.google.com> <nycvar.QRO.7.76.6.1801061354430.1337@wbunaarf-fpuvaqryva.tvgsbejvaqbjf.bet>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:YfS1/Us3gHH8k2glq1mFVrjPHkygI01ff7LEmrPfABBQB9g9VzH
 QqYZwb1QuuQPVdd2T+u8Cl6PWnx1o1lqdXhn/U49j06urXoSQkoyBFYAdbfon8zty0oediu
 yH/h4N3atv9XC37B8mMhEagKeO/vByN1vAA81VZm8YZ51oNxoBbxKpChqASR1skQG5KLCKd
 CuXRwlIfZEAgWzyODhzLg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:Lsua/QKxHno=:EGK6PGLxDUHjVJLGVMACI1
 BSPUf24I4qOXnhjeIhUeOsj6gDFM9D20dvylQsJfIe1OFpRdj1vOzt2Ye8K0zJWYXfq4uV088
 QayvBCH/SfthVKV5k72YsTarvxWvxw6uKR9nVqoAY86qEkr2ypS07pYtwXxOZRchyOoQHt04M
 h3kS41GgHCJejt4MkfRkbwM/t+MDNw+KxS4ur9oTDegRwtnj73vRBWxY6ChQUd5C/riJGpYw4
 lLQvwCKXw29LRUUb50OnpCNlfCW3jX1m48H+2Fp82W/bUFuo2NaPhjBwG1Abj5o+R17EKPZnd
 6KoQJzbvX2MmORhpUMtjEa8GVp9Y/q2OOJW654c0yzQwiUCxV7Dh/34whqVKCBkkhVh0YyK0c
 dPS5FAWIj+KtePu6dRoPdKimsp7k14TxYEDN64PxIY7UNzBoCrsxO7PDhBe35w1T6JAq70YSh
 XFkEFa6wXpmXvGdaeItYsiHThOHg6zLp83w2P7KhGE48idSrER06P1BUFrx8u8bg3OsQkKrT4
 Y8koq6qUVShJeoxHHmoNTd+IkfJwiT2lZU9HOk289DQhGbXgXjIeDoMxv9hxb4vkXYwZ/6yjm
 VCePERudXI6NPwAj24+mX2yT9pNzEndr6ER/sItHOxw2BgL9QTQ33RyeibroePm6m7z3zzKUI
 jAFrjUEP2oZUvRZ5pFVVZxYeFLHimQ/CSjqH/4gv/tZIWYOebvcvaEnj+DhKnNB0vUhkmRAJF
 1KdMwwRZD/6cTW1nnFNw7+ga/0wPXC5SzOnCGINoY9ekDHwvMVBR37WVqTUbp+XUvwo87ODqG
 wkR00i8IZ0fhSjPjsJIJwSFyHr4DEVNI2pKdSyA6jP6fbBUfbQFaNJjudq2VXlJaoK/E2YD
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi again,

On Sat, 6 Jan 2018, Johannes Schindelin wrote:

> On Fri, 5 Jan 2018, Junio C Hamano wrote:
> 
> > A release candidate Git v2.16.0-rc1 is now available for testing
> > at the usual places.  It is comprised of 455 non-merge commits
> > since v2.15.0, contributed by 79 people, 23 of which are new faces.
> 
> I rebased Git for Windows' thicket of patch series on top, and I already
> got this when running t0021:
> 
> 	# failed 10 among 26 test(s)
> 	1..26

I actually was able to figure it out: it was the GITPERLLIB problem I
described earlier, where we run (once again) into trouble with Git's
expectations that everything behaves like Linux, including colon-separated
path lists.

The test suite passed, so I kicked off a build which should be available
soon at:

https://github.com/git-for-windows/git/releases/tag/v2.16.0-rc1.windows.1

The patch to work around the GITPERLLIB issue looks like this:

-- snipsnap --
Subject: [PATCH] mingw: handle GITPERLLIB in t0021 in a Windows-compatible
way

Git's assumption that all path lists are colon-separated is not only
wrong on Windows, it is not even an assumption that is compatible with
POSIX.

In the interest of time, let's not try to fix this properly but simply
work around the obvious breakage on Windows, where the MSYS2 Bash used
by Git for Windows to interpret the Git's Unix shell scripts will
automagically convert path lists in the environment to
semicolon-separated lists of Windows paths (with drive letter and the
corresponding colon and all that jazz).

In other words, we simply look whether there is a semicolon in
GITPERLLIB and split by semicolons if found instead of colons. This is
not fool-proof, of course, as the path list could consist of a single
path. But that is not the case in Git for Windows' test suite, there are
always two paths in GITPERLLIB.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 t/t0021/rot13-filter.pl | 17 ++++++++++++++++-
 1 file changed, 16 insertions(+), 1 deletion(-)

diff --git a/t/t0021/rot13-filter.pl b/t/t0021/rot13-filter.pl
index f1678851de9..470107248eb 100644
--- a/t/t0021/rot13-filter.pl
+++ b/t/t0021/rot13-filter.pl
@@ -31,7 +31,22 @@
 #
 
 use 5.008;
-use lib (split(/:/, $ENV{GITPERLLIB}));
+sub gitperllib {
+	# Git assumes that all path lists are Unix-y colon-separated ones. But
+	# when the Git for Windows executes the test suite, its MSYS2 Bash
+	# calls git.exe, and colon-separated path lists are converted into
+	# Windows-y semicolon-separated lists of *Windows* paths (which
+	# naturally contain a colon after the drive letter, so splitting by
+	# colons simply does not cut it).
+	#
+	# Detect semicolon-separated path list and handle them appropriately.
+
+	if ($ENV{GITPERLLIB} =~ /;/) {
+		return split(/;/, $ENV{GITPERLLIB});
+	}
+	return split(/:/, $ENV{GITPERLLIB});
+}
+use lib (gitperllib());
 use strict;
 use warnings;
 use IO::File;
-- 
2.16.0.rc0.windows.1


