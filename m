From: Philip Oakley <philipoakley@iee.org>
Subject: [PATCH 5/6] add 'everyday' to the help --guides list
Date: Thu,  9 Jan 2014 23:13:11 +0000
Message-ID: <1389309192-5748-6-git-send-email-philipoakley@iee.org>
References: <1389309192-5748-1-git-send-email-philipoakley@iee.org>
To: GitList <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Jan 10 00:13:57 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1W1OnP-0005Gn-CO
	for gcvg-git-2@plane.gmane.org; Fri, 10 Jan 2014 00:13:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754901AbaAIXNk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 9 Jan 2014 18:13:40 -0500
Received: from out1.ip03ir2.opaltelecom.net ([62.24.128.239]:31454 "EHLO
	out1.ip03ir2.opaltelecom.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756004AbaAIXNG (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 9 Jan 2014 18:13:06 -0500
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: AnYGAJQsz1JOl3JU/2dsb2JhbABZgwuDOrcVgQ8XdIImAQVWMwhJOR4GE4gIwyYXjwyENwSqLIMtPA
X-IPAS-Result: AnYGAJQsz1JOl3JU/2dsb2JhbABZgwuDOrcVgQ8XdIImAQVWMwhJOR4GE4gIwyYXjwyENwSqLIMtPA
X-IronPort-AV: E=Sophos;i="4.95,634,1384300800"; 
   d="scan'208";a="446464907"
Received: from host-78-151-114-84.as13285.net (HELO localhost) ([78.151.114.84])
  by out1.ip03ir2.opaltelecom.net with ESMTP; 09 Jan 2014 23:13:00 +0000
X-Mailer: git-send-email 1.8.3.msysgit.0
In-Reply-To: <1389309192-5748-1-git-send-email-philipoakley@iee.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/240292>

Signed-off-by: Philip Oakley <philipoakley@iee.org>
---
 builtin/help.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/builtin/help.c b/builtin/help.c
index cc17e67..45509ce 100644
--- a/builtin/help.c
+++ b/builtin/help.c
@@ -418,6 +418,7 @@ static struct {
 	const char *help;
 } common_guides[] = {
 	{ "attributes", N_("Defining attributes per path") },
+	{ "everyday", N_("Everyday Git With 20 Commands Or So") },
 	{ "glossary", N_("A Git glossary") },
 	{ "ignore", N_("Specifies intentionally untracked files to ignore") },
 	{ "modules", N_("Defining submodule properties") },
-- 
1.8.3.msysgit.0
