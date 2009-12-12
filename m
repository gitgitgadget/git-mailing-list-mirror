From: Lars Hjemli <hjemli@gmail.com>
Subject: [ANNOUNCE] CGIT 0.8.3.1
Date: Sat, 12 Dec 2009 12:17:41 +0100
Message-ID: <8c5c35580912120317k3404d172g338c6b8b36665c85@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sat Dec 12 12:24:04 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NJQ4w-0002cj-TL
	for gcvg-git-2@lo.gmane.org; Sat, 12 Dec 2009 12:24:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761475AbZLLLXm convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 12 Dec 2009 06:23:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1761468AbZLLLXl
	(ORCPT <rfc822;git-outgoing>); Sat, 12 Dec 2009 06:23:41 -0500
Received: from mail-gx0-f211.google.com ([209.85.217.211]:46573 "EHLO
	mail-gx0-f211.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756258AbZLLLXk convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 12 Dec 2009 06:23:40 -0500
X-Greylist: delayed 366 seconds by postgrey-1.27 at vger.kernel.org; Sat, 12 Dec 2009 06:23:40 EST
Received: by gxk3 with SMTP id 3so3312308gxk.1
        for <git@vger.kernel.org>; Sat, 12 Dec 2009 03:23:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:date:message-id:subject
         :from:to:content-type:content-transfer-encoding;
        bh=CW7zxDH7Ta+JZYWpSB+RslcSZChxX+vZGflz3FWlfPM=;
        b=kgJ5B903FUn/PnA9m2tnE0Kp1eGYwYPyS9Vq+ejXM5OSDMdtlXXMHVCY07qcbEr+mF
         YNcw7mGl7aPX4LTZRy6YNLxL5K7T856gXQQgKBpFgU94YF7vvyUwjHMeWut9CW1ouFSn
         pzndSW+QgGB0zCdLkA0xceRE5GWoPzE5Ch3g4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:date:message-id:subject:from:to:content-type
         :content-transfer-encoding;
        b=uA8LqpVhWTw1wz/epAt+jYP/MxcjVCMwyXRyvNLF6ON8pYNj2+ALGH5mKNWjIAkWPR
         jr15ZFrApyxjPWf19HKGlYId/QvCBf0Bt1irlPxp1wKtW3XllgQ7urOTTpZE+xhrvHCi
         ieN3inOIW2g8OwtW0B4vEN91RhBZNT47NGtLE=
Received: by 10.150.173.3 with SMTP id v3mr403109ybe.52.1260616661161; Sat, 12 
	Dec 2009 03:17:41 -0800 (PST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/135134>

A new bugfix-release of cgit is now available.

Clone:  git://hjemli.net/pub/git/cgit
Browse: http://hjemli.net/git/cgit

Changes since 0.8.3
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
Danijel Ta=C5=A1ov (1):
      Nov is the correct abbreviation

Geoff Johnstone (1):
      Fix repolist search links with virtual root

Lars Hjemli (2):
      shared.c: return original errno
      CGIT 0.8.3.1

Loui Chang (2):
      cgitrc.5.txt: Add mansource and manmanual.
      cgitrc.5.txt: Change repo.group to section in example config.

Martins Polakovs (1):
      Fix segfault on ppc when browsing tree

Rys Sommefeldt (1):
      Close fd on error in readfile()

Sami Ky=C3=B6stil=C3=A4 (1):
      Don't crash when a repo-specific readme file is used
