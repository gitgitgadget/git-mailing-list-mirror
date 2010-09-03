From: Knut Franke <k.franke@science-computing.de>
Subject: Re: simple example for git hooks
Date: Fri, 3 Sep 2010 11:43:08 +0200
Organization: science + computing ag
Message-ID: <201009031143.10539.k.franke@science-computing.de>
References: <i5p96s$u7q$1@dough.gmane.org> <AANLkTimEo=sV=bKHyuQ5Md_7uQ0jAFKx+=dv4+KK+oD7@mail.gmail.com> <i5p9vl$tk$1@dough.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Cc: git@vger.kernel.org
To: Gelonida <gelonida@gmail.com>
X-From: git-owner@vger.kernel.org Fri Sep 03 11:56:27 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OrT0Q-0006gQ-Ol
	for gcvg-git-2@lo.gmane.org; Fri, 03 Sep 2010 11:56:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752810Ab0ICJ4Q (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 3 Sep 2010 05:56:16 -0400
Received: from smtp2.belwue.de ([129.143.2.15]:45164 "EHLO smtp2.belwue.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751138Ab0ICJ4Q (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 3 Sep 2010 05:56:16 -0400
X-Greylist: delayed 781 seconds by postgrey-1.27 at vger.kernel.org; Fri, 03 Sep 2010 05:56:15 EDT
Received: from mx4.science-computing.de (mx4.science-computing.de [193.197.16.30])
	by smtp2.belwue.de with ESMTP id o839hCuV013859
	for <git@vger.kernel.org>; Fri, 3 Sep 2010 11:43:12 +0200 (MEST)
	env-from (prvs=85582cedd=k.franke@science-computing.de)
Received: from localhost (localhost [127.0.0.1])
	by scmail.science-computing.de (Postfix) with ESMTP id 0B4FA414002;
	Fri,  3 Sep 2010 11:43:12 +0200 (CEST)
X-Virus-Scanned: amavisd-new
Received: from scmail.science-computing.de ([127.0.0.1])
	by localhost (obitest.science-computing.de [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id ORQteOeptUHd; Fri,  3 Sep 2010 11:43:11 +0200 (CEST)
Received: from sirmione.science-computing.de (sirmione.science-computing.de [10.10.24.2])
	by scmail.science-computing.de (Postfix) with ESMTP id 65E2D414001;
	Fri,  3 Sep 2010 11:43:11 +0200 (CEST)
Received: from sirmione.localnet (localhost [127.0.0.1])
	by sirmione.science-computing.de (Postfix) with ESMTP id 4DAABAE3EA;
	Fri,  3 Sep 2010 11:43:11 +0200 (CEST)
User-Agent: KMail/1.10.3 (Linux/2.6.27.29-0.1-pae; KDE/4.1.3; i686; ; )
In-Reply-To: <i5p9vl$tk$1@dough.gmane.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/155238>

T24gRnJpZGF5IDAzIFNlcHRlbWJlciAyMDEwIDAwOjU0OjQ0IEdlbG9uaWRhIHdyb3RlOgo+IG9r
LCBzbyBpdCBzZWVtcyB3aGF0IEknbSBtaXNzaW5nIGlzIFRIRSBjb21tYW5kIHRvIGxpc3QgYWxs
IGFkZGVkIC8KPiBtb2RpZmllZCBmaWxlcwo+IEkgY291bGQgb2YgY291cnNlIHVzZQo+IAo+IGdp
dCBzdGF0dXMKPiAKPiBhbmQgcGFyc2UgaXRzIG91dHB1dCwgYnV0IHRoaXMgaXMgcHJvYmFibHkg
bm90IHRoZSByaWdodCB3YXkgdG8gZG8uCgpOb3QgdW5sZXNzIHlvdSB1c2UgdGhlIC0tcG9yY2Vs
YWluIG9wdGlvbiwgd2hpY2ggaXMgZXhwbGljaXRseSBtZWFudCB0byBwcm9kdWNlCnBhcnNhYmxl
IG91dHB1dC4KCkZvciBpbnN0YW5jZSwgaWYgImEiIGhhcyBzdGFnZWQgbW9kaWZpY2F0aW9ucywg
ImIiIGhhcyB1bnN0YWdlZCBtb2RpZmljYXRpb25zCmFuZCAgImMiIGlzIGFkZGVkIChhbmQgc3Rh
Z2VkKSwgeW91J2xsIGdldAoKJCBnaXQgc3RhdHVzIC0tcG9yY2VsYWluICAgIApNICBhICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIAogTSBiICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgIApBICBjCgppLmUuIHRoZSBmaXJzdCBjaGFyYWN0
ZXIgaW4gYSBsaW5lIGRlbm90ZXMgdGhlIGRpZmZlcmVuY2UgYmV0d2VlbiBIRUFEIGFuZAppbmRl
eCBhbmQgdGhlIHNlY29uZCBjaGFyYWN0ZXIgZGVub3RlcyB0aGUgZGlmZmVyZW5jZSBiZXR3ZWVu
IGluZGV4IGFuZAp3b3JraW5nIGNvcHkuCi0tIApWb3JzdGFuZC9Cb2FyZCBvZiBNYW5hZ2VtZW50
OgpEci4gQmVybmQgRmlua2JlaW5lciwgRHIuIFJvbGFuZCBOaWVtZWllciwgCkRyLiBBcm5vIFN0
ZWl0eiwgRHIuIEluZ3JpZCBaZWNoClZvcnNpdHplbmRlciBkZXMgQXVmc2ljaHRzcmF0cy8KQ2hh
aXJtYW4gb2YgdGhlIFN1cGVydmlzb3J5IEJvYXJkOgpNaWNoZWwgTGVwZXJ0ClNpdHovUmVnaXN0
ZXJlZCBPZmZpY2U6IFR1ZWJpbmdlbgpSZWdpc3RlcmdlcmljaHQvUmVnaXN0cmF0aW9uIENvdXJ0
OiBTdHV0dGdhcnQKUmVnaXN0ZXJudW1tZXIvQ29tbWVyY2lhbCBSZWdpc3RlciBOby46IEhSQiAz
ODIxOTYgCgo=
