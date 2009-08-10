From: Roald de Vries <rdv@roalddevries.nl>
Subject: backups with git
Date: Mon, 10 Aug 2009 10:27:34 +0200
Message-ID: <41CB836B-6057-448E-805F-F25EAF765D27@roalddevries.nl>
Mime-Version: 1.0 (Apple Message framework v935.3)
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Aug 10 10:33:37 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MaQK1-00005W-0R
	for gcvg-git-2@gmane.org; Mon, 10 Aug 2009 10:33:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752145AbZHJId3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 10 Aug 2009 04:33:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752116AbZHJId3
	(ORCPT <rfc822;git-outgoing>); Mon, 10 Aug 2009 04:33:29 -0400
Received: from platinum.liacs.nl ([132.229.131.22]:37289 "EHLO
	platinum.liacs.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751659AbZHJId2 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 10 Aug 2009 04:33:28 -0400
Received: from localhost (localhost [127.0.0.1])
	by platinum.liacs.nl (8.14.2/8.14.2/LIACS 1.5) with ESMTP id n7A8XPdO016386
	for <git@vger.kernel.org>; Mon, 10 Aug 2009 10:33:27 +0200
X-Virus-Scanned: amavisd-new at liacs.nl
Received: from platinum.liacs.nl ([127.0.0.1])
	by localhost (platinum.liacs.nl [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id 89uqmH8SBjZb for <git@vger.kernel.org>;
	Mon, 10 Aug 2009 10:33:04 +0200 (CEST)
Received: from prive147.liacs.nl (prive147.liacs.nl [132.229.16.147])
	by platinum.liacs.nl (8.14.2/8.14.2/LIACS 1.5) with ESMTP id n7A8Rd1n015250
	for <git@vger.kernel.org>; Mon, 10 Aug 2009 10:27:40 +0200
X-Mailer: Apple Mail (2.935.3)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0 (platinum.liacs.nl [132.229.131.22]); Mon, 10 Aug 2009 10:27:40 +0200 (CEST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/125407>

Dear all,

I'm thinking of using git as a backup solution for my whole system,  
setting my $GIT_DIR to something like "/backupdisc/backup". Does that  
seem sensible? In his Google tech talk, Linus said that git was not  
good at huge projects; I guess that would apply to backups. On the  
other hand, maybe a backup doesn't need to be as fast as he wants git  
to be for projects. Has anybody used git like this? And was it a good  
experience?

Kind regards,

Roald
