From: "Tim Visher" <tim.visher@gmail.com>
Subject: Re: 'Theirs' merge between branches on a binary file.
Date: Sun, 28 Dec 2008 12:14:54 -0500
Message-ID: <c115fd3c0812280914p61e3db34vb033f30b1e04da33@mail.gmail.com>
References: <c115fd3c0812221256l494bb824ga8e1640efb07b20c@mail.gmail.com>
	 <7vr63zhq4k.fsf@gitster.siamese.dyndns.org>
	 <c115fd3c0812221316y24ce0c7q29807cd349a99e83@mail.gmail.com>
	 <7vd4fjhlf8.fsf@gitster.siamese.dyndns.org>
	 <c115fd3c0812221458q3444cbcai7ab1716b9195ad08@mail.gmail.com>
	 <7v3agfhk8b.fsf@gitster.siamese.dyndns.org>
	 <c115fd3c0812230605x369af9c0n372db761fa11ce39@mail.gmail.com>
	 <49512E9A.5040902@lsrfire.ath.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: base64
Cc: "Junio C Hamano" <gitster@pobox.com>, git@vger.kernel.org
To: "=?UTF-8?Q?Ren=C3=A9_Scharfe?=" <rene.scharfe@lsrfire.ath.cx>
X-From: git-owner@vger.kernel.org Sun Dec 28 18:18:34 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LGzHd-0005tx-Cu
	for gcvg-git-2@gmane.org; Sun, 28 Dec 2008 18:18:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751488AbYL1RO6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 28 Dec 2008 12:14:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751179AbYL1RO5
	(ORCPT <rfc822;git-outgoing>); Sun, 28 Dec 2008 12:14:57 -0500
Received: from mail-bw0-f21.google.com ([209.85.218.21]:41314 "EHLO
	mail-bw0-f21.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750881AbYL1RO4 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 28 Dec 2008 12:14:56 -0500
Received: by bwz14 with SMTP id 14so15464587bwz.13
        for <git@vger.kernel.org>; Sun, 28 Dec 2008 09:14:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=qP1v4JEIWC6S5VUg3tc7vfV0k+u+MK2WKLUNQlmDT/U=;
        b=Cc4ZMerCb5xVmV1NpkovSnVYH/OslSlvxnNRDmQCv58k/ZW/gMje8tRwotbpfUG8eo
         I7qxMglK5E+UKXJ5R3Wrst2fXeiVDAlaytfvqCa/+2fs1D7rr7fZuYBMHqi1hgX95eVk
         zxXAKLXzvgCAekldQZoAltknkiksSjOakx3Ao=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=C6u8CuG6VsiBiG6MxKOJC1oPrtuoLD899u2Mm+KtuTQRvb7CNpUAMO1X0bfSVSTO9E
         6sjlXycOUWWPgaq7grk4sDuyVWPAbVM4fD/PqXpRUjae9TrHNalZqVX+uql5f/Tt9hGN
         v0eWZvOZB0qqDaKEl00l39fELvjGBUisB8v98=
Received: by 10.181.50.1 with SMTP id c1mr4871221bkk.3.1230484494180;
        Sun, 28 Dec 2008 09:14:54 -0800 (PST)
Received: by 10.181.23.16 with HTTP; Sun, 28 Dec 2008 09:14:54 -0800 (PST)
In-Reply-To: <49512E9A.5040902@lsrfire.ath.cx>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/104055>

T24gVHVlLCBEZWMgMjMsIDIwMDggYXQgMTozMSBQTSwgUmVuw6kgU2NoYXJmZQo8cmVuZS5zY2hh
cmZlQGxzcmZpcmUuYXRoLmN4PiB3cm90ZToKCj4gSGF2ZSB5b3Ugc2VlbiBtc3lzZ2l0IChodHRw
Oi8vY29kZS5nb29nbGUuY29tL3AvbXN5c2dpdC8pLCB0aGUgZWFzeQo+IHJvdXRlIHRvIGdpdCBv
biBXaW5kb3dzPyAgSXQgaGFzIGFsbCB5b3UgbmVlZCB0byBjaGVjayBvdXQgYW5kIGNvbXBpbGUK
PiB0aGUgbGF0ZXN0IHZlcnNpb24gb2YgZ2l0LgoKSSBoYXZlIHNlZW4gbXN5c2dpdC4gIEkgaGF2
ZW4ndCBzcGVudCB0b28gbXVjaCB0aW1lIHdpdGggaXQgbWFpbmx5CmJlY2F1c2UgSSdtIGluIGRl
bmlhbCB0aGF0IEkgaGF2ZSB0byB3b3JrIHdpdGggV2luZG93cyBhbGwgZGF5IGF0CndvcmsuICBJ
J20gZ29pbmcgdG8gaGF2ZSB0byBsb29rIGludG8gaXQgSSB0aGluayB3aGVuIEkgYXR0ZW1wdCB0
byBnZXQKbXkgdGVhbSBvbnRvIGdpdCBpbiBhIGxpdHRsZSBsZXNzIHRoYW4gYSBtb250aC4KCi0t
IAoKSW4gQ2hyaXN0LAoKVGltbXkgVi4KCmh0dHA6Ly9idXJuaW5nb25lcy5jb20vCmh0dHA6Ly9m
aXZlLnNlbnRlbmMuZXMvIC0gU3BlbmQgbGVzcyB0aW1lIG9uIGUtbWFpbAo=
