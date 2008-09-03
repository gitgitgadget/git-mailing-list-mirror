From: "Dutta, Ranjan" <ranjan.dutta@intel.com>
Subject: Issue with GIT server
Date: Thu, 4 Sep 2008 03:21:20 +0530
Message-ID: <9B6BEB600FC42B4A9A16868DA97FAFEE1B2ACF@bgsmsx412.gar.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
To: <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Sep 03 23:52:58 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Kb0HK-0000T7-QF
	for gcvg-git-2@gmane.org; Wed, 03 Sep 2008 23:52:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751692AbYICVvh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 3 Sep 2008 17:51:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751505AbYICVvh
	(ORCPT <rfc822;git-outgoing>); Wed, 3 Sep 2008 17:51:37 -0400
Received: from mga11.intel.com ([192.55.52.93]:39079 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751398AbYICVvg convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 3 Sep 2008 17:51:36 -0400
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga102.fm.intel.com with ESMTP; 03 Sep 2008 14:49:28 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.32,320,1217833200"; 
   d="scan'208";a="376430590"
Received: from fmsmsx333.amr.corp.intel.com ([132.233.42.2])
  by fmsmga002.fm.intel.com with ESMTP; 03 Sep 2008 14:48:51 -0700
Received: from bgsmsx412.gar.corp.intel.com ([10.223.4.244]) by fmsmsx333.amr.corp.intel.com with Microsoft SMTPSVC(6.0.3790.1830);
	 Wed, 3 Sep 2008 14:51:25 -0700
X-MimeOLE: Produced By Microsoft Exchange V6.5
Content-class: urn:content-classes:message
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: Issue with GIT server 
Thread-Index: AckOCN5dQi6DXyN1SFW96G5/gfaVIgAAI42AAAEowVAAAEQfIA==
X-OriginalArrivalTime: 03 Sep 2008 21:51:25.0954 (UTC) FILETIME=[3690FE20:01C90E0F]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/94859>

Hello,

I am facing the following issue with GIT server running on Ubuntu 8.04
using an http interface (apache2)..

When I try to push code at the GIT client end

1. git-add(s)
2. git-commit
3. sudo git push upload master

I get this error - 

error: http-push died with strange error
error: failed to push some refs to 'http://<usernaM@<server ip
address>/<git_dir>/'

Any pointers as to how to debug this further ?

Regards,
Ranjan
