From: Stefan Beller <stefanbeller@gmail.com>
Subject: [PATCH] de.po: Fixup one translation
Date: Tue, 23 Sep 2014 14:54:46 +0200
Message-ID: <1411476886-13141-1-git-send-email-stefanbeller@gmail.com>
References: <CAN0XMO+D7dDh_Xpcgekg3fsDA9Zhh+i7Asi46G3aBpnknivNjA@mail.gmail.com>
Cc: Stefan Beller <stefanbeller@gmail.com>
To: sunshine@sunshineco.com, ralf.thielow@googlemail.com,
	git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Sep 23 14:54:55 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XWPcL-000629-A3
	for gcvg-git-2@plane.gmane.org; Tue, 23 Sep 2014 14:54:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755791AbaIWMyt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 23 Sep 2014 08:54:49 -0400
Received: from mail-we0-f181.google.com ([74.125.82.181]:45289 "EHLO
	mail-we0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755607AbaIWMys (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 23 Sep 2014 08:54:48 -0400
Received: by mail-we0-f181.google.com with SMTP id w61so2619471wes.26
        for <git@vger.kernel.org>; Tue, 23 Sep 2014 05:54:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=TZB91jv32N9ESIbKNX/PKayNF88NZ/4H8NQWQpFUWxc=;
        b=A+dm3RrdPFoIN1n54jhvADmvanzhAFhK6rJMXeNPgHCLhaOP8gcxgmXfRsX1bqjP1A
         szZuYIyrKNNcBksrW8krvNqAaYCCI67S/c4KfnRvz+qL3UgVPDG6gK5MRGSac3fnyA7y
         2T4Zvb+uEPXhmQARF1Oms6I2FQEulYwjDCtEAocXjjuIlDlxG1Sh7MmxFoMsT2059HTf
         npYSmAfAdtEQMgC9Lv3PEy7n7ZU4Ysr9M9Ek2XagiyOP5ABNLN236bNqIKQ8MMgDemO2
         AUsagXGlGOkgMI7jnVCXCkq3KxUwygIEh245XV5TF4QWA4kGD46WlTXTpdn1hf+sX4Fl
         qVOQ==
X-Received: by 10.194.103.200 with SMTP id fy8mr3187357wjb.123.1411476887525;
        Tue, 23 Sep 2014 05:54:47 -0700 (PDT)
Received: from localhost (p5B095AC8.dip0.t-ipconnect.de. [91.9.90.200])
        by mx.google.com with ESMTPSA id cw6sm15828079wjb.18.2014.09.23.05.54.46
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Tue, 23 Sep 2014 05:54:47 -0700 (PDT)
X-Mailer: git-send-email 2.1.0.238.gce1d3a9
In-Reply-To: <CAN0XMO+D7dDh_Xpcgekg3fsDA9Zhh+i7Asi46G3aBpnknivNjA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/257416>

English grammar with German words doesn't make it a German translation. ;)

Signed-off-by: Stefan Beller <stefanbeller@gmail.com>
---
Here we go again without sentence fragments.

Thanks,
Stefan

 po/de.po | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/po/de.po b/po/de.po
index e5d2b25..bae3723 100644
--- a/po/de.po
+++ b/po/de.po
@@ -3463,13 +3463,13 @@ msgid_plural ""
 "\n"
 "%s\n"
 msgstr[0] ""
-"Warnung: Sie sind um %d Commit hinterher, nicht verbunden zu\n"
-"einem Ihrer Branches:\n"
+"Warnung: Sie sind um %d Commit hinterher, folgende Commits sind in\n"
+"keinem Ihrer Branches enthalten: \n"
 "\n"
 "%s\n"
 msgstr[1] ""
-"Warnung: Sie sind um %d Commits hinterher, nicht verbunden zu\n"
-"einem Ihrer Branches:\n"
+"Warnung: Sie sind um %d Commits hinterher, folgende Commits sind in\n"
+"keinem Ihrer Branches enthalten: \n"
 "\n"
 "%s\n"
 
-- 
2.1.0.238.gce1d3a9
