From: Anupam Srivastava <srivasta@itt.uni-stuttgart.de>
Subject: [PATCH] git-sh-setup.sh
Date: Sat, 15 Sep 2007 22:38:04 +0200
Message-ID: <46EC42AC.8060204@itt.uni-stuttgart.de>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------030002080300070903070103"
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Sep 15 22:38:19 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IWePC-0001p5-Mp
	for gcvg-git-2@gmane.org; Sat, 15 Sep 2007 22:38:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753251AbXIOUiL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 15 Sep 2007 16:38:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752222AbXIOUiL
	(ORCPT <rfc822;git-outgoing>); Sat, 15 Sep 2007 16:38:11 -0400
Received: from ittli1.itt.uni-stuttgart.de ([129.69.36.101]:6701 "EHLO
	ittli1.itt.uni-stuttgart.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751171AbXIOUiL (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 15 Sep 2007 16:38:11 -0400
Received: from [129.69.36.169] (fornax.itt.uni-stuttgart.de [129.69.36.169])
	by ittli1.itt.uni-stuttgart.de (Postfix) with ESMTP id 71EA3623F8
	for <git@vger.kernel.org>; Sat, 15 Sep 2007 22:38:06 +0200 (CEST)
User-Agent: Thunderbird 3.0a1pre (X11/2007091204)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/58272>

This is a multi-part message in MIME format.
--------------030002080300070903070103
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

English is not my native language but I think this patch corrects a 
grammar mistake.

I am not subscribed so please CC to me if replying.

Anupam

--------------030002080300070903070103
Content-Type: text/x-patch;
 name="doc.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="doc.patch"

diff --git a/git-sh-setup.sh b/git-sh-setup.sh
index 185c5c6..3c325fd 100755
--- a/git-sh-setup.sh
+++ b/git-sh-setup.sh
@@ -6,7 +6,7 @@
 # it dies.
 
 # Having this variable in your environment would break scripts because
-# you would cause "cd" to be be taken to unexpected places.  If you
+# you would cause "cd" to be taken to unexpected places.  If you
 # like CDPATH, define it for your interactive shell sessions without
 # exporting it.
 unset CDPATH

--------------030002080300070903070103--
