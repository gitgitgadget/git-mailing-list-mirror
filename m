From: Jiang Xin <worldhello.net@gmail.com>
Subject: [GIT PULL] l10n update for maint branch
Date: Mon, 6 Jan 2014 12:34:09 +0800
Message-ID: <CANYiYbFc6jEQpwpNOTL9hH3pU-c0y6Umb4wDgeWGEDFfHN-vDQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Git List <git@vger.kernel.org>,
	Ralf Thielow <ralf.thielow@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Jan 06 05:34:16 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1W01tI-00089Z-1x
	for gcvg-git-2@plane.gmane.org; Mon, 06 Jan 2014 05:34:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752651AbaAFEeL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 5 Jan 2014 23:34:11 -0500
Received: from mail-wi0-f170.google.com ([209.85.212.170]:62291 "EHLO
	mail-wi0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752569AbaAFEeL (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 5 Jan 2014 23:34:11 -0500
Received: by mail-wi0-f170.google.com with SMTP id hq4so2317549wib.3
        for <git@vger.kernel.org>; Sun, 05 Jan 2014 20:34:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:date:message-id:subject:from:to:cc:content-type;
        bh=cBdNE9C2TgeYXWm7DAl+GxmVxXlIgOMBhswRNtkAx84=;
        b=1GPmLPu0i1zJDz1rqsOJiysQFjEtSxdq2QEo8f+nYM1d4lx4V8YUBf9F0ydT4zsYgV
         19lTrSGzKKh4D86Q5geOGomaNcrT6IvvqCaUbNcZvgUIIz106FWgU5g+eQGrVKQY9JVA
         mIGYOajEoHRKCe8n1DXUu2w7FmoOdWJRsW5Vt2v7g5JyXZv2x3oNe3p575hGNGQ/FXwb
         ZdXMA368m/wMPdUD4Hel0XFs6mOV7BLVOS3J7o6B6H4AYUriuWSd7YkdV+2Yqy8GqnQl
         kyL/LPKccbNQBYWkHRQAYh++NWqR2zYwNp9n/GY7KPEAr/VXAgvFzxiMrSADgaR+scp8
         gEmQ==
X-Received: by 10.180.104.42 with SMTP id gb10mr10681807wib.51.1388982849541;
 Sun, 05 Jan 2014 20:34:09 -0800 (PST)
Received: by 10.216.213.207 with HTTP; Sun, 5 Jan 2014 20:34:09 -0800 (PST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/239986>

Hi, Junio

Please pull l10n update for maint branch. It can be merged to master
without conflict.

The following changes since commit 5512ac5840c8bcaa487806cf402ff960091ab244:

  Git 1.8.5.2 (2013-12-17 11:42:12 -0800)

are available in the git repository at:

  git://github.com/git-l10n/git-po maint

for you to fetch changes up to cb0553651d9bbfc7ecdb9ebe8365a449156f3455:

  l10n: de.po: fix translation of 'prefix' (2014-01-03 18:21:38 +0100)

----------------------------------------------------------------
Ralf Thielow (1):
      l10n: de.po: fix translation of 'prefix'

 po/de.po | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

2014/1/4 Ralf Thielow <notifications@github.com>:
> Hi Xin,
>
> please pull this fix of German translation for 'maint' branch.
> I assume Junio will synchronize 'maint' with 'master' that I don't
> have to merge it myself. The commit can be merged without
> conflicts.
>

--
Jiang Xin
