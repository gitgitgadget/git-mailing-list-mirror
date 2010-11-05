From: <chen_wang@trendmicro.com.cn>
Subject: pretty format can't work on cron job
Date: Fri, 5 Nov 2010 16:29:00 +0800
Message-ID: <7B2091481B9ED640A92789B0CA07059587CCF7@CDCEXMAIL02.tw.trendnet.org>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="utf-8"
Content-Transfer-Encoding: base64
Cc: <ellre923@gmail.com>
To: <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Nov 05 09:29:15 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PEHff-0008Et-5H
	for gcvg-git-2@lo.gmane.org; Fri, 05 Nov 2010 09:29:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752163Ab0KEI3G (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 5 Nov 2010 04:29:06 -0400
Received: from sjdciscan01.udc.trendmicro.com ([216.99.131.130]:59775 "EHLO
	SJDCISCAN01.udc.trendmicro.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752022Ab0KEI3F (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 5 Nov 2010 04:29:05 -0400
Received: from SJDCISCAN01.udc.trendmicro.com (SJDCISCAN01 [127.0.0.1])
	by postfix.imss70 (Postfix) with ESMTP id 249F09A8DEF;
	Fri,  5 Nov 2010 01:29:03 -0700 (PDT)
Received: from sjdcexbh02.us.trendnet.org (sjdcexbh02.udc.trendmicro.com [216.99.131.187])
	by SJDCISCAN01.udc.trendmicro.com (Postfix) with ESMTP id 1A2719A882A;
	Fri,  5 Nov 2010 01:29:03 -0700 (PDT)
Received: from adcexbh02.tw.trendnet.org ([202.133.236.202]) by sjdcexbh02.us.trendnet.org with Microsoft SMTPSVC(6.0.3790.4675);
	 Fri, 5 Nov 2010 01:29:04 -0700
Received: from CDCEXMAIL02.tw.trendnet.org ([10.64.1.42]) by adcexbh02.tw.trendnet.org with Microsoft SMTPSVC(6.0.3790.4675);
	 Fri, 5 Nov 2010 16:29:02 +0800
X-MimeOLE: Produced By Microsoft Exchange V6.5
Content-class: urn:content-classes:message
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: pretty format can't work on cron job
Thread-Index: Act8wPYO+razzJWySO2WbVDMkcG8ZgAAmXYg
X-OriginalArrivalTime: 05 Nov 2010 08:29:02.0121 (UTC) FILETIME=[802ED190:01CB7CC3]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/160802>

DQpGb3IgdGhlIGNvbW1hbmQ6IGdpdCBsb2cgMWRhMTc3ZTRjM2Y0MTUyNGU4ODZiN2YxYjhhMGMx
ZmM3MzIxY2FjMi4uIC1NIC0tZGF0ZT1zaG9ydCAtLXByZXR0eT1mb3JtYXQ6IkF1dGhvcjogJWFO
IDwlYWU+OyBEYXRlOiAlYWQiIC0tc2hvcnRzdGF0IC0tZGlyc3RhdCAtLW5vLW1lcmdlcw0KDQpJ
IHJ1biBpdCBvbiBzaGVsbCBieSBtYW51YWwgY2FuIGNyZWF0ZSBjb3JyZWN0IGZvcm1hdCBvZiBv
dXRwdXQsIHN1Y2ggYXM6DQotLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tDQpBdXRob3I6IEFtaXQgU2hhaCA8YW1pdC5zaGFoQHJlZGhhdC5jb20+OyBEYXRl
OiAyMDEwLTEwLTIwDQrCoDEgZmlsZXMgY2hhbmdlZCwgMTQgaW5zZXJ0aW9ucygrKSwgMyBkZWxl
dGlvbnMoLSkNCsKgMTAwLjAlIGRyaXZlcnMvY2hhci8NCi0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0NCg0KQnV0IHdoZW4gSSBwdXQgdGhhdCBjb21tYW5k
IG9uIGNyb24gam9iLCBldmVuIEkgcnVuIOKAnC4gL2V0Yy9wcm9maWxl4oCdIGFuZCDigJwuIH4v
LmJhc2hfcHJvZmlsZeKAnSBmaXJzdCwgSSBjYW7igJl0IGdldCBjb3JyZWN0IGZvcm1hdCBvZiBv
dXRwdXQuDQotLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
DQpBdXRob3I6ICVhTiA8YW1pdC5zaGFoQHJlZGhhdC5jb20+OyBEYXRlOiBXZWQgT2N0IDIwIDEz
OjQ1OjQzIDIwMTAgKzEwMzANCsKgMTAwLjAlIGRyaXZlcnMvY2hhci8NCsKgMSBmaWxlcyBjaGFu
Z2VkLCAxNCBpbnNlcnRpb25zKCspLCAzIGRlbGV0aW9ucygtKQ0KLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLQ0KDQpNeSBnaXQgdmVyc2lvbiBpcyBnaXQt
MS43LjMuMi4NCg0KRG9lcyBhbnlvbmUga25vdyB0aGUgcmVhc29uPw0KDQpUaGFua3MNCkNoZW4N
Cg0KVFJFTkQgTUlDUk8gRU1BSUwgTk9USUNFDQpUaGUgaW5mb3JtYXRpb24gY29udGFpbmVkIGlu
IHRoaXMgZW1haWwgYW5kIGFueSBhdHRhY2htZW50cyBpcyBjb25maWRlbnRpYWwgYW5kIG1heSBi
ZSBzdWJqZWN0IHRvIGNvcHlyaWdodCBvciBvdGhlciBpbnRlbGxlY3R1YWwgcHJvcGVydHkgcHJv
dGVjdGlvbi4gSWYgeW91IGFyZSBub3QgdGhlIGludGVuZGVkIHJlY2lwaWVudCwgeW91IGFyZSBu
b3QgYXV0aG9yaXplZCB0byB1c2Ugb3IgZGlzY2xvc2UgdGhpcyBpbmZvcm1hdGlvbiwgYW5kIHdl
IHJlcXVlc3QgdGhhdCB5b3Ugbm90aWZ5IHVzIGJ5IHJlcGx5IG1haWwgb3IgdGVsZXBob25lIGFu
ZCBkZWxldGUgdGhlIG9yaWdpbmFsIG1lc3NhZ2UgZnJvbSB5b3VyIG1haWwgc3lzdGVtLg==
