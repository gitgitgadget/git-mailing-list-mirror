From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH 0/2] remote-hg: small fixes
Date: Sun, 11 Nov 2012 15:09:57 +0100
Message-ID: <1352642999-7205-1-git-send-email-felipe.contreras@gmail.com>
Cc: Felipe Contreras <felipe.contreras@gmail.com>,
	Jeff King <peff@peff.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Nov 11 15:10:50 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TXYFN-0003PY-AL
	for gcvg-git-2@plane.gmane.org; Sun, 11 Nov 2012 15:10:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752500Ab2KKOK2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 11 Nov 2012 09:10:28 -0500
Received: from mail-bk0-f46.google.com ([209.85.214.46]:45205 "EHLO
	mail-bk0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751692Ab2KKOK2 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 11 Nov 2012 09:10:28 -0500
Received: by mail-bk0-f46.google.com with SMTP id jk13so2063390bkc.19
        for <git@vger.kernel.org>; Sun, 11 Nov 2012 06:10:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer;
        bh=Iol7mR8Y3qPVJJ7mkQfG2gy6wVVQD3ecMlrYgMiOZIM=;
        b=mg268PEiGBKkQJ8RfuKv9MIbHAWdqe87IGJjaxYuUu/Z6iflb+vt4E+uAHlFAtLAC7
         0nq07IOYep2P2QrwezIDD2P8ojpfi2CIDtporxC448oPsFywzgpbcAYvMFcf8sKh2zKE
         1M5IzEhlXkZ/spwy5TtJSO4/7c2bGrRHSJh8f8y4sM0UYmvWMZU9FGscQv5NwUi4GROW
         446ufmSwL4Y4G4MuW+3C7lTcvCi9XoeJ2DlxUKlp3WQagrFFulhkPfkVwTzg3wHRU/lQ
         zzP2x+JQMvdIEV2TrxFMcI6CpeyYO9ku13X78h+4ipkdVym2Q/bqUDS+hNC/T7gu6j6m
         l3LQ==
Received: by 10.204.128.155 with SMTP id k27mr5873686bks.26.1352643026565;
        Sun, 11 Nov 2012 06:10:26 -0800 (PST)
Received: from localhost (ip-109-43-0-127.web.vodafone.de. [109.43.0.127])
        by mx.google.com with ESMTPS id gy18sm1499490bkc.4.2012.11.11.06.10.24
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sun, 11 Nov 2012 06:10:25 -0800 (PST)
X-Mailer: git-send-email 1.8.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/209372>

Hi,

Nothing major.

These are meant to be on top of fc/remote-hg that is on peff/pu.

Felipe Contreras (2):
  remote-hg: trivial cleanups
  remote-hg: fix for files with spaces

 contrib/remote-helpers/git-remote-hg | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

-- 
1.8.0
