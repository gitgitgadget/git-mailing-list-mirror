From: "Luiz Fernando N. Capitulino" <lcapitulino@mandriva.com.br>
Subject: [PATCH]: git-cherry: Document 'limit' command-line option
Date: Mon, 11 Jun 2007 09:56:56 -0300
Organization: Mandriva
Message-ID: <20070611095656.5a534040@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: GIT Mailing-list <git@vger.kernel.org>
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Mon Jun 11 14:58:54 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HxjTy-0005gX-5q
	for gcvg-git@gmane.org; Mon, 11 Jun 2007 14:58:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753066AbXFKM6p (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 11 Jun 2007 08:58:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753079AbXFKM6p
	(ORCPT <rfc822;git-outgoing>); Mon, 11 Jun 2007 08:58:45 -0400
Received: from perninha.conectiva.com.br ([200.140.247.100]:44725 "EHLO
	perninha.conectiva.com.br" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753066AbXFKM6c (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 11 Jun 2007 08:58:32 -0400
Received: from localhost (localhost [127.0.0.1])
	by perninha.conectiva.com.br (Postfix) with ESMTP id CFF5617801;
	Mon, 11 Jun 2007 09:58:29 -0300 (BRT)
X-Virus-Scanned: amavisd-new at conectiva.com.br
Received: from perninha.conectiva.com.br ([127.0.0.1])
	by localhost (perninha.conectiva.com.br [127.0.0.1]) (amavisd-new, port 10025)
	with LMTP id jY1tXmZva3oK; Mon, 11 Jun 2007 09:58:25 -0300 (BRT)
Received: from localhost (doriath.conectiva [10.0.2.48])
	by perninha.conectiva.com.br (Postfix) with ESMTP id 5745B17800;
	Mon, 11 Jun 2007 09:58:25 -0300 (BRT)
X-Mailer: Claws Mail 2.8.1 (GTK+ 2.10.11; i586-mandriva-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/49848>


Signed-off-by: Luiz Fernando N. Capitulino <lcapitulino@mandriva.com.br>

diff --git a/Documentation/git-cherry.txt b/Documentation/git-cherry.txt
index b62c970..e694382 100644
--- a/Documentation/git-cherry.txt
+++ b/Documentation/git-cherry.txt
@@ -53,6 +53,9 @@ OPTIONS
 <head>::
 	Working branch; defaults to HEAD.
 
+<limit>::
+	Do not report commits up to (and including) limit.
+
 Author
 ------
 Written by Junio C Hamano <junkio@cox.net>


-- 
Luiz Fernando N. Capitulino
