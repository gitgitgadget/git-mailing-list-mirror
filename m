From: Yamada Saburo <devil.tamachan@gmail.com>
Subject: [PATCH5/(4+1)] Fix git-gui/po/ja.po
Date: Fri, 19 Jul 2013 06:13:00 +0900
Message-ID: <CAPM==H+kp3cGyYkX68CeqbMqr_6d5Kvd-f3X-DZgDfMb0YN4yA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-2022-JP
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jul 18 23:13:09 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UzvVb-00020h-Q8
	for gcvg-git-2@plane.gmane.org; Thu, 18 Jul 2013 23:13:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759405Ab3GRVND (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 18 Jul 2013 17:13:03 -0400
Received: from mail-ve0-f182.google.com ([209.85.128.182]:37644 "EHLO
	mail-ve0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759224Ab3GRVNC (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 18 Jul 2013 17:13:02 -0400
Received: by mail-ve0-f182.google.com with SMTP id ox1so2931633veb.27
        for <git@vger.kernel.org>; Thu, 18 Jul 2013 14:13:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:date:message-id:subject:from:to:content-type
         :content-transfer-encoding;
        bh=Pl7Vzl+Md5XqBh7whH1CLt24yVLMO7uR2/zo4pB6U6o=;
        b=p1hFKal+gBY/ShMdUWqZGSSzc5UdcbTCSt3bROXXymR9HPBbaSsmLna3ic0rCezic3
         0vxxhp9irv9Wd9UmkVVckvbJ3ZQLbYSh/t6u7SGlEO7nfLxoRTkar+h26a/KelEatAxw
         X2rEzDafYNr0MZ2J8Hp6mof8U9YO035hwhrXbWysdifpAemowsIYHVqubtqLRinK5a1U
         IJev5lFoCcoCef54XgmsOAUHN+B7dozFziAA2leqTkD2bVy/3dhAaNKC7E4gE8uLxDIZ
         6nxat+xuPImM7lB5OG+aBiRusofTfGMa0PNyHXbClr7qquXyV+mrOj+GllKsdtAHFQbh
         PZTQ==
X-Received: by 10.58.29.111 with SMTP id j15mr4770708veh.76.1374181980901;
 Thu, 18 Jul 2013 14:13:00 -0700 (PDT)
Received: by 10.221.24.7 with HTTP; Thu, 18 Jul 2013 14:13:00 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/230747>

Signed-off-by: Yamada Saburo <devil.tamachan@gmail.com>
---
 git-gui/po/ja.po | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/git-gui/po/ja.po b/git-gui/po/ja.po
index 05215b9..83aeb05 100644
--- a/git-gui/po/ja.po
+++ b/git-gui/po/ja.po
@@ -9,9 +9,8 @@ msgstr ""
 "Report-Msgid-Bugs-To: \n"
 "POT-Creation-Date: 2013-07-10 03:38+0900\n"
 "PO-Revision-Date: 2010-02-02 19:03+0900\n"
-"Last-Translator: しらいし ななこ <nanako3@lavabit.com>, devil.tamachan
<devil.tamachan@gmail.com>\n"
+"Last-Translator: Yamada Saburo <devil.tamachan@gmail.com>\n"
 "Language-Team: Japanese\n"
-"Language: \n"
 "MIME-Version: 1.0\n"
 "Content-Type: text/plain; charset=UTF-8\n"
 "Content-Transfer-Encoding: 8bit\n"
@@ -131,7 +130,7 @@ msgstr "ファイルタイプ変更、コミット未予定"

 #: git-gui.sh:2088 git-gui.sh:2089
 msgid "File type changed, old type staged for commit"
-msgstr "ファイルタイプ変更、コミット予定の形式が古い"
+msgstr "ファイルタイプ変更、元のファイルタイプでの変更をコミット予定済"

 #: git-gui.sh:2090
 msgid "File type changed, staged"
-- 
1.8.1.msysgit.1
