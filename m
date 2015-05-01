From: Alangi Derick <alangiderick@gmail.com>
Subject: Patch that modifies git usage message
Date: Fri, 1 May 2015 12:01:16 +0100
Message-ID: <CAKB+oNtYbJXNb2wGzJCdQ5Ru5fq3HzcapSqiTVC_34=xDnTb7Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary=001a113b9dc4a2a69605150321cd
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri May 01 13:01:26 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Yo8hB-0002ke-HL
	for gcvg-git-2@plane.gmane.org; Fri, 01 May 2015 13:01:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753463AbbEALBT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 1 May 2015 07:01:19 -0400
Received: from mail-qg0-f43.google.com ([209.85.192.43]:33506 "EHLO
	mail-qg0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751995AbbEALBS (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 1 May 2015 07:01:18 -0400
Received: by qgdy78 with SMTP id y78so36604172qgd.0
        for <git@vger.kernel.org>; Fri, 01 May 2015 04:01:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:date:message-id:subject:from:to:content-type;
        bh=/5RWOPSnFu3kD2EhLa2d4ABOuYvSfmYMmQqHfDYeXuc=;
        b=S4ohj2xLjWSiGrfsj4/PgEBAZ20XMTyi1bCpPffh8sVI4yIzU/D78+PdbUaj7OLlQ7
         MXomv1vbj+JzO79+Dlc6vM09g99wPE7MO2LszebKk+VP9u7WIuXub6ehRiYMzf4fOzJy
         avTO6OChU0+GsSpN6cE0xs4JlgDc/UqtJvxkTGQy9OznSL5bA9CWqdNR5xKghpzJRT5q
         E2Xi0H9B5twV4YyOv6D2teJAs3Ly1detRoZ1mtcmt7iNqgWQ0AitI9iyB3iYMb8Fj2QW
         hUNJ1YYwIB9RnrjS1AceXvS6KZLwvyzWqLgMK8m+NHwdXZPLQmRrE470zFdMMlvQqstb
         U61w==
X-Received: by 10.55.24.215 with SMTP id 84mr17766443qky.8.1430478076937; Fri,
 01 May 2015 04:01:16 -0700 (PDT)
Received: by 10.229.45.71 with HTTP; Fri, 1 May 2015 04:01:16 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/268112>

--001a113b9dc4a2a69605150321cd
Content-Type: text/plain; charset=UTF-8

This patch just modifies the "usage" word to "Usage" which enhances
readability. Below is the patch

Regards
Alangi Derick Ndimnain

--001a113b9dc4a2a69605150321cd
Content-Type: text/x-patch; charset=US-ASCII; name="git_usage_modified.patch"
Content-Disposition: attachment; filename="git_usage_modified.patch"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_i95hokp10

ZGlmZiAtLWdpdCBhL2dpdC5jIGIvZ2l0LmMKaW5kZXggNDJhNGVlNS4uNDgxYWE3NCAxMDA2NDQK
LS0tIGEvZ2l0LmMKKysrIGIvZ2l0LmMKQEAgLTY2Nyw3ICs2NjcsNyBAQCBpbnQgbWFpbihpbnQg
YXJnYywgY2hhciAqKmF2KQogCX0gZWxzZSB7CiAJCS8qIFRoZSB1c2VyIGRpZG4ndCBzcGVjaWZ5
IGEgY29tbWFuZDsgZ2l2ZSB0aGVtIGhlbHAgKi8KIAkJY29tbWl0X3BhZ2VyX2Nob2ljZSgpOwot
CQlwcmludGYoInVzYWdlOiAlc1xuXG4iLCBnaXRfdXNhZ2Vfc3RyaW5nKTsKKwkJcHJpbnRmKCJV
c2FnZTogJXNcblxuIiwgZ2l0X3VzYWdlX3N0cmluZyk7CiAJCWxpc3RfY29tbW9uX2NtZHNfaGVs
cCgpOwogCQlwcmludGYoIlxuJXNcbiIsIF8oZ2l0X21vcmVfaW5mb19zdHJpbmcpKTsKIAkJZXhp
dCgxKTsK
--001a113b9dc4a2a69605150321cd--
