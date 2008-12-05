From: "Felipe Contreras" <felipe.contreras@gmail.com>
Subject: Re: Git weekly news: 2008-49
Date: Fri, 5 Dec 2008 23:57:26 +0200
Message-ID: <94a0d4530812051357m4f0bc591n802c41a78e698b3b@mail.gmail.com>
References: <94a0d4530812041643r784ae8b1x242e3b2f9c9f41@mail.gmail.com>
	 <m3d4g6ipah.fsf@localhost.localdomain>
	 <94a0d4530812050946r5ea7ddb2v1d93d28ba679813b@mail.gmail.com>
	 <adf1fd3d0812051344x79fe2c10i77b2abb8e7e19fe@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: base64
Cc: "Jakub Narebski" <jnareb@gmail.com>,
	"git list" <git@vger.kernel.org>
To: "=?UTF-8?Q?Santi_B=C3=A9jar?=" <santi@agolina.net>
X-From: git-owner@vger.kernel.org Fri Dec 05 22:58:59 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L8ihB-0004Uo-Up
	for gcvg-git-2@gmane.org; Fri, 05 Dec 2008 22:58:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756032AbYLEV53 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 5 Dec 2008 16:57:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755737AbYLEV53
	(ORCPT <rfc822;git-outgoing>); Fri, 5 Dec 2008 16:57:29 -0500
Received: from ey-out-2122.google.com ([74.125.78.24]:44664 "EHLO
	ey-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754330AbYLEV52 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 5 Dec 2008 16:57:28 -0500
Received: by ey-out-2122.google.com with SMTP id 6so93991eyi.37
        for <git@vger.kernel.org>; Fri, 05 Dec 2008 13:57:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=LYY907PYLIm/GsxGfOPpbV7wVlcD70qAkPlQ8KptL0k=;
        b=uh2NYjKiK/AOsrCM0zzAnjYzXSLxxTKNr6fws7aKAcxFiZwm5ZfCG4fr5DlJWZAaVR
         sJfPOhNHOOpWu8rhuGSMFH+RfOs6WyG6OxpoC4GOHFhZAW8fEjE0KG0v0RbWbKXBazXS
         /ZmnddL6pm1mgIOMjo9u3ZOLsXx7Mxd3LoLqY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=GOKqgQPDesDn2+MkNQsSHjdBtGPGV3UaGFvU1d/q2iLh8+OAXWyfsnC03s5ntsfWJ9
         zTRVt/dJQAAg4wwuWgGQy5A9XV/APlWh7RgHaB0Ojhcnbl1VB8XlNThYAZtS19Bxj/u/
         q2G7RdSBCowvuNfphoCuzVJ7F5ND4JFF0l8iU=
Received: by 10.210.111.4 with SMTP id j4mr414377ebc.170.1228514246927;
        Fri, 05 Dec 2008 13:57:26 -0800 (PST)
Received: by 10.210.50.8 with HTTP; Fri, 5 Dec 2008 13:57:26 -0800 (PST)
In-Reply-To: <adf1fd3d0812051344x79fe2c10i77b2abb8e7e19fe@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/102415>

T24gRnJpLCBEZWMgNSwgMjAwOCBhdCAxMTo0NCBQTSwgU2FudGkgQsOpamFyIDxzYW50aUBhZ29s
aW5hLm5ldD4gd3JvdGU6Cj4gMjAwOC8xMi81IEZlbGlwZSBDb250cmVyYXMgPGZlbGlwZS5jb250
cmVyYXNAZ21haWwuY29tPjoKPj4gT24gRnJpLCBEZWMgNSwgMjAwOCBhdCA2OjAyIFBNLCBKYWt1
YiBOYXJlYnNraSA8am5hcmViQGdtYWlsLmNvbT4gd3JvdGU6Cj4KPiBbLi4uXQo+Cj4+Pj4gQnV0
IGhlcmUgYXJlIHRoZSBsaW5rcyBhbnl3YXkuIFRoZSBvcmRlciBpcyByYXRoZXIgcmFuZG9tLgo+
Pj4KPj4+IE1vcmVvdmVyIHRoZSBfcXVhbGl0eV8gb2YgdGhvc2UgbGlua3MgaXMgdmVyeSByYW5k
b20uCj4+Cj4+IEV4YWN0bHksIEkgZGlkbid0IGNob29zZSB0aGVtLCB0aGF0J3Mgd2hhdCBwZW9w
bGUgaGF2ZSBiZWVuIHRhZ2dpbmcgYXMKPj4gImdpdCIgaW4gZGVsaWNpb3VzLmNvbS4gSSdtIHN1
YnNjcmliZWQgdG8gdGhlIFJTUyBmZWVkIGFuZCBzYXZpbmcgdGhlCj4+IG9uZXMgdGhhdCBhcHBl
YXIgYSBsb3QuCj4+Cj4+IEluIGZhY3QgSSBkb24ndCBsaWtlIHNvbWUgb2YgdGhlbSwgYnV0IHRo
YXQncyB3aGF0IHRoZSAicHVibGljIiBmaW5kcwo+PiBpbnRlcmVzdGluZy4KPgo+IFNvIEkgZG9u
J3Qgc2VlIHRoZSB2YWx1ZSBvZiBzdWNoIGEgbGlzdC4gWW91IGNhbiBnbyB0byBkZWxpY2lvdXMg
YW5kCj4gZ2V0IGl0LgoKVHJ5IGl0LiBZb3UgY2FuJ3Qgc2VlIHdoaWNoIG9uZXMgYXJlIG5ldywg
d2hpY2ggYXJlIGNvbXBsZXRlbHkKaXJyZWxldmFudC4gVGhlcmUgYXJlIGR1cGxpY2F0ZXMgYW5k
IHlvdSBjYW4ndCBzZWUgdGhlIHBvcHVsYXJpdHkgLwpmcmVzaG5lc3MgcmF0aW8sIG9yICJob3Ru
ZXNzIiwgbmV2ZXIgbWluZCB0aGUgbW9zdCBwb3B1bGFyIHRoaXMgd2Vlay4KCkFwcGFyZW50bHkg
c29tZSBwZW9wbGUgYWxyZWFkeSBmb3VuZCBpbnRlcmVzdGluZyBsaW5rcyB0aGV5IGhhdmVuJ3QK
c2VlbiBiZWZvcmUsIHNvIGF0IGxlc3QgdGhlcmUncyB2YWx1ZSBmb3IgdGhlbS4KCj4gQW5vdGhl
ciB0aGluZyB0aGF0IGNvdWxkIGJlIGdyZWF0IGlzIGZpbHRlcmluZyB0aGlzIGxpc3QgdG8KPiB0
aG9zZSB0aGF0IHBhc3MgYSBjZXJ0YWluIGNyaXRlcmlhIChtYWlubHkgcXVhbGl0eSwgdXAgdG8g
ZGF0ZSwgLi4uKQo+IGFuZCBwcmVzZW50IGl0IGluIGFuIGF0dHJhY3RpdmUgd2F5LCB3aXRoIHN1
bW1hcmllcywgY2F0ZWdvcml6ZWQgYnkKPiB0eXBlICh0cmljaywgdHV0b3JpYWwsIGNvbXBhcmlz
b24sLi4uKSwgLi4uCgpZZXMsIEknbGwgcHJvYmFibHkgaW1wcm92ZSB0aGUgcHJlc2VudGF0aW9u
LgoKLS0gCkZlbGlwZSBDb250cmVyYXMK
