From: "Sean" <seanlkml@sympatico.ca>
Subject: [PATCH 1/3] - Add GIT Version number
Date: Sat, 21 May 2005 14:32:09 -0400 (EDT)
Message-ID: <2230.10.10.10.24.1116700329.squirrel@linux1>
Mime-Version: 1.0
Content-Type: multipart/mixed;boundary="----=_20050521143209_57535"
X-From: git-owner@vger.kernel.org Sat May 21 20:32:12 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DZYkq-0005SP-Qo
	for gcvg-git@gmane.org; Sat, 21 May 2005 20:31:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261765AbVEUScZ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 21 May 2005 14:32:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261763AbVEUScZ
	(ORCPT <rfc822;git-outgoing>); Sat, 21 May 2005 14:32:25 -0400
Received: from simmts7.bellnexxia.net ([206.47.199.165]:16343 "EHLO
	simmts7-srv.bellnexxia.net") by vger.kernel.org with ESMTP
	id S261766AbVEUScK (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 21 May 2005 14:32:10 -0400
Received: from linux1 ([69.156.111.46]) by simmts7-srv.bellnexxia.net
          (InterMail vM.5.01.06.10 201-253-122-130-110-20040306) with ESMTP
          id <20050521183209.YOMK23474.simmts7-srv.bellnexxia.net@linux1>
          for <git@vger.kernel.org>; Sat, 21 May 2005 14:32:09 -0400
Received: from linux1 (linux1.attic.local [127.0.0.1])
	by linux1 (8.12.11/8.12.11) with ESMTP id j4LIW92X021487
	for <git@vger.kernel.org>; Sat, 21 May 2005 14:32:09 -0400
Received: from 10.10.10.24
        (SquirrelMail authenticated user sean)
        by linux1 with HTTP;
        Sat, 21 May 2005 14:32:09 -0400 (EDT)
To: git@vger.kernel.org
User-Agent: SquirrelMail/1.4.4-2
X-Priority: 3 (Normal)
Importance: Normal
References: 
In-Reply-To: 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

------=_20050521143209_57535
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 8bit


Add a version number to the GIT Makefile; lifted from the Linux kernel
source.  Once set, the version number will be reported by the "--version"
option on git commands that are converted to argp argument processing.

The version number was arbitrarily set to 0.5.0 as a starting point, but
obviously you can change it as you see fit.

Signed-off-by: Sean Estabrooks <seanlkml@sympatico.ca>

------=_20050521143209_57535
Content-Type: application/octet-stream; name="argp-Makefile-v3.patch"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="argp-Makefile-v3.patch"

SW5kZXg6IE1ha2VmaWxlCj09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT0KLS0tIDU4NzQxYzY5NTcwNzA1ODAxZGI0Yjc4NTY4
MTc5MGQ2MzY0NzU2OTUvTWFrZWZpbGUgIChtb2RlOjEwMDY0NCkKKysrIHVuY29tbWl0dGVkL01h
a2VmaWxlICAobW9kZToxMDA2NDQpCkBAIC03LDggKzcsMTYgQEAKICMgQlJFQUsgWU9VUiBMT0NB
TCBESUZGUyEgc2hvdy1kaWZmIGFuZCBhbnl0aGluZyB1c2luZyBpdCB3aWxsIGxpa2VseSByYW5k
b21seQogIyBicmVhayB1bmxlc3MgeW91ciB1bmRlcmx5aW5nIGZpbGVzeXN0ZW0gc3VwcG9ydHMg
dGhvc2Ugc3ViLXNlY29uZCB0aW1lcwogIyAobXkgZXh0MyBkb2Vzbid0KS4KKyMKK1ZFUlNJT04g
PSAwCitQQVRDSExFVkVMID0gNQorU1VCTEVWRUwgPSAwCitFWFRSQVZFUlNJT04gPQorCitSRUxF
QVNFPSQoVkVSU0lPTikuJChQQVRDSExFVkVMKS4kKFNVQkxFVkVMKSQoRVhUUkFWRVJTSU9OKQor
CiBDT1BUUz0tTzIKLUNGTEFHUz0tZyAkKENPUFRTKSAtV2FsbAorQ0ZMQUdTPS1nICQoQ09QVFMp
IC1XYWxsICctRFZFUlNJT049IiQoUkVMRUFTRSkiJwogCiBwcmVmaXg9JChIT01FKQogYmluPSQo
cHJlZml4KS9iaW4K
------=_20050521143209_57535--


