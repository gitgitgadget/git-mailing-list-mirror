From: "Nguyen Thai Ngoc Duy" <pclouds@gmail.com>
Subject: Re: [PATCH v2 00/14] Sparse checkout
Date: Fri, 26 Sep 2008 23:00:02 +0700
Message-ID: <fcaeb9bf0809260900g4011411fkff1d61029c362e75@mail.gmail.com>
References: <1221904913-25887-1-git-send-email-pclouds@gmail.com>
	 <m31vzen4v5.fsf@localhost.localdomain>
	 <fcaeb9bf0809201033o1e9298a8ob135c68228b77218@mail.gmail.com>
	 <200809202001.28383.jnareb@gmail.com>
	 <fcaeb9bf0809201248w2850a243n50596dda3121f2c@mail.gmail.com>
	 <7vzlm21n83.fsf@gitster.siamese.dyndns.org>
	 <fcaeb9bf0809210311x7e9337fbmd978e95aa7998525@mail.gmail.com>
	 <adf1fd3d0809230406r598f6d1l41cd860568de761f@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: base64
Cc: "Junio C Hamano" <gitster@pobox.com>,
	"Jakub Narebski" <jnareb@gmail.com>, git@vger.kernel.org
To: "=?UTF-8?Q?Santi_B=C3=A9jar?=" <santi@agolina.net>
X-From: git-owner@vger.kernel.org Fri Sep 26 18:01:26 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KjFks-0005gO-09
	for gcvg-git-2@gmane.org; Fri, 26 Sep 2008 18:01:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752616AbYIZQAH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 26 Sep 2008 12:00:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752734AbYIZQAH
	(ORCPT <rfc822;git-outgoing>); Fri, 26 Sep 2008 12:00:07 -0400
Received: from fg-out-1718.google.com ([72.14.220.158]:41142 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752411AbYIZQAE (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 26 Sep 2008 12:00:04 -0400
Received: by fg-out-1718.google.com with SMTP id 19so684587fgg.17
        for <git@vger.kernel.org>; Fri, 26 Sep 2008 09:00:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=SFJhqkz8hAXLk0OJn7UOrPNZtFQamBGjjCYYx57KAmc=;
        b=w1h6S9sYVDEwUVutrkdyX4xT/lzXdMMGsECJJMsvPXm6EneP53Xoeup8RrLWeVeJQG
         95YeOdzUUgp0Nn/SKHwiMnwX5Qva5iKAZPcfek1rmWhYpmYZThgvV+LsZ1N/Do71Es0f
         IoM7lxrwmcjigChL57j0FEzG26qxG3i9KQWnA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=YH1t+hVOuEisBI64Y36po28gVZPIZRTDqwMXM2B+Cpa6uRlMT61QstzOAlC6OVqeE2
         ztidPN4q1Tj1uyWni//JpcHVcvc/lsJXQAXbuBBUsBkJOmoZkR2WaeWIWafXTuMivZS3
         dp+JlMJqFqBiS47x6F4wQQwaDXomGKLsY0KtM=
Received: by 10.86.80.17 with SMTP id d17mr1432754fgb.24.1222444802226;
        Fri, 26 Sep 2008 09:00:02 -0700 (PDT)
Received: by 10.86.95.9 with HTTP; Fri, 26 Sep 2008 09:00:02 -0700 (PDT)
In-Reply-To: <adf1fd3d0809230406r598f6d1l41cd860568de761f@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/96874>

T24gOS8yMy8wOCwgU2FudGkgQsOpamFyIDxzYW50aUBhZ29saW5hLm5ldD4gd3JvdGU6Cj4gV2hp
bGUgSSBhZ3JlZSB0aGF0IHRoZSBjaGVja291dCBhdHRyIGxvb2tzIGxpa2UgYW4gYXR0cmlidXRl
IChzbwo+ICByZXVzaW5nIGF0dHIuYyBpcyBhIGdvb2QgaWRlYSkgYW5kICRHSVRfRElSL2luZm8v
Z2l0YXR0cmlidXRlcyBzZWVtcyBhCj4gIGdvb2QgcGxhY2UgdG8gc3BlY2lmeSB0aGVtLCBJIHRo
aW5rIGl0IHdpbGwgYmUgYmV0dGVyIGluIHRoZSBjb25maWcKPiAgJEdJVF9ESVIvY29uZmlnLiBU
aGVyZSBpdCBpcyBjbGVhciB0aGF0IGl0IGlzIGEgbG9jYWwgdGhpbmcgYW5kIHlvdQo+ICBoYXZl
ICJnaXQgY29uZmlnIiB0byByZWFkIGFuZCB3cml0ZSB0aGVtLiBBZGRpdGlvbmFsbHkgeW91IGNv
dWxkIGhhdmUKPiAgZGlmZmVyZW50IHBhdHRlcm5zIGluIHRoZSBjb25maWcgKHNwYXJzZS5kZWZh
dWx0LCBzcGFyc2UuZG9jLAo+ICBzcGFyc2Uuc3JjLC4uLiksIGFsdGhvdWdoIG1heWJlIGl0IGlz
IG5vdCB2ZXJ5IHVzZWZ1bC4KPgo+ICBJIHRoaW5rIHRoZSBtYWluIFVJIHRvIHNwYXJzZSBjaGVj
a291dCBzaG91bGQgYmUgYSBkZWZhdWx0IHNwYXJzZQo+ICBwYXR0ZXJuIHRoYXQgaXMgdXNlZCBm
b3IgImFsbCIgY29tbWFuZHMsIGxpa2UgbWVyZ2UsIHJlc2V0LCBhbmQKPiAgY2hlY2tvdXQuIE5v
dyBpdCBpcyB0b28gZWFzeSB0byBlc2NhcGUgZnJvbSB0aGUgc3BhcnNlIGNoZWNrb3V0LCB3aGVu
Cj4gIHlvdSBtZXJnZSBvciBjaGVja291dCBhIGJyYW5jaCB3aXRoIG5ldyBmaWxlcywgd2hlbiBk
b2luZyBhICJnaXQgcmVzZXQKPiAgLS1oYXJkIiAod2hlbiB5b3UgYWJvcnQgYSBmYWlsZWQgbWVy
Z2UpLCBvciB3aGVuIGRvaW5nIGEgZGlmZgo+ICAoc3BlY2lhbGx5IHdoZW4geW91IHB1bGwpLgoK
SSBoYXZlIG1hZGUgYSBwYXRjaCB0byBzYXZlIGRlZmF1bHQgc3BhcnNlIHBhdHRlcm5zLCBzb21l
dGhpbmcgdG8gcGxheQp3aXRoIHNvIHdlIGNhbiBoYXZlIGJldHRlciBpZGVhIGhvdyB0byBkbyBp
dCBwcm9wZXJseS4KClRoZXJlIGlzIGFub3RoZXIgb3B0aW9uIC0tZGVmYXVsdC1zcGFyc2UgaW4g
ImdpdCBjbG9uZSIgYW5kICJnaXQKY2hlY2tvdXQiLiBUaGUgb3B0aW9uIGNhbiBiZSB1c2VkIHRv
IHNhdmUgZGVmYXVsdCBzcGFyc2UgcGF0dGVybnMKKHNwZWNpZmllZCBieSAtLXNwYXJzZS1jaGVj
a291dCBpbiAiZ2l0IGNsb25lIiBvciAtLXJlc2V0LXNwYXJzZSBpbgoiZ2l0IGNoZWNrb3V0Iiku
IFNvbWV0aGluZyBsaWtlIHRoaXM6CgpnaXQgY2xvbmUgLS1kZWZhdWx0LXNwYXJzZSAtLXNwYXJz
ZS1jaGVja291dD1Eb2N1bWVudGF0aW9uLyBnaXQuZ2l0CmdpdCBjaGVja291dCAtLWRlZmF1bHQt
c3BhcnNlIC0tcmVzZXQtc3BhcnNlPXQvCgpEZWZhdWx0IHNwYXJzZSBwYXR0ZXJucyB3aWxsIGJl
IHVzZWQgZm9yIG90aGVyIHVucGFja190cmVlcygpLXJlbGF0ZWQKY29tbWFuZHMgbGlrZSByZXNl
dCwgcmVhZC10cmVlLCBtZXJnZSwgcHVsbC4uLiBGb3IgImdpdCBjaGVja291dCIgaXQKd2lsbCBv
bmx5IGJlIHVzZWQgd2hlbiBuZWl0aGVyIC0tZnVsbCwgLS1yZXNldC1zcGFyc2UsCi0taW5jbHVk
ZS1zcGFyc2Ugbm9yIC0tZXhjbHVkZS1zcGFyc2UgaXMgcHJlc2VudC4gQW5kIGl0IG9ubHkgYXBw
bGllcwp0byBuZXdseS1hZGRlZCBmaWxlcy4KClBhdGNoIHNlcmllcyBpcyBpbiBodHRwOi8vcmVw
by5vci5jei93L2dpdC9wY2xvdWRzLmdpdCAoYnJhbmNoCnNwYXJzZS1jaGVja291dCkuIE5vdGUg
dGhhdCBpdCBhbHNvIGluY29ycG9yYXRlcyBmaXhlcyBhbmQgc29tZSBvcHRpb24KcmVuYW1lcy4K
LS0gCkR1eQo=
