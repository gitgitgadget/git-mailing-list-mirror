From: Jiang Xin <worldhello.net@gmail.com>
Subject: Please pull git-l10n updates on master branch
Date: Tue, 5 Jun 2012 07:12:26 +0800
Message-ID: <CANYiYbHyh6_-P9CY9WEEMbRP+a2hRz2vUEno1FTX9qnVi-YB3w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Git List <git@vger.kernel.org>,
	Ralf Thielow <ralf.thielow@googlemail.com>,
	Thomas Rast <trast@student.ethz.ch>,
	=?ISO-8859-1?Q?Jan_Kr=FCger?= <jk@jk.gs>,
	Christian Stimming <stimming@tuhh.de>,
	=?UTF-8?B?VHLhuqduIE5n4buNYyBRdcOibg==?= <vnwildman@gmail.com>,
	Riku <lu.riku@gmail.com>, Zhuang Ya <zhuangya@me.com>,
	Lian Cheng <rhythm.mail@gmail.com>,
	Yichao Yu <yyc1992@gmail.com>,
	ws3389 <willsmith3389@gmail.com>, Thynson <lanxingcan@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Jun 05 01:12:37 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SbgRw-0001aD-FS
	for gcvg-git-2@plane.gmane.org; Tue, 05 Jun 2012 01:12:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761188Ab2FDXM2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 4 Jun 2012 19:12:28 -0400
Received: from mail-yw0-f46.google.com ([209.85.213.46]:61722 "EHLO
	mail-yw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1761209Ab2FDXM1 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 4 Jun 2012 19:12:27 -0400
Received: by yhmm54 with SMTP id m54so3407670yhm.19
        for <git@vger.kernel.org>; Mon, 04 Jun 2012 16:12:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:date:message-id:subject:from:to:cc:content-type;
        bh=B1OiiF0ZbT+1FTDYwsgCnddcWUsfL6koOXtpKToQ2ec=;
        b=t5g81AKflxDftqXBXqmk9BrWx8tCGHl6pI+gal6RuBLfPx6Z4ICTeesB/v0AIdesIz
         jUi/Uhhl7H0WJiFr8RcCBlLZKr/lVgUq+ObFsAlVb9ofl69U8XXsAluLwnN6RcIAdGKh
         jHlt8QwVc0f+bYNIe66IiJJOevKkd+4IF+yT0SnQygEWZWivXZIzk9AFS7X9fhAgIH2d
         EXmQBJq1fLZievzlrRpQVWfxV938sD1fuwt2JBWv+deeF9b1odEdvbZuiKDh/FaMzx/0
         XIW9h+QIzqO5eBZ/KOGiX4GnjGJJgOADCtWvG8BugD/jWfREclTGfqGfTMKti7rLSvxR
         ugBw==
Received: by 10.50.89.130 with SMTP id bo2mr153309igb.19.1338851546532; Mon,
 04 Jun 2012 16:12:26 -0700 (PDT)
Received: by 10.50.111.194 with HTTP; Mon, 4 Jun 2012 16:12:26 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/199196>

Hi Junio,

The following changes since commit 5498c5f05283cd248fd5e4f48cb8902e9ca6ce28:

  Update draft release notes to 1.7.11 (2012-06-01 13:29:48 -0700)

are available in the git repository at:

  git://github.com/git-l10n/git-po master

for you to fetch changes up to 958a3143eeff336faa244452107522b2c11dfee1:

  Merge git://github.com/ralfth/git-po-de (2012-06-04 23:45:13 +0800)

----------------------------------------------------------------

Jiang Xin (3):
      l10n: Update git.pot (5 new, 3 removed messages)
      l10n: zh_CN.po: translate 2 new, 3 fuzzy messages
      Merge git://github.com/ralfth/git-po-de

Ralf Thielow (4):
      l10n: de.po: translate 265 new messages
      l10n: de.po: translate 41 new messages
      l10n: de.po: translate 2 new, 3 fuzzy messages
      l10n: de.po: add additional newline

Tran Ngoc Quan (1):
      l10n: Update translation for Vietnamese

 po/de.po    | 2563 ++++++++++++++++++++++++++++++++++++++++++++++++-----------
 po/git.pot  |  428 +++++-----
 po/vi.po    |  514 ++++++------
 po/zh_CN.po |  441 +++++-----
 4 files changed, 2799 insertions(+), 1147 deletions(-)


-- 
Jiang Xin
