From: Jiang Xin <worldhello.net@gmail.com>
Subject: Please pull l10n updates for 1.8.4 round 2
Date: Fri, 9 Aug 2013 15:39:47 +0800
Message-ID: <CANYiYbGhtMBwxJPOZNs=o3sxD=uLtF=0obOpZG-OZs63dQECSA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Ralf Thielow <ralf.thielow@gmail.com>,
	Peter Krefting <peter@softwolves.pp.se>,
	Tran Ngoc Quan <vnwildman@gmail.com>,
	Git List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Aug 09 09:39:57 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V7hIj-0005cN-4V
	for gcvg-git-2@plane.gmane.org; Fri, 09 Aug 2013 09:39:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S967662Ab3HIHjv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 9 Aug 2013 03:39:51 -0400
Received: from mail-wi0-f171.google.com ([209.85.212.171]:40253 "EHLO
	mail-wi0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S967652Ab3HIHjs (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 9 Aug 2013 03:39:48 -0400
Received: by mail-wi0-f171.google.com with SMTP id hr7so1363901wib.4
        for <git@vger.kernel.org>; Fri, 09 Aug 2013 00:39:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:date:message-id:subject:from:to:cc:content-type;
        bh=Bx68dxa5KJay5WMd4RLyDvmD+wpFKdpDfc7FKCKrwgA=;
        b=AxHRKk13kq5FenLcUEdLmf4/sKL2AqQ0r52YkIfcvAYMrllAUNkmdkviCJDgCuNGHM
         hYFsOZlHPfAn9OkpobCgDN/SVqDgXyJrSC/x0XgjU8qYwo2FILx9vuUTNZWhxzrUbHRo
         ZkbgAM8r74dMTIR0W1Kfb9BaGiNytIN+JPxOIERJmP+BbSYbSLZNrBeLei4CBqvjUrdE
         CAPZIaywsaGfcdekAraIcw1PWaELpcNDjn9XlzaOoXxzHouHulLj3MkSYHEyj5GbvwQu
         gT7qRn9SHU3v4kYudfTy6BaQof8LdMCG+MHuNNkBMdbZdKmL6bgLHL4eT9tNVyro/6Hg
         aW2w==
X-Received: by 10.180.36.74 with SMTP id o10mr1383698wij.23.1376033987072;
 Fri, 09 Aug 2013 00:39:47 -0700 (PDT)
Received: by 10.194.104.201 with HTTP; Fri, 9 Aug 2013 00:39:47 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/231961>

Hi, Junio

The following changes since commit fb5657082148297b61fbca7e64d51c1e7870309a:

  Sync with maint to grab trivial doc fixes (2013-08-05 13:00:20 -0700)

are available in the git repository at:


  git://github.com/git-l10n/git-po master

for you to fetch changes up to 4402f301555feeada2de68c4576aa15acfe40b46:

  l10n: de.po: translate 5 messages (2013-08-09 06:53:44 +0200)

----------------------------------------------------------------
Jiang Xin (2):
      l10n: git.pot: v1.8.4 round 2 (5 new, 3 removed)
      l10n: zh_CN.po: translate 5 messages (2135t0f0u)

Peter Krefting (1):
      l10n: Update Swedish translation (2135t0f0u)

Ralf Thielow (3):
      l10n: de.po: switch from pure German to German+English
      l10n: de.po: translate 99 new messages
      l10n: de.po: translate 5 messages

Tran Ngoc Quan (1):
      l10n: vi.po(2135t): v1.8.4 round 2

Wieland Hoffmann (1):
      l10n: de.po: Fix a typo

 po/de.po    | 5156 ++++++++++++++++++++++++++++++++---------------------------
 po/git.pot  |  335 ++--
 po/sv.po    | 3365 ++++++++++++++++++++------------------
 po/vi.po    |  356 +++--
 po/zh_CN.po |  346 ++--
 5 files changed, 5144 insertions(+), 4414 deletions(-)

--
Jiang Xin
