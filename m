From: code.sculptor@gmail.com
Subject: Re: Summer of Code project ideas due this Friday
Date: Fri, 11 Mar 2011 14:24:13 +0000
Message-ID: <229797324-1299853442-cardhu_decombobulator_blackberry.rim.net-1488450281-@bda570.bisx.prod.on.blackberry>
References: <AANLkTinpVKBjcqxaCGH0vp82kpKsO2uCBPdMoMKco6Ex@mail.gmail.com><20110303185918.GA18503@sigill.intra.peff.net><AANLkTinXZDq5FJxMmxUuWpCGgMYb3HH774eLJCojmnOz@mail.gmail.com><20110303203323.GA21102@sigill.intra.peff.net><20110309174956.GA22683@sigill.intra.peff.net><AANLkTinpAOE06YX-m=ptQM_y-QMGpVmjewDxWopkXJkQ@mail.gmail.com><20110309215841.GC4400@sigill.intra.peff.net><AANLkTi=RVW8osJaSi1mDhNuOrFksHhAjtPdfdeXQoFeC@mail.gmail.com>
Reply-To: code.sculptor@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Cc: "Shawn Pearce" <spearce@spearce.org>,
	"Ramkumar Ramachandra" <artagnon@gmail.com>,
	"Jonathan Nieder" <jrnieder@gmail.com>,
	"Jens Lehmann" <Jens.Lehmann@web.de>,
	"Christian Couder" <chriscool@tuxfamily.org>,
	"Thomas Rast" <trast@student.ethz.ch>, "git" <git@vger.kernel.org>
To: "=?Windows-1252?B?xnZhciBBcm5mavZy8CBCamFybWFzb24=?=" 
	<avarab@gmail.com>, git-owner@vger.kernel.org,
	"Jeff King" <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Mar 11 15:24:21 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Py3GM-00043p-IF
	for gcvg-git-2@lo.gmane.org; Fri, 11 Mar 2011 15:24:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755343Ab1CKOYO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 11 Mar 2011 09:24:14 -0500
Received: from mail-qy0-f181.google.com ([209.85.216.181]:63276 "EHLO
	mail-qy0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751488Ab1CKOYM (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 11 Mar 2011 09:24:12 -0500
Received: by qyg14 with SMTP id 14so2495755qyg.19
        for <multiple recipients>; Fri, 11 Mar 2011 06:24:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:x-rim-org-msg-ref-id:message-id
         :content-transfer-encoding:reply-to:x-priority:references
         :in-reply-to:sensitivity:importance:subject:to:cc:from:date
         :content-type:mime-version;
        bh=cU7h4mNwh3Qvp4N+mcmT0nvIlaqBHdIrbAk7I4AT+Js=;
        b=NQmwG/gaTrgLGdjMML4Ze1m+mC1dYVE/CnbWPqWezv1L0QOH4JvlokjIsINMLPeWNE
         tV11dWhvz7IB+UegoJp1AsVaFcCvw1Myuj4s+v5nNsj60i3H6rqGlpGweFwV7c1Xd0FI
         5G6Cy/Z8g/CEt4EZRrM5dKXptI+hXEIdjJgD0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=x-rim-org-msg-ref-id:message-id:content-transfer-encoding:reply-to
         :x-priority:references:in-reply-to:sensitivity:importance:subject:to
         :cc:from:date:content-type:mime-version;
        b=Jyv1bU6wtgdoA/HJ8ripehBWW/zZJBPeVB5Ckk8t2Ndpna3HTSFMYo8EndPWiYxYDi
         fKPoMsMn8VEyTeOIdkJs5bT5A/uzcJ8kwGMy/5fXO/skheKWanQJdJ4mrGqspcbQarhZ
         5wJVVYtBJcq6vc7ZpvNCoPpNdyYhx0xZXplaE=
Received: by 10.224.9.9 with SMTP id j9mr1218728qaj.295.1299853450616;
        Fri, 11 Mar 2011 06:24:10 -0800 (PST)
Received: from bda076.bisx.prod.on.blackberry (bda-67-223-70-182.bise.na.blackberry.com [67.223.70.182])
        by mx.google.com with ESMTPS id d21sm2247373qck.40.2011.03.11.06.24.07
        (version=SSLv3 cipher=OTHER);
        Fri, 11 Mar 2011 06:24:08 -0800 (PST)
X-rim-org-msg-ref-id: 229797324
X-Priority: Normal
In-Reply-To: <AANLkTi=RVW8osJaSi1mDhNuOrFksHhAjtPdfdeXQoFeC@mail.gmail.com>
Sensitivity: Normal
Importance: Normal
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/168902>

R3JlYXQgaWRlYSENClNlbnQgZnJvbSBteSBCbGFja0JlcnJ5IGRldmljZSBvbiB0aGUgUm9nZXJz
IFdpcmVsZXNzIE5ldHdvcmsNCg0KLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCkZyb206IMOG
dmFyIEFybmZqw7Zyw7AgQmphcm1hc29uIDxhdmFyYWJAZ21haWwuY29tPg0KU2VuZGVyOiBnaXQt
b3duZXJAdmdlci5rZXJuZWwub3JnDQpEYXRlOiBGcmksIDExIE1hciAyMDExIDEzOjQzOjM5IA0K
VG86IEplZmYgS2luZzxwZWZmQHBlZmYubmV0Pg0KQ2M6IFNoYXduIFBlYXJjZTxzcGVhcmNlQHNw
ZWFyY2Uub3JnPjsgUmFta3VtYXIgUmFtYWNoYW5kcmE8YXJ0YWdub25AZ21haWwuY29tPjsgSm9u
YXRoYW4gTmllZGVyPGpybmllZGVyQGdtYWlsLmNvbT47IEplbnMgTGVobWFubjxKZW5zLkxlaG1h
bm5Ad2ViLmRlPjsgQ2hyaXN0aWFuIENvdWRlcjxjaHJpc2Nvb2xAdHV4ZmFtaWx5Lm9yZz47IFRo
b21hcyBSYXN0PHRyYXN0QHN0dWRlbnQuZXRoei5jaD47IGdpdDxnaXRAdmdlci5rZXJuZWwub3Jn
Pg0KU3ViamVjdDogUmU6IFN1bW1lciBvZiBDb2RlIHByb2plY3QgaWRlYXMgZHVlIHRoaXMgRnJp
ZGF5DQoNCk9uIFdlZCwgTWFyIDksIDIwMTEgYXQgMjI6NTgsIEplZmYgS2luZyA8cGVmZkBwZWZm
Lm5ldD4gd3JvdGU6DQo+IElmIHlvdSBoYXZlIGFueSBpZGVhcywgcGxlYXNlIGFkZCB0aGVtIHRv
IHRoZSBwYWdlIQ0KDQpIZXJlJ3MgYSBzaW1wbGUgb25lOg0KDQpDdXJyZW50bHkgd2UgaGF2ZSBh
IGdsb2JhbCBVSSBjb2xvciBzZXR0aW5nLCBidXQgcHJldHR5IG11Y2ggb25seQ0KZ2l0LXN0YXR1
cy9sb2cvZXRjIHVzZSBpdC4NCg0KQ2hhbmdlIGdpdC1iaXNlY3QsIGdpdC1hbSBldGMuIHRvIGFs
c28gc3VwcG9ydCBjb2xvciBvdXRwdXQuIEl0IHdvdWxkDQpiZSBhIGVhc3kgYnV0IGJpZyBVSSB3
aW4uDQotLQ0KVG8gdW5zdWJzY3JpYmUgZnJvbSB0aGlzIGxpc3Q6IHNlbmQgdGhlIGxpbmUgInVu
c3Vic2NyaWJlIGdpdCIgaW4NCnRoZSBib2R5IG9mIGEgbWVzc2FnZSB0byBtYWpvcmRvbW9Admdl
ci5rZXJuZWwub3JnDQpNb3JlIG1ham9yZG9tbyBpbmZvIGF0ICBodHRwOi8vdmdlci5rZXJuZWwu
b3JnL21ham9yZG9tby1pbmZvLmh0bWwNCg==
