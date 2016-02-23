From: Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: [ANNOUNCE] Git for Windows 2.7.2
Date: Tue, 23 Feb 2016 16:17:58 +0100 (CET)
Message-ID: <alpine.DEB.2.20.1602231617450.3152@virtualbox>
Mime-Version: 1.0
Content-Type: multipart/mixed; BOUNDARY="8323329-10721325-1456240679=:3152"
To: git-for-windows@googlegroups.com, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Feb 23 16:18:13 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aYEj6-0001Rf-1q
	for gcvg-git-2@plane.gmane.org; Tue, 23 Feb 2016 16:18:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752771AbcBWPSF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 23 Feb 2016 10:18:05 -0500
Received: from mout.gmx.net ([212.227.17.21]:54822 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752530AbcBWPSC (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 23 Feb 2016 10:18:02 -0500
Received: from virtualbox ([37.24.143.82]) by mail.gmx.com (mrgmx102) with
 ESMTPSA (Nemesis) id 0MMpYB-1aa8wB04w3-008XXB; Tue, 23 Feb 2016 16:18:00
 +0100
X-X-Sender: virtualbox@virtualbox
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
X-Provags-ID: V03:K0:qJj7nthlUl6ilz3epgy0t9gxL3sAoNIL3oAlSwbgjU8lNhZ/Emv
 W++rjRVFmbAZWwSiFBy8xWqWdUK3zKyBPwccD+ePM9eXzll27HyAxS1cdMpH32zT8XzTjEk
 mxtAj32sJfYbYo8kXzz56I+Oajw+xHSVCX2ljooqTxD9pizbFDnHmIkSsxlf0bvjVLQxOZG
 Yq+OuNEOMyQq2nvXXx/PQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:fQ/2smCZUos=:sGWOtRefa9gGvvC0lMzkFB
 TXSnIVJpWmWvgZHddxqivWY01ZTeG1q37a6t4hF+SxCSSKq2sv64BPYauGz14TOkqIZ6co4dQ
 pBEESwueOhvylzhZQwbeMN/8Go2U3D123B9kaJod55rVDchdl+bks6olshkJqP06rDc0Qg3hc
 SfqmeX4y3nNYXALDWu1d30ntlkAIp1nhCWpomgufireGapGmRGbh+bOaS3e8wbjjw6O9Rrbky
 3ftBiLtCxKkXabu2n0odhGSQRuYBLtLz47KEG5zjcltEPszFjNgGYZoEWscL4Xx20eUhcE1/1
 x6rIKebSMkMhEdXfeyYqcbQ21Uyt3ETZopHVG1JxodYbao3w17myT5kGtqTJQYsprrqf30hLe
 GFKSbDNfJTX3kUv4XBX7AA/qTmskJ1eFWa4qVe8mOviCk8aLPRfpR9DpwFLNLMgyF6KLMtCRu
 8+6vEhHJMABnN8F5GhsoB/2ehL8xdsBkcaxfXl9gV1d9Pp6uiz923/qr4fHSkg0bnvr9J23pm
 SZIsKkcUWFms5CAsOcvgrF/8kXYv9SRkV5JLpggUXikYEgLVpfpGdt9V6Ir/i+Ld71ldhDT/x
 2hjrpNEFe7c2lyCod+CQA87ZUYetBC4oA9m87W0Lp7Dbtf7o2ZjzKApt92B4J2VaAqNo+b343
 Sg7wJKb/QhtBgHiLhXvIy48RWKvR+ECoR7BFfmcFo18WNU1ybvmnMdYvri3G1gGbUXovsIBmV
 ZphHyVREKCOd4CiNSaKsUQcaU5zB3mVxMlVNt13IkPp4mwSEQlJFfHZzGXKKt4ZVVkyL801P 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/287081>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-10721325-1456240679=:3152
Content-Type: text/plain; charset=X-UNKNOWN
Content-Transfer-Encoding: QUOTED-PRINTABLE

Dear Git users,

It is my pleasure to announce that Git for Windows 2.7.2 is available from:

=09https://git-for-windows.github.io/

Changes since Git for Windows v2.7.1(2) (February 12th 2016)

New Features

  =E2=80=A2 Git for Windows' SDK version 1.0.2 has been released.
  =E2=80=A2 The "list references" window of gitk is now wider by default.
  =E2=80=A2 Comes with Git 2.7.2.

Bug Fixes

  =E2=80=A2 The user is now presented with a nice error message when callin=
g
    node while node.exe is not in the PATH (this bug also affected
    other interactive console programs such as python and php).
  =E2=80=A2 The arrow keys are respected again in gitk.
  =E2=80=A2 When a too-long path is encountered, git clean -dfx no longer
    aborts quietly.
  =E2=80=A2 Git GUI learned to stage lines appended to a single-line file.
  =E2=80=A2 When launching C:\Program Files\Git\bin\bash -l -i in a cmd win=
dow
    and pressing Ctrl+C, the console is no longer corrupted
    (previously, the bash.exe redirector would terminate and both cmd &
    Bash would compete for user input).

Filename | SHA-256
-------- | -------
Git-2.7.2-64-bit.exe | ec4009b36ce855ab262f999030fff5471de73cf0071202138d39=
5648756c7e8b
Git-2.7.2-32-bit.exe | 7b432c88fa7ced6a89670e9672279e875361651a0abcddbac6fe=
a64a1a168022
PortableGit-2.7.2-64-bit.7z.exe | 774e18aa40a35ce5f3c0002038937e341c625292c=
474641c8c936822ef77e949
PortableGit-2.7.2-32-bit.7z.exe | 26d1e4a290a5741bccc944684a2ffc664676ccc95=
71e6077d1b8ab40a31fae18
Git-2.7.2-64-bit.tar.bz2 | b292c68ede2b526db47692ec086b7eea61371bc9548c70e1=
9f25f8625bd87242
Git-2.7.2-32-bit.tar.bz2 | d9c2cbae64f3c581b497d2adddfa70502ae18436a222d481=
7c0597c889ee8d09

Ciao,
Johannes
--8323329-10721325-1456240679=:3152--
