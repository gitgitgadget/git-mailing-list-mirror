From: rocketraman@fastmail.fm
Subject: Add branch management for releases to gitworkflows
Date: Thu, 12 Nov 2009 14:46:03 -0500
Message-ID: <1258055164-11876-1-git-send-email-rocketraman@fastmail.fm>
Cc: trast@student.ethz.ch, gitster@pobox.com
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Nov 12 20:46:23 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N8fcc-0007Au-Sv
	for gcvg-git-2@lo.gmane.org; Thu, 12 Nov 2009 20:46:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753261AbZKLTqJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 12 Nov 2009 14:46:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753682AbZKLTqI
	(ORCPT <rfc822;git-outgoing>); Thu, 12 Nov 2009 14:46:08 -0500
Received: from smtp131.rog.mail.re2.yahoo.com ([206.190.53.36]:35045 "HELO
	smtp131.rog.mail.re2.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1753525AbZKLTqG (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 12 Nov 2009 14:46:06 -0500
Received: (qmail 91989 invoked from network); 12 Nov 2009 19:46:12 -0000
Received: from CPE000db9166236-CM00186845d2ae.cpe.net.cable.rogers.com (rocketraman@99.224.155.40 with login)
        by smtp131.rog.mail.re2.yahoo.com with SMTP; 12 Nov 2009 11:46:11 -0800 PST
X-Yahoo-SMTP: 5CKRlKeswBAtrcX.EVB04BFKSgZiN0yKOK0iylIm064Zdzo-
X-YMail-OSG: duNM3tgVM1klng_twMKi9lwCbQatZ12QFFaf6DkKAcpIbinZ_yntayEtixZn6DrjLg--
X-Yahoo-Newman-Property: ymail-3
Received: from localhost (localhost.localdomain [127.0.0.1])
	by apollo.rocketraman.com (Postfix) with ESMTP id 69C9821C05CD;
	Thu, 12 Nov 2009 14:46:11 -0500 (EST)
X-Virus-Scanned: amavisd-new at rocketraman.com
Received: from apollo.rocketraman.com ([127.0.0.1])
	by localhost (apollo.rocketraman.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id EIdlFacnG1rs; Thu, 12 Nov 2009 14:46:06 -0500 (EST)
Received: from zeus (zeus.rocketraman.com [192.168.1.5])
	by apollo.rocketraman.com (Postfix) with SMTP id 08FA021C05CB;
	Thu, 12 Nov 2009 14:46:05 -0500 (EST)
Received: by zeus (sSMTP sendmail emulation); Thu, 12 Nov 2009 14:46:05 -0500
X-Mailer: git-send-email 1.6.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/132792>


Version 3 of the gitworkflows patch follows.

This version of the patch attempts to incorporate all feedback received from Junio and Thomas. The main changes are:

1) Consistent use of pronouns in the imperative.

2) Reorganization to move the new text into the "MANAGING BRANCHES" section. This wasn't explicitly suggested by Junio or Thomas, but it makes sense as it clarifies that the content is not about releases in general, but how releases affect the branch structure previously described in the document.

3) Largely modified and reworded text, to conform to the new reorganization and to include feedback from Junio and Thomas.

Cheers,
Raman
