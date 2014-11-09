From: Jiang Xin <worldhello.net@gmail.com>
Subject: [GIT PULL] l10n updates for 2.2.0 round 1
Date: Sun, 9 Nov 2014 22:36:50 +0800
Message-ID: <CANYiYbHmebuwuGTPNHfZ4MHKeJSMBnwmVSaZ0ZD6tFKrYAawgQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git List <git@vger.kernel.org>,
	Alexander Shopov <ash@kambanaria.org>,
	Jean-Noel Avila <jn.avila@free.fr>,
	Peter Krefting <peter@softwolves.pp.se>,
	Tran Ngoc Quan <vnwildman@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Nov 09 15:37:24 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XnTcJ-0005LK-A7
	for gcvg-git-2@plane.gmane.org; Sun, 09 Nov 2014 15:37:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751937AbaKIOgw convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 9 Nov 2014 09:36:52 -0500
Received: from mail-wg0-f53.google.com ([74.125.82.53]:34479 "EHLO
	mail-wg0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751867AbaKIOgw convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 9 Nov 2014 09:36:52 -0500
Received: by mail-wg0-f53.google.com with SMTP id b13so6955166wgh.40
        for <git@vger.kernel.org>; Sun, 09 Nov 2014 06:36:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=XwrgtsWmi+Y48SqAc0iDZZcLtmqNWl8VDMSaqKvvoGU=;
        b=QVsb1ycepipUQgBwmEIv3yTlm+u5IIeZBu8RWdgIrM3dexFTMoRB+xj6AwiXg9tVD0
         VQU5wKZUwDrX9vWaBLoKxlgW3vyxl7PvbZ/liL2moRhsrmRZpLR3o4pZbDoVAkIlzGug
         Au/6AUaclFK/KskqZ57d7yXmyp8vDRWtEjbg3L+QEnv+cHmf5EY68Gx/UEXaV6f05/jp
         //dCisWOawYdL8b2jVkimnY5zcQqvisKdTIt2FhaMqaoogMQI5A8IP0xRyamvb2i8PUw
         0dpJ2WXb46raBX3ewPgOSdo/STlB8ehKWydCHd1wX041JSB73lAVNVBb0DYTmQlVdbvI
         CRLA==
X-Received: by 10.194.58.180 with SMTP id s20mr31295086wjq.28.1415543810724;
 Sun, 09 Nov 2014 06:36:50 -0800 (PST)
Received: by 10.194.169.103 with HTTP; Sun, 9 Nov 2014 06:36:50 -0800 (PST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

Please pull the following git l10n updates.

The following changes since commit 4ace7ff4557350b7e0b57d024a2ea311b332=
e01d:

  Git 2.2.0-rc0 (2014-10-31 11:57:23 -0700)

are available in the git repository at:

  git://github.com/git-l10n/git-po master

for you to fetch changes up to 6c31a5e94af1036bb29da8a75f1e735e662aee92=
:

  l10n: Updated Bulgarian translation of git (2296t,0f,0u) (2014-11-02
19:11:08 +0200)

----------------------------------------------------------------
Alexander Shopov (1):
      l10n: Updated Bulgarian translation of git (2296t,0f,0u)

Jean-Noel Avila (1):
      l10n: fr.po (2296t) update for version 2.2.0

Jiang Xin (4):
      l10n: git.pot: v2.2.0 round 1 (62 new, 23 removed)
      Merge branch 'master' of git://github.com/nafmo/git-l10n-sv
      Merge branch 'fr_2.2.0' of git://github.com/jnavila/git
      l10n: zh_CN: translations for git v2.2.0-rc0

Peter Krefting (1):
      l10n: sv.po: Update Swedish translation (2296t0f0u)

Tr=E1=BA=A7n Ng=E1=BB=8Dc Qu=C3=A2n (1):
      l10n: vi.po: Update new message strings

 po/bg.po    | 3211 +++++++++++++++++++++++++++++++--------------------=
------
 po/fr.po    | 3199 +++++++++++++++++++++++++++++++--------------------=
------
 po/git.pot  | 3109 +++++++++++++++++++++++++++++----------------------=
----
 po/sv.po    | 3187 ++++++++++++++++++++++++++++++---------------------=
-----
 po/vi.po    | 3306 ++++++++++++++++++++++++++++++++-------------------=
--------
 po/zh_CN.po | 3197 +++++++++++++++++++++++++++++++--------------------=
------
 6 files changed, 10327 insertions(+), 8882 deletions(-)

--
Jiang Xin
