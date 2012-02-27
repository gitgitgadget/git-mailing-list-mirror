From: mhagger@alum.mit.edu
Subject: [PATCH 0/2] Trivial cleanups in the post-receive-email script
Date: Mon, 27 Feb 2012 19:34:08 +0100
Message-ID: <1330367650-23091-1-git-send-email-mhagger@alum.mit.edu>
Cc: git@vger.kernel.org, "Kevin P. Fleming" <kpfleming@digium.com>,
	Andy Parkins <andyparkins@gmail.com>,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Feb 27 19:34:31 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S25P4-0004iB-Mp
	for gcvg-git-2@plane.gmane.org; Mon, 27 Feb 2012 19:34:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754405Ab2B0SeZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 27 Feb 2012 13:34:25 -0500
Received: from mail.berlin.jpk.com ([212.222.128.130]:54179 "EHLO
	mail.berlin.jpk.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753925Ab2B0SeX (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 27 Feb 2012 13:34:23 -0500
Received: from michael.berlin.jpk.com ([192.168.100.152])
	by mail.berlin.jpk.com with esmtp (Exim 4.50)
	id 1S25Ns-00065x-Oy; Mon, 27 Feb 2012 19:33:16 +0100
X-Mailer: git-send-email 1.7.9
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/191645>

From: Michael Haggerty <mhagger@alum.mit.edu>

Should be self-explanatory.

Michael Haggerty (2):
  post-receive-email: remove unused variable
  post-receive-email: match up $LOGBEGIN..$LOGEND pairs correctly

 contrib/hooks/post-receive-email |    7 +++----
 1 files changed, 3 insertions(+), 4 deletions(-)

-- 
1.7.9
