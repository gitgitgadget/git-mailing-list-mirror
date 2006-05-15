From: "Brown, Len" <len.brown@intel.com>
Subject: RE: how to display file history?
Date: Mon, 15 May 2006 02:13:30 -0400
Message-ID: <CFF307C98FEABE47A452B27C06B85BB670F4FD@hdsmsx411.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Cc: <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon May 15 08:13:59 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FfWL8-0005it-EZ
	for gcvg-git@gmane.org; Mon, 15 May 2006 08:13:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932208AbWEOGNo (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 15 May 2006 02:13:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932235AbWEOGNo
	(ORCPT <rfc822;git-outgoing>); Mon, 15 May 2006 02:13:44 -0400
Received: from mga03.intel.com ([143.182.124.21]:15752 "EHLO
	azsmga101-1.ch.intel.com") by vger.kernel.org with ESMTP
	id S932208AbWEOGNn convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 15 May 2006 02:13:43 -0400
Received: from azsmga001.ch.intel.com ([10.2.17.19])
  by azsmga101-1.ch.intel.com with ESMTP; 14 May 2006 23:13:43 -0700
Received: from fmsmsx331.fm.intel.com (HELO fmsmsx331.amr.corp.intel.com) ([132.233.42.156])
  by azsmga001.ch.intel.com with ESMTP; 14 May 2006 23:13:38 -0700
X-IronPort-AV: i="4.05,128,1146466800"; 
   d="scan'208"; a="36393211:sNHT12632857664"
Received: from fmsmsx312.amr.corp.intel.com ([132.233.42.227]) by fmsmsx331.amr.corp.intel.com with Microsoft SMTPSVC(6.0.3790.1830);
	 Sun, 14 May 2006 23:13:33 -0700
Received: from hdsmsx401.amr.corp.intel.com ([10.127.2.60]) by fmsmsx312.amr.corp.intel.com with Microsoft SMTPSVC(6.0.3790.1830);
	 Sun, 14 May 2006 23:13:33 -0700
Received: from hdsmsx411.amr.corp.intel.com ([10.127.2.70]) by hdsmsx401.amr.corp.intel.com with Microsoft SMTPSVC(6.0.3790.211);
	 Mon, 15 May 2006 02:13:31 -0400
X-MimeOLE: Produced By Microsoft Exchange V6.5
Content-class: urn:content-classes:message
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: how to display file history?
Thread-Index: AcZ35PPAJUnW9R8fTVS5gh8ati81sQAAQMhA
To: <spearce@spearce.org>
X-OriginalArrivalTime: 15 May 2006 06:13:32.0032 (UTC) FILETIME=[B0E07000:01C677E6]
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/20026>

 
>	git whatchanged A

thanks.  I've used this on entire repos before, but
for some reason didn't think of this command name
when looking for individual file history.

Searching git(7) for "history" didn't take me here.
Searching for "log" would have, but I must have
terminated that search when git-log and git-shortlog
turned out to not be what I was looking for.

-Len
