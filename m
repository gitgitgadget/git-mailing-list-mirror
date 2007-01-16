From: "Goetz, Philip \(NIH/NLM/LHC\) [C]" <goetzp@mail.nih.gov>
Subject: RE: documentation for git-rm
Date: Tue, 16 Jan 2007 12:52:43 -0500
Message-ID: <7A7EC09F0481DB46BC1EF0B0A9844CDB16D464@NIHCESMLBX8.nih.gov>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
X-From: git-owner@vger.kernel.org Tue Jan 16 18:54:49 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H6sW0-0000KR-E7
	for gcvg-git@gmane.org; Tue, 16 Jan 2007 18:54:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751443AbXAPRy2 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 16 Jan 2007 12:54:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751463AbXAPRy2
	(ORCPT <rfc822;git-outgoing>); Tue, 16 Jan 2007 12:54:28 -0500
Received: from nihcessmtp.hub.nih.gov ([128.231.90.115]:3518 "EHLO
	NIHCESSMTP.hub.nih.gov" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751443AbXAPRy1 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 16 Jan 2007 12:54:27 -0500
X-Greylist: delayed 335 seconds by postgrey-1.27 at vger.kernel.org; Tue, 16 Jan 2007 12:54:27 EST
Received: from NIHCESMLBX8.nih.gov ([156.40.71.208]) by NIHCESSMTP.hub.nih.gov with Microsoft SMTPSVC(6.0.3790.1830);
	 Tue, 16 Jan 2007 12:52:44 -0500
X-MimeOLE: Produced By Microsoft Exchange V6.5
Content-class: urn:content-classes:message
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: documentation for git-rm
Thread-Index: Acc5lpShhYK4UL5YQpSO32UZV28wlgAAEYyA
To: <git@vger.kernel.org>
X-OriginalArrivalTime: 16 Jan 2007 17:52:44.0761 (UTC) FILETIME=[20455C90:01C73997]
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/36951>


Also, the option "--cached" is not recognized by git, which says

usage: git-rm [-n] [-v] [-f] <filepattern>...

Is there any way to remove files from the git repository without
removing them from the working tree?
