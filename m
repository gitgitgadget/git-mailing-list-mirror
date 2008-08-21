From: imyousuf@gmail.com
Subject: [JGit Patch v2 5/7] Add script for adding second pack for test purpose
Date: Thu, 21 Aug 2008 09:13:12 +0600
Message-ID: <1219288394-1241-5-git-send-email-imyousuf@gmail.com>
References: <1219288394-1241-1-git-send-email-imyousuf@gmail.com>
 <1219288394-1241-2-git-send-email-imyousuf@gmail.com>
 <1219288394-1241-3-git-send-email-imyousuf@gmail.com>
 <1219288394-1241-4-git-send-email-imyousuf@gmail.com>
Cc: spearce@spearce.org, robin.rosenberg@dewire.com,
	Imran M Yousuf <imyousuf@smartitengineering.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Aug 21 05:15:24 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KW0dv-0007f6-Iy
	for gcvg-git-2@gmane.org; Thu, 21 Aug 2008 05:15:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754347AbYHUDOL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 20 Aug 2008 23:14:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754005AbYHUDOJ
	(ORCPT <rfc822;git-outgoing>); Wed, 20 Aug 2008 23:14:09 -0400
Received: from ey-out-2122.google.com ([74.125.78.27]:37841 "EHLO
	ey-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754047AbYHUDOI (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 20 Aug 2008 23:14:08 -0400
Received: by ey-out-2122.google.com with SMTP id 6so14267eyi.37
        for <git@vger.kernel.org>; Wed, 20 Aug 2008 20:14:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=jMjQNvrmGp0ePVQ+iiiqMdmH7W4L8S5g+3NX0QYvd1I=;
        b=v53inLJicFa8JOtT0q6z26bLAjOjdGmGF8qiyiigi9IAGH+JLX1Fqon/eHaIX3vlwT
         rnpoIaU6WywN9WvnwTFeFxVLF3xnq5ZrzbffbybUio+dgr4sjFcS/Z+vujx3wLqt5MaE
         jJ8vArgeYPMyN8AcvoX1KIxXB63xDehRekfGY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=Tnlu6nDeOYVfxdJwhqNEWooPx9QGoMLnn5Zg2+5p4w6XzER7OBtfFxJGqlZG+DOpwh
         hLuaxO5Hw+K8HClBoOIECIoBUkLPYDzzfj5ShIsqpEZ6TY33EhKsTIbx5K/PUO9ONYJr
         ATWsGhJMfcOtwmeKf/HVxZFu8XbaUJMskIhZo=
Received: by 10.210.125.13 with SMTP id x13mr1137289ebc.158.1219288447502;
        Wed, 20 Aug 2008 20:14:07 -0700 (PDT)
Received: from localhost ( [62.101.198.35])
        by mx.google.com with ESMTPS id 31sm794562nfu.9.2008.08.20.20.14.03
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 20 Aug 2008 20:14:06 -0700 (PDT)
X-Mailer: git-send-email 1.5.6
In-Reply-To: <1219288394-1241-4-git-send-email-imyousuf@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/93102>

From: Imran M Yousuf <imyousuf@smartitengineering.com>

Forgot to add it last time and thus adding it before removing duplicate
resources.

Signed-off-by: Imran M Yousuf <imyousuf@smartitengineering.com>
---
 .../jgit/test/resources}/create-second-pack        |    0 
 1 files changed, 0 insertions(+), 0 deletions(-)
 copy org.spearce.jgit.test/{tst => tst-rsrc/org/spearce/jgit/test/resources}/create-second-pack (100%)

diff --git a/org.spearce.jgit.test/tst/create-second-pack b/org.spearce.jgit.test/tst-rsrc/org/spearce/jgit/test/resources/create-second-pack
similarity index 100%
copy from org.spearce.jgit.test/tst/create-second-pack
copy to org.spearce.jgit.test/tst-rsrc/org/spearce/jgit/test/resources/create-second-pack
-- 
1.5.6
