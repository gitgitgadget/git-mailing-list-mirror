From: Jiang Xin <worldhello.net@gmail.com>
Subject: Please pull git-l10n updates on maint branch
Date: Fri, 1 Jun 2012 18:04:21 +0800
Message-ID: <CANYiYbF6aiiYMQbGM0L64yw35GOx=zNvniJrPkjs5bWmud-Y9A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Git List <git@vger.kernel.org>,
	Peter Krefting <peter@softwolves.pp.se>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Jun 01 12:04:35 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SaOib-0007rD-Va
	for gcvg-git-2@plane.gmane.org; Fri, 01 Jun 2012 12:04:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759357Ab2FAKEX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 1 Jun 2012 06:04:23 -0400
Received: from mail-gh0-f180.google.com ([209.85.160.180]:63394 "EHLO
	mail-gh0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758828Ab2FAKEW (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 1 Jun 2012 06:04:22 -0400
Received: by ghbz12 with SMTP id z12so1840790ghb.11
        for <git@vger.kernel.org>; Fri, 01 Jun 2012 03:04:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:date:message-id:subject:from:to:cc:content-type;
        bh=vAvkiFQ87LRqPEXz2olQcimaZf3LEhIZtMjPiTNCCRw=;
        b=DwbBkrs9+IYwIXxz+vVduJxygoiqO14MXuOmVc+hPybYYa1htkoBoJdg1pKxdx8nKk
         SKDM7orO02+AZISpwczdptMKig6LzeaZJgcg+WGBooGphrlUzYJS1cO95psi0d0UJxOV
         FnxDL7LBrqZbFkthWtWS1HoXMrRZPBh1gpliveuMFEIcjieHP1YhaPGwO0OP2Z0aDVAF
         PGrf773zY5g1kb2we41IY3w88Lalnq7O3XaRsPaG0o75sUHFZ5ldvuu19zS1Zm52HlEb
         jA5tv53WmmKGNJRwIv0Kr80+7CH/8tAAE4YgiW82nsOL0adCPvKPbqKDYPO/IOKnMNdU
         VVmg==
Received: by 10.50.104.170 with SMTP id gf10mr608950igb.52.1338545061447; Fri,
 01 Jun 2012 03:04:21 -0700 (PDT)
Received: by 10.50.111.194 with HTTP; Fri, 1 Jun 2012 03:04:21 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/198972>

Hi Junio,

The following changes since commit 042e9f94a71977b471e230f0c637699b0a7ca3d3:

  l10n: de.po: translate 3 new messages (2012-05-15 19:09:02 +0200)

are available in the git repository at:

  https://github.com/git-l10n/git-po/ maint

for you to fetch changes up to 3f0812f68d7d4b7f11a850d4c895b168b9490b7c:

  Update Swedish translation (728t0f0u) (2012-05-29 09:28:34 +0100)

----------------------------------------------------------------
Peter Krefting (1):
      Update Swedish translation (728t0f0u)

 po/sv.po | 536 ++++++++++++++++++++++++++++++++++-----------------------------
 1 file changed, 289 insertions(+), 247 deletions(-)

--
Jiang Xin
