From: "Alex Riesen" <raa.lkml@gmail.com>
Subject: [PATCH] Remove an odd "available" from git-mergetool message regarding no merge tools
Date: Mon, 11 Jun 2007 11:01:21 +0200
Message-ID: <81b0412b0706110201s7929c872re4e0bc80dae5e863@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; 
	boundary="----=_Part_43815_28135284.1181552481247"
Cc: "Theodore Ts'o" <tytso@mit.edu>, "Junio C Hamano" <junkio@cox.net>
To: "Git Mailing List" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Jun 11 11:01:31 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HxfmF-0001rc-1q
	for gcvg-git@gmane.org; Mon, 11 Jun 2007 11:01:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750873AbXFKJBX (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 11 Jun 2007 05:01:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753772AbXFKJBX
	(ORCPT <rfc822;git-outgoing>); Mon, 11 Jun 2007 05:01:23 -0400
Received: from ug-out-1314.google.com ([66.249.92.173]:42619 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750873AbXFKJBW (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 11 Jun 2007 05:01:22 -0400
Received: by ug-out-1314.google.com with SMTP id j3so1424172ugf
        for <git@vger.kernel.org>; Mon, 11 Jun 2007 02:01:21 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:mime-version:content-type;
        b=eg5DgClwZlpF4QURkP3fYoIBWGrSKH01OmXsxb/aA5l0FXcLxM0Yg6fdPCdT02t0OlgPmRcs1mIDa7qfJz8ZjAOjV41cFO91O6PRDIJAmhm0Mq9LwAjDBYsZ9ShDyyCm+2PswZk1v6yKReuJ3CtnRjQ5IhlPyptJB/Jh6OnfWTU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:mime-version:content-type;
        b=h4MdmN3VHE0S9pursEQUmczsY+gh0xQhPQPP811qlqPrT3PhkjCzmmb+mIA32j1SE4UWlF7sNKB7nPbVilFU/JXEylSW9QOLaXO2PPqJ7g2r1fvhnyy9ll9EeCqbel7GrHBVqxWFI9/R7jXqIrkOal4BltAvpg0PO0DHDA2btSo=
Received: by 10.78.175.14 with SMTP id x14mr2080844hue.1181552481276;
        Mon, 11 Jun 2007 02:01:21 -0700 (PDT)
Received: by 10.78.118.19 with HTTP; Mon, 11 Jun 2007 02:01:21 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/49835>

------=_Part_43815_28135284.1181552481247
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Signed-off-by: Alex Riesen <raa.lkml@gmail.com>
---
 git-mergetool.sh |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

------=_Part_43815_28135284.1181552481247
Content-Type: text/plain; 
	name=0001-Remove-an-odd-available-from-git-mergetool-message-r.txt; 
	charset=ANSI_X3.4-1968
Content-Transfer-Encoding: base64
X-Attachment-Id: f_f2spuj8l
Content-Disposition: attachment; filename="0001-Remove-an-odd-available-from-git-mergetool-message-r.txt"

RnJvbSBjYWY1YjYzYTE3MDAzZWZhNTM3MjliNzFhZTMxNDE5NzQzOGFjZmU4IE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBBbGV4IFJpZXNlbiA8cmFhLmxrbWxAZ21haWwuY29tPgpEYXRl
OiBNb24sIDExIEp1biAyMDA3IDEwOjU0OjIzICswMjAwClN1YmplY3Q6IFtQQVRDSF0gUmVtb3Zl
IGFuIG9kZCAiYXZhaWxhYmxlIiBmcm9tIGdpdC1tZXJnZXRvb2wgbWVzc2FnZSByZWdhcmRpbmcg
bm8gbWVyZ2UgdG9vbHMKClNpZ25lZC1vZmYtYnk6IEFsZXggUmllc2VuIDxyYWEubGttbEBnbWFp
bC5jb20+Ci0tLQogZ2l0LW1lcmdldG9vbC5zaCB8ICAgIDIgKy0KIDEgZmlsZXMgY2hhbmdlZCwg
MSBpbnNlcnRpb25zKCspLCAxIGRlbGV0aW9ucygtKQoKZGlmZiAtLWdpdCBhL2dpdC1tZXJnZXRv
b2wuc2ggYi9naXQtbWVyZ2V0b29sLnNoCmluZGV4IDdiNjYzMDkuLjNlNDkxNjggMTAwNzU1Ci0t
LSBhL2dpdC1tZXJnZXRvb2wuc2gKKysrIGIvZ2l0LW1lcmdldG9vbC5zaApAQCAtMzM5LDcgKzMz
OSw3IEBAIGlmIHRlc3QgLXogIiRtZXJnZV90b29sIiA7IHRoZW4KICAgICAgICAgZmkKICAgICBk
b25lCiAgICAgaWYgdGVzdCAteiAiJG1lcmdlX3Rvb2wiIDsgdGhlbgotCWVjaG8gIk5vIGF2YWls
YWJsZSBtZXJnZSByZXNvbHV0aW9uIHByb2dyYW1zIGF2YWlsYWJsZS4iCisJZWNobyAiTm8gbWVy
Z2UgcmVzb2x1dGlvbiBwcm9ncmFtcyBhdmFpbGFibGUuIgogCWV4aXQgMQogICAgIGZpCiBmaQot
LSAKMS41LjIuMS44NzguZ2VmNDIKCg==
------=_Part_43815_28135284.1181552481247--
