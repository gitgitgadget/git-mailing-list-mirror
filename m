From: "Kris Shannon" <kris@shannon.id.au>
Subject: [PATCH] Fix thinko in Release Notes
Date: Thu, 4 Sep 2008 17:30:26 +1000
Message-ID: <e51f4f550809040030h25b7913dn85269d135d1a28e0@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: gitster@pobox.com
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Sep 04 09:31:35 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Kb9JW-00079e-Bn
	for gcvg-git-2@gmane.org; Thu, 04 Sep 2008 09:31:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751769AbYIDHa2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 4 Sep 2008 03:30:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751841AbYIDHa2
	(ORCPT <rfc822;git-outgoing>); Thu, 4 Sep 2008 03:30:28 -0400
Received: from ag-out-0708.google.com ([72.14.246.248]:56760 "EHLO
	ag-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751050AbYIDHa1 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 4 Sep 2008 03:30:27 -0400
Received: by ag-out-0708.google.com with SMTP id 31so6612135agc.10
        for <git@vger.kernel.org>; Thu, 04 Sep 2008 00:30:26 -0700 (PDT)
Received: by 10.90.115.6 with SMTP id n6mr12717459agc.30.1220513426567;
        Thu, 04 Sep 2008 00:30:26 -0700 (PDT)
Received: by 10.90.120.12 with HTTP; Thu, 4 Sep 2008 00:30:26 -0700 (PDT)
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/94901>

Signed-off-by: Kris Shannon <kris@shannon.id.au>
---
 Documentation/RelNotes-1.6.0.2.txt |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/Documentation/RelNotes-1.6.0.2.txt
b/Documentation/RelNotes-1.6.0.2.txt
index 686e607..a862305 100644
--- a/Documentation/RelNotes-1.6.0.2.txt
+++ b/Documentation/RelNotes-1.6.0.2.txt
@@ -30,7 +30,7 @@ Fixes since v1.6.0.1

 * "git for-each-ref refs/heads/" did not work as expected.

-* "git log --grep=pattern -i" did not ignore case.
+* "git log -i --grep=pattern" did not ignore case.

 * "git log --pretty="%ad" --date=short" did not use short format when
   showing the timestamp.
--
1.6.0.1
