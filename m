From: al_shopov@yahoo.com
Subject: [PATCH 3/3] git-gui l10n: Add 29 more terms to glossary
Date: Wed, 15 Jan 2014 13:07:57 +0200
Message-ID: <1389784077-8105-4-git-send-email-lists@kambanaria.org>
References: <1389784077-8105-1-git-send-email-lists@kambanaria.org>
Cc: Pat Thoyts <patthoyts@users.sourceforge.net>,
	Alexander Shopov <ash@kambanaria.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jan 15 12:14:01 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1W3OQ4-00029X-Pi
	for gcvg-git-2@plane.gmane.org; Wed, 15 Jan 2014 12:14:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751489AbaAOLN5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 15 Jan 2014 06:13:57 -0500
Received: from nm10-vm1.bullet.mail.ird.yahoo.com ([77.238.189.93]:36295 "EHLO
	nm10-vm1.bullet.mail.ird.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751046AbaAOLN4 (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 15 Jan 2014 06:13:56 -0500
Received: from [77.238.189.236] by nm10.bullet.mail.ird.yahoo.com with NNFMP; 15 Jan 2014 11:08:13 -0000
Received: from [46.228.39.110] by tm17.bullet.mail.ird.yahoo.com with NNFMP; 15 Jan 2014 11:08:13 -0000
Received: from [127.0.0.1] by smtp147.mail.ir2.yahoo.com with NNFMP; 15 Jan 2014 11:08:13 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s1024; t=1389784093; bh=Lb1febUpzRAkdJLi9EX+dF8IumVh2DWD/X8SG9AI/c4=; h=X-Yahoo-Newman-Id:X-Rocket-Received:X-Yahoo-Newman-Property:X-YMail-OSG:X-Yahoo-SMTP:From:To:Cc:Subject:Date:Message-Id:X-Mailer:In-Reply-To:References; b=AgY8TLx4mxT8c7CYFgpAfy+mTB2oUvGvVcSvM0hQZpv/Ycjn2CPQrPwmXEsU2odUVXtoFfVadp9xSIbvW3UEs9+ueLnXe7x2HAXneanue68mCOwJY4CoX4gj8s1kJNhR7QS2+tN9qk/ou7XdZDtNrP+LOt14M27lu+sCKqcocio=
X-Yahoo-Newman-Id: 814365.73467.bm@smtp147.mail.ir2.yahoo.com
X-Rocket-Received: from localhost.lan (al_shopov@78.83.52.173 with plain [188.125.69.59])
        by smtp147.mail.ir2.yahoo.com with SMTP; 15 Jan 2014 11:08:13 +0000 UTC
X-Yahoo-Newman-Property: ymail-3
X-YMail-OSG: 3fgjgDsVM1mCowSdVB.LbaznwFHgYdJAFpWlQ1d99CgDp_e
 zFFoV1edPH0MunlxOZHJCOK6rJpP0Hq8psiZ8dKrxKn4SQOfSuretlApE8Tq
 gcYhr4WT7_WrKUx5Ed7OKCDIKxoBjs.ELanhejgXKgRgbcY_CZpj1ZpIwvRU
 qWoTcBjWjMtnUJVtYQuotI9Pzy5KgHva4tT7YR3yBNIV5NrBInEK8WAkLqQU
 6hhXpTTJVG7wy6jhk9ztIGLeOo6Lt3svnH3hHqasVUBA1cgR03KTGd5CKQad
 sQVn3lClxOTr3DriaUbDywmh43L_0YnNF.Nlrl7PjSyb5ziOXLQLbu7Rh2qr
 kQ3e.KW5K9GC.hx5lPYFPFZ_Fv8QNw93uXYvaRETB.6gi56ekUs1OedAvPeJ
 Azbl0IK.ULQiOhbgvP9gqDwSUSVoIv72yW68js5_xDX1QcCD7DuSNXC3L7vv
 HCDyMObxYhbTnnQ4ehMlMwShBFj9xssGdT9UcogHE1B5RqM4IUCLLXMXZlH0
 liD8g8W1iEsXgrT1iDds_9LCuwFlpJ_NtldXCZ3O0PIbDIuFq
X-Yahoo-SMTP: yRWQ8BGswBDCUSC0.xLhuVo_zCa4SQ--
X-Mailer: git-send-email 1.8.4.2
In-Reply-To: <1389784077-8105-1-git-send-email-lists@kambanaria.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/240455>

From: Alexander Shopov <ash@kambanaria.org>

Signed-off-by: Alexander Shopov <ash@kambanaria.org>
---
 po/glossary/git-gui-glossary.txt | 29 +++++++++++++++++++++++++++++
 1 file changed, 29 insertions(+)

diff --git a/po/glossary/git-gui-glossary.txt b/po/glossary/git-gui-glossary.txt
index 9b31f69..4093046 100644
--- a/po/glossary/git-gui-glossary.txt
+++ b/po/glossary/git-gui-glossary.txt
@@ -36,3 +36,32 @@
 "update"	""
 "verify"	""
 "working copy, working tree"	"The tree of actual checked out files."
+"ancestor"	"a commit that succeeds the current one in git's graph of commits (not necessarily directly)"
+"abort"	"prematurely stop and abandon an operation"
+"bare repository"	"a repository with only .git directory, without working directory"
+"base"	"a parent version of the current file"
+"blame"	"get the authors responsible for each line in a file"
+"cherry-pick"	"to select and apply a single commit without merging"
+"child"	"a commit that directly succeeds the current one in git's graph of commits"
+"cleanup"	"clean the state of the git repository, often after manually stopped operation"
+"commit message"	"a message that gets attached with any commit"
+"descendant"	"a commit that precedes the current one in git's graph of commits (not necessarily directly)"
+"detached checkout"	"checkout of a revision rather than a some head"
+"file level merging"	"any merge strategy that works on a file by file basis"
+"head"	"the last revision in a branch"
+"hook"	"script that gets executed automatically on some event"
+"initial checkout"	"the first checkout during a clone operation"
+"local branch"	"a branch that resides in the local git repository"
+"loose object"	"a Git object that is not part of any pack"
+"master branch"	"a branch called by convention 'master' that exists in a newly created git repository"
+"origin"	"a remote called by convention 'origin' that the current git repository has been cloned from"
+"pack [noun]"	"a file containing many git objects packed together"
+"packed object"	"a Git object part of some pack"
+"parent"	"a commit that directly precedes the current one in git's graph of commits"
+"reflog"	"the log file containing all states of the HEAD reference (in other words past pristine states of the working copy)"
+"resolve (a conflict)"	"decide which changes from alternative versions of a file should persist in Git"
+"revert changes"	"abandon changes and go to pristine version"
+"revision expression"	"expression that signifies a revision in git"
+"stage/unstage"	"add some content of files and directories to the staging area in preparation for a commit"
+"stash"	"temporarily save changes in a stack without committing"
+"tracked/untracked"	"file whose content is tracked/not tracked by git"
-- 
1.8.4.2
