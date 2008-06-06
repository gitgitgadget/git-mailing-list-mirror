From: Thomas Harning <thomas.harning@trustbearer.com>
Subject: Mac OSX and gitk right-click
Date: Fri, 6 Jun 2008 18:44:52 -0400
Message-ID: <3215D250-73A0-422C-B104-2BE306778271@trustbearer.com>
Mime-Version: 1.0 (Apple Message framework v924)
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jun 07 01:20:23 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K4lEM-0000Va-D7
	for gcvg-git-2@gmane.org; Sat, 07 Jun 2008 01:20:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756786AbYFFXT1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 6 Jun 2008 19:19:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756384AbYFFXT1
	(ORCPT <rfc822;git-outgoing>); Fri, 6 Jun 2008 19:19:27 -0400
Received: from host.trustbearer.com ([72.52.247.80]:39159 "EHLO
	host.trustbearer.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755464AbYFFXT1 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 6 Jun 2008 19:19:27 -0400
X-Greylist: delayed 2069 seconds by postgrey-1.27 at vger.kernel.org; Fri, 06 Jun 2008 19:19:27 EDT
Received: from [75.149.208.122] (port=54681 helo=[10.1.10.130])
	by host.trustbearer.com with esmtpsa (TLSv1:AES128-SHA:128)
	(Exim 4.68)
	(envelope-from <thomas.harning@trustbearer.com>)
	id 1K4kg3-0008J6-1A; Fri, 06 Jun 2008 18:44:55 -0400
X-Mailer: Apple Mail (2.924)
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - host.trustbearer.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - trustbearer.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/84138>

gitk doesn't appear to have right-click support in OSX, but  
gitgui-0.8.1 has it...

Thought I'd bring this up in case anybody has any fixes.  Currently  
digging through to see if I can make a quick fix...


-- 
Thomas Harning
TrustBearer Labs
TB OpenID: https://openid.trustbearer.com/harningt
