From: Julian Phillips <julian@quantumfyre.co.uk>
Subject: git via rsync
Date: Fri, 20 Apr 2007 22:23:13 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0704202218480.7764@beast.quantumfyre.co.uk>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Apr 20 23:23:39 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hf0Zs-0001kS-D0
	for gcvg-git@gmane.org; Fri, 20 Apr 2007 23:23:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1767225AbXDTVXQ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 20 Apr 2007 17:23:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1767255AbXDTVXQ
	(ORCPT <rfc822;git-outgoing>); Fri, 20 Apr 2007 17:23:16 -0400
Received: from electron.quantumfyre.co.uk ([87.106.55.16]:40738 "EHLO
	electron.quantumfyre.co.uk" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1767225AbXDTVXP (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 20 Apr 2007 17:23:15 -0400
Received: from neutron.quantumfyre.co.uk (neutron.datavampyre.co.uk [212.159.54.235])
	by electron.quantumfyre.co.uk (Postfix) with ESMTP id 7210EC648A
	for <git@vger.kernel.org>; Fri, 20 Apr 2007 22:23:14 +0100 (BST)
Received: (qmail 927 invoked by uid 103); 20 Apr 2007 22:22:25 +0100
Received: from 192.168.0.7 by neutron.quantumfyre.co.uk (envelope-from <julian@quantumfyre.co.uk>, uid 201) with qmail-scanner-1.25st 
 (clamdscan: 0.90.2/3135. spamassassin: 3.1.8. perlscan: 1.25st.  
 Clear:RC:1(192.168.0.7):. 
 Processed in 0.039284 secs); 20 Apr 2007 21:22:25 -0000
Received: from beast.quantumfyre.co.uk (192.168.0.7)
  by neutron.datavampyre.co.uk with SMTP; 20 Apr 2007 22:22:25 +0100
X-X-Sender: jp3@beast.quantumfyre.co.uk
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/45133>

Is rsync still a supported git transport (I know that there is still 
code for it, but does anyone care for it)?  Does anyone use it?

http has caused a couple of queries recently, but I haven't noticed 
anything about rsync.  Does that mean that it "just works", or is it 
simply that no one uses it?

Just curious ...

-- 
Julian

  ---
Children are unpredictable.  You never know what inconsistency they're
going to catch you in next.
 		-- Franklin P. Jones
