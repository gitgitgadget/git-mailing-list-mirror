From: Jiang Xin <worldhello.net@gmail.com>
Subject: [GIT PULL] Korean l10n updates for Git 2.7.0 (maint branch)
Date: Tue, 12 Jan 2016 01:20:00 +0800
Message-ID: <CANYiYbHVUi3xftFuwTHkiXgS=7KZEv309dE5vyywsFVvSMcEEA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>, Changwoo Ryu <cwryu@debian.org>
X-From: git-owner@vger.kernel.org Mon Jan 11 18:20:11 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aIg8X-0004u5-JO
	for gcvg-git-2@plane.gmane.org; Mon, 11 Jan 2016 18:20:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759978AbcAKRUD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 11 Jan 2016 12:20:03 -0500
Received: from mail-wm0-f52.google.com ([74.125.82.52]:35204 "EHLO
	mail-wm0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759969AbcAKRUC (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 11 Jan 2016 12:20:02 -0500
Received: by mail-wm0-f52.google.com with SMTP id f206so220668365wmf.0
        for <git@vger.kernel.org>; Mon, 11 Jan 2016 09:20:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:date:message-id:subject:from:to:cc:content-type;
        bh=+VXMc7WUD+EFskzbpQ1+nApRdq9+x8C4r65FlQ/R2pI=;
        b=KCbK5/Untqx1wMZgciu2979WNIY0FlRrDZd1R7lri416jE8UMI3K+hBB2SpX0Xtx7w
         +k874KisND6ucIi84Accfzh4Q6jiKUAkPj3umNnuTIf+NTwypM/BS1GgLssQS6bOFNCO
         nGSmsPViJRoA1jZc2pZzVUSZ6khDo8m/z3cklnKxMhktxdhVw0kj5vM8RT0hBXPl4YxH
         wY5jXxnsUygJ0wy5wC7nU7d7IqVsb5AgDANmVaPjj0JXbNkaRmTTpU2BjX/aUYEUMGBv
         t+Anske9yUt5+5Y6t0M1Lt5vXRBh3mRZAKPIbXoxR60I4Tp6RBgoR+VTDoxOoRIEjcru
         nWyg==
X-Received: by 10.194.246.200 with SMTP id xy8mr131890501wjc.62.1452532800894;
 Mon, 11 Jan 2016 09:20:00 -0800 (PST)
Received: by 10.194.61.43 with HTTP; Mon, 11 Jan 2016 09:20:00 -0800 (PST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/283677>

Hi Junio,

Changwoo contributed a new language (Korean) l10n support, but missed the
update window for Git 2.7.0.  Please merge this to the maint branch.

The following changes since commit 02103b328912d06d1b04cf42e408cad2218b1f9b:

  l10n: de.po: translate 68 new messages (2015-12-29 19:53:17 +0100)

are available in the git repository at:

  git://github.com/git-l10n/git-po maint

for you to fetch changes up to c6cd26696c4312fbe3800edc61e4fb0851ee180b:

  l10n: ko.po: Add Korean translation (2016-01-03 19:07:29 +0900)

----------------------------------------------------------------
Changwoo Ryu (1):
      l10n: ko.po: Add Korean translation

 po/TEAMS |     4 +
 po/ko.po | 11859 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 11863 insertions(+)
 create mode 100644 po/ko.po
