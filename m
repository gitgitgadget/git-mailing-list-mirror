From: Jiang Xin <worldhello.net@gmail.com>
Subject: Please pull git-l10n updates on master branch
Date: Tue, 12 Jun 2012 23:59:48 +0800
Message-ID: <CANYiYbF6-oDagBD04Cf7X2EOYPMFMydJ1a2QQfbxcWgL3=cb7g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Git List <git@vger.kernel.org>, Riku <lu.riku@gmail.com>,
	Zhuang Ya <zhuangya@me.com>,
	Lian Cheng <rhythm.mail@gmail.com>,
	Yichao Yu <yyc1992@gmail.com>,
	ws3389 <willsmith3389@gmail.com>, Thynson <lanxingcan@gmail.com>
To: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?B?VHLhuqduIE5n4buNYyBRdcOibg==?= <vnwildman@gmail.com>,
	Ralf Thielow <ralf.thielow@googlemail.com>,
	Thomas Rast <trast@student.ethz.ch>,
	=?ISO-8859-1?Q?Jan_Kr=FCger?= <jk@jk.gs>,
	Christian Stimming <stimming@tuhh.de>
X-From: git-owner@vger.kernel.org Tue Jun 12 17:59:56 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SeTVZ-0000HM-Ti
	for gcvg-git-2@plane.gmane.org; Tue, 12 Jun 2012 17:59:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752303Ab2FLP7u (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 12 Jun 2012 11:59:50 -0400
Received: from mail-yx0-f174.google.com ([209.85.213.174]:55540 "EHLO
	mail-yx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751924Ab2FLP7t (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 12 Jun 2012 11:59:49 -0400
Received: by yenm10 with SMTP id m10so3540954yen.19
        for <git@vger.kernel.org>; Tue, 12 Jun 2012 08:59:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:date:message-id:subject:from:to:cc:content-type;
        bh=g3SPGWmD1zG/khbCZjkIxDH15fayQNqEvRJe4BZ6vco=;
        b=qsVbMaREZvfpY/rgF7tP9L2dxT75v+KSk3nb0Yddq2tT5Ssed6va8pMWKKrz3naFJm
         3Y+g7sKAdYSoZJDMyyZ8l1aifNbtRIysgyHj17/km0tiaHPWi5PUfGVJi5ICO2i1fF5A
         BG0/E6TTLiuAMBZMrDAIaTLekcpaEwV8TkMPn0bYHdA8HDwcHJG+vAd+ULB/shxb4WVG
         m7C9Ec/VcbPwFx/T+OSaeKQKRqeaq5YF0fvMtTwdS0+pfnSOn9fqF/uLDa0xltCV8NAn
         7n2r5WaGUz+s6ak4O1gOcVp6F00kfSjSFd15QXJFfDOeT1fOcJrEy8ICv1BG6hwxVNai
         AN3g==
Received: by 10.50.212.66 with SMTP id ni2mr8719774igc.66.1339516788615; Tue,
 12 Jun 2012 08:59:48 -0700 (PDT)
Received: by 10.50.111.194 with HTTP; Tue, 12 Jun 2012 08:59:48 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/199806>

Hi Junio,

The following changes since commit a1a031d9356cc89cadc5e14acc4028e3ecc306eb:

  Git 1.7.11-rc2 (2012-06-07 09:14:41 -0700)

are available in the git repository at:

  git://github.com/git-l10n/git-po master

for you to fetch changes up to 3482b144652e9cafe41f329dcfca95b84c7c20e6:

  Merge git://github.com/ralfth/git-po-de (2012-06-12 23:41:05 +0800)

----------------------------------------------------------------

Jiang Xin (3):
      l10n: Update git.pot (27 new, 1 removed messages)
      l10n: zh_CN.po: translate 27 new messages
      Merge git://github.com/ralfth/git-po-de

Ralf Thielow (1):
      l10n: de.po: translate 27 new messages

Tran Ngoc Quan (1):
      l10n: Update  po/vi.po to v1.7.11.rc2.2.gb694fbb

 po/de.po    | 216 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++--
 po/git.pot  | 170 +++++++++++++++++++++++++++++++++++++++++++++--
 po/vi.po    | 212 +++++++++++++++++++++++++++++++++++++++++++++++++++++++---
 po/zh_CN.po | 217 ++++++++++++++++++++++++++++++++++++++++++++++++++++++------
 4 files changed, 777 insertions(+), 38 deletions(-)
