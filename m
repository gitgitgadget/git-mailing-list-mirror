From: Andreas Gruenbacher <agruen@gnu.org>
Subject: GNU patch: 2.6.1 release (mostly bugfixes)
Followup-To: gmane.org.fsf.announce
Date: Wed, 30 Dec 2009 17:30:21 +0100
Message-ID: <200912301730.21746.agruen@gnu.org>
Reply-To: info-gnu@gnu.org
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: info-gnu@gnu.org
X-From: git-owner@vger.kernel.org Wed Dec 30 17:43:56 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NQ1eJ-0002U6-Ou
	for gcvg-git-2@lo.gmane.org; Wed, 30 Dec 2009 17:43:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752522AbZL3Qnr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 30 Dec 2009 11:43:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752494AbZL3Qnr
	(ORCPT <rfc822;git-outgoing>); Wed, 30 Dec 2009 11:43:47 -0500
Received: from mail09.linbit.com ([212.69.161.110]:55540 "EHLO
	mail09.linbit.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752424AbZL3Qnq (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 30 Dec 2009 11:43:46 -0500
X-Greylist: delayed 615 seconds by postgrey-1.27 at vger.kernel.org; Wed, 30 Dec 2009 11:43:46 EST
Received: from murkel-lan.localnet (unknown [78.142.182.101])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTPS id 7690D1012A98;
	Wed, 30 Dec 2009 17:33:30 +0100 (CET)
User-Agent: KMail/1.12.2 (Linux/2.6.31.5-0.1-desktop; KDE/4.3.1; i686; ; )
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/135906>

Some glitches in release 2.6 of GNU patch made a new release 2.6.1 necessary, 
available from:

	ftp://ftp.gnu.org/gnu/patch/

The previous release was on 13 November.  NEWS since then:

* Support for diff3(1) style merges which show the old, original, and new
  lines of a conflict has been added (--merge=diff3).  The default still is
  the merge(1) format (--merge or --merge=merge).
* Bug and portability fixes.

The source code repository, a bug-patch@gnu.org mailing list archive, and the 
project's bug tracker are available at:

	http://savannah.gnu.org/projects/patch

Please email bugs or suggestions to <bug-patch@gnu.org>.  Check the bug 
tracker for a list of known issues.


Thanks,
Andreas
