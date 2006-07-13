From: Luben Tuikov <ltuikov@yahoo.com>
Subject: [PATCH] gitweb.css: Courier fonts for commits and tree-diff
Date: Wed, 12 Jul 2006 20:31:32 -0700 (PDT)
Message-ID: <20060713033132.76395.qmail@web31810.mail.mud.yahoo.com>
Reply-To: ltuikov@yahoo.com
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="0-78215621-1152761492=:76038"
Content-Transfer-Encoding: 8bit
X-From: git-owner@vger.kernel.org Thu Jul 13 05:31:41 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1G0rvR-00067p-Ec
	for gcvg-git@gmane.org; Thu, 13 Jul 2006 05:31:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750790AbWGMDbd (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 12 Jul 2006 23:31:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750791AbWGMDbd
	(ORCPT <rfc822;git-outgoing>); Wed, 12 Jul 2006 23:31:33 -0400
Received: from web31810.mail.mud.yahoo.com ([68.142.207.73]:5792 "HELO
	web31810.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S1750790AbWGMDbd (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 12 Jul 2006 23:31:33 -0400
Received: (qmail 76397 invoked by uid 60001); 13 Jul 2006 03:31:32 -0000
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  h=Message-ID:Received:Date:From:Reply-To:Subject:To:MIME-Version:Content-Type:Content-Transfer-Encoding;
  b=hpyPw83DRaYgurGuWdXd1XIUmqIroR5QhJtVAPAZwPBwcTDx0Mai8FhBbyeIa39sFOhWWvML5E8+YJUEHTY4dvkBG11Sh8KNZKals7JVKIpVgN4+AgSuCn5x84+K//Lvp9GJnADuqB5u/tSJmqMf31F1u8Hq88VOgB9FsDadefI=  ;
Received: from [68.186.50.195] by web31810.mail.mud.yahoo.com via HTTP; Wed, 12 Jul 2006 20:31:32 PDT
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/23804>

--0-78215621-1152761492=:76038
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Content-Id: 
Content-Disposition: inline

Courier fonts for the commit header, commit message,
and tree-diff.

Signed-off-by: Luben Tuikov <ltuikov@yahoo.com>
---
 gitweb/gitweb.css |    9 ++++++++-
 1 files changed, 8 insertions(+), 1 deletions(-)

--0-78215621-1152761492=:76038
Content-Type: application/octet-stream; name="p0.patch"
Content-Transfer-Encoding: base64
Content-Description: pat1954662842
Content-Disposition: attachment; filename="p0.patch"

ZGlmZiAtLWdpdCBhL2dpdHdlYi9naXR3ZWIuY3NzIGIvZ2l0d2ViL2dpdHdl
Yi5jc3MKaW5kZXggOTg0MTBmNS4uYjUxMjgyYiAxMDA2NDQKLS0tIGEvZ2l0
d2ViL2dpdHdlYi5jc3MKKysrIGIvZ2l0d2ViL2dpdHdlYi5jc3MKQEAgLTYw
LDYgKzYwLDcgQEAgZGl2LnBhZ2VfZm9vdGVyX3RleHQgewogCiBkaXYucGFn
ZV9ib2R5IHsKIAlwYWRkaW5nOiA4cHg7CisJZm9udC1mYW1pbHk6IGNvdXJp
ZXI7CiB9CiAKIGRpdi50aXRsZSwgYS50aXRsZSB7CkBAIC03OSw2ICs4MCw3
IEBAIGRpdi50aXRsZV90ZXh0IHsKIAlwYWRkaW5nOiA2cHggMHB4OwogCWJv
cmRlcjogc29saWQgI2Q5ZDhkMTsKIAlib3JkZXItd2lkdGg6IDBweCAwcHgg
MXB4OworCWZvbnQtZmFtaWx5OiBjb3VyaWVyOwogfQogCiBkaXYubG9nX2Jv
ZHkgewpAQCAtMTQyLDExICsxNDQsMTUgQEAgdGFibGUgewogCXBhZGRpbmc6
IDhweCA0cHg7CiB9CiAKLXRhYmxlLnByb2plY3RfbGlzdCwgdGFibGUuZGlm
Zl90cmVlIHsKK3RhYmxlLnByb2plY3RfbGlzdCB7CiAJYm9yZGVyLXNwYWNp
bmc6IDA7CiB9CiAKK3RhYmxlLmRpZmZfdHJlZSB7CisJYm9yZGVyLXNwYWNp
bmc6IDA7CisJZm9udC1mYW1pbHk6IGNvdXJpZXI7Cit9CisKIHRhYmxlLmJs
YW1lIHsKIAlib3JkZXItY29sbGFwc2U6IGNvbGxhcHNlOwogfQotLSAKMS40
LjEuZzljYTMKCg==

--0-78215621-1152761492=:76038--
