From: Jiang Xin <worldhello.net@gmail.com>
Subject: Please pull git-l10n updates on master branch
Date: Fri, 28 Sep 2012 09:17:57 +0800
Message-ID: <CANYiYbF87qr0NHoiwKHEsTqG9mnANkp92t_AN7eUg-QB8cK=WQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Git List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>,
	Ralf Thielow <ralf.thielow@gmail.com>,
	Peter Krefting <peter@softwolves.pp.se>, lanxingcan@gmail.com
X-From: git-owner@vger.kernel.org Fri Sep 28 03:18:11 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1THPDT-0005nl-Cw
	for gcvg-git-2@plane.gmane.org; Fri, 28 Sep 2012 03:18:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755208Ab2I1BR6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 27 Sep 2012 21:17:58 -0400
Received: from mail-ie0-f174.google.com ([209.85.223.174]:43843 "EHLO
	mail-ie0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753569Ab2I1BR6 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 27 Sep 2012 21:17:58 -0400
Received: by ieak13 with SMTP id k13so6120252iea.19
        for <git@vger.kernel.org>; Thu, 27 Sep 2012 18:17:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:date:message-id:subject:from:to:cc:content-type;
        bh=SLD0TTGbUG2K8tAUcN8telneRR2WE2EVEOdpL0Cidfs=;
        b=jGUVuOZknfcP6grrm3bdi8YaYbWBOscTBTX6GrXiPwmEiOZy6jYzNIFsT14xeFu6sR
         BYClwbP1B1ZkVzFWWYIMq97bOgJPmrB/RvwgR1GDN2tGSS4jj9c/ouhmfS4UNI9bQkxB
         xtNSLQePUssIijo0APWmqKlN1AieT4nnGh2JdbvqOYftra11qI2fTKrJ3PJDxV/Sg2lq
         nHG6wtf62yUkD+Hs+2EH5NqD8cyhKr4gzGHzn+K9KWEuJwDxdOAqhEJgq+Q5+gPHCWZ7
         58XG9qyNiFK2SdEE47Kr5QP9ti9rIgeopZ/rsQ5ixJ2uT+zLcJlI3ZSRFmL7uKFtBqk8
         lfrg==
Received: by 10.43.12.137 with SMTP id pi9mr4443832icb.26.1348795077521; Thu,
 27 Sep 2012 18:17:57 -0700 (PDT)
Received: by 10.50.42.230 with HTTP; Thu, 27 Sep 2012 18:17:57 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/206531>

Hi, Junio

The following changes since commit 1084f3b844d80d84d2d318bc562b78514cd78028:

  The sixth batch for 1.8.0 (2012-09-14 12:34:11 -0700)

are available in the git repository at:

  git://github.com/git-l10n/git-po master

for you to fetch changes up to b2f4b6cec2c5c1e2f802ac4b4bd12d5b26461069:

  Merge git://github.com/gotgit/git-po-zh_CN (2012-09-28 07:03:43 +0800)

----------------------------------------------------------------

Jiang Xin (6):
      l10n: Update git.pot (825 new, 24 removed messages)
      l10n: zh.CN.po: msgmerge git.pot (1142t195f630u)
      Merge branch 'maint' of https://github.com/ralfth/git-po-de into maint
      Merge branch 'l10n-thynson' of
git://github.com/thynson/git-po-zh_CN into maint
      Merge branch 'maint'
      Merge git://github.com/gotgit/git-po-zh_CN

Peter Krefting (2):
      Update Swedish translation (1967t0f0u)
      l10n: Fixes to Swedish translation

Ralf Thielow (1):
      l10n: de.po: correct translation of a 'rebase' message

Thynson (2):
      l10n: Unify the translation for '(un)expected'
      l10n: Improve many translation for zh_CN

 po/de.po    |   10 +-
 po/git.pot  | 6908 +++++++++++++++++++++++++++++++++++++++++++----------------
 po/sv.po    | 4433 +++++++++++++++++++++++++++++++++-----
 po/zh_CN.po | 4687 +++++++++++++++++++++++++++++++++++-----
 4 files changed, 13108 insertions(+), 2930 deletions(-)

--
Jiang Xin
