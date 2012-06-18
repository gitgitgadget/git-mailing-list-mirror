From: Grant Zhao <zhao.grant@gmail.com>
Subject: unable to index file UsrClass.dat
Date: Mon, 18 Jun 2012 03:09:08 -0700
Message-ID: <CACUgyLmvWk0WeMqx-7Qkw0py8=1ND+4pZNJDp5JOYxEcjU-UXQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary=e89a8f22c4115839c304c2bc5b57
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jun 18 12:09:18 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SgYtY-0002Ty-UV
	for gcvg-git-2@plane.gmane.org; Mon, 18 Jun 2012 12:09:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751207Ab2FRKJL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 18 Jun 2012 06:09:11 -0400
Received: from mail-lb0-f174.google.com ([209.85.217.174]:35067 "EHLO
	mail-lb0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754892Ab2FRKJK (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 18 Jun 2012 06:09:10 -0400
Received: by lbbgm6 with SMTP id gm6so4157208lbb.19
        for <git@vger.kernel.org>; Mon, 18 Jun 2012 03:09:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:date:message-id:subject:from:to:content-type;
        bh=q30UVQ45sKOoNi79Oz7PkkR5anRYOBD/SKOrD7Xjf1A=;
        b=Hq1BSAE/z3hdc2kyP+xKFrA1tfTi1Gm4nyGvHt+cRA9IQOqefGdGl+IPh06/GExo3g
         DvLqXNVWkXJljsyfrj8+T38C/ZmrDUt3JeKqJ9dvygVswwSl5dDgttjOmguUhOWpk/GP
         c9MfVA+FqixbggA06+HZKijR6LweqQ/Fk//0RVln/kkGEIGpwR5vOA7Qn2ZkfLjgyRLS
         AI6BxyRFhof+Acv8jRwTu1jDOX17H6cGMVuAkUQ5IIMZ7nH0Uwacf/rK7tvUD90DGg7+
         bVmUxvJTuREoSmXPjXT+LV9HZaciQex92UJgX0XxKx0XQfCNtwhEUNOPCIB2xHRK2ZIz
         Yeqw==
Received: by 10.152.147.33 with SMTP id th1mr14185388lab.9.1340014148991; Mon,
 18 Jun 2012 03:09:08 -0700 (PDT)
Received: by 10.112.22.199 with HTTP; Mon, 18 Jun 2012 03:09:08 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/200138>

--e89a8f22c4115839c304c2bc5b57
Content-Type: text/plain; charset=ISO-8859-1

I used "git add .",but "fatal: adding files failed".
because

error: open("Local Settings/Application Data/Microsoft/Windows/UsrClass.dat"): P
ermission denied

I cannot open the file "UsrClass.dat",I use Windows XP Profesional
Sp3, please tell me why!

thank you!

Grant

--e89a8f22c4115839c304c2bc5b57
Content-Type: text/plain; charset=US-ASCII; name="AddingFilesFailed20120618-2.txt"
Content-Disposition: attachment; filename="AddingFilesFailed20120618-2.txt"
Content-Transfer-Encoding: base64
X-Attachment-Id: file0

V2VsY29tZSB0byBtc3lzR2l0DQoNCg0KUnVuICdnaXQgaGVscCBnaXQnIHRvIGRpc3BsYXkgdGhl
IGhlbHAgaW5kZXguDQpSdW4gJ2dpdCBoZWxwIDxjb21tYW5kPicgdG8gZGlzcGxheSBoZWxwIGZv
ciBzcGVjaWZpYyBjb21tYW5kcy4NClJ1biAnL3NoYXJlL21zeXNHaXQvYWRkLXNob3J0Y3V0LnRj
bCcgdG8gYWRkIGEgc2hvcnRjdXQgdG8gbXN5c0dpdC4NCg0KQWRtaW5pc3RyYXRvckBUSVRJQU4x
MjUwODM5MSB+L0RvY3VtZW50cyBhbmQgU2V0dGluZ3MvTW9uaWNhIChtYXN0ZXIpDQokIGdpdCBp
bml0DQpSZWluaXRpYWxpemVkIGV4aXN0aW5nIEdpdCByZXBvc2l0b3J5IGluIEM6L0RvY3VtZW50
cyBhbmQgU2V0dGluZ3MvTW9uaWNhLy5naXQvDQoNCkFkbWluaXN0cmF0b3JAVElUSUFOMTI1MDgz
OTEgfi9Eb2N1bWVudHMgYW5kIFNldHRpbmdzL01vbmljYSAobWFzdGVyKQ0KJCBnaXQgYWRkIC4N
CmVycm9yOiBvcGVuKCJMb2NhbCBTZXR0aW5ncy9BcHBsaWNhdGlvbiBEYXRhL01pY3Jvc29mdC9X
aW5kb3dzL1VzckNsYXNzLmRhdCIpOiBQDQplcm1pc3Npb24gZGVuaWVkDQplcnJvcjogdW5hYmxl
IHRvIGluZGV4IGZpbGUgTG9jYWwgU2V0dGluZ3MvQXBwbGljYXRpb24gRGF0YS9NaWNyb3NvZnQv
V2luZG93cy9Vcw0KckNsYXNzLmRhdA0KZmF0YWw6IGFkZGluZyBmaWxlcyBmYWlsZWQNCg0KQWRt
aW5pc3RyYXRvckBUSVRJQU4xMjUwODM5MSB+L0RvY3VtZW50cyBhbmQgU2V0dGluZ3MvTW9uaWNh
IChtYXN0ZXIpDQok
--e89a8f22c4115839c304c2bc5b57--
