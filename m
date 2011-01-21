From: Detlef Vollmann <dv@vollmann.ch>
Subject: Re: cannot fetch arm git tree
Date: Fri, 21 Jan 2011 16:14:18 +0100
Message-ID: <4D39A2CA.5030504@vollmann.ch>
References: <AANLkTikRrewCLGDTU7DjVssjpxz-EFK8AhRScAGPRumg@mail.gmail.com>
	<20110116092315.GA27542@n2100.arm.linux.org.uk>
	<20110116110819.GG6917@pengutronix.de>
	<AANLkTinrZ0GnT71GCueUUpAXM5ckq+LBd0RjA51DMR-a@mail.gmail.com>
	<20110116134248.GD27542@n2100.arm.linux.org.uk>
	<4D398C43.1000306@vollmann.ch>
	<20110121134728.GO14956@pengutronix.de>
	<20110121135725.GR13235@n2100.arm.linux.org.uk>
	<4D3997FE.5030109@vollmann.ch>
	<20110121145025.GS13235@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Content-Transfer-Encoding: base64
Cc: linux-arm-kernel@lists.infradead.org, Jello huang <ruifeihuang@gmail.com>,
	git@vger.kernel.org,
	=?UTF-8?B?VXdlIEtsZWluZS1Lw7ZuaWc=?= <u.kleine-koenig@pengutronix.de>
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
X-From: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org Fri Jan 21 16:14:56 2011
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Envelope-to: linux-arm-kernel@m.gmane.org
Received: from canuck.infradead.org ([134.117.69.58])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>)
	id 1PgIhP-0003Yl-Q4
	for linux-arm-kernel@m.gmane.org; Fri, 21 Jan 2011 16:14:51 +0100
Received: from localhost ([127.0.0.1] helo=canuck.infradead.org)
	by canuck.infradead.org with esmtp (Exim 4.72 #1 (Red Hat Linux))
	id 1PgIh5-0006HZ-R9; Fri, 21 Jan 2011 15:14:31 +0000
Received: from mailrelay04.sunrise.ch ([194.158.229.47]
	helo=smtp-be-02.be08.sunrise.ch)
	by canuck.infradead.org with esmtps (Exim 4.72 #1 (Red Hat Linux))
	id 1PgIh1-0006H3-BL for linux-arm-kernel@lists.infradead.org;
	Fri, 21 Jan 2011 15:14:28 +0000
Received: from [192.168.26.14] (212-98-43-140.static.adslpremium.ch
	[212.98.43.140])
	by smtp-be-02.be08.sunrise.ch (8.13.1/8.12.10) with ESMTP id
	p0LFEI7U001549; Fri, 21 Jan 2011 16:14:18 +0100
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US;
	rv:1.9.2.13) Gecko/20101208 Thunderbird/3.1.7
In-Reply-To: <20110121145025.GS13235@n2100.arm.linux.org.uk>
X-CRM114-Version: 20090807-BlameThorstenAndJenny ( TRE 0.7.6 (BSD) )
	MR-646709E3 
X-CRM114-CacheID: sfid-20110121_101427_670748_599CB782 
X-CRM114-Status: GOOD (  13.59  )
X-Spam-Score: 0.0 (/)
X-Spam-Report: SpamAssassin version 3.3.1 on canuck.infradead.org summary:
	Content analysis details:   (0.0 points)
	pts rule name              description
	---- ----------------------
	--------------------------------------------------
X-BeenThere: linux-arm-kernel@lists.infradead.org
X-Mailman-Version: 2.1.12
Precedence: list
List-Id: <linux-arm-kernel.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>, 
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>, 
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/165375>

T24gMDEvMjEvMTEgMTU6NTAsIFJ1c3NlbGwgS2luZyAtIEFSTSBMaW51eCB3cm90ZToKPiBPbiBG
cmksIEphbiAyMSwgMjAxMSBhdCAwMzoyODoxNFBNICswMTAwLCBEZXRsZWYgVm9sbG1hbm4gd3Jv
dGU6Cj4+IEl0IHNlZW1zIHRvIGJlIGFuIGltcGxlbWVudGF0aW9uIG9mIHRoZSBnaXQgcHJvdG9j
b2wgdXNpbmcKPj4gSFRUUCBhcyB0cmFuc3BvcnQuCj4+IFNvbWUgaW5mbyBvbiB0aGlzIGlzIGF0
PGh0dHA6Ly9wcm9naXQub3JnLzIwMTAvMDMvMDQvc21hcnQtaHR0cC5odG1sPi4KPgo+IFNldHRp
bmcgdXAgU21hcnQgSFRUUAo+Cj4gLi4uCj4gICAgIFRvIHNldCBpdCB1cCwgaXTilqBzIGJlc3Qg
dG8gd2FsayB0aHJvdWdoIHRoZSBpbnN0cnVjdGlvbnMgb24gdGhlCj4gICAgIGBnaXQtaHR0cC1i
YWNrZW5kYCBkb2N1bWVudGF0aW9uIHBhZ2UuIEJhc2ljYWxseSwgeW91IGhhdmUgdG8gaW5zdGFs
bCBHaXQKPiAgICAgdjEuNi42IG9yIGhpZ2hlciBvbiBhIHNlcnZlciB3aXRoIGFuIEFwYWNoZSAy
Lnggd2Vic2VydmVyIChpdCBoYXMgdG8gYmUKPiAgICAgQXBhY2hlLCBjdXJyZW50bHkgLSBvdGhl
ciBDR0kgc2VydmVycyBkb27ilqB0IHdvcmssIGxhc3QgSSBjaGVja2VkKS4gVGhlbgo+ICAgICB5
b3UgYWRkIHNvbWV0aGluZyBzaW1pbGFyIHRvIHRoaXMgdG8geW91ciBodHRwLmNvbmYgZmlsZToK
Pgo+ICAgU2V0RW52IEdJVF9QUk9KRUNUX1JPT1QgL3Zhci93d3cvZ2l0Cj4gICBTZXRFbnYgR0lU
X0hUVFBfRVhQT1JUX0FMTAo+ICAgU2NyaXB0QWxpYXMgL2dpdC8gL3Vzci9saWJleGVjL2dpdC1j
b3JlL2dpdC1odHRwLWJhY2tlbmQvCj4KPiBHcmVhdC4gIERlY2lkaW5nIHRoYXQgaXQgd2lsbCBi
ZSBodHRwOi8vc2VydmVybmFtZS5leGFtcGxlLmNvbS9naXQvIGlzCj4gcmVhbGx5IGRhbW5lZCBh
bm5veWluZyBhcyB0aGF0J3MgdHJhZGl0aW9uYWxseSB3aGVyZSBnaXR3ZWIgbGl2ZXMsCj4gd2hp
Y2ggcmVxdWlyZXMgYSBkaWZmZXJlbnQgc2NyaXB0IGFsaWFzLgo+Cj4gSXQgc2VlbXMgdGhhdCBk
dWUgdG8gYSBsYWNrIG9mIGNvb3JkaW5hdGlvbiBiZXR3ZWVuIGRpZmZlcmVudCBnaXQKPiBkZXZl
bG9wZXJzLCBwZW9wbGUgcnVubmluZyB3ZWJzZXJ2ZXJzIGhhdmUgYSBjaG9pY2UgYmV0d2VlbiBw
cm92aWRpbmcKPiBnaXR3ZWIgb3IgdGhpcyBodHRwIGV4dGVuc2lvbi4KSHVoPwovZ2l0LyBpcyBq
dXN0IHRoZSBleGFtcGxlIGhlcmUsIHlvdSBjYW4gdXNlIGFueSBuYW1lIHlvdSB3YW50LgpFLmcu
IEkgdXNlIC9hdXRoLyBmb3IgYXV0aGVudGljYXRlZCB1c2VycywgYW5kIG90aGVycyB1c2UgL2dp
dG1vYi8Kb3IgL2dpdGFub24vIGZvciBub24tYXV0aGVudGljYXRlZCB1c2Vycy4KQW5kIHlvdSBj
YW4gdXNlIHNvbWV0aGluZyBsaWtlIGdpdHNtYXJ0LCBnaXRodHRwLCBvciB3aGF0ZXZlci4uLgoK
ICAgRGV0bGVmCgoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X18KbGludXgtYXJtLWtlcm5lbCBtYWlsaW5nIGxpc3QKbGludXgtYXJtLWtlcm5lbEBsaXN0cy5p
bmZyYWRlYWQub3JnCmh0dHA6Ly9saXN0cy5pbmZyYWRlYWQub3JnL21haWxtYW4vbGlzdGluZm8v
bGludXgtYXJtLWtlcm5lbAo=
