Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.1 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4BA48203BD
	for <e@80x24.org>; Sat, 16 Jul 2016 09:20:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751435AbcGPJUW (ORCPT <rfc822;e@80x24.org>);
	Sat, 16 Jul 2016 05:20:22 -0400
Received: from mout.gmx.net ([212.227.15.19]:55465 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751017AbcGPJUT (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 16 Jul 2016 05:20:19 -0400
Received: from virtualbox ([37.24.141.198]) by mail.gmx.com (mrgmx002) with
 ESMTPSA (Nemesis) id 0Lbuo0-1aysO32QcO-00jLMg; Sat, 16 Jul 2016 11:20:15
 +0200
Date:	Sat, 16 Jul 2016 11:20:14 +0200 (CEST)
From:	Johannes Schindelin <johannes.schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:	git-for-windows@googlegroups.com, git@vger.kernel.org
Subject: [ANNOUNCE] Git for Windows 2.9.2
Message-ID: <alpine.DEB.2.20.1607161120030.6426@virtualbox>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: multipart/mixed; BOUNDARY="8323329-484531525-1468660815=:6426"
X-Provags-ID: V03:K0:Re+9P/n/NovPDEzvEfPjUoElfwk3G97i0RIBJebmAhVTDjn7b2Q
 4Ns3luRQvngZ0AO6PTM5Rz0oAgiYijJJg2hDsP88t+kUkBWFQCpP0XlE5OLy+vEEpGo6Y8c
 Xltd6LFEmf80SwBMApiwSo+FY0Y2+ApOWrIcvG0lVgyjkqbg1dOsF5hHanDEvmMBjCvgUa5
 nhQW56OhRNG8eWofiMy5Q==
X-UI-Out-Filterresults:	notjunk:1;V01:K0:2EirVUSYzUk=:Oeu7hoaYnKlxG1Ta30cQ9O
 gKtJuNOCsH03cxegns96EAvL4WucBG3zmZnnudFcwjMJhKBnZpOKKtnR9tVYk5wy+lbpjCO17
 is58MNCaiNW8IYuabDZdI5ZZskxxzv7w1/1cwdaO09N022YhROZuV+frXo9uHtNcJECOIfw2W
 jV1ebnJjYL9nGGJ60dv5cnfZvv+QRiAn/M8GdeQ5dtW7QfitRf3hHlVavYvXKXb2vR24So9QG
 lpOr2afXk/eFLmGL1efoacA+21wHEKt4uxz71+S+30Wxx3PxoEKznIBGqCeakhOFblmr8R6K/
 MalsRrGBQ8cCVlXHDK5Km+jyhr97g1kGcMdJzyLrfz/mHPgATw/FFYp52Vjwu2SifiB2Bo5f4
 2VwXpHxS3Ehy7Gw551sBdgm+MGqg+AtPRJwuHT8F0TaKhYxrsmiojsJja9qxdsxEswBEsQ0Wa
 zpxN0TLARCLd/KPbGQhkiX113kJ5UohPbqHEaZ/RfrLP66OKe3XkWuDWreLGr2ZsxVxhqr1ms
 nXMEf2ZmKqLhpx4OyXz1ULrTkBEYx0TlrdGGGsQKLkMdjywhSMff1sFJoBFiKpTzqkAFU3oac
 4VqWpphjmKKiZjnQhviG4ePveodrH8yR+xl70mNr3mtO8lZCbU5ZQHHvMGmgUWaDKWy/wiIoF
 kU65sDjAj+8YLVKxkKZpRoqOKu5oUyXUwibLpfCiUHO5swkr4IQTEEYefQxZZz4eM4K6tvn2I
 5pdY+frlU/yZPX426siwOmqNwfTb4UrfuxXWF5D9OkiZmK8OSW9gCjxKtF+7pZ2+ikuwLVpF8
 H5D1aGp
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-484531525-1468660815=:6426
Content-Type: text/plain; charset=X-UNKNOWN
Content-Transfer-Encoding: QUOTED-PRINTABLE

Dear Git users,

It is my pleasure to announce that Git for Windows 2.9.2 is available from:

=09https://git-for-windows.github.io/

Changes since Git for Windows v2.9.0 (June 14th 2016)

New Features

  =E2=80=A2 Comes with Git 2.9.2 (skipping the Windows release of Git 2.9.1=
 due
    to a regression caught by the automated tests).
  =E2=80=A2 Git Credential Manager was updated to v1.5.0.
  =E2=80=A2 The installer will now refuse to downgrade Git for Windows, unl=
ess
    the user assures that it is intended.
  =E2=80=A2 MinGit, the portable, non-interactive Git intended for third-pa=
rty
    tools, is now also built as part of Git for Windows' official
    versions.

Bug Fixes

  =E2=80=A2 When git bundle create is asked to create an empty bundle, it i=
s
    supposed to error out and delete the corrupt bundle file. The
    deletion no longer fails due to an unreleased lock file.
  =E2=80=A2 When launching git help <command>, the help.browser config sett=
ing
    is now respected.
  =E2=80=A2 The title bar in Git for Windows' SDK shows the correct prefix
    again.
  =E2=80=A2 We no longer throw an assertion when using the git
    credential-store.
  =E2=80=A2 When configuring notepad as commit message editor, UTF-8 messag=
es
    are now handled correctly.

Filename | SHA-256
-------- | -------
Git-2.9.2-64-bit.exe | 006d971bcbe73cc8d841a100a4eb20d22e135142bf5b0f212072=
2fd420e166e5
Git-2.9.2-32-bit.exe | d8b5d67dc4859a05254f36e61dcc4bfcffd7e6201c940bb94fb2=
b502c5dd8e7c
PortableGit-2.9.2-64-bit.7z.exe | 4319caf04f6e9b7bc4916660ce918e1d26cfc1c6a=
e5d19981d7ccab166117aca
PortableGit-2.9.2-32-bit.7z.exe | d023e37c5e54d46900af4879e786ad107611ec937=
3fa348450fe844ab125a0a1
Git-2.9.2-64-bit.tar.bz2 | 292d897d54d864d4b819e25a9773d067310d7890014567cd=
8e44d2028c583102
Git-2.9.2-32-bit.tar.bz2 | b530185c69d9ae4758087de04da706d887e35b94a12e9c08=
8324833818a06a46

Ciao,
Johannes
--8323329-484531525-1468660815=:6426--
