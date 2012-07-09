From: Jiang Xin <worldhello.net@gmail.com>
Subject: Please pull git-po master branch with l10n updates for several languages
Date: Mon, 9 Jul 2012 09:21:07 +0800
Message-ID: <CANYiYbEiZLOfaNeBa-udERaMH1PTV4_oWtZPLHC7WEtiO_o_Eg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Git List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>,
	Peter Krefting <peter@softwolves.pp.se>,
	Ralf Thielow <ralf.thielow@googlemail.com>,
	Thomas Rast <trast@student.ethz.ch>,
	=?ISO-8859-1?Q?Jan_Kr=FCger?= <jk@jk.gs>,
	Christian Stimming <stimming@tuhh.de>,
	=?UTF-8?B?VHLhuqduIE5n4buNYyBRdcOibg==?= <vnwildman@gmail.com>,
	Riku <lu.riku@gmail.com>, Zhuang Ya <zhuangya@me.com>,
	Lian Cheng <rhythm.mail@gmail.com>,
	Yichao Yu <yyc1992@gmail.com>,
	ws3389 <willsmith3389@gmail.com>, Thynson <lanxingcan@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jul 09 03:21:22 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1So2fA-0005AN-N1
	for gcvg-git-2@plane.gmane.org; Mon, 09 Jul 2012 03:21:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751429Ab2GIBVK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 8 Jul 2012 21:21:10 -0400
Received: from mail-gg0-f174.google.com ([209.85.161.174]:46531 "EHLO
	mail-gg0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751191Ab2GIBVI (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 8 Jul 2012 21:21:08 -0400
Received: by gglu4 with SMTP id u4so9641204ggl.19
        for <git@vger.kernel.org>; Sun, 08 Jul 2012 18:21:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:date:message-id:subject:from:to:cc:content-type;
        bh=J7yKQO9iWnPlbYBLT8ImpY2OFY0TJ0aqsCed4Q511tw=;
        b=eygackO0Mn01Vq9++4/FrUTAesK1BNWU88kBxNnRrBTyPog4IZqhVQ6DD9INRDWEyn
         gsmcNQ27W2Gzziu3AhjMEBy4yu/2Ljo60oiiBn/khN9T7FHm6OLtghAAlZN2R7TweTZ7
         iVkcUYmHBo2vQq6aDT3dP+cvgHhUPrIQyEIxDhtjmuWc6WLhd1OBPf/I9guBooG4MRoL
         lJIT7a5q3/kglcB/xZjk5/4wJHCOng+vnkn58ERxrby9geXEadhJM3Zh59WVbWnpbgne
         aZsNHUT8D0/ev8G71XWAGbAzhdvYqN2HPJr3dkwDiGxdj2UBvNHiAyAcQEKU3OEmFvtd
         QRCA==
Received: by 10.43.49.67 with SMTP id uz3mr19471866icb.47.1341796867899; Sun,
 08 Jul 2012 18:21:07 -0700 (PDT)
Received: by 10.50.237.38 with HTTP; Sun, 8 Jul 2012 18:21:07 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/201186>

Hi Junio,

The following changes since commit 726016725d45894c061e8d187385327f82803c9f:

  Sync with i18n-po updates in maint (2012-07-02 15:37:54 -0700)

are available in the git repository at:


  git://github.com/git-l10n/git-po master

for you to fetch changes up to 6792b93b1965561e85be3733bb3ab00b2e598119:

  l10n: zh_CN.po: translate 29 new messages (2012-07-06 09:11:15 +0800)

----------------------------------------------------------------
Jiang Xin (2):
      l10n: Update git.pot (29 new messages)
      l10n: zh_CN.po: translate 29 new messages

Peter Krefting (1):
      Update Swedish translation (1095t0f0u)

Ralf Thielow (1):
      l10n: de.po: translate 29 new messages

Tran Ngoc Quan (1):
      l10n: Update translation for Vietnamese

 po/de.po    | 569 ++++++++++++++++++++++++++++++++++----------------------
 po/git.pot  | 537 ++++++++++++++++++++++++++++++++---------------------
 po/sv.po    | 545 +++++++++++++++++++++++++++++++++---------------------
 po/vi.po    | 600 ++++++++++++++++++++++++++++++++++++------------------------
 po/zh_CN.po | 566 ++++++++++++++++++++++++++++++++++----------------------
 5 files changed, 1727 insertions(+), 1090 deletions(-)

-- 
Jiang Xin
