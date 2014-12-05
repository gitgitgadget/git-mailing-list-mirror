From: Jiang Xin <worldhello.net@gmail.com>
Subject: [GIT PULL] l10n update on maint branch
Date: Fri, 5 Dec 2014 09:59:53 +0800
Message-ID: <CANYiYbFE8i0p1HBA_SC-J0J_7XLukgZqj5Z9K82_opSfqn43gg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>,
	Ralf Thielow <ralf.thielow@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Dec 05 02:59:58 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XwiBa-0001Us-EX
	for gcvg-git-2@plane.gmane.org; Fri, 05 Dec 2014 02:59:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933009AbaLEB7z (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 4 Dec 2014 20:59:55 -0500
Received: from mail-wg0-f50.google.com ([74.125.82.50]:55732 "EHLO
	mail-wg0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754893AbaLEB7y (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 4 Dec 2014 20:59:54 -0500
Received: by mail-wg0-f50.google.com with SMTP id k14so24140092wgh.37
        for <git@vger.kernel.org>; Thu, 04 Dec 2014 17:59:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:date:message-id:subject:from:to:cc:content-type;
        bh=wUtv3odMe4yhcEbi+h5ergCNMPZuPP4PoRkt3Vtp5Zs=;
        b=O3SvdgCMh6Uv5qWPimmAsike0SXxOD/axmJw9fkzS3Ht02ZPRdD8wslZs1g7sbSCSe
         1zFS/KhR+riL4+rrTLGtkS5UkjP1Vcgi+il7no4YnfgOWwKWg62ohrQQuZZ3S3EjRj89
         ys9ooW72a1nCTLCE8ZYuC58rjCQOb5NzTeniFZDxhA/r7ZJyBD53BhK54MH601Zgn76w
         Ae0N7pv6HxKpe6Z8Bj7m12nlZKtzPZcGBPyk/pocJ6o1TFfr4gHolRzY4KcX/y3G1XaW
         RbUjey+xzMGaTuNC8Jy579ZSum+7r0NFuQc5idh2lhrJSeA+pZ2DixNYdjiXj2HmGztp
         rs7w==
X-Received: by 10.194.234.40 with SMTP id ub8mr21117304wjc.100.1417744793222;
 Thu, 04 Dec 2014 17:59:53 -0800 (PST)
Received: by 10.194.29.129 with HTTP; Thu, 4 Dec 2014 17:59:53 -0800 (PST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/260852>

Hi Junio,

Please pull l10n update to maint branch.

The following changes since commit b260d265e189728b26e50506ac6ffab6a7d588da:

  Git 2.2 (2014-11-26 13:18:34 -0800)

are available in the git repository at:

  git://github.com/git-l10n/git-po maint

for you to fetch changes up to ff51f5619d52410e4343c7cd75889e7d07f5659e:

  Merge branch 'master' of https://github.com/ralfth/git-po-de
(2014-11-29 10:44:48 +0800)

----------------------------------------------------------------
Hartmut Henkel (1):
      l10n: de.po: fix typos

Jiang Xin (1):
      Merge branch 'master' of https://github.com/ralfth/git-po-de

 po/de.po | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)
