From: Robert Richter <robert.richter@amd.com>
Subject: Gitweb: Provide Git links in project list?
Date: Wed, 30 Jul 2008 14:57:43 +0200
Message-ID: <20080730125743.GY15356@erda.amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jul 30 14:59:10 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KOBGn-0006tF-KZ
	for gcvg-git-2@gmane.org; Wed, 30 Jul 2008 14:59:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754380AbYG3M6J (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 30 Jul 2008 08:58:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751724AbYG3M6H
	(ORCPT <rfc822;git-outgoing>); Wed, 30 Jul 2008 08:58:07 -0400
Received: from outbound-wa4.frontbridge.com ([216.32.181.16]:43422 "EHLO
	WA4EHSOBE006.bigfish.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751750AbYG3M6H (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 30 Jul 2008 08:58:07 -0400
Received: from mail123-wa4-R.bigfish.com (10.8.14.250) by
 WA4EHSOBE006.bigfish.com (10.8.40.26) with Microsoft SMTP Server id
 8.1.240.5; Wed, 30 Jul 2008 12:58:04 +0000
Received: from mail123-wa4 (localhost.localdomain [127.0.0.1])	by
 mail123-wa4-R.bigfish.com (Postfix) with ESMTP id 71702B00412	for
 <git@vger.kernel.org>; Wed, 30 Jul 2008 12:58:04 +0000 (UTC)
X-BigFish: VPS13(zz4015M62a3Lzz10d3izzz32i6bh87il)
X-FB-DOMAIN-IP-MATCH: fail
Received: by mail123-wa4 (MessageSwitch) id 1217422682227997_10743; Wed, 30
 Jul 2008 12:58:02 +0000 (UCT)
Received: from ausb3extmailp02.amd.com (ausb3extmailp02.amd.com
 [163.181.251.22])	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)	by mail123-wa4.bigfish.com (Postfix) with
 ESMTP id 0BB5B20078	for <git@vger.kernel.org>; Wed, 30 Jul 2008 12:58:01
 +0000 (UTC)
Received: from ausb3twp01.amd.com ([163.181.250.37])	by
 ausb3extmailp02.amd.com (Switch-3.2.7/Switch-3.2.7) with ESMTP id
 m6UCvvop025865	for <git@vger.kernel.org>; Wed, 30 Jul 2008 07:58:00 -0500
X-WSS-ID: 0K4TLCF-01-7DS-01
Received: from sausexbh1.amd.com (sausexbh1.amd.com [163.181.22.101])	by
 ausb3twp01.amd.com (Tumbleweed MailGate 3.5.1) with ESMTP id 2B8BC1943C8	for
 <git@vger.kernel.org>; Wed, 30 Jul 2008 07:57:51 -0500 (CDT)
Received: from sausexmb5.amd.com ([163.181.49.129]) by sausexbh1.amd.com with
 Microsoft SMTPSVC(6.0.3790.3959);	 Wed, 30 Jul 2008 07:57:56 -0500
Received: from SDRSEXMB1.amd.com ([172.20.3.116]) by sausexmb5.amd.com with
 Microsoft SMTPSVC(6.0.3790.3959);	 Wed, 30 Jul 2008 07:57:56 -0500
Received: from erda.amd.com ([165.204.85.17]) by SDRSEXMB1.amd.com with
 Microsoft SMTPSVC(6.0.3790.3959);	 Wed, 30 Jul 2008 14:57:54 +0200
Received: by erda.amd.com (Postfix, from userid 35569)	id AB62A8403; Wed, 30
 Jul 2008 14:57:43 +0200 (CEST)
Content-Disposition: inline
User-Agent: Mutt/1.5.16 (2007-06-09)
X-OriginalArrivalTime: 30 Jul 2008 12:57:54.0320 (UTC) FILETIME=[E1B00900:01C8F243]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/90778>

The Gitweb on git.kernel.org povides links to the Git repository for
each project (git <git://...>). However, I did not find this feature
in the current implementation of git_project_list_body(). Does
somebody know if there is a patch available for this and if this could
be added to gitweb?

Thanks,

-Robert

-- 
Advanced Micro Devices, Inc.
Operating System Research Center
email: robert.richter@amd.com
