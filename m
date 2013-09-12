From: Jiang Xin <worldhello.net@gmail.com>
Subject: [GIT PULL] updates of German translation for maint branch
Date: Thu, 12 Sep 2013 11:49:38 +0800
Message-ID: <CANYiYbENW=Z6xSz_--CXdS9qjj74oeu_XoRT9=9gEy-v4uC9NA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Ralf Thielow <ralf.thielow@gmail.com>,
	Dirk Heinrichs <dirk.heinrichs@altum.de>,
	Git List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Sep 12 05:49:46 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VJxuZ-00044F-Tz
	for gcvg-git-2@plane.gmane.org; Thu, 12 Sep 2013 05:49:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752750Ab3ILDtk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 11 Sep 2013 23:49:40 -0400
Received: from mail-we0-f179.google.com ([74.125.82.179]:50890 "EHLO
	mail-we0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751166Ab3ILDtj (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 Sep 2013 23:49:39 -0400
Received: by mail-we0-f179.google.com with SMTP id x55so7508404wes.24
        for <git@vger.kernel.org>; Wed, 11 Sep 2013 20:49:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:date:message-id:subject:from:to:cc:content-type;
        bh=aFTEREVoeKXLdIhBuw68D3HNWNNJ+YJ9ZLwZ7LFekqE=;
        b=Vb4WeB2raT+BLCy/g9DhuznEnqA+CP07psOBzKm5W6C0AX6U7O+XFp/kvqBnWzRLKC
         RXfRohohwdxz7TOJy5ORVpnDSVmB1d/Kg5GOKp3iGvxCKjEDrZzxyNaIEmOjU0XiaPUA
         m7ya2vE0uMvCnq2kIIZRpV+XG+MDWRzBqvFjQdfmbWKMfzLsK9mnA+WYDxbbIEWwM1dN
         5NrN03HLR/HY7EhdddTqQv4pztyCDZH1UyoeI3JwGGweZlBVETZdAvyjQ5Wnhmjkt94Q
         doAjsBaPaurZZ9fIk7DMuh2m1vEmU8pKOc247/obI1Gr1mp0ho4HMxPg7xefaMgXdOBb
         MGqw==
X-Received: by 10.194.201.131 with SMTP id ka3mr4174273wjc.22.1378957778676;
 Wed, 11 Sep 2013 20:49:38 -0700 (PDT)
Received: by 10.194.71.175 with HTTP; Wed, 11 Sep 2013 20:49:38 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/234618>

Hi, Junio

Would you please pull the following into maint branch. And it can be merged
to the master branch. This isn't really a bugfix but a "nice to have" in a
maintenance release. ($gmane/233807)

The following changes since commit 21860882c8782771e99aa68fab6e365c628ff39d:

  l10n: fr.po: hotfix for commit 6b388fc (2013-08-30 16:59:29 +0800)

are available in the git repository at:

  git://github.com/git-l10n/git-po maint

for you to fetch changes up to 8766343faff88c303917944fb771471ec0fdbec1:

  l10n: de.po: use "das Tag" instead of "der Tag" (2013-09-08 18:37:13 +0200)

----------------------------------------------------------------
Ralf Thielow (1):
      l10n: de.po: use "das Tag" instead of "der Tag"

 po/de.po | 22 +++++++++++-----------
 1 file changed, 11 insertions(+), 11 deletions(-)
