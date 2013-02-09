From: Jiang Xin <worldhello.net@gmail.com>
Subject: Please pull l10n updates for 1.8.2 round 1
Date: Sat, 9 Feb 2013 11:55:36 +0800
Message-ID: <CANYiYbHhGDFD3LZKGeRxkBF5s0TRHMvRBZY7c9T8zONiZGiNdA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Ralf Thielow <ralf.thielow@gmail.com>,
	Thomas Rast <trast@inf.ethz.ch>,
	Wang Sheng <wangsheng2008love@163.com>,
	Peter Krefting <peter@softwolves.pp.se>,
	Tran Ngoc Quan <vnwildman@gmail.com>,
	Git List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Feb 09 04:56:05 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U41Xl-00068k-TC
	for gcvg-git-2@plane.gmane.org; Sat, 09 Feb 2013 04:56:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760639Ab3BIDzi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 8 Feb 2013 22:55:38 -0500
Received: from mail-wi0-f171.google.com ([209.85.212.171]:61992 "EHLO
	mail-wi0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760635Ab3BIDzh (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 8 Feb 2013 22:55:37 -0500
Received: by mail-wi0-f171.google.com with SMTP id hn17so1562676wib.10
        for <git@vger.kernel.org>; Fri, 08 Feb 2013 19:55:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:x-received:date:message-id:subject:from:to:cc
         :content-type;
        bh=AuMLohP6AutU9WoBX3zCjipQAz4Sh/sVDhvnxD2wIac=;
        b=yalDJEMbTOLizZhFwsMI81E32SeC1gD+MK6zZGIcxggi9DTZ6pDCvzqh4ip3xhfXsS
         p6wqYC3OMrUaNJRan86M60GC7lVljbOBpUN2f0ra3dqFdpbUnjztRXPW4VS7oUop7Amk
         5eF3xcrZerObePjChsWxitpW0+3y8XiEABJEIQa/CuNdKkN1Y06bxVGy90DaskfwEMl4
         gUNpkFPzUGOD0pRzVh6bjcWfdGk5w25dfCKSFq9T1LH2W9Tpoif2AKKMe8vhZY/lNRo/
         +mf+Al30X/1xuoIFV4GBu/tsAXGtltod38XVT+yeBL5gJJz2E9NkiMusu05F55sQhHBL
         AeVw==
X-Received: by 10.180.84.165 with SMTP id a5mr6015191wiz.6.1360382136505; Fri,
 08 Feb 2013 19:55:36 -0800 (PST)
Received: by 10.194.110.199 with HTTP; Fri, 8 Feb 2013 19:55:36 -0800 (PST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/215850>

Hi, Junio

The following changes since commit ec3ae6ec46ed48383ae40643990f169b65a563cc:

  Merge git://ozlabs.org/~paulus/gitk (2013-01-23 08:35:03 -0800)

are available in the git repository at:


  git://github.com/git-l10n/git-po/ master

for you to fetch changes up to 1bbe7c3c124c435b45f87a71516211f5252086f7:

  l10n: de.po: translate "reset" as "neu setzen" (2013-02-08 20:43:30 +0100)

----------------------------------------------------------------
Jiang Xin (2):
      l10n: Update git.pot (11 new, 7 removed messages)
      Merge branch 'master' of git://github.com/ralfth/git-po-de

Peter Krefting (1):
      l10n: Update Swedish translation (1983t0f0u)

Ralf Thielow (4):
      l10n: de.po: fix some minor issues
      l10n: de.po: translate 11 new messages
      l10n: de.po: translate "revision" consistently as "Revision"
      l10n: de.po: translate "reset" as "neu setzen"

Tran Ngoc Quan (1):
      l10n: vi.po: updated Vietnamese translation

Wang Sheng (1):
      l10n: zh_CN.po: 800+ new translations on command usages

 po/TEAMS    |    1 +
 po/de.po    | 1545 ++++++++++++----------
 po/git.pot  | 1137 ++++++++--------
 po/sv.po    | 1164 ++++++++--------
 po/vi.po    | 1182 +++++++++--------
 po/zh_CN.po | 4258 +++++++++++++++++++++++++++++------------------------------
 6 files changed, 4728 insertions(+), 4559 deletions(-)

--
Jiang Xin
