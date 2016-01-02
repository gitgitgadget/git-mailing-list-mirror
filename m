From: Jiang Xin <worldhello.net@gmail.com>
Subject: [GIT PULL] German l10n updates on Git 2.7.0
Date: Sat, 2 Jan 2016 08:53:15 +0800
Message-ID: <CANYiYbGd4cZLnDQdOjbzehOeJEeu_ZyTwyyYsD_=ghGzHHqh1Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>,
	Ralf Thielow <ralf.thielow@googlemail.com>
X-From: git-owner@vger.kernel.org Sat Jan 02 01:53:57 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aFASC-00081Q-0E
	for gcvg-git-2@plane.gmane.org; Sat, 02 Jan 2016 01:53:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752387AbcABAxS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 1 Jan 2016 19:53:18 -0500
Received: from mail-wm0-f49.google.com ([74.125.82.49]:38605 "EHLO
	mail-wm0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751804AbcABAxR (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 1 Jan 2016 19:53:17 -0500
Received: by mail-wm0-f49.google.com with SMTP id b14so118487231wmb.1
        for <git@vger.kernel.org>; Fri, 01 Jan 2016 16:53:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:date:message-id:subject:from:to:cc:content-type;
        bh=j0vr1AKLKaK4Wj0MJgM2I3mGtag4/1YfTMKXlfW3Vkk=;
        b=Hb/1F2JQTa8xl+GgOyS49s2YltBs+LA1SBa3gmpVUs1KIl1raK573VFRZkKGUyGbwT
         jhDtQ7giycbCJsAO1ml5uDNRYN9amhmIgaLp96h71nftm/q7m9mrlMClhkvprVmYtJ3B
         T1i+sXl7B/G3orKdCuZkRNT85pYsZ8Wu9nRO1mQ+SnBQw83meVx/KfSKrNdr35KiXHYW
         quuETIJC3jVe7reHY+H7nFHWK4vuYzE6MqbMcAw4Ixclyrgql+zcbdtJs2c7tvEKPutD
         +nytj/cm6cHCrErbuMS+HVkYoK6o+AHDNXQlOBy2aTF+r4wMY/Jf+jmW1Qbz8M3G9c5i
         Nz+w==
X-Received: by 10.194.246.200 with SMTP id xy8mr81749563wjc.62.1451695995517;
 Fri, 01 Jan 2016 16:53:15 -0800 (PST)
Received: by 10.194.61.43 with HTTP; Fri, 1 Jan 2016 16:53:15 -0800 (PST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/283263>

Hi Junio,

Ralf completed his work on German l10n for Git 2.7.0, please pull.

The following changes since commit 28274d02c489f4c7e68153056e9061a46f62d7a0:

  Git 2.7-rc3 (2015-12-28 14:00:52 -0800)

are available in the git repository at:

  git://github.com/git-l10n/git-po tags/l10n-2.7.0-rnd2+de

for you to fetch changes up to 02103b328912d06d1b04cf42e408cad2218b1f9b:

  l10n: de.po: translate 68 new messages (2015-12-29 19:53:17 +0100)

----------------------------------------------------------------
l10n-2.7.0-rnd2+de

----------------------------------------------------------------
Ralf Thielow (2):
      l10n: de.po: improve some translations
      l10n: de.po: translate 68 new messages

 po/de.po | 3212 +++++++++++++++++++++++++++++++++-----------------------------
 1 file changed, 1723 insertions(+), 1489 deletions(-)

--
Jiang Xin
