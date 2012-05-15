From: Jiang Xin <worldhello.net@gmail.com>
Subject: Please pull git-l10n update for upcoming v1.7.10.3
Date: Wed, 16 May 2012 07:25:26 +0800
Message-ID: <CANYiYbH1FDcFcbfH4+D8ApnMOPJZjaATu6xosxuct0+9mq8rRA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Git List <git@vger.kernel.org>,
	Ralf Thielow <ralf.thielow@googlemail.com>,
	Thomas Rast <trast@student.ethz.ch>,
	=?ISO-8859-1?Q?Jan_Kr=FCger?= <jk@jk.gs>,
	Christian Stimming <stimming@tuhh.de>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed May 16 01:33:44 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SURFM-0000qq-FF
	for gcvg-git-2@plane.gmane.org; Wed, 16 May 2012 01:33:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S967033Ab2EOXdN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 15 May 2012 19:33:13 -0400
Received: from mail-yx0-f174.google.com ([209.85.213.174]:51364 "EHLO
	mail-yx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S966132Ab2EOXdM (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 15 May 2012 19:33:12 -0400
Received: by yenm10 with SMTP id m10so154597yen.19
        for <git@vger.kernel.org>; Tue, 15 May 2012 16:33:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:date:message-id:subject:from:to:cc:content-type;
        bh=l+cTfgVQElrNTok4/EXIzLnGTW2ukw+sXMWc5yFDlGo=;
        b=frFKreQk9pp/GDGAI9LxSPHAxAPkyzHpZGIuXKObJW1zolgpxGnTs4F+dQcTKR/eTH
         TBwe5R/D+tbWurVVbMK1bNy+zL8eollmCrwel2BZY25XkOF7M/okRoqCU+4Wb+knv7TM
         yiuGFNtkg2zm8beiuUL+UFEsUqRnBKnCyL6vn+nZ0GRs3fcFhPxtXJPZkdUgWNMnI4pc
         4oBHlOke9tShuK4mm61mCd2wnnZUIubXjWDuga/AUmLiHLTaxfcjky8uixyMGK7F7Fdn
         pSffWh4TwNuTb5RDkP9YH+ASwwHilRJZHVtlcTritBZsiFD4c/tD+C9A641sfGL2eLM3
         guCA==
Received: by 10.50.42.130 with SMTP id o2mr487540igl.37.1337124326565; Tue, 15
 May 2012 16:25:26 -0700 (PDT)
Received: by 10.50.134.102 with HTTP; Tue, 15 May 2012 16:25:26 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/197858>

Hi Junio,

This pull request contains updates of de.po and zh_CN.po
in git-l10n/git-po maint branch for upcoming git v1.7.10.3.

The following changes since commit 0b9f4b63a0c1ff351415a1f41dfcbc2461c65e74:

  Merge branch 'maint' of git://github.com/git-l10n/git-po into maint
(2012-05-14 11:47:49 -0700)

are available in the git repository at:


  https://github.com/git-l10n/git-po/ maint

for you to fetch changes up to 042e9f94a71977b471e230f0c637699b0a7ca3d3:

  l10n: de.po: translate 3 new messages (2012-05-15 19:09:02 +0200)

----------------------------------------------------------------
Jiang Xin (2):
      l10n: Update git.pot (3 new, 2 removed messages)
      l10n: zh_CN.po: translate 3 new messages

Ralf Thielow (1):
      l10n: de.po: translate 3 new messages

 po/de.po    |  228 +++++++++++++++++++++++++++++++++--------------------------
 po/git.pot  |  204 +++++++++++++++++++++++++++-------------------------
 po/zh_CN.po |  220 ++++++++++++++++++++++++++++++--------------------------
 3 files changed, 356 insertions(+), 296 deletions(-)


-- 
Jiang Xin
