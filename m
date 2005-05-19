From: Martin Atukunda <matlads@ds.co.ug>
Subject: [PATCH] README: make help example more consistent
Date: Thu, 19 May 2005 11:12:30 +0300
Message-ID: <200505191112.30514.matlads@ds.co.ug>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-From: git-owner@vger.kernel.org Thu May 19 10:25:01 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DYgDv-0001HV-FO
	for gcvg-git@gmane.org; Thu, 19 May 2005 10:17:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262442AbVESISR (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 19 May 2005 04:18:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262469AbVESISR
	(ORCPT <rfc822;git-outgoing>); Thu, 19 May 2005 04:18:17 -0400
Received: from mail1.starcom.co.ug ([217.113.72.31]:16996 "EHLO
	mail1.starcom.co.ug") by vger.kernel.org with ESMTP id S262442AbVESISK
	(ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 19 May 2005 04:18:10 -0400
Received: from entandikwa.ds.co.ug ([::ffff:217.113.73.39])
  by mail1.starcom.co.ug with esmtp; Thu, 19 May 2005 11:17:56 +0300
  id 000EDBCC.428C4BB4.00001006
Received: from igloo.ds.co.ug (igloo.ds.co.ug [192.168.129.66])
	by entandikwa.ds.co.ug (Postfix) with ESMTP id A214F67DE
	for <git@vger.kernel.org>; Thu, 19 May 2005 11:18:53 +0300 (EAT)
Received: from matlads by igloo.ds.co.ug with local (Exim 4.50)
	id 1DYg8s-0002hN-II
	for git@vger.kernel.org; Thu, 19 May 2005 11:12:30 +0300
To: git@vger.kernel.org
User-Agent: KMail/1.8
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

in the README, the help section mentions how to get help on the command 
cg-update, yet in subsquent examples uses the command cg-pull to demostrate. 
this patch changes the reference to cg-update to cg-pull instead to be more 
consistent.

Signed-off-by: Martin Atukunda <matlads@ds.co.ug>


Index: README
===================================================================
--- ca5fef50fb68a3afbb35e1a48ac622f7a964f021/README  (mode:100644)
+++ uncommitted/README  (mode:100644)
@@ -223,7 +223,7 @@
        Getting Help

 Cogito commands come with their own helpful documentation. To get help on
-cg-update, for example, give this command:
+cg-pull, for example, give this command:

        $ cg-pull --help

-- 
- Martin -
