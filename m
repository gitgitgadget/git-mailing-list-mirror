From: =?ISO-2022-JP?B?GyRCMC1LYkxuNkxDY0w1GyhC?= 
	<devil.tamachan@gmail.com>
Subject: [PATCH 0/4] git-gui translation update
Date: Fri, 19 Jul 2013 02:12:05 +0900
Message-ID: <CAPM==HLR594OYU5-ZVE6jCgJLHB3bNkR_ZBOXM52xxPffFDVmA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jul 18 19:12:13 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UzrkS-0002h7-Kc
	for gcvg-git-2@plane.gmane.org; Thu, 18 Jul 2013 19:12:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932572Ab3GRRMI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 18 Jul 2013 13:12:08 -0400
Received: from mail-vb0-f68.google.com ([209.85.212.68]:44709 "EHLO
	mail-vb0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932394Ab3GRRMG (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 18 Jul 2013 13:12:06 -0400
Received: by mail-vb0-f68.google.com with SMTP id w16so406258vbb.11
        for <git@vger.kernel.org>; Thu, 18 Jul 2013 10:12:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:date:message-id:subject:from:to:content-type;
        bh=HS62hxk8eVLIWGWGZ7FGroMkw7CKrnMzMOqVVE6gX9c=;
        b=O5QD/ARR0PwkzZDy1YHBt/+leLn0S6BoV7dKK4HQBDjDiQPZymgLnWzrSkX/nuwRRG
         gBgMAUGnbzfwmkwjw7L9PgPMPfDVqKtzeC2Any28a/Vb6fpcp02AAV9mOE7/otDLiUaF
         49/5eDC1GjnZlkOxI9dWJnVohCrk2gIx+7wGA8aR92qV/577w734UtXLrHt1Oxm4O8o+
         ppJ5DBty/qsYwCgg3OI6Vc5RMnjDYCxigbrsG9amTR2y7O2DkK2GWBFmz91h4ry3Aigy
         8r8Quss0SWZaYu3+0XjGXJYbS0ts/Uks4pE4xSir6HUUkB78iJgF9cyo//u42KSf6MZx
         0DHQ==
X-Received: by 10.221.63.2 with SMTP id xc2mr4371278vcb.74.1374167525832; Thu,
 18 Jul 2013 10:12:05 -0700 (PDT)
Received: by 10.221.24.7 with HTTP; Thu, 18 Jul 2013 10:12:05 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/230703>

 git-gui/lib/option.tcl |    2 +-
 git-gui/po/git-gui.pot | 1057 ++++++++++++++++++++++++--------------------
 git-gui/po/ja.po       | 1147 ++++++++++++++++++++++++++----------------------
 3 files changed, 1200 insertions(+), 1006 deletions(-)
