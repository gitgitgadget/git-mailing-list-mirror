From: =?UTF-8?B?UmVuw6kgU2NoYXJmZQ==?= <l.s.r@web.de>
Subject: [PATCH] api-run-command: add missing list item marker
Date: Tue, 28 Oct 2014 23:09:53 +0100
Message-ID: <54501431.2090100@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Oct 28 23:10:35 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XjEyI-0001Er-Il
	for gcvg-git-2@plane.gmane.org; Tue, 28 Oct 2014 23:10:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754300AbaJ1WKG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 28 Oct 2014 18:10:06 -0400
Received: from mout.web.de ([212.227.15.14]:62715 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752356AbaJ1WKF (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 28 Oct 2014 18:10:05 -0400
Received: from [192.168.178.27] ([79.253.156.206]) by smtp.web.de (mrweb004)
 with ESMTPSA (Nemesis) id 0MZRnx-1XVI4z14sn-00LEVq; Tue, 28 Oct 2014 23:10:00
 +0100
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:31.0) Gecko/20100101 Thunderbird/31.2.0
X-Provags-ID: V03:K0:Ez/eoFlSb0bDW7kMPT5HyOp6kMUa+vU345O70LDeC3VMnJgjJbh
 33X+AQT1qS5wFwRh6Rb3Vj0m2YwfnQxIuItnGMVRX6CApN++snmgRqucM2pKpMP9u7THeIk
 o/ZJHMERsN4Jzywfbk8Tq3VWzrD23jEQfA6+ulg9bJzqmQXr8XQLAH7xzcOVfH495h/LQsV
 hZZ3/TmQ2J8fxOOvJt6HQ==
X-UI-Out-Filterresults: notjunk:1;
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Rene Scharfe <l.s.r@web.de>
---
 Documentation/technical/api-run-command.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/technical/api-run-command.txt b/Documentation/technical/api-run-command.txt
index 3f12fcd..a9fdb45 100644
--- a/Documentation/technical/api-run-command.txt
+++ b/Documentation/technical/api-run-command.txt
@@ -13,7 +13,7 @@ produces in the caller in order to process it.
 Functions
 ---------
 
-`child_process_init`
+`child_process_init`::
 
 	Initialize a struct child_process variable.
 
-- 
2.1.2
