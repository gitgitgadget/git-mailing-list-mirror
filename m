From: "Brown, Len" <len.brown@intel.com>
Subject: RE: how to display file history?
Date: Mon, 15 May 2006 13:24:41 -0400
Message-ID: <CFF307C98FEABE47A452B27C06B85BB670FB0A@hdsmsx411.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Cc: <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon May 15 19:40:08 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Ffh33-0007YF-QB
	for gcvg-git@gmane.org; Mon, 15 May 2006 19:40:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751614AbWEORj7 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 15 May 2006 13:39:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751615AbWEORj7
	(ORCPT <rfc822;git-outgoing>); Mon, 15 May 2006 13:39:59 -0400
Received: from mga01.intel.com ([192.55.52.88]:34982 "EHLO
	fmsmga101-1.fm.intel.com") by vger.kernel.org with ESMTP
	id S1751606AbWEORj6 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 15 May 2006 13:39:58 -0400
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga101-1.fm.intel.com with ESMTP; 15 May 2006 10:39:57 -0700
Received: from fmsmsx331.fm.intel.com (HELO fmsmsx331.amr.corp.intel.com) ([132.233.42.156])
  by fmsmga001.fm.intel.com with ESMTP; 15 May 2006 10:24:53 -0700
X-IronPort-AV: i="4.05,130,1146466800"; 
   d="scan'208"; a="37514158:sNHT3900504300"
Received: from fmsmsx311.amr.corp.intel.com ([132.233.42.214]) by fmsmsx331.amr.corp.intel.com with Microsoft SMTPSVC(6.0.3790.1830);
	 Mon, 15 May 2006 10:24:46 -0700
Received: from hdsmsx402.amr.corp.intel.com ([10.127.2.62]) by fmsmsx311.amr.corp.intel.com with Microsoft SMTPSVC(6.0.3790.1830);
	 Mon, 15 May 2006 10:24:45 -0700
Received: from hdsmsx411.amr.corp.intel.com ([10.127.2.70]) by hdsmsx402.amr.corp.intel.com with Microsoft SMTPSVC(6.0.3790.211);
	 Mon, 15 May 2006 13:24:43 -0400
X-MimeOLE: Produced By Microsoft Exchange V6.5
Content-class: urn:content-classes:message
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: how to display file history?
Thread-Index: AcZ36sGeb9HWEt9sShWKCMzu7fkjlQAWJZXQ
To: "Junio C Hamano" <junkio@cox.net>
X-OriginalArrivalTime: 15 May 2006 17:24:44.0172 (UTC) FILETIME=[74F154C0:01C67844]
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/20070>

>	git log --stat -- A

very handy indeed.

I was surprised on initial use that --stat is
limited to the file specified in "A" and doesn't
expand to describe the entire commit that touches "A".
(ie. the stat output is a subset of what is associated
with the displayed commit comments).

This, of course, is clear now, it just isn't what
I expected on first use.

thanks,
-Len
