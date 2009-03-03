From: Roy Lee <roylee17@gmail.com>
Subject: Re: [PATCH] Documentation/git-archive.txt: Note attributes
Date: Wed, 4 Mar 2009 02:50:34 +0800
Message-ID: <6eac7f470903031050q3e3e4ad2je6035aef67f42f7b@mail.gmail.com>
References: <1236099168-20231-1-git-send-email-roylee@andestech.com>
	 <7vab82bgxv.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary=000e0cd1d5060bf35604643b6908
Cc: roylee@andestech.com, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Mar 03 19:53:00 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LeZis-0006pZ-A8
	for gcvg-git-2@gmane.org; Tue, 03 Mar 2009 19:52:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753209AbZCCSui (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 3 Mar 2009 13:50:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753152AbZCCSuh
	(ORCPT <rfc822;git-outgoing>); Tue, 3 Mar 2009 13:50:37 -0500
Received: from rv-out-0506.google.com ([209.85.198.236]:6782 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752942AbZCCSuh (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 Mar 2009 13:50:37 -0500
Received: by rv-out-0506.google.com with SMTP id g37so2910214rvb.1
        for <git@vger.kernel.org>; Tue, 03 Mar 2009 10:50:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type;
        bh=B/XCZe/2jUthEJ90xFaMefgv1wlelLtAeadr6nsrH8c=;
        b=BLpCs2ezjJHayVeSQHXAVDjAU4oF9W4H/TOeI1LkvE7Z/o6N7Ldh5btFlEkCYg5Nai
         DRTxeKSHcgvgb9oE8I8TCSGMgU67Wl0dymHDniqSJSNpTaXKnKEvkrr6IkmHvq8IFtp3
         I5JSN9pQ2sKCkc6zK6Sykr0Iu6u30zIcxI8GM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=VJQMAzRB1YztTacT+8Ann4AxTqmx0x1B0XiNYbiTvNmKpgEwbbb6B4EL5rmgm0h9hQ
         Bm6P3phMp/Ir4Awzk8Hexr/vuJxvkuwBkrobgJWzuLZ5gYoQKY6x/gtvZC1yRooWSfjn
         y2dp5tqh8rwlbYohBqndAzb3HbFTFL/lbjyjE=
Received: by 10.141.71.14 with SMTP id y14mr3661316rvk.202.1236106235081; Tue, 
	03 Mar 2009 10:50:35 -0800 (PST)
In-Reply-To: <7vab82bgxv.fsf@gitster.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/112147>

--000e0cd1d5060bf35604643b6908
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 4, 2009 at 2:27 AM, Junio C Hamano <gitster@pobox.com> wrote:
>
> Please add a sign-off. =A0What the patch text says looks perfect, even
> though the lines are too long and would better be rewrapped and the lines
> under ATTRIBUTES must match the length of the word it underlines (this is
> text marked-up with asciidoc, not just freeform).
>
> Thanks.
>

Thanks for the comment. Here's the revised patch.

Regards,
Roy

--000e0cd1d5060bf35604643b6908
Content-Type: application/octet-stream; 
	name="0001-Documentation-git-archive.txt-Note-attributes.patch"
Content-Disposition: attachment; 
	filename="0001-Documentation-git-archive.txt-Note-attributes.patch"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_fruxo6jl0

RnJvbSAyNzIwNTQyMzdmMjA0NjE5ZWQ5MzRiNzY0ZGI0ODVkYjk3ZmFhNWM5IE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBSb3kgTGVlIDxyb3lsZWUxN0BnbWFpbC5jb20+CkRhdGU6IFdl
ZCwgNCBNYXIgMjAwOSAwMDo0OToyOSArMDgwMApTdWJqZWN0OiBbUEFUQ0hdIERvY3VtZW50YXRp
b24vZ2l0LWFyY2hpdmUudHh0OiBOb3RlIGF0dHJpYnV0ZXMKCgpTaWduZWQtb2ZmLWJ5OiBSb3kg
TGVlIDxyb3lsZWUxN0BnbWFpbC5jb20+Ci0tLQogRG9jdW1lbnRhdGlvbi9naXQtYXJjaGl2ZS50
eHQgfCAgIDE3ICsrKysrKysrKysrKysrKysrCiAxIGZpbGVzIGNoYW5nZWQsIDE3IGluc2VydGlv
bnMoKyksIDAgZGVsZXRpb25zKC0pCgpkaWZmIC0tZ2l0IGEvRG9jdW1lbnRhdGlvbi9naXQtYXJj
aGl2ZS50eHQgYi9Eb2N1bWVudGF0aW9uL2dpdC1hcmNoaXZlLnR4dAppbmRleCA0MWNiZjljLi41
YjNlYjEyIDEwMDY0NAotLS0gYS9Eb2N1bWVudGF0aW9uL2dpdC1hcmNoaXZlLnR4dAorKysgYi9E
b2N1bWVudGF0aW9uL2dpdC1hcmNoaXZlLnR4dApAQCAtODgsNiArODgsMTggQEAgdGFyLnVtYXNr
OjoKIAlhcmNoaXZpbmcgdXNlcidzIHVtYXNrIHdpbGwgYmUgdXNlZCBpbnN0ZWFkLiAgU2VlIHVt
YXNrKDIpIGZvcgogCWRldGFpbHMuCiAKK0FUVFJJQlVURVMKKy0tLS0tLS0tLS0KKworZXhwb3J0
LWlnbm9yZTo6CisJRmlsZXMgYW5kIGRpcmVjdG9yaWVzIHdpdGggdGhlIGF0dHJpYnV0ZSBleHBv
cnQtaWdub3JlIHdvbid0IGJlCisJYWRkZWQgdG8gYXJjaGl2ZSBmaWxlcy4gIFNlZSBsaW5rZ2l0
OmdpdGF0dHJpYnV0ZXNbNV0gZm9yIGRldGFpbHMuCisKK2V4cG9ydC1zdWJzdDo6CisJSWYgdGhl
IGF0dHJpYnV0ZSBleHBvcnQtc3Vic3QgaXMgc2V0IGZvciBhIGZpbGUgdGhlbiBnaXQgd2lsbAor
CWV4cGFuZCBzZXZlcmFsIHBsYWNlaG9sZGVycyB3aGVuIGFkZGluZyB0aGlzIGZpbGUgdG8gYW4g
YXJjaGl2ZS4KKwlTZWUgbGlua2dpdDpnaXRhdHRyaWJ1dGVzWzVdIGZvciBkZXRhaWxzLgorCiBF
WEFNUExFUwogLS0tLS0tLS0KIGdpdCBhcmNoaXZlIC0tZm9ybWF0PXRhciAtLXByZWZpeD1qdW5r
LyBIRUFEIHwgKGNkIC92YXIvdG1wLyAmJiB0YXIgeGYgLSk6OgpAQCAtMTEwLDYgKzEyMiwxMSBA
QCBnaXQgYXJjaGl2ZSAtLWZvcm1hdD16aXAgLS1wcmVmaXg9Z2l0LWRvY3MvIEhFQUQ6RG9jdW1l
bnRhdGlvbi8gPiBnaXQtMS40LjAtZG9jcwogCVB1dCBldmVyeXRoaW5nIGluIHRoZSBjdXJyZW50
IGhlYWQncyBEb2N1bWVudGF0aW9uLyBkaXJlY3RvcnkKIAlpbnRvICdnaXQtMS40LjAtZG9jcy56
aXAnLCB3aXRoIHRoZSBwcmVmaXggJ2dpdC1kb2NzLycuCiAKKworU0VFIEFMU08KKy0tLS0tLS0t
CitsaW5rZ2l0OmdpdGF0dHJpYnV0ZXNbNV0KKwogQXV0aG9yCiAtLS0tLS0KIFdyaXR0ZW4gYnkg
RnJhbmNrIEJ1aS1IdXUgYW5kIFJlbmUgU2NoYXJmZS4KLS0gCjEuNi4xLjMKCg==
--000e0cd1d5060bf35604643b6908--
