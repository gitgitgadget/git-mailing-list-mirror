From: Beber <beber.lkml@gmail.com>
Subject: [PATCH] Cogito: Handle push over http
Date: Mon, 23 Jan 2006 00:57:10 +0100
Message-ID: <4615f4910601221557u1dc37233ue2e3c312547a14de@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; 
	boundary="----=_Part_35724_9514194.1137974230909"
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jan 23 00:57:39 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1F0p5O-0007on-8R
	for gcvg-git@gmane.org; Mon, 23 Jan 2006 00:57:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932082AbWAVX5P (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 22 Jan 2006 18:57:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932360AbWAVX5P
	(ORCPT <rfc822;git-outgoing>); Sun, 22 Jan 2006 18:57:15 -0500
Received: from uproxy.gmail.com ([66.249.92.194]:49737 "EHLO uproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932082AbWAVX5P (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 22 Jan 2006 18:57:15 -0500
Received: by uproxy.gmail.com with SMTP id s2so574920uge
        for <git@vger.kernel.org>; Sun, 22 Jan 2006 15:57:11 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:mime-version:content-type;
        b=sQYbG9wkqGw1fORCfMfAdl2XzYRWJPoREVTNvEfGfynKPCgjLZxpg16KWZwhl0XuUeJciE4+hORtdoL5qlKQrVrq0Cs+8aMvdKgNdilFafDuUwKigd6WupfLaiqL8NSXvr0+drRlJsYmtujy14xqA09Cwt5+0O69zbRCVZ7DZ0c=
Received: by 10.66.239.17 with SMTP id m17mr560098ugh;
        Sun, 22 Jan 2006 15:57:10 -0800 (PST)
Received: by 10.66.242.15 with HTTP; Sun, 22 Jan 2006 15:57:10 -0800 (PST)
To: pasky@suse.cz
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/15068>

------=_Part_35724_9514194.1137974230909
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

Here is a patch allow cg-push to push over http.

You can pull http://guybrush.ath.cx/git/public/cogito.git/
Or use attach patch.

Beber

------=_Part_35724_9514194.1137974230909
Content-Type: application/octet-stream; name="http-push-for-cg.patch"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="http-push-for-cg.patch"

LS0tIGEvY2ctcHVzaAorKysgYi9jZy1wdXNoCkBAIC02OSw3ICs2OSw3IEBAIGZpCiBzcHJlbWJy
YW5jaD0iOnJlZnMvaGVhZHMvJHJlbWJyYW5jaCIKIAogaWYgWyAiJHt1cmkjaHR0cDovL30iICE9
ICIkdXJpIiBdOyB0aGVuCi0JZGllICJwdXNoaW5nIG92ZXIgSFRUUCBub3Qgc3VwcG9ydGVkIHll
dCIKKwlnaXQtaHR0cC1wdXNoICIkdXJpLyIgJGxvY2JyYW5jaAogZWxpZiBbICIke3VyaSNnaXQr
c3NoOi8vfSIgIT0gIiR1cmkiIF07IHRoZW4KIAlzZW5kX3BhY2tfdXBkYXRlICIkbmFtZSIgIiQo
ZWNobyAiJHVyaSIgfCBzZWQgJ3MjXmdpdCtzc2g6Ly9cKFteL10qXClcKC8uKlwpJCNcMTpcMiMn
KSIgIiRsb2NicmFuY2gkc3ByZW1icmFuY2giICIke3RhZ3NbQF19IgogZWxpZiBbICIke3VyaSNy
c3luYzovL30iICE9ICIkdXJpIiBdOyB0aGVuCg==
------=_Part_35724_9514194.1137974230909--
