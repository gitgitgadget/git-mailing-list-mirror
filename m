From: "Praveen A" <pravi.a@gmail.com>
Subject: Re: gitweb and unicode special characters
Date: Fri, 12 Dec 2008 16:55:03 -0800
Message-ID: <3f2beab60812121655m6cd868bfhaaf386e6f5457533@mail.gmail.com>
References: <3f2beab60812121033r5d41894t77acc271b7c6955c@mail.gmail.com>
	 <m37i65gp6b.fsf@localhost.localdomain>
	 <m3y6ylf3mq.fsf@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: base64
Cc: git@vger.kernel.org, "Santhosh Thottingal" <santhosh00@gmail.com>
To: "Jakub Narebski" <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Sat Dec 13 01:56:45 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LBIoF-0005yH-2t
	for gcvg-git-2@gmane.org; Sat, 13 Dec 2008 01:56:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752732AbYLMAzI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 12 Dec 2008 19:55:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752216AbYLMAzI
	(ORCPT <rfc822;git-outgoing>); Fri, 12 Dec 2008 19:55:08 -0500
Received: from mail-gx0-f12.google.com ([209.85.217.12]:60401 "EHLO
	mail-gx0-f12.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752171AbYLMAzG (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 12 Dec 2008 19:55:06 -0500
Received: by gxk5 with SMTP id 5so1181712gxk.13
        for <git@vger.kernel.org>; Fri, 12 Dec 2008 16:55:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=bRJ87Wv8cnE9mzvyUT6/aQW1cTq7+dx4p3WkSs5qZtQ=;
        b=SaRyXD4suIyBYisJN3W2WItGHjPxdZWbNRj6kVkE8Rqlanig9zwLs6OO6y7PGkvYPo
         zPv0lxBw4DGIV0nW0OfAM/qUPXwhZh1Ky929JKFdBpA8PdOP1LWntwhhtfVZ+YsDMTcK
         0H8/xhZVUvlgjcl43lKl8P76cCE3cTatE5iFQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=vh5lwFpY7ipG7FALYZpwBlYyPOV/8mzpqhBB0F2oBVZKg5wsXRBnbKC1enh6uH+YCF
         wMWo1S6gEGfP2GUTZ5JS4ghqjoysQnDHlfaIEYQeu5RoFU6kvPStuiNcJyIqOGb5OW0V
         /8jHrIRTcni35pqITH5L9xEy2Wdn9vsjn+wP4=
Received: by 10.90.35.9 with SMTP id i9mr678996agi.98.1229129703882;
        Fri, 12 Dec 2008 16:55:03 -0800 (PST)
Received: by 10.90.56.1 with HTTP; Fri, 12 Dec 2008 16:55:03 -0800 (PST)
In-Reply-To: <m3y6ylf3mq.fsf@localhost.localdomain>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/102970>

MjAwOC8xMi8xMiBKYWt1YiBOYXJlYnNraSA8am5hcmViQGdtYWlsLmNvbT46Cj4gSmFrdWIgTmFy
ZWJza2kgPGpuYXJlYkBnbWFpbC5jb20+IHdyaXRlczoKPj4gIlByYXZlZW4gQSIgPHByYXZpLmFA
Z21haWwuY29tPiB3cml0ZXM6Cj4+Cj4+ID4gR2l0IGN1cnJlbnRseSBkb2VzIG5vdCBoYW5kbGUg
dW5pY29kZSBzcGVjaWFsIGNoYXJhY3RlcnMgWldKIGFuZCBaV05KLAo+PiA+IGJvdGggYXJlIGhl
YXZpbHkgdXNlZCBpbiBNYWxheWFsYW0gYW5kIGNvbW1vbiBpbiBvdGhlciBsYW5ndWFnZXMKPj4g
PiBuZWVkaW5nIGNvbXBsZXggdGV4dCBsYXlvdXQgbGlrZSBTaW5oYWxhIGFuZCBBcmFiaWMuCj4+
ID4KPj4gPiBBbiBleGFtcGxlIG9mIHRoaXMgaXMgc2hvd24gaW4gdGhlIGNvbW1pdCBtZXNzYWdl
IGhlcmUKPj4gPiBodHRwOi8vZ2l0LnNhdmFubmFoLmdudS5vcmcvZ2l0d2ViLz9wPXNtYy5naXQ7
YT1jb21taXQ7aD1jM2YzNjhjNjBhYWJkYzM4MGM3NzYwOGM2MTRkOTFiMGE2Mjg1OTBhCj4+ID4K
Pj4gPiBcMjAwMTQgYW5kIFwyMDAxNSBzaG91bGQgaGF2ZSBiZWVuIFpXTkogYW5kIFpXSiByZXNw
ZWN0aXZlbHkuIFlvdSBqdXN0Cj4+ID4gbmVlZCB0byBoYW5kbGUgdGhlbSBhcyBhbnkgb3RoZXIg
dW5pY29kZSBjaGFyYWN0ZXIgLSBlc3BlY2lhbGx5IGl0IGlzCj4+ID4gYSBjb21taXQgbWVzc2Fn
ZSBhbmQgZXhwZWN0YXRpb24gaXMgbm9ybWFsIHBhaW4gdGV4dCBkaXNwbGF5Lgo+PiA+Cj4+ID4g
SSBob3BlIHNvbWUgb25lIHdpbGwgZml4IHRoaXMuCj4+Cj4+IFdlbGwsIEkgYW0gYml0IHN0dW1w
ZWQuICBnaXRfY29tbWl0IGNhbGxzIGZvcm1hdF9sb2dfbGluZV9odG1sLCB3aGljaAo+PiBpbiB0
dXJuIGNhbGxzIGVzY19odG1sLiAgZXNjX2h0bWwgbG9va3MgbGlrZSB0aGlzOgo+Pgo+PiAgIHN1
YiBlc2NfaHRtbCAoJDslKSB7Cj4+ICAgICAgIG15ICRzdHIgPSBzaGlmdDsKPj4gICAgICAgbXkg
JW9wdHMgPSBAXzsKPj4KPj4gICAqKiAgJHN0ciA9IHRvX3V0ZjgoJHN0cik7Cj4+ICAgICAgICRz
dHIgPSAkY2dpLT5lc2NhcGVIVE1MKCRzdHIpOwo+PiAgICAgICBpZiAoJG9wdHN7Jy1uYnNwJ30p
IHsKPj4gICAgICAgICAgICAgICAkc3RyID1+IHMvIC8mbmJzcDsvZzsKPj4gICAgICAgfQo+PiAg
ICoqICAkc3RyID1+IHN8KFtbOmNudHJsOl1dKXwoKCQxIG5lICJcdCIpID8gcXVvdF9jZWMoJDEp
IDogJDEpfGVnOwo+PiAgICAgICByZXR1cm4gJHN0cjsKPj4gICB9Cj4+Cj4+IFRoZSB0d28gaW1w
b3J0YW50IGxpbmVzIGFyZSBtYXJrZWQgd2l0aCAnKionLgo+IFsuLi5dCj4KPj4gU28gaXQgbG9v
a3MgbGlrZSBQZXJsIHRyZWF0cyBcMjAwMTQgYW5kIFwyMDAxNSAoWldOSiBhbmQgWldKKSBhcwo+
PiBiZWxvbmdpbmcgdG8gJ1s6Y250cmw6XScgY2xhc3MuIEkgZG9uJ3Qga25vdyBpZiBpdCBpcyBj
b3JyZWN0IGZyb20gdGhlCj4+IHBvaW50IG9mIHZpZXcgb2YgVW5pY29kZSBjaGFyYWN0ZXIgY2xh
c3NlcywgdGhlcmVmb3JlIGlmIGl0IGlzIGEgYnVnCj4+IGluIFBlcmwsIG9yIGp1c3QgaW4gZ2l0
d2ViLgo+Cj4gSSBjaGVja2VkIHRoaXMsIHZpYSB0aGlzIHNpbXBsZSBQZXJsIHNjcmlwdDoKPgo+
ICAjIS91c3IvYmluL3BlcmwKPgo+ICB1c2UgY2hhcm5hbWVzICI6ZnVsbCI7Cj4KPiAgbXkgJGMg
PSBvcmQoIlxOe1pXTkp9Iik7Cj4gIHByaW50ZiAib2N0PSVvIGRlYz0lZCBoZXg9JXhcbiIsICRj
LCAkYywgJGM7Cj4KPiAgIlxOe1pXTkp9IiA9fiAvW1s6Y250cmw6XV0vIGFuZCBwcmludCAiaXMg
WzpjbnRybDpdIjsKPgo+IEFuZCB0aGUgYW5zd2VyIHdhczoKPgo+ICBvY3Q9MjAwMTQgZGV4PTgy
MDQgaGV4PTIwMGMKPiAgaXMgWzpjbnRybDpdCj4KPiAnWkVSTyBXSURUSCBOT04tSk9JTkVSJyBf
aXNfIGNvbnRyb2wgY2hhcmFjdGVyLi4uIFdlIHByb2JhYmx5IHNob3VsZAo+IHVzZSBbXls6cHJp
bnQ6XVs6c3BhY2U6XV0gaW5zdGVhZCBvZiBbWzpjbnRybDpdXSBoZXJlLgoKVGhhdCBsb29rcyBn
b29kLiBCdXQgSSdtIHdvbmRlcmluZyB3aHkgZG8gd2UgbmVlZCB0byBmaWx0ZXIgYXQgYWxsPwpJ
cyBpdCBhIHNlY3VyaXR5IGNvbmNlcm4/IEl0IGlzIGp1c3QgZGVzY3JpcHRpb24uCgo+Cj4gWy4u
Ll0KPj4gUC5TLiBFdmVuIHRoYXQgbWlnaHQgbm90IGhlbHAgbXVjaCwgYXMgU2F2YW5uYWggdXNl
cyBnaXQgYW5kIGdpdHdldgo+PiB2ZXJzaW9uIDEuNS42LjUsIHdoaWNoIGlzIHByb2JhYmx5IHZl
cnNpb24gcmVsZWFzZWQgd2l0aCBzb21lIG1ham9yCj4+IGRpc3RyaWJ1dGlvbi4gIEFzIG9mIG5v
dyB3ZSBhcmUgYXQgMS42LjAuNS4uLgo+Cj4gV2hpY2ggY2FuIGJlIHNlZW4gZnJvbSB0aGUgZmFj
dCB0aGF0IGdpdHdlYiB1c2VzIG9jdGFsIGVzY2FwZXMsCj4gaW5zdGVhZCBvZiBoZXggZXNjYXBl
cy4uLgoKQnV0IHdlIGNhbiBleHBlY3QgaXQgdG8gd29yayBzb21lZGF5IHdoZW4gc2F2YW5uYWgg
dXBkYXRlcyB0aGVpciBnaXQKdmVyc2lvbiwgb3Igd2UgY2FuIGJ1ZyB0aGVtIHRvIHVwZ3JhZGUg
aWYgdGhlIGZpeCBpcyBpbiBvZmZpY2lhbCBnaXQKcmVsZWFzZS4KCi0gUHJhdmVlbgpqNHY0bTRu
Cj4KPiAtLQo+IEpha3ViIE5hcmVic2tpCj4gUG9sYW5kCj4gU2hhZGVIYXdrIG9uICNnaXQKPgoK
CgotLSAK4LSq4LWN4LSw4LS14LWA4LSj4LWN4oCNIOC0heC0sOC0v+C0ruC1jeC0quC1jeC0sOC0
pOC1jeC0pOC1iuC0n+C0v+C0r+C0v+C0suC1jeKAjQo8R1BMdjI+IEkga25vdyBteSByaWdodHM7
IEkgd2FudCBteSBwaG9uZSBjYWxsIQo8RFJNPiBXaGF0IHVzZSBpcyBhIHBob25lIGNhbGwsIGlm
IHlvdSBhcmUgdW5hYmxlIHRvIHNwZWFrPwooYXMgc2VlbiBvbiAvLikKSm9pbiBUaGUgRFJNIEVs
aW1pbmF0aW9uIENyZXcgTm93IQpodHRwOi8vZmNpLndpa2lhLmNvbS93aWtpL0FudGktRFJNLUNh
bXBhaWduCg==
