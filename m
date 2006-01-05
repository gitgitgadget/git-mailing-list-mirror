From: Alex Riesen <raa.lkml@gmail.com>
Subject: trivial: clarify, what are the config's user.name and user.email about
Date: Thu, 5 Jan 2006 12:44:18 +0100
Message-ID: <81b0412b0601050344u87748b3i62c26898ed77e4a2@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; 
	boundary="----=_Part_11233_9707671.1136461458005"
X-From: git-owner@vger.kernel.org Thu Jan 05 12:45:36 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EuTYb-00082H-3K
	for gcvg-git@gmane.org; Thu, 05 Jan 2006 12:45:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752161AbWAELpV (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 5 Jan 2006 06:45:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752162AbWAELpV
	(ORCPT <rfc822;git-outgoing>); Thu, 5 Jan 2006 06:45:21 -0500
Received: from zeus1.kernel.org ([204.152.191.4]:14039 "EHLO zeus1.kernel.org")
	by vger.kernel.org with ESMTP id S1752161AbWAELpU (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 5 Jan 2006 06:45:20 -0500
Received: from nproxy.gmail.com (nproxy.gmail.com [64.233.182.203])
	by zeus1.kernel.org (8.13.1/8.13.1) with ESMTP id k05BjIuj003854
	for <git@vger.kernel.org>; Thu, 5 Jan 2006 03:45:19 -0800
Received: by nproxy.gmail.com with SMTP id x37so102860nfc
        for <git@vger.kernel.org>; Thu, 05 Jan 2006 03:44:18 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:mime-version:content-type;
        b=PS3kw+Lmqtmel2B8dcxLfZWrBLjSMbOkkPB7J61PwkWYSLCnWxvmSPbOgmLhdos+fo0Y4LHZAh9EPlyYRL2qk9FB8II8acESLU4+NF2W5fohNxlSVDznsz8SwyQcfQeyQjywx8J/cnBd5nELebdi1P1HRjiuH99D4aT30hi2L3I=
Received: by 10.48.3.13 with SMTP id 13mr682833nfc;
        Thu, 05 Jan 2006 03:44:18 -0800 (PST)
Received: by 10.48.248.4 with HTTP; Thu, 5 Jan 2006 03:44:18 -0800 (PST)
To: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
X-Virus-Scanned: ClamAV version 0.85, clamav-milter version 0.85 on zeus1
X-Virus-Status: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/14189>

------=_Part_11233_9707671.1136461458005
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Signed-off-by: Alex Riesen <raa.lkml@gmail.com>

------=_Part_11233_9707671.1136461458005
Content-Type: text/plain; name="0002-clarify-what-are-the-config-s-user.name-and-user.email-about.txt"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="0002-clarify-what-are-the-config-s-user.name-and-user.email-about.txt"

U3ViamVjdDogW1BBVENIXSBjbGFyaWZ5LCB3aGF0IGFyZSB0aGUgY29uZmlnJ3MgdXNlci5uYW1l
IGFuZCB1c2VyLmVtYWlsIGFib3V0CgpTaWduZWQtb2ZmLWJ5OiBBbGV4IFJpZXNlbiA8cmFhLmxr
bWxAZ21haWwuY29tPgoKCi0tLQoKIERvY3VtZW50YXRpb24vZ2l0LWNvbW1pdC10cmVlLnR4dCB8
ICAgIDMgKystCiAxIGZpbGVzIGNoYW5nZWQsIDIgaW5zZXJ0aW9ucygrKSwgMSBkZWxldGlvbnMo
LSkKCjBkYThhYjBlOGViYWNjODZlMzhjMDI5YTg1Nzc0MTFmYmIxMzc5ZjgKZGlmZiAtLWdpdCBh
L0RvY3VtZW50YXRpb24vZ2l0LWNvbW1pdC10cmVlLnR4dCBiL0RvY3VtZW50YXRpb24vZ2l0LWNv
bW1pdC10cmVlLnR4dAppbmRleCBhNzk0MTkyLi40MWQxYTFjIDEwMDY0NAotLS0gYS9Eb2N1bWVu
dGF0aW9uL2dpdC1jb21taXQtdHJlZS50eHQKKysrIGIvRG9jdW1lbnRhdGlvbi9naXQtY29tbWl0
LXRyZWUudHh0CkBAIC02MCw3ICs2MCw4IEBAIGVpdGhlciBgLmdpdC9jb25maWdgIGZpbGUsIG9y
IHVzaW5nIHRoZSAKIAogKG5iICI8IiwgIj4iIGFuZCAiXG4icyBhcmUgc3RyaXBwZWQpCiAKLUlu
IGAuZ2l0L2NvbmZpZ2AgZmlsZSwgdGhlIGZvbGxvd2luZyBpdGVtcyBhcmUgdXNlZDoKK0luIGAu
Z2l0L2NvbmZpZ2AgZmlsZSwgdGhlIGZvbGxvd2luZyBpdGVtcyBhcmUgdXNlZCBmb3IgR0lUX0FV
VEhPUl9OQU1FIGFuZAorR0lUX0FVVEhPUl9FTUFJTDoKIAogCVt1c2VyXQogCQluYW1lID0gIllv
dXIgTmFtZSIKLS0gCjEuMC5HSVQK
------=_Part_11233_9707671.1136461458005--
