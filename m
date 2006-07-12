From: Luben Tuikov <ltuikov@yahoo.com>
Subject: [PATCH] gitweb.css: Courer fonts for commits and tree-diff
Date: Tue, 11 Jul 2006 20:43:23 -0700 (PDT)
Message-ID: <20060712034323.48414.qmail@web31806.mail.mud.yahoo.com>
Reply-To: ltuikov@yahoo.com
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="0-1028027107-1152675803=:47431"
Content-Transfer-Encoding: 8bit
X-From: git-owner@vger.kernel.org Wed Jul 12 05:43:31 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1G0VdH-0001SQ-F3
	for gcvg-git@gmane.org; Wed, 12 Jul 2006 05:43:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932380AbWGLDnZ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 11 Jul 2006 23:43:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932371AbWGLDnZ
	(ORCPT <rfc822;git-outgoing>); Tue, 11 Jul 2006 23:43:25 -0400
Received: from web31806.mail.mud.yahoo.com ([68.142.207.69]:15775 "HELO
	web31806.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S932380AbWGLDnY (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 11 Jul 2006 23:43:24 -0400
Received: (qmail 48416 invoked by uid 60001); 12 Jul 2006 03:43:23 -0000
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  h=Message-ID:Received:Date:From:Reply-To:Subject:To:MIME-Version:Content-Type:Content-Transfer-Encoding;
  b=f58Cm1mdvskTVrtwyZRunD5KwslpXPfQCMuGc8NO/6/soho8cHLi49BFfguBV2fOl52ZqE+SZIGg6j+j+fbBhZXFeny6h7M4hQXdn2cm8PwUK/pOSp1j8jjlMDNltAVSbUdtB9BtaAYrOqcYAT4ITgSB8wSqR82HAdXOSl4meA0=  ;
Received: from [68.186.50.195] by web31806.mail.mud.yahoo.com via HTTP; Tue, 11 Jul 2006 20:43:23 PDT
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/23755>

--0-1028027107-1152675803=:47431
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Content-Id: 
Content-Disposition: inline

Courer fonts for the commit header, commit message,
and tree-diff.

Signed-off-by: Luben Tuikov <ltuikov@yahoo.com>
---
 gitweb/gitweb.css |    9 ++++++++-
 1 files changed, 8 insertions(+), 1 deletions(-)
--0-1028027107-1152675803=:47431
Content-Type: application/octet-stream; name="p0.patch"
Content-Transfer-Encoding: base64
Content-Description: pat619875137
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

--0-1028027107-1152675803=:47431--
