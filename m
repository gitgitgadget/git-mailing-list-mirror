From: "Luck, Tony" <tony.luck@intel.com>
Subject: RE: git pull on ia64 linux tree
Date: Wed, 27 Apr 2005 15:11:38 -0700
Message-ID: <B8E391BBE9FE384DAA4C5C003888BE6F035B31D9@scsmsx401.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Apr 28 00:08:07 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DQugt-0003DP-4d
	for gcvg-git@gmane.org; Thu, 28 Apr 2005 00:07:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262049AbVD0WMI (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 27 Apr 2005 18:12:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262050AbVD0WMI
	(ORCPT <rfc822;git-outgoing>); Wed, 27 Apr 2005 18:12:08 -0400
Received: from fmr14.intel.com ([192.55.52.68]:4240 "EHLO
	fmsfmr002.fm.intel.com") by vger.kernel.org with ESMTP
	id S262049AbVD0WLw convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 27 Apr 2005 18:11:52 -0400
Received: from fmsfmr100.fm.intel.com (fmsfmr100.fm.intel.com [10.1.192.58])
	by fmsfmr002.fm.intel.com (8.12.10/8.12.10/d: major-outer.mc,v 1.1 2004/09/17 17:50:56 root Exp $) with ESMTP id j3RMBgjI015256;
	Wed, 27 Apr 2005 22:11:42 GMT
Received: from fmsmsxvs041.fm.intel.com (fmsmsxvs041.fm.intel.com [132.233.42.126])
	by fmsfmr100.fm.intel.com (8.12.10/8.12.10/d: major-inner.mc,v 1.2 2004/09/17 18:05:01 root Exp $) with SMTP id j3RMBLkO001256;
	Wed, 27 Apr 2005 22:11:42 GMT
Received: from fmsmsx332.amr.corp.intel.com ([132.233.42.148])
 by fmsmsxvs041.fm.intel.com (SAVSMTP 3.1.7.47) with SMTP id M2005042715114104446
 ; Wed, 27 Apr 2005 15:11:41 -0700
Received: from fmsmsx312.amr.corp.intel.com ([132.233.42.227]) by fmsmsx332.amr.corp.intel.com with Microsoft SMTPSVC(6.0.3790.211);
	 Wed, 27 Apr 2005 15:11:41 -0700
Received: from scsmsx401.amr.corp.intel.com ([10.3.90.12]) by fmsmsx312.amr.corp.intel.com with Microsoft SMTPSVC(6.0.3790.211);
	 Wed, 27 Apr 2005 15:11:41 -0700
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
Content-class: urn:content-classes:message
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: git pull on ia64 linux tree
Thread-Index: AcVLTExmvBfnK+hrSeGJktvWn3i8fAAKXczQ
To: "Linus Torvalds" <torvalds@osdl.org>
X-OriginalArrivalTime: 27 Apr 2005 22:11:41.0389 (UTC) FILETIME=[16FDE7D0:01C54B76]
X-Scanned-By: MIMEDefang 2.44
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

>On Wed, 27 Apr 2005 tony.luck@intel.com wrote:
>> 
>> please pull from:
>> 
>> 	
>rsync://rsync.kernel.org/pub/scm/linux/kernel/git/aegl/linux-2.6.git
>
>Merged and pushed out. You should probably check the end 
>result, but it all looks good from here.

The merge is right ... but "cg-update" leaves files that have been
deleted lying around in the checked out tree.

-Tony
