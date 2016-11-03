Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.7 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id ED7A02021E
	for <e@80x24.org>; Thu,  3 Nov 2016 15:15:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756416AbcKCPPK (ORCPT <rfc822;e@80x24.org>);
        Thu, 3 Nov 2016 11:15:10 -0400
Received: from mout.gmx.net ([212.227.17.21]:55465 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750970AbcKCPPJ (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 3 Nov 2016 11:15:09 -0400
Received: from virtualbox ([37.24.142.40]) by mail.gmx.com (mrgmx103) with
 ESMTPSA (Nemesis) id 0MfmZs-1cGWf02DTg-00N8C5 for <git@vger.kernel.org>; Thu,
 03 Nov 2016 16:15:06 +0100
Date:   Thu, 3 Nov 2016 16:15:05 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     git@vger.kernel.org
Subject: Help with vger's rules, was Re: [ANNOUNCE] Git for Windows 2.10.2
In-Reply-To: <alpine.DEB.2.20.1611022158140.3108@virtualbox>
Message-ID: <alpine.DEB.2.20.1611031554100.3108@virtualbox>
References: <alpine.DEB.2.20.1611022158140.3108@virtualbox>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: multipart/mixed; BOUNDARY="8323329-264901697-1478186106=:3108"
X-Provags-ID: V03:K0:hvtE017sbY+Uv9KiLlULAnCZ+Q4uj3fNKCPm/UJHU9EhCm7uWMV
 35aEVuyK6z9rMrjKEiCm/cEchvocNbp0u+W71mQbL/La12OuZrVhA/to0qtwR1JPklTC3eD
 BR+lVZODWDzaQxgDOXyAzDkUdrpg3P8Vj8T7M7g1os2ZBjpL3RT7N7U3yZTov8ccJKut7jn
 chUcdIAaJdLBNJ5U/+3iA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:y/wch2XMnhY=:kVKvKi10g9k/XWabPDVTTi
 bcRBer+XMvGaicPJAA26b0mwGCWl/W5wvvfHKNN3r+hcu1ZLUKl/fpgU+OSw/0psyGgUF21wb
 iMk+1agBKE/EfdDDy0/P4RpcHzuwSVYerzZyNOLGWk71IRTaf8zkMmXSfH1o+FTNSDLQgnjKF
 uGuglN010IXDsSyGL/RB5LQrc6hwpHOjwcrbhDUdPx45QSq8LKA2NT1kT6H24i52OWoM4lR1r
 Nu7w1R8H02b/ywLXB5E43re2h5CZEGywgLKelmWROWfIagRS1mAGcHbsOt4K+h98lxakN2ptW
 alkth7MsQLutxZ35gBUFZ7NzUaVXVbvNtIOTl7/3QHm0OwY7t4mbxeCtwEypXDnJfkU0LwA3K
 aoDkL/t777vzN+GjiVWe4TWZWE6ULftxl3OOc7FNryoKevNaL9PnzVJTWlWUd13KImOZSvu+/
 8p0xA+RRjeYbtxDLVNT4Qpe6OpP87kRVJ0n0nSD97/WTa7DrjAVerud84xqI7vm9DKU6LN8a+
 JsSSL1PsUKOIgK1wpFJsf5DKDm1kYkoQcUz8qWulhnRtkqxCFZ0uDq5i+6OspNW8h7FK3YChT
 YNmNbzUXIRrtDCfccdUBGAKe5pLb6K71V5JdOaanI/di4M6y3Ras1v1Fyc3OQoa6Nxr4Bg7og
 0PMJS36U8y51HGZOOwHr16cbSFSegrguaGs0F5JOfaS1di7NWtaTiYKc42c9M/bskmaCpPdnW
 unjWDh/sWzhkYCH5Tcffcyw+Tj5+/gqUabwkomJoozthfA/JtnDt/1ClrhqI4bSbEiknqot6v
 dabTEJF
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-264901697-1478186106=:3108
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE

Hi all,

On Wed, 2 Nov 2016, Johannes Schindelin wrote:

> Dear Git users,
>=20
> It is my pleasure to announce that Git for Windows 2.10.2 is available fr=
om:
>=20
> =09https://git-for-windows.github.io/
> [...]

I originally intended this to be sent out at the same time as the
announcement to the Git for Windows mailing list, finally in an automated
manner so that I do not have to sit by the keyboard waiting for the
uploads to finish (every new Git for Windows version is bundled into 9
different distributables that all want to be uploaded).

But.

When it finally sent out the mail, and I thought everything was alright,
thinking that I could turn out for the night with a well-deserved drink, I
got this from vger.kernel.org:

-- snip --
SMTP error from remote server for TEXT command, host: vger.kernel.org (209.=
132.180.67) reason: 550 5.7.1 Content-Policy reject msg: Wrong MIME labelin=
g on 8-bit character texts.
-- snap --

Is there *anybody* who could give me a clue what this means?

For the record, I tried to use `git send-email` to send out the
announcement for the very first time, and the headers of the mbox file I
fed to that command read thusly:

-- snip --
From=202.10.2.windows.1 Mon Sep 17 00:00:00 2001
From: Johannes Schindelin <johannes.schindelin@gmx.de>
Date: Wed, 02 Nov 2016 21:43:54 +0100
To: git-for-windows@googlegroups.com, git@vger.kernel.org
Subject: [ANNOUNCE] Git for Windows 2.10.2
Content-Type: text/plain; charset=3DUTF-8
Fcc: Sent
-- snap --

The only problem I could *possibly* imagine is this UTF-8 bullet character
used in the enumerations in the mail body:

=09 =E2=80=A2 [...]

FWIW I like that bullet very much, even if it was not my doing, but w3m's
rendering of the release notes [*1*].

I would really, really, *really* like to keep automating things to make
the release engineering of Git for Windows more painless and boring, but
this thing, this unhelpful vger error message is blocking me from doing so
right now.

Help, anyone?

Thanks,
Dscho

Footnote *1*: The release notes are actually written using Markdown:
https://github.com/git-for-windows/build-extra/blob/master/ReleaseNotes.md
Those release notes are then rendered into HTML when releasing:
https://github.com/git-for-windows/build-extra/blob/4d6097f/installer/relea=
se.sh#L86
They are also rendered into nice-looking ASCII via HTML by using both
Markdown.perl and w3m, for use in the tag message:
https://github.com/git-for-windows/build-extra/blob/4d6097f/please.sh#L1063=
-L1066
Same procedure is used again (to allow for very, very last-minute changes,
such as the inclusion of Git Credential Manager v1.8.1 late yesterday,
just because I still chased a bug introduced during the high-intensity
installer patching bout last Tuesday) when announcing the new version:
https://github.com/git-for-windows/build-extra/blob/4d6097f/please.sh#L1580=
-L1582
--8323329-264901697-1478186106=:3108--
