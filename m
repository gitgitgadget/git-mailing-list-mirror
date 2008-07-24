From: "Matt Seitz (matseitz)" <matseitz@cisco.com>
Subject: Re: gitk highlighting descendents/ancestors
Date: Wed, 23 Jul 2008 17:12:14 -0700
Message-ID: <70952A932255A2489522275A628B97C307540BC3@xmb-sjc-233.amer.cisco.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="UTF-8"
Content-Transfer-Encoding: base64
To: <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Jul 24 02:12:13 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KLoRI-0007wm-A2
	for gcvg-git-2@gmane.org; Thu, 24 Jul 2008 02:12:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754597AbYGXALL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 23 Jul 2008 20:11:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754593AbYGXALJ
	(ORCPT <rfc822;git-outgoing>); Wed, 23 Jul 2008 20:11:09 -0400
Received: from sj-iport-2.cisco.com ([171.71.176.71]:31556 "EHLO
	sj-iport-2.cisco.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754058AbYGXALI (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 23 Jul 2008 20:11:08 -0400
X-IronPort-AV: E=Sophos;i="4.31,241,1215388800"; 
   d="scan'208";a="68463588"
Received: from sj-dkim-2.cisco.com ([171.71.179.186])
  by sj-iport-2.cisco.com with ESMTP; 24 Jul 2008 00:11:08 +0000
Received: from sj-core-5.cisco.com (sj-core-5.cisco.com [171.71.177.238])
	by sj-dkim-2.cisco.com (8.12.11/8.12.11) with ESMTP id m6O0B7DF029245
	for <git@vger.kernel.org>; Wed, 23 Jul 2008 17:11:07 -0700
Received: from xbh-sjc-211.amer.cisco.com (xbh-sjc-211.cisco.com [171.70.151.144])
	by sj-core-5.cisco.com (8.13.8/8.13.8) with ESMTP id m6O0B7bd023360
	for <git@vger.kernel.org>; Thu, 24 Jul 2008 00:11:07 GMT
Received: from xmb-sjc-233.amer.cisco.com ([128.107.191.88]) by xbh-sjc-211.amer.cisco.com with Microsoft SMTPSVC(6.0.3790.1830);
	 Wed, 23 Jul 2008 17:11:07 -0700
X-MimeOLE: Produced By Microsoft Exchange V6.5
Content-class: urn:content-classes:message
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: gitk highlighting descendents/ancestors
Thread-Index: AcjtIez914EipdHiQIyfP6T+8viCHQ==
X-OriginalArrivalTime: 24 Jul 2008 00:11:07.0637 (UTC) FILETIME=[C516D250:01C8ED21]
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; l=638; t=1216858267; x=1217722267;
	c=relaxed/simple; s=sjdkim2002;
	h=Content-Type:From:Subject:Content-Transfer-Encoding:MIME-Version;
	d=cisco.com; i=matseitz@cisco.com;
	z=From:=20=22Matt=20Seitz=20(matseitz)=22=20<matseitz@cisco.
	com>
	|Subject:=20Re=3A=20gitk=20highlighting=20descendents/ances
	tors
	|Sender:=20;
	bh=0b2m1NOtWgCmgUNuPPBqAvbQj0oZ3+ySzbBZIjsZwLU=;
	b=Qn+mP1MseS1q29ZJVRJUIXJnBxgu+8dKy/BFkT8AsHYtKqI8QnlJjkSByy
	2DzFwD8UpvgebSEAtHJBGj7lBAyck87EfPpW4iTdHWmGb6b1KTsAgiW/wdwI
	O98eRmV/Z6;
Authentication-Results: sj-dkim-2; header.From=matseitz@cisco.com; dkim=pass (
	sig from cisco.com/sjdkim2002 verified; ); 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/89818>

IlBhdWwgTWFja2VycmFzIiA8cGF1bHVzQHNhbWJhLm9yZz4gd3JvdGUgaW4gbWVzc2FnZSBuZXdz
OjwxNzUzMC42MDAyNi42MzY5ODEuNjA1MzJAY2FyZ28ub3psYWJzLmlibS5jb20+Li4uDQo+IEkg
aGF2ZSBpbXBsZW1lbnRlZCBhIGZlYXR1cmUgaW4gZ2l0ayAob24gdGhlICJuZXciIGJyYW5jaCkg
d2hlcmUgaXQNCj4gY2FuIGhpZ2hsaWdodCB0aGUgY29tbWl0cyB0aGF0IGFyZSwgb3IgYXJlIG5v
dCwgZGVzY2VuZGVudHMgb3INCj4gYW5jZXN0b3JzIG9mIHRoZSBzZWxlY3RlZCBjb21taXQuICBG
b3Igbm93IGl0IGlzIGludm9rZWQgdmlhIGENCj4gZHJvcC1kb3duIG1lbnUuICANCg0KSXMgdGhp
cyBmZWF0dXJlIHN0aWxsIGF2YWlsYWJsZT8gIEkgZG9uJ3Qgc2VlIHRoZSBtZW51IHJ1bm5pbmcg
MS41LjYgb24gQ3lnd2luLiAgQSBjb3dvcmtlciBydW5uaW5nIDEuNS4wLjcgb24gTGludXggc2Vl
cyBpdC4NCg==
