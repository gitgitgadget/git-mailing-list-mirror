From: Jiang Xin <worldhello.net@gmail.com>
Subject: Please pull git-po master branch
Date: Wed, 2 May 2012 10:45:56 +0800
Message-ID: <CANYiYbHtKKWw9LPnr+1khC5Oms-kOtA2WEucoNoE3Njzqiahzw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Git List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed May 02 04:46:02 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SPPZp-0003KS-JI
	for gcvg-git-2@plane.gmane.org; Wed, 02 May 2012 04:46:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758547Ab2EBCp5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 1 May 2012 22:45:57 -0400
Received: from mail-gy0-f174.google.com ([209.85.160.174]:43553 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757388Ab2EBCp5 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 1 May 2012 22:45:57 -0400
Received: by ghrr11 with SMTP id r11so176800ghr.19
        for <git@vger.kernel.org>; Tue, 01 May 2012 19:45:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:date:message-id:subject:from:to:cc:content-type;
        bh=rlNvZ4D35OwlSKl+0lQDd6OTDQB/d0XDO2H2O/df8y0=;
        b=GSTmPwZkJB3LNW2ew3+SxCwD0wE+6rVkWhcwOBixtdN+09fEbDBZQ3phEF7CcO+wfI
         qIGObz5M2TBs4E5Usr+Cg7euWlKIns89af3POIeRQwn6LzZJklLtmkTHm02McL6dGk4X
         kwgIjBSfOqqQMovTTlEPViz5ZyrnvwySndSO+wV07PW4u0gXr0SZrubtHVlokBOAPUxw
         I6F/0JJLigQVpN2YMVo2BESXtEnJ1li3zTjIQg0EmA3nKr+XV8l6GrilzfIZsAM96+fE
         SkFy9aCb5gitClwNbrBH7uBNkyuE5o6lVZr7AbU4QP0q8DTAyi/EY9CTG4xEPkwsXbh7
         MMDA==
Received: by 10.50.190.197 with SMTP id gs5mr3481631igc.37.1335926756338; Tue,
 01 May 2012 19:45:56 -0700 (PDT)
Received: by 10.50.207.40 with HTTP; Tue, 1 May 2012 19:45:56 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/196779>

The following changes since commit 62bc83349d52be49b037d2c800a7f4064cfbc5b5:

  The sixth batch of topics graduated to 'master' (2012-04-27 14:12:56 -0700)

are available in the git repository at:

  https://github.com/git-l10n/git-po/ master

for you to fetch changes up to 839f7f8eed3bbb757dbbb6c2ef1a838974aa4bc8:

  l10n: Update German translation (2012-05-02 07:46:35 +0800)

----------------------------------------------------------------
Byrial Jensen (2):
      l10n: New da.po file with 0 translations
      l10n: Add Danish team (da) to list of teams

Jiang Xin (8):
      Merge master branch for tracking l10n updates of next release
      l10n: Update git.pot (33 new, 24 deleted messages)
      Merge maint branch for tracking l10n updates of git stable version
      l10n: Update git.pot (2 new messages)
      l10n: Update Simplified Chinese translation
      Merge branch 'maint'
      l10n: Update Simplified Chinese translation
      Merge l10n updates from branch 'maint' into master

Marco Sousa (1):
      l10n: Updated pt_PT language

Ralf Thielow (3):
      l10n: Add the German translation team and initialize de.po
      l10n: Initial German translation
      l10n: Update German translation

 po/TEAMS    |    8 +
 po/da.po    | 3503 ++++++++++++++++++++++++++++++++++++++++++++++++++++++
 po/de.po    | 3825 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 po/git.pot  |  720 +++++------
 po/pt_PT.po |  242 ++--
 po/zh_CN.po |  783 ++++++------
 6 files changed, 8271 insertions(+), 810 deletions(-)
 create mode 100644 po/da.po
 create mode 100644 po/de.po
