From: Jonathan Nieder <jrnieder@uchicago.edu>
Subject: [PATCH 04/15] git(1): add comma
Date: Thu, 3 Jul 2008 00:08:12 -0500 (CDT)
Message-ID: <Pine.GSO.4.62.0807030004070.16085@harper.uchicago.edu>
References: <Pine.GSO.4.62.0806301650530.7190@harper.uchicago.edu>
 <7viqvqov01.fsf@gitster.siamese.dyndns.org> <Pine.GSO.4.62.0807022322380.16085@harper.uchicago.edu>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org, "J. Bruces Fields" <bfields@fieldses.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Jul 03 10:25:07 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KEK7l-0002yW-Ub
	for gcvg-git-2@gmane.org; Thu, 03 Jul 2008 10:25:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755143AbYGCG7k (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 3 Jul 2008 02:59:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753853AbYGCG5z
	(ORCPT <rfc822;git-outgoing>); Thu, 3 Jul 2008 02:57:55 -0400
Received: from smtp01.uchicago.edu ([128.135.12.77]:48035 "EHLO
	smtp01.uchicago.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754746AbYGCFIO (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 3 Jul 2008 01:08:14 -0400
Received: from harper.uchicago.edu (harper.uchicago.edu [128.135.12.7])
	by smtp01.uchicago.edu (8.13.8/8.13.8) with ESMTP id m6358DB5008408;
	Thu, 3 Jul 2008 00:08:13 -0500
Received: from localhost (jrnieder@localhost)
	by harper.uchicago.edu (8.12.10/8.12.10) with ESMTP id m6358CZA018496;
	Thu, 3 Jul 2008 00:08:13 -0500 (CDT)
X-Authentication-Warning: harper.uchicago.edu: jrnieder owned process doing -bs
In-Reply-To: <Pine.GSO.4.62.0807022322380.16085@harper.uchicago.edu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/87243>

Signed-off-by: Jonathan Nieder <jrnieder@uchicago.edu>
---
 Documentation/git.txt |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/Documentation/git.txt b/Documentation/git.txt
index f9e4416..5f4d666 100644
--- a/Documentation/git.txt
+++ b/Documentation/git.txt
@@ -141,7 +141,7 @@ help ...'.
 --exec-path::
 	Path to wherever your core git programs are installed.
 	This can also be controlled by setting the GIT_EXEC_PATH
-	environment variable. If no path is given 'git' will print
+	environment variable. If no path is given, 'git' will print
 	the current setting and then exit.
 
 -p::
-- 
1.5.5.GIT
