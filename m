From: Hwasung Mars Lee <hwasungmars@hotmail.com>
Subject: libcrypto error
Date: Sat, 29 Dec 2007 15:05:58 +0000
Message-ID: <BLU129-W145F3EAD72285347BFF215B3560@phx.gbl>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sat Dec 29 16:22:40 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J8dWJ-00065e-84
	for gcvg-git-2@gmane.org; Sat, 29 Dec 2007 16:22:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753771AbXL2PWN convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 29 Dec 2007 10:22:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753763AbXL2PWN
	(ORCPT <rfc822;git-outgoing>); Sat, 29 Dec 2007 10:22:13 -0500
Received: from blu0-omc3-s2.blu0.hotmail.com ([65.55.162.156]:51113 "EHLO
	blu0-omc3-s2.bay6.hotmail.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1753633AbXL2PWM convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 29 Dec 2007 10:22:12 -0500
X-Greylist: delayed 973 seconds by postgrey-1.27 at vger.kernel.org; Sat, 29 Dec 2007 10:22:12 EST
Received: from BLU129-W14 ([65.55.162.187]) by blu0-omc3-s2.bay6.hotmail.com with Microsoft SMTPSVC(6.0.3790.3959);
	 Sat, 29 Dec 2007 07:05:58 -0800
X-Originating-IP: [163.1.148.87]
Importance: Normal
X-OriginalArrivalTime: 29 Dec 2007 15:05:58.0948 (UTC) FILETIME=[51AEB640:01C84A2C]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/69315>


Hello,

I have some problems when using git remotely. When I git clone from Ubu=
ntu or Mac to Debian, I get the following message:

git-upload-pack: error while loading shared libraries: libcrypto.so.0.9=
=2E8: cannot open shared object file: No such file or directory
fatal: unexpected EOF
fetch-pack from 'maths:~/Desktop/TeX' failed.

I tried googling and the FAQ but nothing helped. Can somebody help me o=
ut?

Thanks, Mars.

---
Hwasung Mars Lee

Mathematical Institute,
Oxford University,
24-29 St Giles',
Oxford, OX1 3LB,
United Kingdom

It is by logic that we prove,
but by intuition that we discover.
- Henri Poincar=E9

_________________________________________________________________
=46ancy some celeb spotting?=20
https://www.celebmashup.com