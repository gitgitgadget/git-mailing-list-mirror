From: "Horst H. von Brand" <vonbrand@inf.utfsm.cl>
Subject: [PATCH 2/2] Release notes for 1.7.10: Repeated phase for "diffall"
Date: Tue, 13 Mar 2012 09:28:37 -0300
Message-ID: <1331641717-6430-3-git-send-email-vonbrand@inf.utfsm.cl>
References: <1331641717-6430-1-git-send-email-vonbrand@inf.utfsm.cl>
Cc: "Horst H. von Brand" <vonbrand@inf.utfsm.cl>
To: git@vger.kernel.org, gitster@pobox.com
X-From: git-owner@vger.kernel.org Tue Mar 13 13:36:57 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S7QyG-0008Gw-9c
	for gcvg-git-2@plane.gmane.org; Tue, 13 Mar 2012 13:36:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752475Ab2CMMgv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 13 Mar 2012 08:36:51 -0400
Received: from zimbra.inf.utfsm.cl ([200.1.19.17]:50208 "EHLO
	zimbra.inf.utfsm.cl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752410Ab2CMMgu (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 13 Mar 2012 08:36:50 -0400
Received: from localhost (localhost [127.0.0.1])
	by zimbra.inf.utfsm.cl (Postfix) with ESMTP id 4C653182281;
	Tue, 13 Mar 2012 09:28:42 -0300 (CLST)
X-Virus-Scanned: amavisd-new at zimbra.inf.utfsm.cl
Received: from zimbra.inf.utfsm.cl ([127.0.0.1])
	by localhost (zimbra.inf.utfsm.cl [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id JKeLWLJRvrcT; Tue, 13 Mar 2012 09:28:42 -0300 (CLST)
Received: from quelen.inf.utfsm.cl (quelen.inf.utfsm.cl [200.1.19.54])
	by zimbra.inf.utfsm.cl (Postfix) with ESMTPS id 39E35181ABC;
	Tue, 13 Mar 2012 09:28:42 -0300 (CLST)
Received: from laptop15.inf.utfsm.cl (ip127.4.priv.inf.utfsm.cl [10.10.4.127])
	by quelen.inf.utfsm.cl (8.14.5/8.14.5) with ESMTP id q2DCSfYp001255
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Tue, 13 Mar 2012 09:28:41 -0300
Received: from laptop15.inf.utfsm.cl (laptop15.inf.utfsm.cl [127.0.0.1])
	by laptop15.inf.utfsm.cl (8.14.5/8.14.5) with ESMTP id q2DCSfxm006511;
	Tue, 13 Mar 2012 09:28:41 -0300
Received: (from vonbrand@localhost)
	by laptop15.inf.utfsm.cl (8.14.5/8.14.5/Submit) id q2DCSfSc006510;
	Tue, 13 Mar 2012 09:28:41 -0300
X-Mailer: git-send-email 1.7.10.rc0.41.gfa678f
In-Reply-To: <1331641717-6430-1-git-send-email-vonbrand@inf.utfsm.cl>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/193014>

From: "Horst H. von Brand" <vonbrand@inf.utfsm.cl>

Signed-off-by: Horst H. von Brand <vonbrand@inf.utfsm.cl>
---
 Documentation/RelNotes/1.7.10.txt |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/RelNotes/1.7.10.txt b/Documentation/RelNotes/1.7.10.txt
index 0e7def1..b5cf3e0 100644
--- a/Documentation/RelNotes/1.7.10.txt
+++ b/Documentation/RelNotes/1.7.10.txt
@@ -120,8 +120,8 @@ UI, Workflows & Features
    project name and description highlighted.
 
  * A new script "diffall" is added to contrib/; it drives an external
-   an external tool to perform a directory diff of two Git revisions
-   in one go, unlike "difftool" that compares one file at a time.
+   tool to perform a directory diff of two Git revisions in one go,
+   unlike "difftool" that compares one file at a time.
 
 Foreign Interface
 
-- 
1.7.10.rc0.41.gfa678f
