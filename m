From: Piotr Krukowiecki <piotr.krukowiecki@gmail.com>
Subject: [PATCH] Add link to git-cherry(1) in git-cherry-pick(1)
Date: Sat, 05 Mar 2011 20:09:30 +0100
Message-ID: <4D728A6A.8090507@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Mar 05 20:09:46 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PvwrK-0001gc-1W
	for gcvg-git-2@lo.gmane.org; Sat, 05 Mar 2011 20:09:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753491Ab1CETJk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 5 Mar 2011 14:09:40 -0500
Received: from mail-wy0-f174.google.com ([74.125.82.174]:62523 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752170Ab1CETJk (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 5 Mar 2011 14:09:40 -0500
Received: by wyg36 with SMTP id 36so3128774wyg.19
        for <git@vger.kernel.org>; Sat, 05 Mar 2011 11:09:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:message-id:date:from:user-agent:mime-version:to
         :subject:content-type:content-transfer-encoding;
        bh=rrSr1mBVXSF82J4P3odqJyeHAQh1wT8bWTSNoita0fw=;
        b=QZEucmxuvoEtBqrmT0eZWdRDWvPfJ0DPEbYJCWpz2GeV/B4jVrKBFlK7/bHw3k9uZz
         k5Lqv75GTPzUiOSqimErJETUvGMXK6+HhhIkBHuBmWfDtH0PE29JPJaNbgEPqHVj768p
         6BHUVi65i1Cfbo3lNHeIUF6JCdBHSuck7fWmw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:to:subject
         :content-type:content-transfer-encoding;
        b=n1qi5f1nfHRrzHiuXwHv2eQY9u5nTjvnyUjthgYujSFl8mGjX6I54fYHXlUvof4Nxj
         KV3B2K5OqZ6F7eemHBNugWc8p0asXBGV+5jWnyVl0wEByiWZIReZh0Ys/4LXaxAP90am
         6nADf1ltBzWVdWb+gv766HgXo9+KLHlO6MQis=
Received: by 10.227.202.80 with SMTP id fd16mr1732083wbb.229.1299352178734;
        Sat, 05 Mar 2011 11:09:38 -0800 (PST)
Received: from [192.168.1.101] (akz223.neoplus.adsl.tpnet.pl [83.26.29.223])
        by mx.google.com with ESMTPS id x1sm615176wbh.20.2011.03.05.11.09.37
        (version=SSLv3 cipher=OTHER);
        Sat, 05 Mar 2011 11:09:38 -0800 (PST)
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.9.2.14) Gecko/20110223 Thunderbird/3.1.8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/168504>


Signed-off-by: Piotr Krukowiecki <piotr.krukowiecki@gmail.com>
---
 Documentation/git-cherry-pick.txt |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/Documentation/git-cherry-pick.txt b/Documentation/git-cherry-pick.txt
index 749d68a..c078cc9 100644
--- a/Documentation/git-cherry-pick.txt
+++ b/Documentation/git-cherry-pick.txt
@@ -162,7 +162,7 @@ Documentation by Junio C Hamano and the git-list <git@vger.kernel.org>.
 
 SEE ALSO
 --------
-linkgit:git-revert[1]
+linkgit:git-revert[1], linkgit:git-cherry[1]
 
 GIT
 ---
-- 
1.7.4.1.179.gb9a20

-- 
Piotr Krukowiecki
