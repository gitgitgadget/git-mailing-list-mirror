From: Pedro Melo <melo@simplicidade.org>
Subject: Deleting a submodule
Date: Thu, 12 Mar 2009 17:31:44 +0000
Message-ID: <20BA928D-7133-40E7-AB01-466F509F002C@simplicidade.org>
Mime-Version: 1.0 (Apple Message framework v928.1)
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Content-Transfer-Encoding: 7bit
To: Git Mailinglist <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Mar 12 18:34:25 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LhomZ-0005DV-4O
	for gcvg-git-2@gmane.org; Thu, 12 Mar 2009 18:33:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753999AbZCLRbw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 12 Mar 2009 13:31:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752998AbZCLRbw
	(ORCPT <rfc822;git-outgoing>); Thu, 12 Mar 2009 13:31:52 -0400
Received: from speed.simplicidade.org ([81.92.204.129]:44290 "HELO
	speed.simplicidade.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1751952AbZCLRbv (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 12 Mar 2009 13:31:51 -0400
Received: (qmail 30691 invoked from network); 12 Mar 2009 17:31:55 -0000
Received: from bl4-203-241.dsl.telepac.pt (HELO [192.168.0.201]) (81.193.203.241)
  (smtp-auth username melo@simplicidade.org, mechanism cram-md5)
  by speed.simplicidade.org (qpsmtpd/0.43rc1) with (AES256-SHA encrypted) ESMTPSA; Thu, 12 Mar 2009 17:31:55 +0000
Jabber-Id: melo@simplicidade.org
X-Mailer: Apple Mail (2.928.1)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/113095>

Hi,

I couldn't find a git-submodule command to delete a submodule. What is  
the correct procedure?

I did:

  * removed the entry from .gitmodules;
  * run git submodule sync

But its still recorded somewhere.

Thanks,
-- 
Pedro Melo
Blog: http://www.simplicidade.org/notes/
XMPP ID: melo@simplicidade.org
Use XMPP!
