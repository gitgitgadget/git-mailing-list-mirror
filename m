From: Jiang Xin <worldhello.net@gmail.com>
Subject: New git.pot is generated for the upcoming git v1.7.12
Date: Mon, 30 Jul 2012 11:10:24 +0800
Message-ID: <CANYiYbFLy4s3q1Tn9FD1ASLwY1=AND_ePqhHpC_X_nvb1iLoCA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Git List <git@vger.kernel.org>
To: Byrial Jensen <byrial@vip.cybercity.dk>,
	Ralf Thielow <ralf.thielow@googlemail.com>,
	=?ISO-8859-1?Q?=C6var_Arnfj=F6r=F0_Bjarmason?= <avarab@gmail.com>,
	Marco Paolone <marcopaolone@gmail.com>,
	Vincent van Ravesteijn <vfr@lyx.org>,
	Marco Sousa <marcomsousa@gmail.com>,
	Peter Krefting <peter@softwolves.pp.se>,
	=?UTF-8?B?VHLhuqduIE5n4buNYyBRdcOibg==?= <vnwildman@gmail.com>,
	=?UTF-8?B?RGF2aWQgSHJiw6HEjQ==?= <david@hrbac.cz>,
	Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Jul 30 05:10:31 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SvgNK-0002MM-At
	for gcvg-git-2@plane.gmane.org; Mon, 30 Jul 2012 05:10:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753987Ab2G3DK0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 29 Jul 2012 23:10:26 -0400
Received: from mail-gg0-f174.google.com ([209.85.161.174]:40460 "EHLO
	mail-gg0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753929Ab2G3DKZ (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 29 Jul 2012 23:10:25 -0400
Received: by gglu4 with SMTP id u4so4368894ggl.19
        for <git@vger.kernel.org>; Sun, 29 Jul 2012 20:10:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:date:message-id:subject:from:to:cc:content-type;
        bh=7ohYdrw38DiBZ18x1+qBDe4VPU64YYOnvtbhHPSA4GE=;
        b=qwKmcF1hiBvdHOiftRFSBTJeEeix6wSmJ4k7W6cg987SeiJmR3xIv8RsCh9r/1H4Ob
         WnpbapsxkflIACJajy12CLkPL59Kpr95skLZLnKqmi5bDqN26ih8jVcdW2aK16j9SP74
         TjgqMVEHjFpiCu6/uW82BO+j3Jtjxn6s/0AGTNxVjMIIbDBIsls9aGgXrl/GlF8GJJI7
         K5iSLymFavbJ1eK3hrbowm+e6vkf3dvMdW6zxty53uk+Gabk5VB2HPsdVUwYskjDzo4X
         OhL45HATGua8ujGPdlyL1q5aFKFqZ+xGuNCpC8effzQDIS7dwcR1DZg/KsatAS29yLib
         Eaxw==
Received: by 10.50.17.170 with SMTP id p10mr7290993igd.19.1343617824090; Sun,
 29 Jul 2012 20:10:24 -0700 (PDT)
Received: by 10.50.237.38 with HTTP; Sun, 29 Jul 2012 20:10:24 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/202521>

L10n teams:

New "git.pot" is generated from git v1.7.12-rc0. L10n teams can get it
from the usual place and start translation.

 * https://github.com/git-l10n/git-po/commits/master

This update is quite small:

    l10n: Update git.pot (4 new, 3 removed messages)

    Generate po/git.pot from v1.7.12-rc0-54-g9e211, and there are 4 new,
    3 removed l10n messages.

     * 4 new messages are added at lines:
       1254, 1264, 1459, 1523

     * 3 old messages are deleted from the previous version at lines:
       1254, 1273, 2854

I am not sure whether Junio would like to merge new new i18n commits
to the upcoming 1.7.12, but I bet there would be more i18n/l10n works
in the future. (I would contribute more i18n update since I begin to
update my book on Git in Chinese, any untranslated output would be fixed.)

I also generate a "git.pot" from branch "jx/i18n-1.7.11" in Junio's repo
just for reference. The update is huge:

    l10n: Update git.pot (79 new, 6 removed messages)

    Generate po/git.pot from v1.7.11.2-256-g55653, and there are 79 new,
    6 removed l10n messages.

     * 79 new messages are added at lines:

       337, 342, 346, 350, 354, 359, 364, 370, 375, 380, 385, 395, 400,
       404, 409, 413, 420, 427, 431, 435, 440, 447, 451, 456, 461, 466,
       ...

     * 6 old messages are deleted from the previous version at lines:

       1254, 1273, 2854, 4726, 4761, 5292

You can find it from https://github.com/git-l10n/git-po/commits/jx/i18n-1.7.11 .

-- 
Jiang Xin
