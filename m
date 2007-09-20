From: "Matt Seitz \(matseitz\)" <matseitz@cisco.com>
Subject: Symbolic link documentation
Date: Thu, 20 Sep 2007 10:17:58 -0700
Message-ID: <70952A932255A2489522275A628B97C3052E98EB@xmb-sjc-233.amer.cisco.com>
Mime-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----_=_NextPart_001_01C7FBAA.1DF78A90"
To: <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Sep 20 19:18:50 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IYPft-0007UM-V8
	for gcvg-git-2@gmane.org; Thu, 20 Sep 2007 19:18:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755144AbXITRSN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 20 Sep 2007 13:18:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754513AbXITRSM
	(ORCPT <rfc822;git-outgoing>); Thu, 20 Sep 2007 13:18:12 -0400
Received: from sj-iport-3-in.cisco.com ([171.71.176.72]:43745 "EHLO
	sj-iport-3.cisco.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752779AbXITRSK (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 20 Sep 2007 13:18:10 -0400
X-IronPort-AV: E=Sophos;i="4.20,279,1186383600"; 
   d="vcf'?scan'208";a="526246505"
Received: from sj-dkim-1.cisco.com ([171.71.179.21])
  by sj-iport-3.cisco.com with ESMTP; 20 Sep 2007 10:17:26 -0700
Received: from sj-core-1.cisco.com (sj-core-1.cisco.com [171.71.177.237])
	by sj-dkim-1.cisco.com (8.12.11/8.12.11) with ESMTP id l8KHHRtw015697
	for <git@vger.kernel.org>; Thu, 20 Sep 2007 10:17:27 -0700
Received: from xbh-sjc-211.amer.cisco.com (xbh-sjc-211.cisco.com [171.70.151.144])
	by sj-core-1.cisco.com (8.12.10/8.12.6) with ESMTP id l8KHHRin015717
	for <git@vger.kernel.org>; Thu, 20 Sep 2007 17:17:27 GMT
Received: from xmb-sjc-233.amer.cisco.com ([128.107.191.88]) by xbh-sjc-211.amer.cisco.com with Microsoft SMTPSVC(6.0.3790.1830);
	 Thu, 20 Sep 2007 10:17:27 -0700
X-MimeOLE: Produced By Microsoft Exchange V6.5
Content-class: urn:content-classes:message
X-MS-Has-Attach: yes
X-MS-TNEF-Correlator: 
Thread-Topic: Symbolic link documentation
Thread-Index: Acf7qjDlmy2hTMLzTzqjqA08Klq83A==
X-OriginalArrivalTime: 20 Sep 2007 17:17:27.0037 (UTC) FILETIME=[1E0A92D0:01C7FBAA]
DKIM-Signature: v=0.5; a=rsa-sha256; q=dns/txt; l=1152; t=1190308647; x=1191172647;
	c=relaxed/simple; s=sjdkim1004;
	h=Content-Type:From:Subject:Content-Transfer-Encoding:MIME-Version;
	d=cisco.com; i=matseitz@cisco.com;
	z=From:=20=22Matt=20Seitz=20\(matseitz\)=22=20<matseitz@cisco.com>
	|Subject:=20Symbolic=20link=20documentation
	|Sender:=20;
	bh=S7m71Rhef9feClowMlhQz+uj4vw+VfRf9ruMCkWMTKY=;
	b=YFWS2Zgt5u51hfezXT7PKg1AbaynzuAU48TEwrjiD1ewkfkXOn7rLshQHSfdyUQLbybi2RCq
	LdcDlkaDuR+R5HWgNFUxDFOtv00zJoQ81yuPfPxFzLVHqI8D56jZpXWkn6lNQrJO8jx64/7zwu
	ib8WiNEG5OV+gWbrTW4HBlt0M=;
Authentication-Results: sj-dkim-1; header.From=matseitz@cisco.com; dkim=pass (
	sig from cisco.com/sjdkim1004 verified; ); 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/58787>

This is a multi-part message in MIME format.

------_=_NextPart_001_01C7FBAA.1DF78A90
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Where does the git user documentation discuss how git handles symbolic
links?


--
Matt Seitz
Manager, File System Virtualization
Cisco Systems, Inc.
.:|:.:|:.=20

------_=_NextPart_001_01C7FBAA.1DF78A90
Content-Type: text/x-vcard;
	name="Matt Seitz.vcf"
Content-Transfer-Encoding: base64
Content-Description: Matt Seitz.vcf
Content-Disposition: attachment;
	filename="Matt Seitz.vcf"

QkVHSU46VkNBUkQNClZFUlNJT046Mi4xDQpOOlNlaXR6O01hdHQNCkZOOk1hdHQgU2VpdHoNCk9S
RzpDaXNjbyBTeXN0ZW1zLCBJbmMNClRJVExFOk1hbmFnZXINClRFTDtXT1JLO1ZPSUNFOjQwOC0y
MDAtODAwMA0KQURSO1dPUks6OzszOTc1IEZyZWVkb20gQ2lyY2xlLCBGbG9vciA4O1NhbnRhIENs
YXJhO0NBOzk1MDU0O1VuaXRlZCBTdGF0ZXMgb2YgQW1lcmljYQ0KTEFCRUw7V09SSztFTkNPRElO
Rz1RVU9URUQtUFJJTlRBQkxFOjM5NzUgRnJlZWRvbSBDaXJjbGUsIEZsb29yIDg9MEQ9MEFTYW50
YSBDbGFyYSwgQ0EgOTUwNTQ9MEQ9MEFVbml0ZWQgU3RhdGVzIG89DQpmIEFtZXJpY2ENCkVNQUlM
O1BSRUY7SU5URVJORVQ6bWF0c2VpdHpAY2lzY28uY29tDQpSRVY6MjAwNzA3MDlUMjM0MDQ5Wg0K
RU5EOlZDQVJEDQo=

------_=_NextPart_001_01C7FBAA.1DF78A90--
