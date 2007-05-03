From: "Brown, Len" <len.brown@intel.com>
Subject: RE: git-send-email vs address syntax
Date: Thu, 3 May 2007 02:30:43 -0400
Message-ID: <CFF307C98FEABE47A452B27C06B85BB6030BDEB2@hdsmsx411.amr.corp.intel.com>
References: <7v8xc62zky.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Cc: <git@vger.kernel.org>, "David Miller" <davem@davemloft.net>
To: "Junio C Hamano" <junkio@cox.net>
X-From: git-owner@vger.kernel.org Thu May 03 08:30:52 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HjUq4-0004S9-BE
	for gcvg-git@gmane.org; Thu, 03 May 2007 08:30:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754570AbXECGat (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 3 May 2007 02:30:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754568AbXECGat
	(ORCPT <rfc822;git-outgoing>); Thu, 3 May 2007 02:30:49 -0400
Received: from mga03.intel.com ([143.182.124.21]:35905 "EHLO mga03.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754570AbXECGas convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 3 May 2007 02:30:48 -0400
Received: from azsmga001.ch.intel.com ([10.2.17.19])
  by azsmga101.ch.intel.com with ESMTP; 02 May 2007 23:30:48 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.14,482,1170662400"; 
   d="scan'208";a="223533919"
Received: from fmsmsx334.amr.corp.intel.com ([132.233.42.1])
  by azsmga001.ch.intel.com with ESMTP; 02 May 2007 23:30:47 -0700
Received: from hdsmsx411.amr.corp.intel.com ([10.127.2.70]) by fmsmsx334.amr.corp.intel.com with Microsoft SMTPSVC(6.0.3790.1830);
	 Wed, 2 May 2007 23:30:47 -0700
X-MimeOLE: Produced By Microsoft Exchange V6.5
Content-class: urn:content-classes:message
In-Reply-To: <7v8xc62zky.fsf@assigned-by-dhcp.cox.net>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: git-send-email vs address syntax
Thread-Index: AceNS9xPBS84kOCCS764aBp8fqg0JwAAFn3g
X-OriginalArrivalTime: 03 May 2007 06:30:47.0856 (UTC) FILETIME=[96186300:01C78D4C]
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/46071>


>As a matter of fact, recent enough send-email is supposed to
>have a fix for this exact problem.  If your copy of send-email
>does not have
>
>	sub sanitize_address_rfc822 {
>
>you might want to upgrade.  Both 1.5.2-rc1 and 1.5.1.3 have
>this.
>
>

Hmmm, the message has this tag at the bottom:
1.5.2.rc0.34.gda94

so I guess I didn't have the latest at the time.

thanks,
-Len
