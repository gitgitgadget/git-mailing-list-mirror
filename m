From: Ralf Thielow <ralf.thielow@gmail.com>
Subject: [PATCH 0/7] l10n: de.po: use imperative form for command options
Date: Fri, 19 Sep 2014 19:12:43 +0200
Message-ID: <1411146770-8508-1-git-send-email-ralf.thielow@gmail.com>
Cc: tr@thomasrast.ch, jk@jk.gs, stimming@tuhh.de,
	phillip.szelat@gmail.com, matthias.ruester@gmail.com,
	magnus.goerlitz@googlemail.com,
	Ralf Thielow <ralf.thielow@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Sep 19 19:13:07 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XV1k3-0003qI-6I
	for gcvg-git-2@plane.gmane.org; Fri, 19 Sep 2014 19:13:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757469AbaISRNA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 19 Sep 2014 13:13:00 -0400
Received: from mail-wg0-f43.google.com ([74.125.82.43]:59632 "EHLO
	mail-wg0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757445AbaISRNA (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 19 Sep 2014 13:13:00 -0400
Received: by mail-wg0-f43.google.com with SMTP id y10so34074wgg.2
        for <git@vger.kernel.org>; Fri, 19 Sep 2014 10:12:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=D/hisv1qreGYqPH8N1I+XUUxgjKUFPprVOB14pXljm8=;
        b=PSl7gzTeCnYxeurjR1+nx/o1y6T3S1DtlrzIh2ewPxKoLN4DBiLVj6H7GIJHQDVSUZ
         thfsn9eLHxFBZ54SQyMcTui1qR4/Xdp9fY6u1KTwUnSgupP2CDydZN5bjcGoDLJlEWV5
         +5IlGarrD3RlqWH1pgQ1VD3tYB4qOQWbDD6as1lMopMaU9yjtLjfoCGRUZhz5Wexo5i7
         yWnkiKmy8V49Odv5V4O25r0zJH32UuhQwjxjUQQ4TXTXM3ylNbzSrZGN9bwjwRy+eZ+v
         04GXBf9YvMlRT8H/+WaZ7rYa3GN7FfmfJxa8DAdnJxVGt6q/MhWyrZgT1MRJ2Y0JYwkE
         dVrQ==
X-Received: by 10.194.95.8 with SMTP id dg8mr2512548wjb.1.1411146778885;
        Fri, 19 Sep 2014 10:12:58 -0700 (PDT)
Received: from localhost (dslb-178-000-162-213.178.000.pools.vodafone-ip.de. [178.0.162.213])
        by mx.google.com with ESMTPSA id cf3sm2902038wjc.17.2014.09.19.10.12.58
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Fri, 19 Sep 2014 10:12:58 -0700 (PDT)
X-Mailer: git-send-email 2.1.0.368.g9f4fb5d
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/257291>

Some people have suggested to use an imperative form for translating
command options. I added this topic to my TODO list and now found
the time to implement it.

I've splitted this huge patch into seven parts to make the review
easier. I'll squash those 7 parts into one big patch before applying.

Ralf Thielow (7):
  part1: l10n: de.po: use imperative form for command options
  part2: l10n: de.po: use imperative form for command options
  part3: l10n: de.po: use imperative form for command options
  part4: l10n: de.po: use imperative form for command options
  part5: l10n: de.po: use imperative form for command options
  part6: l10n: de.po: use imperative form for command options
  part7: l10n: de.po: use imperative form for command options

 po/de.po | 1146 +++++++++++++++++++++++++++++++-------------------------------
 1 file changed, 573 insertions(+), 573 deletions(-)

-- 
2.1.0.368.g9f4fb5d
