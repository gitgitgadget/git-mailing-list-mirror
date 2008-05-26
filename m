From: "Nguyen Thai Ngoc Duy" <pclouds@gmail.com>
Subject: Re: git-diff cr/nl files on linux
Date: Mon, 26 May 2008 11:15:10 +0700
Message-ID: <fcaeb9bf0805252115q60f784aax6b1f267c476960b4@mail.gmail.com>
References: <fcaeb9bf0805240554j71693d5eo2a425ee0efe2f364@mail.gmail.com>
	 <483811BF.3090302@dirk.my1.cc>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: base64
Cc: "Git Mailing List" <git@vger.kernel.org>
To: "=?UTF-8?Q?Dirk_S=C3=BCsserott?=" <newsletter@dirk.my1.cc>
X-From: git-owner@vger.kernel.org Mon May 26 06:16:22 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K0U8C-0005gJ-R6
	for gcvg-git-2@gmane.org; Mon, 26 May 2008 06:16:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750872AbYEZEPO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 26 May 2008 00:15:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750852AbYEZEPN
	(ORCPT <rfc822;git-outgoing>); Mon, 26 May 2008 00:15:13 -0400
Received: from fg-out-1718.google.com ([72.14.220.154]:44222 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750833AbYEZEPM (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 26 May 2008 00:15:12 -0400
Received: by fg-out-1718.google.com with SMTP id 19so1120815fgg.17
        for <git@vger.kernel.org>; Sun, 25 May 2008 21:15:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=07/2y81LyjeZhI9RmLrYJVPM5dw5xrmjS5SsXcgcV/c=;
        b=YVekcf7ymv3dFRmf/1LlzbcmT58R0rIwrAED0xO6w2NPKV9rS7PCOZBAyT/ItQALt+jkD8nVvM/won30gdFNuujCRtbwZ0+11XgyBmn9YnE+rteV8zLz1XAITL2cN9c+qnb778egQT27oIQXN2HzJtcjSyn/QojdDk0CCmbawnM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=Yb3P1++N9A3BXfHp7os+f0sKv/aPdQKgrVzlRmWEqlopSMKxunPgtnUFXgH3IAJCwqXHixT1GxL6Zcv8wi18B6PpkA9TsCDS9KQCzioiTBfKhVU07DCIUOMlra5OiQARLasPET5GnnmImAFa9Vjwa3Em+lnmU7exX9GW9lPGmCg=
Received: by 10.86.51.2 with SMTP id y2mr4010832fgy.52.1211775310903;
        Sun, 25 May 2008 21:15:10 -0700 (PDT)
Received: by 10.86.62.13 with HTTP; Sun, 25 May 2008 21:15:10 -0700 (PDT)
In-Reply-To: <483811BF.3090302@dirk.my1.cc>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/82895>

T24gU2F0LCBNYXkgMjQsIDIwMDggYXQgODowMSBQTSwgRGlyayBTw7xzc2Vyb3R0IDxuZXdzbGV0
dGVyQGRpcmsubXkxLmNjPiB3cm90ZToKPiBOZ3V5ZW4gVGhhaSBOZ29jIER1eSBzY2hyaWViOgo+
Pgo+PiBIaSwKPj4KPj4gSXMgdGhlcmUgYW55IHdheSB0aGF0IGNhbiBtYWtlIGdpdC1kaWZmIHNo
b3cgY3IvbmwgZW5kaW5nIGZpbGVzIG9uCj4+IGxpbnV4IHdpdGhvdXQgXk0gYXQgdGhlIGVuZD8K
Pj4KPj4gVGhhbmtzCj4+Cj4KPiBXaGF0IGFib3V0ICdnaXQgZGlmZiAtdyc/IEl0IGRyb3BzIGFu
eSB3aGl0ZXNwYWNlIGNoYW5nZXMsIGluY2x1ZGluZyBeTSdzLgo+IE5vdCBzdXJlIHdoZXRoZXIg
dGhhdCBpcyB3aGF0IHlvdSBtZWFudC4KClRoYXQgd29uJ3QgaGVscC4gSGVyZSBpcyBhIHNuaXBw
ZXQgb2Ygd2hhdCBJIHNlZToKCmRpZmYgLS1naXQgYS9hYmMuYyBiL2FiYy5jCmluZGV4IDA2NGE3
NjkuLjY0N2I5YWUgMTAwNjQ0Ci0tLSBhL2FiYy5jCisrKyBiL2FiYy5jCkBAIC04NTksNyArODU5
LDEwIEBAIGludCBkZWYKICAgICApCiAgICAgewogICAgIEZBU1QgaW50IGFzZHNhOwotICAgIEZB
U1QgaW50IGRzZHNhZDsKKyAgICBGQVNUIGludCBkc2FkYWRkOyAgICAgICAgICAvKiBFUlJPUiBh
bHNvIG1lYW5zIEFBU0FTICovXk0KKyNpZm5kZWYgSkhBU0hKSkheTQorICAgIHN0cnVjdCBzZGRk
ZCBkYXNkYWRhO15NCisjZW5kaWZeTQogICAgIHVuaW9uIHNkZGQgYXNkc2RhZDsKICAgICBGQVNU
IFNUQVRVUyBkc2FkYWRhZDsKICAgICB1bnNpZ25lZCBpbnQgc2RhZGFkYWQgPSAwOwoKV2l0aCBj
b2xvciB0dXJuaW5nIG9mZiwgaXQgZG9lcyBub3Qgc2hvdyBeTSBzbyBwcm9iYWJseSBzb21ldGhp
bmcgdG8KZG8gd2l0aCB0aGUgY29sb3JpbmcuIGxlc3MgaXMgYXQgdmVyc2lvbiAzOTQuCi0tIApE
dXkK
