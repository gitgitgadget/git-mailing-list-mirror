From: "John Dlugosz" <JDlugosz@TradeStation.com>
Subject: RE: dangling commits and blobs: is this normal?
Date: Wed, 22 Apr 2009 16:15:54 -0400
Message-ID: <450196A1AAAE4B42A00A8B27A59278E70ACE07F3@EXCHANGE.trad.tradestation.com>
References: <450196A1AAAE4B42A00A8B27A59278E70ACE0502@EXCHANGE.trad.tradestation.com> <20090422152719.GA12881@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="UTF-8"
Content-Transfer-Encoding: base64
Cc: <git@vger.kernel.org>
To: "Jeff King" <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Apr 22 22:17:47 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lwit7-0001eA-35
	for gcvg-git-2@gmane.org; Wed, 22 Apr 2009 22:17:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754125AbZDVUQH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 22 Apr 2009 16:16:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753634AbZDVUQG
	(ORCPT <rfc822;git-outgoing>); Wed, 22 Apr 2009 16:16:06 -0400
Received: from mail2.tradestation.com ([63.99.207.80]:34363 "EHLO
	mail2.tradestation.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753084AbZDVUQF (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 22 Apr 2009 16:16:05 -0400
X-ASG-Debug-ID: 1240431362-7e6b01750000-QuoKaX
X-Barracuda-URL: http://192.168.51.31:8000/cgi-bin/mark.cgi
Received: from mail5.tradestation.com (localhost [127.0.0.1])
	by mail2.tradestation.com (Spam & Virus Firewall) with ESMTP
	id 12A4A373F4B; Wed, 22 Apr 2009 16:16:02 -0400 (EDT)
Received: from mail5.tradestation.com (tx02exchange02.trad.tradestation.com [192.168.51.76]) by mail2.tradestation.com with ESMTP id IOeDNmAICB3e6mWy; Wed, 22 Apr 2009 16:16:02 -0400 (EDT)
X-Barracuda-Envelope-From: JDlugosz@TradeStation.com
X-ASG-Whitelist: Client
Received: from EXCHANGE.trad.tradestation.com ([10.4.0.121]) by mail5.tradestation.com with Microsoft SMTPSVC(6.0.3790.3959);
	 Wed, 22 Apr 2009 16:16:02 -0400
X-MimeOLE: Produced By Microsoft Exchange V6.5
Content-class: urn:content-classes:message
X-ASG-Orig-Subj: RE: dangling commits and blobs: is this normal?
In-Reply-To: <20090422152719.GA12881@coredump.intra.peff.net>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: dangling commits and blobs: is this normal?
Thread-Index: AcnDXtXX1E77OIkSTcarvt4Q499EIQAB3SPA
X-OriginalArrivalTime: 22 Apr 2009 20:16:02.0617 (UTC) FILETIME=[289D5290:01C9C387]
X-Barracuda-Connect: tx02exchange02.trad.tradestation.com[192.168.51.76]
X-Barracuda-Start-Time: 1240431363
X-Barracuda-Virus-Scanned: by TX-Barracuda Spam Firewall 400 at tradestation.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/117252>

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogSmVm
ZiBLaW5nIFttYWlsdG86cGVmZkBwZWZmLm5ldF0NCj4gU2VudDogV2VkbmVz
ZGF5LCBBcHJpbCAyMiwgMjAwOSAxMDoyNyBBTQ0KPiBUbzogSm9obiBEbHVn
b3N6DQo+IENjOiBnaXRAdmdlci5rZXJuZWwub3JnDQo+IFN1YmplY3Q6IFJl
OiBkYW5nbGluZyBjb21taXRzIGFuZCBibG9iczogaXMgdGhpcyBub3JtYWw/
DQo+IA0KPiANCj4gZ2Mgd2lsbCBsZWF2ZSBkYW5nbGluZyBsb29zZSBvYmpl
Y3RzIGZvciBhIHNldCBleHBpcmF0aW9uIHRpbWUNCj4gKGRlZmF1bHRpbmcg
dG8gdHdvIHdlZWtzKS4gVGhpcyBtYWtlcyBpdCBzYWZlIHRvIHJ1biBldmVu
IGlmIHRoZXJlIGFyZQ0KPiBvcGVyYXRpb25zIGluIHByb2dyZXNzIHRoYXQg
d2FudCB0aG9zZSBkYW5nbGluZyBvYmplY3RzLCBidXQgaGF2ZW4ndA0KPiB5
ZXQNCj4gYWRkZWQgYSByZWZlcmVuY2UgdG8gdGhlbSAoYXMgbG9uZyBhcyBz
YWlkIG9wZXJhdGlvbiB0YWtlcyBsZXNzIHRoYW4NCj4gdHdvDQo+IHdlZWtz
KS4NCg0KDQpBaCwgdmVyeSBlbmxpZ2h0ZW5pbmcuICBJIHNlZTogaXQncyBu
b3QganVzdCByZWZsb2cgc3R1ZmYgKHdoaWNoIGdjIHNob3VsZCBrbm93IGFy
ZSByb290IGVudHJ5IHBvaW50cyBhbmQgbm90IGNvbXBsYWluIGFib3V0KSwg
aXQgcmVhbGx5IGRvZXMgbGVhdmUgdW5jb2xsZWN0ZWQgZ2FyYmFnZSBvbiBw
dXJwb3NlLCBpbiBjYXNlIHNvbWV0aGluZyBpcyBpbiBwcm9ncmVzcy4NCg0K
LS1Kb2huDQoKVHJhZGVTdGF0aW9uIEdyb3VwLCBJbmMuIGlzIGEgcHVibGlj
bHktdHJhZGVkIGhvbGRpbmcgY29tcGFueSAoTkFTREFRIEdTOiBUUkFEKSBv
ZiB0aHJlZSBvcGVyYXRpbmcgc3Vic2lkaWFyaWVzLCBUcmFkZVN0YXRpb24g
U2VjdXJpdGllcywgSW5jLiAoTWVtYmVyIE5ZU0UsIEZJTlJBLCBTSVBDIGFu
ZCBORkEpLCBUcmFkZVN0YXRpb24gVGVjaG5vbG9naWVzLCBJbmMuLCBhIHRy
YWRpbmcgc29mdHdhcmUgYW5kIHN1YnNjcmlwdGlvbiBjb21wYW55LCBhbmQg
VHJhZGVTdGF0aW9uIEV1cm9wZSBMaW1pdGVkLCBhIFVuaXRlZCBLaW5nZG9t
LCBGU0EtYXV0aG9yaXplZCBpbnRyb2R1Y2luZyBicm9rZXJhZ2UgZmlybS4g
Tm9uZSBvZiB0aGVzZSBjb21wYW5pZXMgcHJvdmlkZXMgdHJhZGluZyBvciBp
bnZlc3RtZW50IGFkdmljZSwgcmVjb21tZW5kYXRpb25zIG9yIGVuZG9yc2Vt
ZW50cyBvZiBhbnkga2luZC4gVGhlIGluZm9ybWF0aW9uIHRyYW5zbWl0dGVk
IGlzIGludGVuZGVkIG9ubHkgZm9yIHRoZSBwZXJzb24gb3IgZW50aXR5IHRv
IHdoaWNoIGl0IGlzIGFkZHJlc3NlZCBhbmQgbWF5IGNvbnRhaW4gY29uZmlk
ZW50aWFsIGFuZC9vciBwcml2aWxlZ2VkIG1hdGVyaWFsLiBBbnkgcmV2aWV3
LCByZXRyYW5zbWlzc2lvbiwgZGlzc2VtaW5hdGlvbiBvciBvdGhlciB1c2Ug
b2YsIG9yIHRha2luZyBvZiBhbnkgYWN0aW9uIGluIHJlbGlhbmNlIHVwb24s
IHRoaXMgaW5mb3JtYXRpb24gYnkgcGVyc29ucyBvciBlbnRpdGllcyBvdGhl
ciB0aGFuIHRoZSBpbnRlbmRlZCByZWNpcGllbnQgaXMgcHJvaGliaXRlZC4g
SWYgeW91IHJlY2VpdmVkIHRoaXMgaW4gZXJyb3IsIHBsZWFzZSBjb250YWN0
IHRoZSBzZW5kZXIgYW5kIGRlbGV0ZSB0aGUgbWF0ZXJpYWwgZnJvbSBhbnkg
Y29tcHV0ZXIuCg==
