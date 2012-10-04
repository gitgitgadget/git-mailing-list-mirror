From: John Whitney <jjw@emsoftware.com>
Subject: Bug report
Date: Wed, 03 Oct 2012 23:35:58 -0500
Message-ID: <506D122E.2050404@emsoftware.com>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------010400030205080904010502"
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Oct 05 00:05:46 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TJtOW-0001DP-Ll
	for gcvg-git-2@plane.gmane.org; Thu, 04 Oct 2012 23:55:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752970Ab2JDEy2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 4 Oct 2012 00:54:28 -0400
Received: from mail.emsoftware.com ([76.75.201.49]:51010 "EHLO emsoftware.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1752813Ab2JDEy2 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 4 Oct 2012 00:54:28 -0400
X-Greylist: delayed 1103 seconds by postgrey-1.27 at vger.kernel.org; Thu, 04 Oct 2012 00:54:27 EDT
Received: from Johns-MacBook-Pro.local (ppp-70-253-75-224.dsl.austtx.swbell.net [70.253.75.224])
	by emsoftware.com (Postfix) with ESMTP id D10FA1AF4A3C;
	Thu,  4 Oct 2012 00:39:32 -0400 (EDT)
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.7; rv:15.0) Gecko/20120907 Thunderbird/15.0.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/206962>

This is a multi-part message in MIME format.
--------------010400030205080904010502
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Hi all!

I just ran into a problem that I'm pretty sure is a bug in git. Just 
read and run this (fairly trivial) shell script to replicate.

Thanks!
    ---John Whitney


--------------010400030205080904010502
Content-Type: application/x-sh;
 name="git_failure.sh"
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
 filename="git_failure.sh"

IyBJbml0aWFsaXplIHJlcG9zaXRvcnkKZ2l0IGluaXQgc2ltcGxlUmVwb3NpdG9yeQpjZCBz
aW1wbGVSZXBvc2l0b3J5CgojIENvbW1pdCBzaW1wbGUgZmlsZSB0aGF0IGNvbnRhaW5zIGEg
RG9zL1dpbmRvd3Mtc3R5bGUgcmV0dXJuCmVjaG8gIg0iID4gdGVzdC50eHQKZ2l0IGFkZCB0
ZXN0LnR4dApnaXQgY29tbWl0IC1tICJBZGQgZmlsZSB3aXRoIHJldHVybiBjaGFyYWN0ZXIi
CgojIERlbGV0ZSB0aGUgZmlsZSBpbiBhbm90aGVyIGNvbW1pdCAoQW5kIG1ha2UgYnJhbmNo
IGZvciBlYXN5IHJlZmVyZW5jZSkKZ2l0IGNoZWNrb3V0IC1iIGFicmFuY2gKZ2l0IHJtIHRl
c3QudHh0CmdpdCBjb21taXQgLW0gIlJlbW92ZSBmaWxlIHdpdGggcmV0dXJuIGNoYXJhY3Rl
ciIKCiMgR28gYmFjayB0byBvcmlnaW5hbCBjb21taXQgYW5kIHR1cm4gb24gYXV0b21hdGlj
IGVuZC1vZi1saW5lIG5vcm1hbGl6YXRpb24KZ2l0IGNoZWNrb3V0IG1hc3RlcgplY2hvICIq
IHRleHQ9YXV0byIgPiAuZ2l0YXR0cmlidXRlcwoKIyBDaGVycnktcGljayBmYWlscyB3aXRo
OgojIGVycm9yOiBZb3VyIGxvY2FsIGNoYW5nZXMgdG8gdGhlIGZvbGxvd2luZyBmaWxlcyB3
b3VsZCBiZSBvdmVyd3JpdHRlbi4uLgpnaXQgY2hlcnJ5LXBpY2sgYWJyYW5jaAoKIyBUaGUg
ZmFpbGVkIGNoZXJyeS1waWNrIGhhcyBjYXVzZWQgdGhlIGZpbGUgdG8gYmUgbWFya2VkIGFz
ICJtb2RpZmllZCIKCiMgQnV0IHRoaXMgcmVzZXQgb3BlcmF0aW9uIHdpbGwgbm90IGNsZWFy
IHRoZSBzdGF0dXMKZ2l0IHJlc2V0IC0taGFyZAoKIyBUaGlzIHN0YXNoIG9wZXJhdGlvbiBz
dWNjZWVkcywgYnV0IHRlc3QudHh0IHN0aWxsIGlzIG1hcmtlZCBhcyAibW9kaWZpZWQiCmdp
dCBzdGFzaAoKIyBJdCBkb2VzIG5vdCBzZWVtIHRvIGJlIHBvc3NpYmxlIHRvIGVkaXQgdGVz
dC50eHQgaW4gCiMgYSB3YXkgdGhhdCB3aWxsIGNhdXNlIGdpdCB0byBtYXJrIGl0IGFzICJ1
bm1vZGlmaWVkIgoKIyBDb21taXR0aW5nIHRlc3QudHh0IG9yIGNsZWFyaW5nIC5naXRhdHRy
aWJ1dGVzIGRvZXMgY2xlYXIKIyB0aGUgIm1vZGlmaWVkIiBzdGF0dXMsIGJ1dCB0aG9zZSBv
cHRpb25zIGFyZSB1bmRlc2lyYWJsZQoKIyBVbmNvbW1lbnQgdGhlc2UgbGluZXMgaWYgeW91
IHdhbnQgdG8gY2xlYW4gdXAKIyBjZCAuLgojIHJtIC1SZiBzaW1wbGVSZXBvc2l0b3J5Cg==
--------------010400030205080904010502--
