From: Paolo Ciarrocchi <paolo.ciarrocchi@gmail.com>
Subject: [PATCH] Remove link to the survey from the git home page.
Date: Tue, 16 Oct 2007 23:57:14 +0200
Message-ID: <20071016235714.190672ff@paolo-desktop>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
To: pasky@suse.cz, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Oct 16 23:58:29 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IhuQg-0003ix-Eg
	for gcvg-git-2@gmane.org; Tue, 16 Oct 2007 23:58:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934738AbXJPV5r (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 16 Oct 2007 17:57:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755140AbXJPV5q
	(ORCPT <rfc822;git-outgoing>); Tue, 16 Oct 2007 17:57:46 -0400
Received: from ug-out-1314.google.com ([66.249.92.174]:8716 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753227AbXJPV5p (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 16 Oct 2007 17:57:45 -0400
Received: by ug-out-1314.google.com with SMTP id z38so171397ugc
        for <git@vger.kernel.org>; Tue, 16 Oct 2007 14:57:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:date:from:to:subject:message-id:x-mailer:mime-version:content-type:content-transfer-encoding;
        bh=osjcFxBECDWiqTr7tLKHGuuK9pYceL5gq7lMANr999A=;
        b=GEG0zsqb42f5Cl65eCBHQ6/i08Pzfi/acpzzaBZ390p/8D0axRLD/V9oOOqofp+ayh0A+dRUdAN/YKsFKKUXvNiJhWv54DR6UgIEv/G3hcYdGI2B2jOw2DUHD0U1OynmDj0LVjuP50F42BmOFv5+osWLgAhfC1zupTLfdA3HJeM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:date:from:to:subject:message-id:x-mailer:mime-version:content-type:content-transfer-encoding;
        b=KGX3EniPu+OVe22m7HJYykSVGIdBmxRXhswBFxVq4+dMvwZcSd5SPBzOt/wDSCYXIEiandhDfZaYqMVjFPHgtxhpzo4V8tnNl7QO+nAWB3sKZq0qcMvExKOPF2VSg+OYYbYcifdv4+GoaJeOy7P1+e/u7tHV1PkShgfFvetUHh0=
Received: by 10.67.30.13 with SMTP id h13mr9575825ugj.1192571861330;
        Tue, 16 Oct 2007 14:57:41 -0700 (PDT)
Received: from paolo-desktop ( [82.56.4.108])
        by mx.google.com with ESMTPS id l33sm700880ugc.2007.10.16.14.57.39
        (version=SSLv3 cipher=OTHER);
        Tue, 16 Oct 2007 14:57:40 -0700 (PDT)
X-Mailer: Sylpheed-Claws 1.0.5 (GTK+ 1.2.10; i486-pc-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/61261>

As far as I know the survey is close so it makes sense to remove the link/text from the home page.

Signed-off-by: Paolo Ciarrocchi <paolo.ciarrocchi@gmail.com>
---
 index.html |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/index.html b/index.html
index 5d14acf..dc5189a 100644
--- a/index.html
+++ b/index.html
@@ -50,7 +50,7 @@ the <a href="http://www.gnu.org/licenses/gpl2.txt">GNU General Public License v2
 It was originally written by Linus Torvalds and is currently maintained by
 Junio C Hamano.</p>
 
-<p><strong><a href="http://www.survey.net.nz/survey.php?94e135ff41e871a1ea5bcda3ee1856d9">The Git User Survey</a> is up now! Please devote a few minutes of your time to fill this simple questionnaire, it will help a lot the git community to understand your needs, what you like of GIT, and of course what you don't like  of it.</strong></p>
+
 
 
 <div style="float: right"><table class="releases">
-- 
1.5.3.4.206.g58ba4
