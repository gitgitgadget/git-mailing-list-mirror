From: =?UTF-8?B?VHLhuqduIE5n4buNYyBRdcOibg==?= <vnwildman@gmail.com>
Subject: RE: Please pull l10n updates for 1.8.1 round 1
Date: Thu, 29 Nov 2012 14:28:45 +0700
Message-ID: <50b70eb8.46c5440a.38b1.3f66@mx.google.com>
References: <CANYiYbHfhBXbLEEKdpJkhp+wY9-AJ1JkjfO62W3c+dm8qpk7_g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: "'Git List'" <git@vger.kernel.org>,
	"'Peter Krefting'" <peter@softwolves.pp.se>,
	=?UTF-8?Q?'Nguy=E1=BB=85n_Th=C3=A1i_Ng=E1=BB=8Dc_Duy'?= 
	<pclouds@gmail.com>
To: "'Jiang Xin'" <worldhello.net@gmail.com>,
	"'Junio C Hamano'" <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Nov 29 08:29:16 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TdyYd-0001uB-2R
	for gcvg-git-2@plane.gmane.org; Thu, 29 Nov 2012 08:29:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751363Ab2K2H27 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 29 Nov 2012 02:28:59 -0500
Received: from mail-da0-f46.google.com ([209.85.210.46]:58109 "EHLO
	mail-da0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751100Ab2K2H27 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 29 Nov 2012 02:28:59 -0500
Received: by mail-da0-f46.google.com with SMTP id p5so5141947dak.19
        for <git@vger.kernel.org>; Wed, 28 Nov 2012 23:28:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:from:to:cc:subject:date:mime-version:content-type
         :content-transfer-encoding:x-mailer:in-reply-to:thread-index
         :x-mimeole;
        bh=8vuA4p+q2J59lto6/7hDel0BxmtEflcekIiXyh1JC78=;
        b=Uo+KaEydQTzfCUT7emQDkdbjCQ5wI64/nvr8sWPjPUCmEEQixNkE7gQu4rHJXcTM5X
         63R/gK6hGX0f8EF8gl0GuyjcJre1NQwhi8y+ujyIcgO2tn7WqNGAmpZMWIEhboije4iq
         0tpbVK8BUs9FeLRIbJ3YfzKGfRm1dJ8xzVFY0951iUNriNyobZdf/yIfsGYoslAi1E5z
         EdSH6dpp2HgP6U6k4dIw3+qFj7edBleYXu+sRWAmkebdrjpU6gIubZ6vicAeU1yqcJOn
         kaznnA2WRyvIT5eZQVH2y8/+O9zWnkKALEUabsgXxjWGQ2SewsEHR2uMW4LLy0sLEt1O
         BjUQ==
Received: by 10.68.243.10 with SMTP id wu10mr66041595pbc.85.1354174137718;
        Wed, 28 Nov 2012 23:28:57 -0800 (PST)
Received: from tnquan495e2448 ([113.171.162.179])
        by mx.google.com with ESMTPS id is6sm799262pbc.55.2012.11.28.23.28.53
        (version=SSLv3 cipher=OTHER);
        Wed, 28 Nov 2012 23:28:56 -0800 (PST)
X-Mailer: Microsoft Office Outlook, Build 11.0.5510
In-Reply-To: <CANYiYbHfhBXbLEEKdpJkhp+wY9-AJ1JkjfO62W3c+dm8qpk7_g@mail.gmail.com>
Thread-Index: Ac3Nz4b451zjDdlyTfy3PbBTaPtU+AAMjb0g
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.3138
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/210817>

Hello JX,
You missing pull from my repo (2 commits instead of one, v1.7 and v1.8)=
: dcc52a0449c7ee10690e23152e63b9798f8a332f

$ git log -n 2
commit dcc52a0449c7ee10690e23152e63b9798f8a332f
Author: Tran Ngoc Quan <vnwildman@gmail.com>
Date:   Sat Nov 24 07:37:35 2012 +0700

    l10n: vi.po: Update follow git-v1.8.0-273-g2d242

    Signed-off-by: Tran Ngoc Quan <vnwildman@gmail.com>

commit 131fa518f10521b4a534863331decbfef2875f24
Author: Tran Ngoc Quan <vnwildman@gmail.com>
Date:   Wed Oct 31 08:19:59 2012 +0700

    l10n: vi.po: update to git-v1.7.12-437-g1084f

     * updated all new messages (1967t0f0u)
     * make quote become more good-looking

    Signed-off-by: Tran Ngoc Quan <vnwildman@gmail.com>

 https://github.com/vnwildman/git.git master
Thanks,
Tr=E1=BA=A7n Ng=E1=BB=8Dc Qu=C3=A2n

-----Original Message-----
=46rom: Jiang Xin [mailto:worldhello.net@gmail.com]=20
Sent: Thursday, November 29, 2012 8:19 AM
To: Junio C Hamano
Cc: Git List; Peter Krefting; Tr=E1=BA=A7n Ng=E1=BB=8Dc Qu=C3=A2n; Nguy=
=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy
Subject: Please pull l10n updates for 1.8.1 round 1

Hi, Junio

The following changes since commit 2d242fb3fc19fc9ba046accdd9210be8b991=
3f64:

  Update draft release notes for 1.8.1 (2012-11-21 13:32:58 -0800)

are available in the git repository at:

  git://github.com/git-l10n/git-po.git master

for you to fetch changes up to 647d5183b8dc36b38d19c7a3f388108f245b11d3=
:

  l10n: Update Swedish translation (1975t0f0u) (2012-11-23 08:59:11 +01=
00)

----------------------------------------------------------------
Jiang Xin (1):
      l10n: Update git.pot (14 new, 3 removed messages)

Peter Krefting (1):
      l10n: Update Swedish translation (1975t0f0u)

Tran Ngoc Quan (1):
      l10n: vi.po: update to git-v1.7.12-437-g1084f

 po/git.pot | 1224 ++++++++++++++++++++++++----------------------
 po/sv.po   | 1246 +++++++++++++++++++++++++----------------------
 po/vi.po   | 1597 ++++++++++++++++++++++++++++++----------------------=
--------
 3 files changed, 2097 insertions(+), 1970 deletions(-)

--
Jiang Xin
