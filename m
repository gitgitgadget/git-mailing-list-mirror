From: David Scurrah <D.Scurrah@bom.gov.au>
Subject: Re: Patch for git-completion.bash [SEC=UNCLASSIFIED]
Date: Mon, 16 Aug 2010 15:45:21 +1000
Message-ID: <0E3686EB9FA8AA409AFA0A25468DCE4301309C3DE86C@BOM-VMBX-HO.bom.gov.au>
References: <0E3686EB9FA8AA409AFA0A25468DCE4301309C3DE865@BOM-VMBX-HO.bom.gov.au>
 <AANLkTimGrrvz6myV=Fmioqh9=rt+Fh7qSSLcoma6Z-Bw@mail.gmail.com>
 <0E3686EB9FA8AA409AFA0A25468DCE4301309C3DE869@BOM-VMBX-HO.bom.gov.au>
 <AANLkTi=cKVeDNqP018ottyB0xW3xp1yosO1AY6CQbnUY@mail.gmail.com>
 <0E3686EB9FA8AA409AFA0A25468DCE4301309C3DE86A@BOM-VMBX-HO.bom.gov.au>
 <AANLkTi=QY+3M9jpuwXVcH1-yFhNQrjTfL9epTL-OYGMY@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Cc: "spearce@spearce.org" <spearce@spearce.org>,
	"git@vger.kernel.org" <git@vger.kernel.org>
To: "avarab@gmail.com" <avarab@gmail.com>
X-From: git-owner@vger.kernel.org Mon Aug 16 07:45:42 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OksVx-0002Jw-W0
	for gcvg-git-2@lo.gmane.org; Mon, 16 Aug 2010 07:45:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752454Ab0HPFpZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 16 Aug 2010 01:45:25 -0400
Received: from mgmtbom7.bom.gov.au ([134.178.63.157]:4008 "EHLO
	mgmtbom7.bom.gov.au" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752429Ab0HPFpY (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 16 Aug 2010 01:45:24 -0400
X-Protective-Marking: VER=2005.6, NS=gov.au, SEC=UNCLASSIFIED, 
    ORIGIN=D.Scurrah@bom.gov.au
Received: from BOM-CAS-HO2.bom.gov.au (bom-cas-ho2.bom.gov.au) by mgmtbom7.bom.gov.au
 (Clearswift SMTPRS 5.2.5) with ESMTP id <T9787fc518786b23f9da38@mgmtbom7.bom.gov.au>;
 Mon, 16 Aug 2010 15:45:21 +1000
Received: from BOM-VMBX-HO.bom.gov.au ([fe80::e8b6:c91e:5d4a:2993]) by
 BOM-CAS-HO2.bom.gov.au ([fe80::3dfa:9a29:fba2:d87e%16]) with mapi; Mon, 16
 Aug 2010 15:45:21 +1000
Thread-Topic: Patch for git-completion.bash [SEC=UNCLASSIFIED]
Thread-Index: Acs9BjcEinitjEinRx+yLTWgmiUryg==
In-Reply-To: <AANLkTi=QY+3M9jpuwXVcH1-yFhNQrjTfL9epTL-OYGMY@mail.gmail.com>
Accept-Language: en-US, en-AU
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
acceptlanguage: en-US, en-AU
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/153650>

VGhhbmtzIHJlYWRpbmcgdGhlIGxpc3Qgc2hvd2VkIHJ1bm5pbmcgYXMgc2ggaW5zdGVhZCBvZiBi
YXNoIHdhcyBteSBwcm9ibGVtCgpJIGFtIHRyeWluZyB0byBjb21iaW5lIHRoZSB2ZXJ5IHVzZWZ1
bCBnaXQtcHJvbXB0CihodHRwOi8vdm9sbml0c2t5LmNvbS9wcm9qZWN0L2dpdC1wcm9tcHQvKSBh
bmQgZ2l0LWNvbXBsZXRpb24uYmFzaApzY3JpcHRzIGFzIGVhY2ggaGFkIHNvbWV0aGluZyB0aGUg
b3RoZXIgbGFja2VkLgoKVGhlIHByb2JsZW0gaXMgdGhhdCB3aGlsZSBnaXQtcHJvbXB0IHN1Z2dl
c3RzIHlvdSBzdGFydCBpdCBmcm9tIC5iYXNocmMKdmlhIApbWyAkLSA9PSAqaSogXV0gICAmJiAg
IC4gL3BhdGgvdG8vZ2l0LXByb21wdC5zaAoKVXNpbmcgLiB0byBleGVjdXRlIGdpdC1jb21wbGV0
aW9uLmJhc2ggcnVucyBzaCB3aGljaCBydW5zIGJhc2ggaW4gc2gKZW11bGF0aW9uIG1vZGUgd2hp
Y2ggbWFrZXMgaXQgZmFpbCBpbiBzZXZlcmFsIHBsYWNlcy4KCkkgZGlkIHNlZSBhIHRocmVhZCBh
Ym91dCBhbiBhdHRlbXB0IHRvIG1ha2UgdGhlIHNjcmlwdCB6c2ggY29tcGxpYW50IGFzCndlbGws
IEkgd29uZGVyIGlmIGl0IHdvdWxkIGJlIGJldHRlciB0byBqdXN0IG1ha2UgaXQgc2ggY29tcGxp
YW50IHNvCnRoYXQgaXQgaXMgbW9yZSBwb3J0YWJsZSwgSSBndWVzcyB0aGF0J3MgdG9vIGhhcmQK
CnJlZ2FyZHMKCkRhdmlkIFNjdXJyYWgKPiA+Cj4gPiBPbiBNb24sIDIwMTAtMDgtMTYgYXQgMDQ6
MTQgKzAwMDAsIMOGdmFyIEFybmZqw7Zyw7AgQmphcm1hc29uIHdyb3RlOgo+ID4+IE9uIE1vbiwg
QXVnIDE2LCAyMDEwIGF0IDA0OjA5LCBEYXZpZCBTY3VycmFoIDxELlNjdXJyYWhAYm9tLmdvdi5h
dT4gd3JvdGU6Cj4gPj4gPiBIaSwKPiA+PiA+Cj4gPj4gPiBPbiBNb24sIDIwMTAtMDgtMTYgYXQg
MDE6MDkgKzAwMDAsIMOGdmFyIEFybmZqw7Zyw7AgQmphcm1hc29uIHdyb3RlOgo+ID4+ID4+IE9u
IE1vbiwgQXVnIDE2LCAyMDEwIGF0IDAwOjUzLCBEYXZpZCBTY3VycmFoIDxELlNjdXJyYWhAYm9t
Lmdvdi5hdT4gd3JvdGU6Cj4gPj4gPj4KPiA+PiA+PiBUaGFua3MgZm9yIG5vdCBzZW5kaW5nIGEg
Y2xhc3NpZmllZCBwYXRjaC4KPiA+PiA+Cj4gPj4gPiBIYSBoYSAtIHRoZSBBdXN0cmFsaWFuIEdv
dmVybm1lbnQgaGFzIHRvIGhhdmUgZW1haWwgY2xhc3NpZmljYXRpb25zIGZvcgo+ID4+ID4gZXZl
cnkgZW1haWwgc2VudCAtIGNsYXNzaWZpZWQgSSBiZWxpZXZlIGp1c3QgbWVhbnMgSSBkbyBub3Qg
d2lzaCB5b3UgdG8KPiA+PiA+IHNoYXJlIGl0IG5vdCB0aGF0IGl0IGlzIGEgc3RhdGUgc2VjcmV0
IChzZWUgb25lIGltcGxlbWVudGF0aW9uCj4gPj4gPiBodHRwOi8vd3d3LmphbnVzLm5ldC5hdS9q
YW51c1NFQUwvT3V0bG9vay9mZWF0dXJlcykKPiA+PiA+Cj4gPj4gPgo+ID4+ID4+IEhhdmUgeW91
IHNlZW4gdGhlICJbYmFzaC1jb21wbGV0aW9uXSBzeW50YXggZXJyb3IgbmVhciB1bmV4cGVjdGVk
Cj4gPj4gPj4gdG9rZW4gJzwnIG9uIGxpbmUgMTIzIGluIGJhc2hfY29tcGxldGlvbi5kL2dpdCIg
dGhyZWFkIHJlY2VudGx5IG9uCj4gPj4gPj4gdGhpcyBsaXN0PyBJdCBwcm9iYWJseSBkZXNjcmli
ZXMgdGhlIHByb2JsZW0geW91J3JlIGhhdmluZy4KPiA+PiA+Cj4gPj4gPiBJJ2xsIGxvb2tlZCBo
YXJkIGFuZCBjYW4ndCBmaW5kIHRoZSB0aHJlYWQgeW91IG1lbnRpb25lZAo+ID4+ID4gYW5kIHRo
ZSBjdXJyZW50IHZlcnNpb24gb24gbXkgRmVkb3JhIHN5c3RlbSBkb2VzIG5vdCBjb21wbGV0ZSBm
aXJzdAo+ID4+ID4gbGV2ZWwgY29tbWFuZHMgbGlrZSBjaGVja291dCAuLi4KPiA+Pgo+ID4+IGh0
dHA6Ly9jb21tZW50cy5nbWFuZS5vcmcvZ21hbmUuY29tcC52ZXJzaW9uLWNvbnRyb2wuZ2l0LzE1
MTcyMwo+ID4+Cj4gPj4gPiBNYXliZSB0aGVyZSBpcyBzb21ldGhpbmcgSSBhbSBtaXNzaW5nLgo+
ID4+Cj4gPj4gWW91J3JlIHByb2JhYmx5IGV4ZWN1dGluZyB0aGUgY29tcGxldGlvbiBmaWxlIGlu
IGJhc2gncyBzaCBjb21wYXRpYmlsaXR5IG1vZGUuCgoK
