From: Dimitriy Ryazantcev <dimitriy.ryazantcev@gmail.com>
Subject: [PATCH] git-gui: Update Russian translation
Date: Mon, 12 Oct 2015 14:41:36 +0300
Message-ID: <1444650097-7036-1-git-send-email-dimitriy.ryazantcev@gmail.com>
Cc: Dimitriy Ryazantcev <dimitriy.ryazantcev@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Oct 12 13:42:25 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZlbUn-0002FG-Az
	for gcvg-git-2@plane.gmane.org; Mon, 12 Oct 2015 13:42:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751893AbbJLLmT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 12 Oct 2015 07:42:19 -0400
Received: from mail-lb0-f177.google.com ([209.85.217.177]:35146 "EHLO
	mail-lb0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751747AbbJLLmQ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 Oct 2015 07:42:16 -0400
Received: by lbwr8 with SMTP id r8so138547774lbw.2
        for <git@vger.kernel.org>; Mon, 12 Oct 2015 04:42:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=ZbxmmF0W+hBI6Ml6qPdkbasA9pXgs+sYQSnYLI8D8os=;
        b=0snsENXxnKZQLX9hj00ftjcl2ydfyg5bx96NxgXQxM0Ie1R1xSNUPRP8s8oSn4X4N3
         cMQszRq4EONnQvfCUePj04bMyj1qNBw7bvhp2g4zL0osse0nJGgvTP9VGzf9Wejrddm0
         dlT2rEWlqSIhS++nIfaPmU7omn7AGu6OmPqzlwhgNCc0tndZLqk7FKflhAcuX4K0gPEF
         vVGT1fwRFpphDI2I88aZmfAIxChMakLg8+TcZsg2H5hYBBr/NM5Q9t0TnNvUi6AQI+kn
         5bRqBDqLjRXV4CDzeCAvEkwF3cRDG6JmsXr4ouVKrYnd4hDdoAlOya7zVNxF+khf092u
         dudw==
X-Received: by 10.25.28.81 with SMTP id c78mr4059940lfc.29.1444650134244;
        Mon, 12 Oct 2015 04:42:14 -0700 (PDT)
Received: from Prog004.devcubestudio.com (host-46-250-125-121.la.net.ua. [46.250.125.121])
        by smtp.gmail.com with ESMTPSA id pm6sm2802656lbc.1.2015.10.12.04.42.12
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 12 Oct 2015 04:42:13 -0700 (PDT)
X-Mailer: git-send-email 2.6.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/279374>

I updated Russian translation for git-gui.
Please feel free to add any sugessions on Git Russian Localization Project: https://www.transifex.com/djm00n/git-po-ru/language/ru/
Patch is against current git://repo.or.cz/git-gui.git master branch.

Dimitriy Ryazantcev (1):
  git-gui: Update Russian translation

 po/ru.po | 675 +++++++++++++++++++++++----------------------------------------
 1 file changed, 247 insertions(+), 428 deletions(-)

-- 
2.6.0
