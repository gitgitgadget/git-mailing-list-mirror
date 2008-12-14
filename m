From: "Li Frank" <lznuaa@gmail.com>
Subject: Re: Announce: TortoiseGit 0.1 preview version
Date: Sun, 14 Dec 2008 21:29:14 +0800
Message-ID: <1976ea660812140529k1499b410u4437645be0dc7dfc@mail.gmail.com>
References: <1976ea660812130033m2d54cc57tfe134fab0d687d71@mail.gmail.com>
	 <m3d4fuewe0.fsf@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=GB2312
Content-Transfer-Encoding: base64
To: "Jakub Narebski" <jnareb@gmail.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Dec 14 14:30:40 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LBr3P-0002dd-Ke
	for gcvg-git-2@gmane.org; Sun, 14 Dec 2008 14:30:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753094AbYLNN3R (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 14 Dec 2008 08:29:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753120AbYLNN3Q
	(ORCPT <rfc822;git-outgoing>); Sun, 14 Dec 2008 08:29:16 -0500
Received: from mail-gx0-f12.google.com ([209.85.217.12]:41675 "EHLO
	mail-gx0-f12.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753080AbYLNN3Q (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 14 Dec 2008 08:29:16 -0500
Received: by gxk5 with SMTP id 5so1558076gxk.13
        for <git@vger.kernel.org>; Sun, 14 Dec 2008 05:29:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=EmezS3bnkshEioyZ3uRH5EimmsRx4yza4jZD+beaxlE=;
        b=FwAWEwuYDN6OtDIZq95EW4dPfwlPje9zwqCI4v/gXoL9v976OBnV2vIXbOznpKPocS
         NEk2xuaKWuwcmaHbOXAsFVawFDs2ECJObeAB61YisxYy2flrcMUJ+ZRhwLKAxbWMYpuU
         OUhN7oxWqykyYnFNIHOUIqDgGWmwGNlmDLK38=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=wQLEmz4J/TLLI25ner8XBgMo6FtCa+/FifavaJ8+Nm27H3apVaPY8y4F0Z8iAdI3rw
         navpG7FT4DwSDwKqoAaL0lqw1XweYlmeM+4goOawBZVhk+KR3plpuVhcdNX1ou/dKr7u
         42zcf3+EsP4XS3sGn5LRIJhgmuYymvLOrQA6o=
Received: by 10.150.92.10 with SMTP id p10mr10549979ybb.45.1229261354913;
        Sun, 14 Dec 2008 05:29:14 -0800 (PST)
Received: by 10.151.134.2 with HTTP; Sun, 14 Dec 2008 05:29:14 -0800 (PST)
In-Reply-To: <m3d4fuewe0.fsf@localhost.localdomain>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/103082>

R2l0Q2hlZXRhaCBqdXN0IHNob3cgZ2l0LWd1aSAmZ2l0LWJhc2ggYXQgY29udGV4dCBtZW51IQoK
VG9ydG9pc2VHaXQgaXMgZnVsbCBwb3J0aW5nIGZyb20gVG9ydG9pc2VTVk4uIE92ZXJsYXkgaWNv
biBjYW4gc2hvdwptb2RpZmllZCBmaWxlLCBhZGQgZmlsZSBhbmQgY29uZmxpY3RlZCBmaWxlIHdo
aXRoIGRpZmZlcmVudCBpY29uLgoKVG9ydG9pc2VHaXQgY2FuIGNvbW1pdCBjaGFuZ2UsIHNob3cg
bG9nLCBjaGVja291dCAuLi4gYXQgQ29udGV4dCBtZW51IQpJdCBpcyBmdWxsIGdpdCBmb250ZW5k
LgoKVG9ydG9pc2VHaXQgaXMgaW4gdmVyeSBlYXJseSBzdGFnZS4gSSBqdXN0IGltcGxlbWVudCBt
aW4gc2V0IGZlYXR1cmUKYW5kIG5vdCBtYXR1cmUgLiBJIGhvcGUgdGhlcmUgYXJlIG1vcmUgYW5k
IG1vcmUgcGVvcGxlIGludm9sdmUgdGhpcwpwcm9qZWN0IGFuZCBtYWtlIGl0IG1hdHVyZSBhcyBU
b3J0b2lzZVNWTi4KCjIwMDgvMTIvMTQgSmFrdWIgTmFyZWJza2kgPGpuYXJlYkBnbWFpbC5jb20+
Ogo+ICLA7tbHIiA8bHpudWFhQGdtYWlsLmNvbT4gd3JpdGVzOgo+Cj4+IFRvcnRvaXNlR2l0IGlz
IHBvcnRpbmcgZnJvbSBUb3J0b2lzZVNWTi4gIEl0IGlzIGV4cGxvcmUgZXh0ZW5zaW9uLgo+PiBU
aGlzIHZlcnNpb24ganVzdCBmaW5pc2ggYSBtaW5pbXVtIHNldCBvZiBUb3J0b2lzZVNWTiBwb3J0
aW5nCj4KPiBIb3cgaXQgZGlmZmVycyBmcm9tIEdpdENoZWV0YWggcHJvamVjdD8KPgo+IFsuLi5d
Cj4+IFByb2plY3QgSG9tZSBQYWdlIGF0Ogo+PiBodHRwOi8vY29kZS5nb29nbGUuY29tL3AvdG9y
dG9pc2VnaXQvCj4+Cj4+IFNvdXJjZSBjb2RlIGF0Cj4+IGh0dHA6Ly9yZXBvLm9yLmN6L3cvVG9y
dG9pc2VHaXQuZ2l0Cj4+Cj4+IEl0IG5lZWQgbXN5c2dpdCAxLjYuMC4yLgo+Cj4gRG8geW91IGZl
ZWwgaXQgaXMgbWF0dXJlIGVub3VnaCB0byBiZSBhZGRlZCB0byBnaXQgd2lraSBwYWdlCj4gIGh0
dHA6Ly9naXQub3IuY3ovZ2l0d2lraS9JbnRlcmZhY2VzRnJvbnRlbmRzQW5kVG9vbHMKPiBqdXN0
IGFib3ZlICJHaXQgRXh0ZW5zaW9ucyIgZW50cnk/ICBXb3VsZCB5b3UgZG8gaXQsIG9yIHNob3Vs
ZAo+IEkgZG8gdGhpcz8KPgo+IC0tCj4gSmFrdWIgTmFyZWJza2kKPiBQb2xhbmQKPiBTaGFkZUhh
d2sgb24gI2dpdAo+Cg==
