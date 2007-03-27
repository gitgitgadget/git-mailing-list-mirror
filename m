From: Bryan Wu <bryan.wu@analog.com>
Subject: Help: git-quiltimport error
Date: Wed, 28 Mar 2007 01:01:07 +0800
Organization: Analog Devices, Ltd.
Message-ID: <1175014867.15767.13.camel@roc-laptop>
Reply-To: bryan.wu@analog.com
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org, Eric Biederman <ebiederm@lnxi.com>
X-From: git-owner@vger.kernel.org Tue Mar 27 19:01:49 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HWF35-0004R4-Ui
	for gcvg-git@gmane.org; Tue, 27 Mar 2007 19:01:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933326AbXC0RBP (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 27 Mar 2007 13:01:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933306AbXC0RBO
	(ORCPT <rfc822;git-outgoing>); Tue, 27 Mar 2007 13:01:14 -0400
Received: from nwd2mail10.analog.com ([137.71.25.55]:43854 "EHLO
	nwd2mail10.analog.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933326AbXC0RBM (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 Mar 2007 13:01:12 -0400
Received: from nwd2mhb1.analog.com ([137.71.5.12])
  by nwd2mail10.analog.com with ESMTP; 27 Mar 2007 13:01:11 -0400
X-IronPort-AV: i="4.14,335,1170651600"; 
   d="scan'208"; a="32770256:sNHT48130362"
Received: from nwd2exm4.ad.analog.com (nwd2exm4.ad.analog.com [10.64.53.123])
	by nwd2mhb1.analog.com (8.9.3 (PHNE_28810+JAGae91741)/8.9.3) with ESMTP id NAA08781;
	Tue, 27 Mar 2007 13:01:07 -0400 (EDT)
Received: from 220.232.78.92 ([220.232.78.92]) by nwd2exm4.ad.analog.com ([10.64.53.123]) via Exchange Front-End Server owa.analog.com ([10.64.25.31]) with Microsoft Exchange Server HTTP-DAV ;
 Tue, 27 Mar 2007 17:01:07 +0000
Received: from roc-laptop by owa.analog.com; 28 Mar 2007 01:01:07 +0800
X-Mailer: Evolution 2.10.0 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/43285>

Hi folks,

When I am using latest git-quiltimport, I met following errors. 

$git-quiltimport --dry-run --author "Bryan Wu <bryan.wu@analog.com>" --patches "/home/roc/mm-tree/patches" 
/usr/local/bin/git-quiltimport: 114: Syntax error: Missing '))'

Could you please help me on this?

Thanks
-Bryan Wu
