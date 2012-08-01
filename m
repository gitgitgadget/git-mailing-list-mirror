From: Jiang Xin <worldhello.net@gmail.com>
Subject: Please pull git-l10n updates for git v1.7.12-rc0
Date: Thu, 2 Aug 2012 06:34:18 +0800
Message-ID: <CANYiYbHHBAOKw-5LMs_QgMaucdOH-sSRwrOX5Ad2RLvxJuWctQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Git List <git@vger.kernel.org>,
	=?UTF-8?B?VHLhuqduIE5n4buNYyBRdcOibg==?= <vnwildman@gmail.com>,
	Ralf Thielow <ralf.thielow@googlemail.com>,
	Thomas Rast <trast@student.ethz.ch>,
	=?ISO-8859-1?Q?Jan_Kr=FCger?= <jk@jk.gs>,
	Christian Stimming <stimming@tuhh.de>,
	Riku <lu.riku@gmail.com>, Zhuang Ya <zhuangya@me.com>,
	Lian Cheng <rhythm.mail@gmail.com>,
	Yichao Yu <yyc1992@gmail.com>,
	ws3389 <willsmith3389@gmail.com>, Thynson <lanxingcan@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Aug 02 00:34:30 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SwhUp-0006m9-6v
	for gcvg-git-2@plane.gmane.org; Thu, 02 Aug 2012 00:34:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756115Ab2HAWeU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 1 Aug 2012 18:34:20 -0400
Received: from mail-gg0-f174.google.com ([209.85.161.174]:61020 "EHLO
	mail-gg0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756075Ab2HAWeT (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 1 Aug 2012 18:34:19 -0400
Received: by ggnl2 with SMTP id l2so634973ggn.19
        for <git@vger.kernel.org>; Wed, 01 Aug 2012 15:34:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:date:message-id:subject:from:to:cc:content-type;
        bh=kn671/ZUIKjbwPeO+VNRi2WD2g98W+x5QKehsNhPKN8=;
        b=Mt2obLT4xHGOh/oNTOnMboteK+iSsNlvzolsKPXnfKsr8XsqnqwcODcgOAqQo/PPdD
         n1Zzkl5tgzh/sahCXFv2VR1JVIbSMz2zYJUJ7aQ5t7Lfhy1ko7CBIt15rG2J4HnRxmjg
         h//HjGFWaTy2WZ3ebQBk5UtwSb/qJcqKqD+2iXsm339Y1cdDDCf1U+RM5d+VNzsQnr/8
         xKJFo2XXSSfzbInQXm0oj44IsPt5CuuAzZIVc+SenSpdzaRMXe35U5sb7eouAKU0LrFE
         AQS/YhYXOjzWODGbdtih8hqnViGJtkcdjPPmcwb+gPTFq7CKkDnkrP39U8wA/+lI0G7v
         YgtQ==
Received: by 10.43.124.201 with SMTP id gp9mr629705icc.47.1343860458358; Wed,
 01 Aug 2012 15:34:18 -0700 (PDT)
Received: by 10.50.237.38 with HTTP; Wed, 1 Aug 2012 15:34:18 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/202737>

Hi Junio,

The following changes since commit 9e2116adbe192f3090785bdf3412bf7e3e2767b7:

  Update draft release notes to 1.7.12 (2012-07-27 22:25:19 -0700)

are available in the git repository at:

  git://github.com/git-l10n/git-po master

for you to fetch changes up to 9c87b0d28f05c8ffcfe28da32161827cf0bac8e7:

  l10n: de.po: translate 4 new messages (2012-07-31 17:01:15 +0200)

----------------------------------------------------------------
Jiang Xin (2):
      l10n: Update git.pot (4 new, 3 removed messages)
      l10n: zh_CN.po: translate 4 new messages

Ralf Thielow (1):
      l10n: de.po: translate 4 new messages

Tran Ngoc Quan (1):
      l10n: vi.po: translate 4 new messages

 po/de.po    | 1000 ++++++++++++++++++++++++-----------------------
 po/git.pot  |  953 ++++++++++++++++++++++----------------------
 po/vi.po    | 1074 +++++++++++++++++++++++++-------------------------
 po/zh_CN.po | 1259 ++++++++++++++++++++++++++++++++++++-----------------------
 4 files changed, 2305 insertions(+), 1981 deletions(-)

--
Jiang Xin
