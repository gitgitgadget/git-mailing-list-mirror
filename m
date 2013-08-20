From: Tony Finch <dot@dotat.at>
Subject: [PATCH v4 0/4] Four small gitweb tweaks
Date: Tue, 20 Aug 2013 18:22:42 +0100
Message-ID: <cover.1377019362.git.dot@dotat.at>
References: <alpine.LSU.2.00.1308051220170.6019@hermes-2.csi.cam.ac.uk>
Cc: =?UTF-8?Q?Jakub_Nar=C4=99bski?= <jnareb@gmail.com>,
	Jonathan Nieder <jrnieder@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Aug 20 19:29:01 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VBpjm-00050N-Mm
	for gcvg-git-2@plane.gmane.org; Tue, 20 Aug 2013 19:28:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751615Ab3HTR2j (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 20 Aug 2013 13:28:39 -0400
Received: from ppsw-33.csi.cam.ac.uk ([131.111.8.133]:43268 "EHLO
	ppsw-33.csi.cam.ac.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751435Ab3HTR2h (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 20 Aug 2013 13:28:37 -0400
X-Cam-AntiVirus: no malware found
X-Cam-ScannerInfo: http://www.cam.ac.uk/cs/email/scanner/
Received: from hermes-2.csi.cam.ac.uk ([131.111.8.54]:51933)
	by ppsw-33.csi.cam.ac.uk (smtp.hermes.cam.ac.uk [131.111.8.157]:25)
	with esmtpa (EXTERNAL:fanf2) id 1VBpjQ-0006Bs-gt (Exim 4.80_167-5a66dd3)
	(return-path <fanf2@hermes.cam.ac.uk>); Tue, 20 Aug 2013 18:28:36 +0100
Received: from fanf2 by hermes-2.csi.cam.ac.uk (hermes.cam.ac.uk)
	with local id 1VBpjQ-0002mY-8B (Exim 4.72)
	(return-path <fanf2@hermes.cam.ac.uk>); Tue, 20 Aug 2013 18:28:36 +0100
In-Reply-To: <alpine.LSU.2.00.1308051220170.6019@hermes-2.csi.cam.ac.uk>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/232620>

This is mostly just a repost to un-stall this topic.

I have fixed the tab damage problem spotted by Jakub in the search
help link patch, and I have improved the commit message for the
repository owner patch. No other changes.

Tony Finch (4):
  gitweb: Ensure OPML text fits inside its box.
  gitweb: vertically centre contents of page footer
  gitweb: omit the repository owner when it is unset
  gitweb: make search help link less ugly

 gitweb/gitweb.perl | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

-- 
1.8.3.1.605.g85318f5
