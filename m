From: Mihamina Rakotomandimby <mihamina@gulfsat.mg>
Subject: use case, advices (SVN/GIT)
Date: Thu, 22 Apr 2010 15:14:01 +0300
Organization: Gulfsat
Message-ID: <20100422151401.2c47aa76@pbmiha.malagasy.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
To: git list <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Apr 22 14:24:16 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O4vS4-00056t-4B
	for gcvg-git-2@lo.gmane.org; Thu, 22 Apr 2010 14:24:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754097Ab0DVMYH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 22 Apr 2010 08:24:07 -0400
Received: from smtp-out.malagasy.com ([41.204.104.33]:51693 "EHLO
	smtp-out.malagasy.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751695Ab0DVMYG (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 22 Apr 2010 08:24:06 -0400
X-Greylist: delayed 590 seconds by postgrey-1.27 at vger.kernel.org; Thu, 22 Apr 2010 08:24:05 EDT
Received: from second-camel.malagasy.com (static-104-61.blueline.mg [41.204.104.61])
	(using TLSv1 with cipher ADH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp-out.malagasy.com (Postfix) with ESMTPS id CBD4C8C360
	for <git@vger.kernel.org>; Thu, 22 Apr 2010 15:14:10 +0300 (EAT)
Received: from localhost (static-104-53.blueline.mg [41.204.104.53])
	by second-camel.malagasy.com (Postfix) with ESMTP id C1C0E4305DD
	for <git@vger.kernel.org>; Thu, 22 Apr 2010 15:14:10 +0300 (EAT)
X-Virus-Scanned: par antivirus2.malagasy.com
X-Spam-Flag: NO
X-Spam-Score: -2.691
X-Spam-Level: 
X-Spam-Status: No, score=-2.691 required=7 tests=[AWL=-0.092, BAYES_00=-2.599]
Received: from second-camel.malagasy.com ([41.204.104.61])
	by localhost (antivirus2.malagasy.com [41.204.104.53]) (amavisd-new, port 10024)
	with ESMTP id 8fGkK+co3XwW for <git@vger.kernel.org>;
	Thu, 22 Apr 2010 15:14:01 +0300 (EAT)
Received: from pbmiha.malagasy.com (sysadmin-cnc.malagasy.com [41.204.104.9])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by second-camel.malagasy.com (Postfix) with ESMTPS id EAB4A4305B1
	for <git@vger.kernel.org>; Thu, 22 Apr 2010 15:14:01 +0300 (EAT)
Received: from localhost ([127.0.0.1] helo=pbmiha.malagasy.com)
	by pbmiha.malagasy.com with esmtp (Exim 4.69)
	(envelope-from <mihamina@gulfsat.mg>)
	id 1O4vI9-0001W5-GQ
	for git@vger.kernel.org; Thu, 22 Apr 2010 15:14:01 +0300
X-Mailer: Claws Mail 3.7.2 (GTK+ 2.18.3; x86_64-pc-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/145525>

Manao ahoana, Hello, Bonjour,

We'd rather use GIT.
But there is a project, that we regularily pull (Coova:
http://coova.org/CoovaChilli/Developers) which is under SVN.

I first "svn export" this project.
I initiate a new GIT repository based on what I "exported".
I make my changes, and commit them.

I month (and several commits) later, I would like to sync with Coova
SVN.

It's a one way "pull": I wont push my changes to their repository.

What's your recommended way to handle this?

Misaotra, Thanks, Merci.

-- 
       Architecte Informatique chez Blueline/Gulfsat:
    Administration Systeme, Recherche & Developpement
                +261 34 29 155 34 / +261 33 11 207 36
