From: Jay Soffian <jaysoffian@gmail.com>
Subject: Re: orthogonal cases of log --date option
Date: Fri, 6 Mar 2009 03:31:55 -0500
Message-ID: <76718490903060031u2bbc5c08k6a635dcdb1c8bc32@mail.gmail.com>
References: <buo8wnnrpcf.fsf@dhlpc061.dev.necel.com>
	 <7vtz6bdmfi.fsf@gitster.siamese.dyndns.org>
	 <20090305104304.GA17760@coredump.intra.peff.net>
	 <76718490903051304j6d8138f7qa5492ac15edd6460@mail.gmail.com>
	 <20090305211120.GB20157@coredump.intra.peff.net>
	 <7vy6vjy5js.fsf@gitster.siamese.dyndns.org>
	 <20090306052318.GB3426@sigill.intra.peff.net>
	 <7vmybzw3el.fsf@gitster.siamese.dyndns.org>
	 <76718490903052258j277fa8e9g963deae1c3264a22@mail.gmail.com>
	 <7v1vtbw03h.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: base64
Cc: Jeff King <peff@peff.net>, Miles Bader <miles@gnu.org>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Mar 06 09:33:31 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LfVUk-0005f2-7d
	for gcvg-git-2@gmane.org; Fri, 06 Mar 2009 09:33:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752379AbZCFIb6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 6 Mar 2009 03:31:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752256AbZCFIb6
	(ORCPT <rfc822;git-outgoing>); Fri, 6 Mar 2009 03:31:58 -0500
Received: from rv-out-0506.google.com ([209.85.198.227]:39872 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751468AbZCFIb5 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 6 Mar 2009 03:31:57 -0500
Received: by rv-out-0506.google.com with SMTP id g37so395369rvb.1
        for <git@vger.kernel.org>; Fri, 06 Mar 2009 00:31:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=2GKnFqnsKzM/KiytcSEEZNfH9Y92ikvbBeSRnrZ6awA=;
        b=CCULHXJ4YwpfkKwYxlnV7bq33KROTLNdzx4RCp8083farny/9Cvm6x9G0RLG8vuOcK
         oAWeXYmOvgZC1ifVpwJZZgjjpeYUGdFYcFePUTmOLAWGfWqXmU1sOHQ9SyXhpFukek73
         iT5QE/u+Lo3o8ZbVHFgk5xLUOQnYUCOYVrcuE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=GFMz1das/8SJfoYJs/ftG7z2Hfn8wA1/oMReb3BoLCGOj+osRjulwb5rHfUxiY15cL
         SRZPuUgpuGJkhXx4H2AFwK+WI2T0OmYvhECbbkUyIMEVwppfDcj5NZR09eOT0yEvBftE
         D7Nh8OSr8lqV6Jpk/dRZUhEBvsCu2iT8T1BDg=
Received: by 10.141.180.16 with SMTP id h16mr1156560rvp.68.1236328315704; Fri, 
	06 Mar 2009 00:31:55 -0800 (PST)
In-Reply-To: <7v1vtbw03h.fsf@gitster.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/112406>

T24gRnJpLCBNYXIgNiwgMjAwOSBhdCAzOjAyIEFNLCBKdW5pbyBDIEhhbWFubyA8Z2l0c3RlckBw
b2JveC5jb20+IHdyb3RlOgo+Cj4gSXMgaXQ/IMKgSXNuJ3QgaXQganVzdCB0aGUgbWF0dGVyIG9m
IGRvaW5nIHNvbWV0aGluZyBsaWtlIHRoaXM/Cj4KPiDCoCDCoCDCoCDCoHN0cnVjdCBkYXRlX21v
ZGUgewo+IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgZW51bSB7Cj4gwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqBEQVRFX05PUk1BTCA9IDAsCj4gwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqBEQVRFX1JFTEFU
SVZFLAo+IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgLi4uCj4gwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqBEQVRFX1JBVwo+IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgfSBmb3JtYXQ7Cj4gwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqBlbnVtIHsKPiDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoERBVEVfT1JJR0lO
QUwgPSAwLAo+IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgREFURV9MT0NBTAo+IMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgLyogcGVyaGFwcyAiLERBVEVfR01UIiBsYXRlci4uLiAqLwo+IMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgfSB0el9vZmZzZXQ7Cj4gwqAgwqAgwqAgwqB9Owo+Cj4gwqAgwqAgwqAg
wqAvKiBJbiByZXZpc2lvbi5jOjpoYW5kbGVfcmV2aXNpb25fb3B0KCkgKi8KPiDCoCDCoCDCoCDC
oC4uLgo+IMKgIMKgIMKgIMKgfSBlbHNlIGlmICghc3RyY21wKGFyZywgIi0tZGF0ZT1sb2NhbCIp
KSB7Cj4gwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqByZXZzLT5kYXRlX21vZGUuZm9ybWF0ID0gREFU
RV9OT1JNQUw7Cj4gwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqByZXZzLT5kYXRlX21vZGUudHpfb2Zm
c2V0ID0gREFURV9MT0NBTDsKPiDCoCDCoCDCoCDCoH0gZWxzZSBpZiAoIXByZWZpeGNtcChhcmcs
ICItLWRhdGU9IikpIHsKPiDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoHJldnMtPmRhdGVfbW9kZS5m
b3JtYXQgPSBwYXJzZV9kYXRlX2Zvcm1hdChhcmcgKyA3KTsKPiDCoCDCoCDCoCDCoH0gZWxzZSBp
ZiAoIXN0cmNtcChhcmcsICItLXR6PWxvY2FsIikpIHsKPiDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oHJldnMtPmRhdGVfbW9kZS50el9vZmZzZXQgPSBEQVRFX0xPQ0FMOwo+IMKgIMKgIMKgIMKgfQo+
IMKgIMKgIMKgIMKgLi4uCj4KPiDCoCDCoCDCoCDCoC8qIEluIGRhdGUuYzo6c2hvd19kYXRlKCkg
Ki8KPiDCoCDCoCDCoCDCoC4uLgo+IMKgIMKgIMKgIMKgY29uc3QgY2hhciAqc2hvd19kYXRlKHVu
c2lnbmVkIGxvbmcgdGltZSwgaW50IHR6LCBzdHJ1Y3QgZGF0ZV9tb2RlICptb2RlXykKPiDCoCDC
oCDCoCDCoHsKPiDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoGludCBtb2RlID0gbW9kZV8tPmZvcm1h
dDsKPgo+IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgaWYgKG1vZGVfLT50el9vZmZzZXQgPT0gREFU
RV9MT0NBTCkKPiDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoHR6ID0gbG9jYWxf
dHpvZmZzZXQodGltZSk7Cj4KPiDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoC4uLgo+IMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgLyogYW5kIHJlbW92ZSB0aGUgZXhpc3RpbmcKPiDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoGlmIChtb2RlID09IERBVEVfTE9DQUwpCj4gwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqB0eiA9IGxvY2FsX3R6b2Zmc2V0KHRpbWUpOwo+IMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIHRoYXQgYXBwZWFycyBsYXRlciBpbiB0aGUgY29kZQo+IMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgKi8KPiDCoCDCoCDCoCDCoC4uLgoKClllYWgsIHRoYXQgcGFydCBpcyBlYXN5
LiBJIHdhc24ndCBzdXJlIHRoZSBiZXN0IHdheSB0byBoYW5kbGUgcGxhY2VzCndoZXJlIGEgY29u
c3RhbnQgZGF0ZV9tb2RlIGlzIHVzZWQgZS5nLjoKCnBwX3VzZXJfaW5mbyhOVUxMLCBDTUlUX0ZN
VF9FTUFJTCwgJnNiLCBjb21taXR0ZXIsIERBVEVfUkZDMjgyMiwKCQkgICAgIGVuY29kaW5nKTsK
CkkgaGFkIHN0YXJ0ZWQgb246CgpzdGF0aWMgY29uc3Qgc3RydWN0IGRhdGVfbW9kZSBkYXRlX3Jm
YzI4MjIgPSB7REFURV9SRkMyODIyLCBEQVRFX09SSUdJTkFMfTsKLi4uCnBwX3VzZXJfaW5mbyhO
VUxMLCBDTUlUX0ZNVF9FTUFJTCwgJnNiLCBjb21taXR0ZXIsICZkYXRlX3JmYzI4MjIsCgkJICAg
ICBlbmNvZGluZyk7CgpCdXQgSSBpbWFnaW5lIHRoZXJlJ3MgbWF5YmUgYSBiZXR0ZXIgd2F5IHRv
IGRvIHRoYXQuCgpqLgo=
