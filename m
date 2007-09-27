From: "Ritwik Ghosh" <ritwik.ghosh@sasken.com>
Subject: Relating to some syntax error in the gitk script
Date: Thu, 27 Sep 2007 17:52:10 +0530
Message-ID: <3CA23C3F3E66D246A478348D6FF3908E06EA45@EXGZ02.sasken.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
To: <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Sep 27 14:23:05 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IasO0-0002uK-1K
	for gcvg-git-2@gmane.org; Thu, 27 Sep 2007 14:22:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753135AbXI0MWQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 27 Sep 2007 08:22:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752867AbXI0MWQ
	(ORCPT <rfc822;git-outgoing>); Thu, 27 Sep 2007 08:22:16 -0400
Received: from mta-blr2.sasken.com ([164.164.56.19]:10488 "EHLO
	mta-blr2.sasken.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752814AbXI0MWO convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 27 Sep 2007 08:22:14 -0400
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: AgAAAAs9+0YKATAC/2dsb2JhbAAM
X-IronPort-AV: E=Sophos;i="4.21,203,1188757800"; 
   d="scan'208";a="22263307"
Received: from sunrnd2.sasken.com ([10.1.48.2])
  by mta-blr2.sasken.com with ESMTP; 27 Sep 2007 17:52:10 +0530
Received: from exgfezb.sasken.com (localhost [127.0.0.1])
	by sunrnd2.sasken.com (8.13.3/) with ESMTP id l8RCMAlL005408
	for <git@vger.kernel.org>; Thu, 27 Sep 2007 17:52:10 +0530 (IST)
Received: from EXGZ02.sasken.com ([10.1.0.122]) by exgfezb.sasken.com with Microsoft SMTPSVC(6.0.3790.1830);
	 Thu, 27 Sep 2007 17:52:10 +0530
X-MS-Has-Attach: 
Content-class: urn:content-classes:message
X-MS-TNEF-Correlator: 
X-MimeOLE: Produced By Microsoft Exchange V6.5
Thread-Topic: Relating to some syntax error in the gitk script
Thread-Index: AcgAz71+a9oChBgYSYGjHKHMbrzPIQAMSwSA
X-OriginalArrivalTime: 27 Sep 2007 12:22:10.0245 (UTC) FILETIME=[06E6E750:01C80101]
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/59293>

 
Hi,

When I am running the gitk command I get the following error message:-

========================================================================
===========================
Error in startup script: syntax error in expression "$i >= [llength
$argv] && $revtreeargs ne {}"
    while executing
"if {$i >= [llength $argv] && $revtreeargs ne {}} { 
    # no -- on command line, but some arguments (other than -d)
    if {[catch {
        set f [eval exec..."
    (file "./gitk" line 7912)
========================================================================
============================

Is there a problem with the script or is it a problem with my
environment...?


Regards,


Ritwik
SASKEN BUSINESS DISCLAIMER
-------------------------
This message may contain confidential, proprietary or legally privileged information. In 
case you are not the original intended Recipient of the message, you must not, directly or 
indirectly, use, Disclose, distribute, print, or copy any part of this message and you are 
requested to delete it and inform the sender. Any views expressed in this message are 
those of the individual sender unless otherwise stated. Nothing contained in this message 
shall be construed as an offer or acceptance of any offer by Sasken Communication 
Technologies Limited ("Sasken") unless sent with that express intent and with due 
authority of Sasken. Sasken has taken enough precautions to prevent the spread of 
viruses. However the company accepts no liability for any damage caused by any virus 
transmitted by this email
