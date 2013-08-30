From: Jiang Xin <worldhello.net@gmail.com>
Subject: [GIT PULL] hotfix on fr.po for the maint branch
Date: Fri, 30 Aug 2013 17:07:26 +0800
Message-ID: <CANYiYbG6MweCwLaUw5Uk3S9a0hUY1vuS+ORCF1BipkZkJeHjrw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Git List <git@vger.kernel.org>, Jean-Noel Avila <jn.avila@free.fr>,
	Sebastien Helleu <flashcode@flashtux.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Aug 30 11:07:41 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VFKg9-0006mf-2o
	for gcvg-git-2@plane.gmane.org; Fri, 30 Aug 2013 11:07:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752694Ab3H3JHb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 30 Aug 2013 05:07:31 -0400
Received: from mail-we0-f174.google.com ([74.125.82.174]:62659 "EHLO
	mail-we0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752529Ab3H3JHa (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 30 Aug 2013 05:07:30 -0400
Received: by mail-we0-f174.google.com with SMTP id q54so1348950wes.19
        for <git@vger.kernel.org>; Fri, 30 Aug 2013 02:07:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:date:message-id:subject:from:to:cc:content-type;
        bh=YOLBzJQLXQRYIgZO/wLmv8CUVkJ3yiYMwys1iN5itVE=;
        b=eGhnwjBpKLJTY67XCSNqjC0JKc2D/ZngnIQFgSP6OxBk7tdlPQOvsLt7J91pAO99lC
         tcQ50tvyrj5KLkbegGqeihmaQSyaNzm/Oqmy3oOUB+IkjXhrH2Gc22ND5GjaNXqdKLbn
         MCiVY8Nb1BZoxS4mzcSAyedkk+FaO/0i9KIqMKa74EcLsPv+A8gvikwKJIpThYjsKO/P
         xf9EsB2gPpFjGcnW/ZXBWtJRH2E1ZiCyT+T6RJTozDqi9Pi+F1SdHFmytHOPpjIuuymp
         HOiE6nk7dzxnC00G+Qw7xf3NPNt33sq7+HZbl2LJFzokgrKZu/QdmocFqpK+W0tndqDD
         y6kw==
X-Received: by 10.180.160.212 with SMTP id xm20mr1498754wib.23.1377853646758;
 Fri, 30 Aug 2013 02:07:26 -0700 (PDT)
Received: by 10.194.71.175 with HTTP; Fri, 30 Aug 2013 02:07:26 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/233434>

Hi, Junio

Please merge this commit to the maint branch.

The following changes since commit e230c568c4b9a991e3175e5f65171a566fd8e39c:

  Git 1.8.4 (2013-08-23 11:49:46 -0700)

are available in the git repository at:

  git://github.com/git-l10n/git-po master

for you to fetch changes up to 21860882c8782771e99aa68fab6e365c628ff39d:

  l10n: fr.po: hotfix for commit 6b388fc (2013-08-30 16:59:29 +0800)

----------------------------------------------------------------
Sebastien Helleu (1):
      l10n: fr.po: hotfix for commit 6b388fc

 po/TEAMS |    1 +
 po/fr.po | 1591 ++++++++++++++++++++++++++++++++++----------------------------
 2 files changed, 874 insertions(+), 718 deletions(-)

--
Jiang Xin
