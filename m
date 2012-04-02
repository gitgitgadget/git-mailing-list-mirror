From: Jiang Xin <worldhello.net@gmail.com>
Subject: Please pull git-l10n update with Portuguese (Portugal) language support
Date: Mon, 2 Apr 2012 10:25:07 +0800
Message-ID: <CANYiYbGDRP2cag3TLdW1=No6RS-K_E7ez9Q7iws=CEgDKgkgCw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Git List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>,
	Marco Sousa <marcomsousa@gmail.com>,
	=?ISO-8859-1?Q?=C6var_Arnfj=F6r=F0_Bjarmason?= <avarab@gmail.com>
X-From: git-owner@vger.kernel.org Mon Apr 02 04:25:17 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SEWxI-00068K-FK
	for gcvg-git-2@plane.gmane.org; Mon, 02 Apr 2012 04:25:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754057Ab2DBCZJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 1 Apr 2012 22:25:09 -0400
Received: from mail-iy0-f174.google.com ([209.85.210.174]:44207 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754018Ab2DBCZI (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 1 Apr 2012 22:25:08 -0400
Received: by iagz16 with SMTP id z16so3504130iag.19
        for <git@vger.kernel.org>; Sun, 01 Apr 2012 19:25:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:date:message-id:subject:from:to:cc:content-type;
        bh=h5Eh5BNMzSUQHw1d+h8tqw5Xqtg1FCXhEmziHzow1b4=;
        b=g3CDwnYVx5fGWSNVRyVxHRFLPP8quo+BjOeJ/TLStfPQCbLvg13/756hL1Yu3hBUhI
         6dwOn/NqJJdHIQ438PnNW4UIvmcpB2psAkTwxwy+OUHgq5JnqNPrTyYs+wOFrtOsAb1a
         IBQLAX2L0k7MdrChPYb5QHFH7Bij3aOp/n8g9Llkb/iMsbPeplgBjlOO+pmKN8/9/EdR
         DHNyJ9u2A6GyapfHEr6ywQ89YE9QD9od/hKp5G2aRCh7c6OEwrgl3RPIw7+xk5Pt46cX
         gQRcsYVO4QhTfOv+tHdN8LwbFOnJbwswfg+MwtFg+Ouyou/d/UUPKjJVhVyOLL8CSJQH
         kA2Q==
Received: by 10.42.18.67 with SMTP id w3mr3347179ica.46.1333333507674; Sun, 01
 Apr 2012 19:25:07 -0700 (PDT)
Received: by 10.50.207.40 with HTTP; Sun, 1 Apr 2012 19:25:07 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/194497>

Junio,

The following changes since commit 455cf268dbaf227bdbd5e9fbf96525452bcfe44f:

  Git 1.7.10-rc3 (2012-03-28 11:18:42 -0700)

are available in the git repository at:

  http://github.com/git-l10n/git-po.git/ master

for you to fetch changes up to 833662295e6b9515617f96323d6821bcb6662cf0:

  l10n: Inital Portuguese Portugal language (pt_PT) (2012-04-02 09:46:11 +0800)

----------------------------------------------------------------
Jiang Xin (1):
      l10n: Improve zh_CN translation for Git 1.7.10-rc3

Marco Sousa (1):
      l10n: Inital Portuguese Portugal language (pt_PT)

 po/TEAMS    |    4 +
 po/pt_PT.po | 3583
+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 po/zh_CN.po |   38 +-
 3 files changed, 3606 insertions(+), 19 deletions(-)
 create mode 100644 po/pt_PT.po
