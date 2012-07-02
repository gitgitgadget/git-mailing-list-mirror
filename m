From: Jiang Xin <worldhello.net@gmail.com>
Subject: Please pull git-po maint branch with Swedish update
Date: Mon, 2 Jul 2012 09:43:45 +0800
Message-ID: <CANYiYbFuOM5r-x0ozxuw3tSju4QNBn=nZOv5CydnB2BO-NQ6hQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Git List <git@vger.kernel.org>,
	Peter Krefting <peter@softwolves.pp.se>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Jul 02 03:44:00 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SlVgF-0001tx-L7
	for gcvg-git-2@plane.gmane.org; Mon, 02 Jul 2012 03:43:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754051Ab2GBBnu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 1 Jul 2012 21:43:50 -0400
Received: from mail-gg0-f174.google.com ([209.85.161.174]:59397 "EHLO
	mail-gg0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754014Ab2GBBnt (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 1 Jul 2012 21:43:49 -0400
Received: by gglu4 with SMTP id u4so3774069ggl.19
        for <git@vger.kernel.org>; Sun, 01 Jul 2012 18:43:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:date:message-id:subject:from:to:cc:content-type;
        bh=SKd/8QJTPH9ZjRdeMk7qNmza9ukucnwOSozjI51ru1M=;
        b=PQ5D8VRG0/dakgLqLAwYuAaYnQKqyatywAYy1Zeb9fkwAESkZH0XBxLM2N+8fdUf5u
         ht/Zw5Pz1aqw5lKYkG8d+uy6g7awZE1pxQdDO/emXGPHegKUtbInSeTOSpeCns6lB6Oz
         /6tNWZkXm0v96p6bQ6QP67/F8L+PXWjgaDszTY3Xz8yIIwUgcxtFqBwPpRexIll2AyD4
         qYGVHtWZPItJA00/ULul1QgjwHpXON4KkuNd1jgmAFgsHkvLzU9f7R+LUSnigQY+X4le
         L6m1b2OU+zNVZIqEDthEKXva3qmElxNHiW6fzXnDyXztx6WsVAu6EC/gOIYyG91ksOyP
         3SlQ==
Received: by 10.50.161.234 with SMTP id xv10mr4090261igb.66.1341193425259;
 Sun, 01 Jul 2012 18:43:45 -0700 (PDT)
Received: by 10.50.237.38 with HTTP; Sun, 1 Jul 2012 18:43:45 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/200844>

Hi Junio,

Please merge the maint branch of git-l10n, and then merge back to the
master branch.

The following changes since commit 0ce2e396ee9fb0fa07e8381b338e49859dbf03db:

  Git 1.7.11 (2012-06-17 14:07:15 -0700)

are available in the git repository at:

  git://github.com/git-l10n/git-po maint

for you to fetch changes up to 16b183094e7c93e194bc2c471e95fe3386e6fb69:

  Update Swedish translation (1066t0f0u) (2012-07-01 23:04:09 +0100)

----------------------------------------------------------------
Peter Krefting (1):
      Update Swedish translation (1066t0f0u)

 po/sv.po | 3078 ++++++++++++++++++++++++++++++++++++++++++++++++--------------
 1 file changed, 2393 insertions(+), 685 deletions(-)

--
JIang Xin
