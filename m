From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Documentation: For consistency, use CVS instead of cvs.
Date: Fri, 24 Aug 2007 00:04:37 -0700
Message-ID: <7vhcmps9a2.fsf@gitster.siamese.dyndns.org>
References: <20070824004008.GA21778@ruiner>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Brian Hetro <whee@smaertness.net>
X-From: git-owner@vger.kernel.org Fri Aug 24 09:05:54 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IOTEG-0008QM-Qe
	for gcvg-git@gmane.org; Fri, 24 Aug 2007 09:05:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751009AbXHXHEp (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 24 Aug 2007 03:04:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751217AbXHXHEp
	(ORCPT <rfc822;git-outgoing>); Fri, 24 Aug 2007 03:04:45 -0400
Received: from rune.sasl.smtp.pobox.com ([208.210.124.37]:49266 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750856AbXHXHEo (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 24 Aug 2007 03:04:44 -0400
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by rune.sasl.smtp.pobox.com (Postfix) with ESMTP id 1831512746C;
	Fri, 24 Aug 2007 03:05:00 -0400 (EDT)
In-Reply-To: <20070824004008.GA21778@ruiner> (Brian Hetro's message of "Thu,
	23 Aug 2007 20:40:08 -0400")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/56554>

Brian Hetro <whee@smaertness.net> writes:

> When not referring to the cvs command, CVS makes more sense.

I wonder if you would also want to upcase this one:

diff --git a/Documentation/git-cvsserver.txt b/Documentation/git-cvsserver.txt
index 60d0bcf..258a62f 100644
--- a/Documentation/git-cvsserver.txt
+++ b/Documentation/git-cvsserver.txt
@@ -102,7 +102,7 @@ No special setup is needed for SSH access, other than having GIT tools
 in the PATH. If you have clients that do not accept the CVS_SERVER
 environment variable, you can rename git-cvsserver to cvs.
 
-Note: Newer cvs versions (>= 1.12.11) also support specifying
+Note: Newer CVS versions (>= 1.12.11) also support specifying
 CVS_SERVER directly in CVSROOT like
 
 ------
