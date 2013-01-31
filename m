From: =?euc-kr?B?x+PBvri4?= <jongman.heo@samsung.com>
Subject: Re: Re: Re: Segmentation fault with latest git (070c57df)
Date: Thu, 31 Jan 2013 08:07:16 +0000 (GMT)
Message-ID: <6083817.360021359619635900.JavaMail.weblogic@epv6ml01>
Reply-To: jongman.heo@samsung.com
Mime-Version: 1.0
Content-Type: text/plain; charset=euc-kr
Content-Transfer-Encoding: base64
Cc: git <git@vger.kernel.org>, Antoine Pelisse <apelisse@gmail.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Jan 31 09:07:44 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U0pBO-0001U0-D0
	for gcvg-git-2@plane.gmane.org; Thu, 31 Jan 2013 09:07:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755210Ab3AaIHT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 31 Jan 2013 03:07:19 -0500
Received: from mailout4.samsung.com ([203.254.224.34]:49527 "EHLO
	mailout4.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755132Ab3AaIHS (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 31 Jan 2013 03:07:18 -0500
Received: from epcpsbge7.samsung.com (epcpsbge7 [203.254.230.17])
 by mailout4.samsung.com
 (Oracle Communications Messaging Server 7u4-24.01(7.0.4.24.0) 64bit (built Nov
 17 2011)) with ESMTP id <0MHH00K6XD5HPF10@mailout4.samsung.com> for
 git@vger.kernel.org; Thu, 31 Jan 2013 17:07:16 +0900 (KST)
Received: from epcpsbge7.samsung.com ( [203.254.230.41])
	by epcpsbge7.samsung.com (EPCPMTA) with SMTP id 30.CB.10066.4362A015; Thu,
 31 Jan 2013 17:07:16 +0900 (KST)
X-AuditID: cbfee611-b7f1c6d000002752-b6-510a2634ba52
Received: from epextmailer03 ( [203.254.219.153])
	by epcpsbge7.samsung.com (EPCPMTA) with SMTP id 00.CB.10066.4362A015; Thu,
 31 Jan 2013 17:07:16 +0900 (KST)
X-MTR: 20130131080437345@jongman.heo
Msgkey: 20130131080437345@jongman.heo
X-EPLocale: ko_KR.euc-kr
X-Priority: 3
X-EPWebmail-Msg-Type: personal
X-EPWebmail-Reply-Demand: 0
X-EPApproval-Locale: 
X-EPHeader: ML
X-EPTrCode: 
X-EPTrName: 
X-MLAttribute: 
X-RootMTR: 20130131080437345@jongman.heo
X-ParentMTR: 
X-ArchiveUser: 
X-CPGSPASS: N
MIME-version: 1.0
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrDKsWRmVeSWpSXmKPExsVy+t8zTV0TNa5Ag2/NGhZdV7qZHBg9Pm+S
	C2CM4rJJSc3JLEst0rdL4Mo4eu8Dc8EK9or+vlVMDYw97F2MnBxCAmoSNz8fYgSxJQRMJBYf
	mw5li0lcuLeerYuRC6hmGaPEl78bWGCKpkx7xwyRmM8osXnKV7AEi4CqxLYdEDabgJnEsfO/
	wSYJCzhJzF7TDWaLCMhL3Jq2kA3EZhbwlJj4fgYjxBWKEteWLgaL8woISpyc+QRqmYpE1+l/
	LBBxVYlJf9uZIeISErOmX2CFsHklZrQ/haqXk5j2dQ1UjbTE+Vkb4L5Z/P0xVJxf4tjtHUxd
	jBxgvU/uB8OM2b35CxuELSAx9cxBRogSTYkJa8UhwnwSaxa+ZYGZsuvUcmaY1vtb5jJBfKUo
	MaX7ITuErSXx5cc+DF/xCjhL3Fiyk20Co/IsJKlZSNpnIWlHVrOAkWUVo2hqQXJBcVJ6qrle
	cWJucWleul5yfu4mRkhaENzBuLTB4hCjAAejEg+vhiNnoBBrYllxZe4hRgkOZiUR3uaLQCHe
	lMTKqtSi/Pii0pzU4kOMycD4m8gsJZqcD0xZeSXxhsYGxoaGloZmppamBqQJK4nzclZMDxAS
	SE8sSc1OTS1ILYLZwsTBKdXAmHehO2XhtmqFvJjXh5Lsrr9b9tw49fjOFWtXCblcberZEx/l
	KBilyBTynu+Q5q5Jj0Ry72dIXl+10/zZw9g/59Xy/jd5/2FdWPTuBxOblHx5Tvb2NdU9Ci0e
	JucvrDxfE7vvx5flNYnBl3eyn03cn31tzgTF/GqOEylVlVlvPrZtvKFWm3nhuRJL 
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFmpkk+LIzCtJLcpLzFFi42I5/e/2TF0TNa5AgytPlSy6rnQzOTB6fN4k
	F8AYlWGTkZqYklqkkJqXnJ+SmZduq+QdHO8cb2pmYKhraGlhrqSQl5ibaqvk4hOg65aZAzRU
	SaEsMacUKBSQWFyspG9nU5RfWpKqkJFfXGKrFG1kYKxnZGqiZ2RsoGdiEGtlaGBgZApUlZCR
	cfTeB+aCFewV/X2rmBoYe9i7GDk5hATUJG5+PsQIYksImEhMmfaOGcIWk7hwbz1bFyMXUM18
	RonNU76ygCRYBFQltu2AsNkEzCSOnf8N1iws4CQxe003mC0iIC9xa9pCNhCbWcBTYuL7GYwQ
	yxQlri1dDBbnFRCUODnzCQvEMhWJrtP/WCDiqhKT/rZDHSEhMWv6BVYIm1diRvtTqHo5iWlf
	10DVSEucn7WBEeboxd8fQ8X5JY7d3sHUxcgB1vvkfjDMmN2bv7BB2AISU88cZIQo0ZSYsFYc
	IswnsWbhWxaYKbtOLWeGab2/ZS4TxFeKElO6H7JD2FoSX37sw/AVr4CzxI0lO9kmMMrNQpKa
	haR9FpJ2ZDULGFlWMYqmFiQXFCelp5rrFSfmFpfmpesl5+duYgQnqGeCOxiXNlgcYhTgYFTi
	4dVw5AwUYk0sK67MPcQowcGsJMLbfBEoxJuSWFmVWpQfX1Sak1p8iDEZGH8TmaVEk/OByTOv
	JN7Q2MDY0NDS3MDU0MiCNGElcV7OiukBQgLpiSWp2ampBalFMFuYODilGhgz15dunBd19tbl
	7tnh61uFr09a0dfhKxN4KzbrdpuLYfkf28X5c1ceXKJplPiyess6HY76r5kVWZtD 
DLP-Filter: Pass
X-CFilter-Loop: Reflected
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/215108>

DQo+IEl0J3MgYWxtb3N0IGxpa2UgdGhlIGNvbXBpbGVyIGlzIGdldHRpbmcgdGhlIGluaXRpYWxp
emVyIHdyb25nLiBJdCdzIGENCj4gbG9uZyBzaG90LCBidXQgSSB3b25kZXIgaWYgdGhlIHByZXNl
bmNlIG9mIHRoZSBiaXRmaWVsZCBjb3VsZCBiZQ0KPiB0cmlnZ2VyaW5nIGEgY29tcGlsZXIgYnVn
IChvciB0aGVyZSBpcyBhIHN1YnRsZSBDIHJ1bGUgYWJvdXQgYml0ZmllbGQNCj4gaW5pdGlhbGl6
YXRpb25zIHRoYXQgSSBkbyBub3Qga25vdykuIEp1c3QgZm9yIHRoZSBzYWtlIG9mIG15IHNhbml0
eSwNCj4gd2hhdCBkb2VzIHRoZSBmb2xsb3dpbmcgcHJvZ3JhbSBvdXRwdXQgZm9yIHlvdT8NCg0K
SGksIA0KDQpqdXN0ICJjbXAgaXMgMCIgIGlzIHByaW50ZWQuDQoNCiQgZ2NjIC0tdmVyc2lvbg0K
Z2NjIChHQ0MpIDQuMS4yIDIwMDgwNzA0IChSZWQgSGF0IDQuMS4yLTQ4KQ0KQ29weXJpZ2h0IChD
KSAyMDA2IEZyZWUgU29mdHdhcmUgRm91bmRhdGlvbiwgSW5jLg0KVGhpcyBpcyBmcmVlIHNvZnR3
YXJlOyBzZWUgdGhlIHNvdXJjZSBmb3IgY29weWluZyBjb25kaXRpb25zLiAgVGhlcmUgaXMgTk8N
CndhcnJhbnR5OyBub3QgZXZlbiBmb3IgTUVSQ0hBTlRBQklMSVRZIG9yIEZJVE5FU1MgRk9SIEEg
UEFSVElDVUxBUiBQVVJQT1NFLg0KDQoNCkJlc3QgcmVnYXJkcywNCkpvbmdtYW4gSGVvLg==
