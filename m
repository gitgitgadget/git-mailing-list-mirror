From: Jiang Xin <worldhello.net@gmail.com>
Subject: Please pull l10n updates for 1.8.2 round 4
Date: Thu, 7 Mar 2013 09:03:01 +0800
Message-ID: <CANYiYbEUSc3s1KZ6tyd9Ot68_o2-hxPE=sD8oA0Dgz-_4G8AWA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Ralf Thielow <ralf.thielow@gmail.com>,
	Tran Ngoc Quan <vnwildman@gmail.com>,
	Peter Krefting <peter@softwolves.pp.se>,
	Git List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Mar 07 02:03:31 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UDPF5-0004b9-3S
	for gcvg-git-2@plane.gmane.org; Thu, 07 Mar 2013 02:03:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758544Ab3CGBDD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 6 Mar 2013 20:03:03 -0500
Received: from mail-pa0-f46.google.com ([209.85.220.46]:49055 "EHLO
	mail-pa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755348Ab3CGBDC (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 6 Mar 2013 20:03:02 -0500
Received: by mail-pa0-f46.google.com with SMTP id kp14so4905pab.19
        for <git@vger.kernel.org>; Wed, 06 Mar 2013 17:03:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:x-received:date:message-id:subject:from:to:cc
         :content-type;
        bh=pIaZGfHF98R9iJp7aAHVqhhvKHPTCD0tYCQT1mq+9BM=;
        b=zY1C4+eD3weKtQQ4ZEdY0rVrwZ07E8eblMie8KoXymEDSWeGVfULUHNG/nMOl09Qhj
         5/YDHcbbsoRxRW07+sGBp2/IicGBqG0w/CETjMJslZDfWSYaZldfzHfguprywHtumGT+
         zPNleTluegGcHWhXg+IHFyDH5cnppNeVg0NkybVlhscy/+7EkXUfTPtYos6yuqPkA3gp
         aNrupdm3r1zTw7P9/TEXlZ/+/1wqhGeV0GV0kyhalur7NSUPrdk68XIVaNslpki3fyfE
         PTw1ukI4DpsqG0mEHybQmQBUxR36DXeLNrXK/08NV1nW9BhWVwm65Yxfw93/E3SYrnTj
         /jOA==
X-Received: by 10.66.253.198 with SMTP id ac6mr108028pad.87.1362618181520;
 Wed, 06 Mar 2013 17:03:01 -0800 (PST)
Received: by 10.68.69.49 with HTTP; Wed, 6 Mar 2013 17:03:01 -0800 (PST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/217567>

Hi Junio,

The following changes since commit 7799588faa2a8071da8ef047c87f9a1520fb8903:

  Merge git://github.com/git-l10n/git-po (2013-03-04 01:16:02 -0800)

are available in the git repository at:


  git://github.com/git-l10n/git-po master

for you to fetch changes up to a7409dfbc1c0d7e0c62f704a03a61bf669e90ae9:

  l10n: zh_CN.po: translate 1 new message (2013-03-07 08:46:19 +0800)

----------------------------------------------------------------
Jiang Xin (2):
      l10n: git.pot: v1.8.2 round 4 (1 changed)
      l10n: zh_CN.po: translate 1 new message

Peter Krefting (1):
      l10n: Update Swedish translation (2009t0f0u)

Ralf Thielow (1):
      l10n: de.po: translate 1 new message

Tran Ngoc Quan (1):
      l10n: vi.po: Update translation (2009t0f0u)

 po/de.po    | 16 +++++++++-------
 po/git.pot  |  4 ++--
 po/sv.po    |  8 ++++----
 po/vi.po    | 20 ++++++++++----------
 po/zh_CN.po |  8 ++++----
 5 files changed, 29 insertions(+), 27 deletions(-)

--
Jiang Xin
