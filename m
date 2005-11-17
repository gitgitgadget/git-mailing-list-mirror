From: Andreas Ericsson <ae@op5.se>
Subject: [PATCH 0/5] User-relative paths, take three.
Date: Thu, 17 Nov 2005 20:36:55 +0100
Message-ID: <437CDBD7.4020304@op5.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-From: git-owner@vger.kernel.org Thu Nov 17 20:39:43 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EcpZR-0000hg-1Z
	for gcvg-git@gmane.org; Thu, 17 Nov 2005 20:37:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964806AbVKQTg5 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 17 Nov 2005 14:36:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964782AbVKQTg5
	(ORCPT <rfc822;git-outgoing>); Thu, 17 Nov 2005 14:36:57 -0500
Received: from linux-server1.op5.se ([193.201.96.2]:36058 "EHLO
	smtp-gw1.op5.se") by vger.kernel.org with ESMTP id S964806AbVKQTg4
	(ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 17 Nov 2005 14:36:56 -0500
Received: from [192.168.1.19] (unknown [213.88.215.14])
	by smtp-gw1.op5.se (Postfix) with ESMTP id BCE976BD02
	for <git@vger.kernel.org>; Thu, 17 Nov 2005 20:36:55 +0100 (CET)
User-Agent: Mozilla Thunderbird 1.0.7-1.1.fc3 (X11/20050929)
X-Accept-Language: en-us, en
To: Git Mailing List <git@vger.kernel.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/12146>

See the threads "User-relative paths", "[RFC] GIT paths" and
"[PATCH 0/4] User-relative paths, take two" for previous discussions
on this topic.

Perhaps this has simmered enough by now.

I've tested cloning, pulling and pushing with every possible valid and 
invalid url'ish notation I could think of, including local.

Everything works, in spite of my not-so-stellar track record. ;)

-- 
Andreas Ericsson                   andreas.ericsson@op5.se
OP5 AB                             www.op5.se
Tel: +46 8-230225                  Fax: +46 8-230231
