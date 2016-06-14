From: Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: [ANNOUNCE] Git for Windows 2.9.0
Date: Tue, 14 Jun 2016 13:17:15 +0200 (CEST)
Message-ID: <alpine.DEB.2.20.1606141316530.22630@virtualbox>
Mime-Version: 1.0
Content-Type: multipart/mixed; BOUNDARY="8323329-1563245596-1465903036=:22630"
To: git-for-windows@googlegroups.com, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jun 14 13:17:40 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1bCmLT-0003c5-Mc
	for gcvg-git-2@plane.gmane.org; Tue, 14 Jun 2016 13:17:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751212AbcFNLRU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 14 Jun 2016 07:17:20 -0400
Received: from mout.gmx.net ([212.227.15.18]:56079 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751140AbcFNLRT (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 14 Jun 2016 07:17:19 -0400
Received: from virtualbox ([37.24.143.84]) by mail.gmx.com (mrgmx003) with
 ESMTPSA (Nemesis) id 0LmKag-1blHoc0JoQ-00ZuNZ; Tue, 14 Jun 2016 13:17:16
 +0200
X-X-Sender: virtualbox@virtualbox
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
X-Provags-ID: V03:K0:/l9nt4VLw0HovMS/XrHajYV4uRJ6sT0uhH5c3LUzGpWQ2OgboQ2
 rT2wBthffZ30wdJPeT8zyNxjY+ZXktFNx+LxWJfhcmAOUS2U0WF+Td0MWLVbAGDjrqp7szQ
 iJkQm3QJzKJRu24MyMrnP9DX7toYARwR8lEGTpmOqW0ifMO4sHk7qVMJ3/w1gQi/xFguJzn
 Lts/GR1bC+LUvGFb61cjQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:V4R15K1D/7I=:YI7HffyGw51xHvuc5lUKp8
 s0wbOFrQ++OkIwJ3xqM03qOl1y9QVaANwDiaaxIgJbBuzislEe7kd+7LXaeL3S76QTabOeb3p
 ucxHQ9RMuAizkB9TshJ1UjboTDnk2IdG5zr7nmUVZWAmYc9HsbtWxy4JBYIHbRC51MFh2BsUv
 fhX3wGzBzEuyQFxi/HS6xRKANhPg1zlasybPC0kDea+HMLOX+N5gysAy2DUQLPPhQTf0wR8y9
 GbLZ5SY47A2QKZJgA4PPCJFxj7jYXCdKDK34kc3KwjELdj5Bpjos4py4nps5Y6hJOsbvrH8qo
 jz2ghapjmYII5oQccadUHD9+dLNB62ckfqUquTnwkDh0oCthILLwVHMXIzLrWQSi5PpKCHOc/
 dy1xEMyl/Ub72Cs86mLYlYJWmPRIuCJWuP9l5wfl4+sONOx0FPJhkeW9hsBs3CHZ5PjuyoRCw
 rm3TQoa6Vdr4UZGieFSFMSVdLd2tTX/ob6c/nE+GwAtFXGaMVfnD4HrCbT0m3MoZKarQZZO8u
 MDjCltQ9jbW5ksZPcY1Rcf/5Z75DMlQFPcFgLTtq7HSZ+9K9QspSlWDoo6sAnKENUx0GWjKBT
 CAzKb5H2MmBfEFEbBSpYQ5CCwim790kpTaJ8Qqc6sIiKHQR+qBtXmplyldbIVQZUDQakyRUHa
 9s/EYZRjAby0mDJEv+mtaiKk1NqmcHN8z3bJaER9rrlkE3w4N9XPS/mZgvWib8sPddFRC0JMZ
 vEGetBfyRKdH5FhH/nBlbAJgmRIHNjv4spZ2h8yM69GkFmu7Ug6qAcpv7r/VVzlCN9SmDgmh 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/297287>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-1563245596-1465903036=:22630
Content-Type: text/plain; charset=X-UNKNOWN
Content-Transfer-Encoding: QUOTED-PRINTABLE

Dear Git users,

It is my pleasure to announce that Git for Windows 2.9.0 is available from:

=09https://git-for-windows.github.io/

Changes since Git for Windows v2.8.4 (June 7th 2016)

Bug Fixes

  =E2=80=A2 When running git gc --aggressive or git repack -ald in the pres=
ence
    of multiple pack files, the command still had open handles to the
    pack files it wanted to remove. This has been fixed.

Filename | SHA-256
-------- | -------
Git-2.9.0-64-bit.exe | 4e736ae188f4b75c2c24282d8a9543726f6cb7e0b2f1e7ad8e37=
e3b61cfa8d1d
Git-2.9.0-32-bit.exe | c511db6eb0a23ae53fbf753f688a1a180a371e082c3b202bf8b6=
4f3bccf9bc95
PortableGit-2.9.0-64-bit.7z.exe | 566bf55d7a3ba18660e76034d4af3e0cdd985cbb6=
f73eb881f287aa23a0f6bbc
PortableGit-2.9.0-32-bit.7z.exe | ed7c648f58decbd70f27e124704e88ac1c9934e78=
bcc60516aaeddace2275581
Git-2.9.0-64-bit.tar.bz2 | 85662a8b7d69fa604eb68e337eab3991ef77aa724794b9f2=
7705190b206a4d7d
Git-2.9.0-32-bit.tar.bz2 | 33c4e9f75c883c003baf350d16d3ebaad9f93f3789e34c62=
51e23e9fa98cf659

Ciao,
Johannes
--8323329-1563245596-1465903036=:22630--
