From: Ben Harper <ben.harper@rackspace.com>
Subject: life cycle documentation
Date: Thu, 23 Oct 2014 17:15:21 -0500
Message-ID: <54497DF9.1050501@rackspace.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
To: <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Oct 24 00:19:47 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XhQjT-00072J-Hs
	for gcvg-git-2@plane.gmane.org; Fri, 24 Oct 2014 00:19:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751469AbaJWWTn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 23 Oct 2014 18:19:43 -0400
Received: from mx2.ord1.rackspace.com ([173.203.4.136]:54753 "EHLO
	mx2.ord1.rackspace.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750930AbaJWWTm (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 23 Oct 2014 18:19:42 -0400
X-Greylist: delayed 651 seconds by postgrey-1.27 at vger.kernel.org; Thu, 23 Oct 2014 18:19:42 EDT
X-SBRS: None
X-SenderGroup: RELAYLIST-US
X-MailFlowPolicy: $RELAYED-US
X-IronPort-AV: E=McAfee;i="5600,1067,7471"; a="396256220"
X-IronPort-AV: E=Sophos;i="5.01,489,1400043600"; 
   d="scan'208";a="396256220"
Received: from ord1exh01.rackspace.corp ([10.12.120.25])
  by mx2.ord1.rackspace.com with ESMTP/TLS/AES128-SHA; 23 Oct 2014 17:08:47 -0500
Received: from x.box (10.1.69.82) by smtpout.rackspace.com (10.12.120.25) with
 Microsoft SMTP Server (TLS) id 14.3.123.3; Thu, 23 Oct 2014 17:08:47 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Thunderbird/31.2.0
X-Originating-IP: [10.1.69.82]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Greetings,

I am unable to find any documentation regarding the life cycle regarding 
the various versions of git.  Is only the current version supported?  
What about older minor/major versions?  At what point does a version go 
EOL? Currently, is only 2.1.2 supported?  I would entertain the thought 
on creating a RELEASES document if the information is provided.

Ben Harper
OS Deployment Services, RPMDEV
Rackspace Hosting & IUS Community
