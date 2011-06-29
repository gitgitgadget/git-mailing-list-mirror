From: Mihamina Rakotomandimby <mihamina@bbs.mg>
Subject: importing history
Date: Wed, 29 Jun 2011 16:45:14 +0300
Message-ID: <20110629164514.58175480.mihamina@bbs.mg>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jun 29 15:45:36 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Qbv5C-0004vd-Qs
	for gcvg-git-2@lo.gmane.org; Wed, 29 Jun 2011 15:45:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754144Ab1F2Npa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 29 Jun 2011 09:45:30 -0400
Received: from smtp-out.malagasy.com ([41.204.104.33]:33892 "EHLO
	smtp-out.malagasy.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752853Ab1F2Np2 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 29 Jun 2011 09:45:28 -0400
Received: from smtp-1.blueline.mg (unknown [41.204.104.52])
	(using TLSv1 with cipher ADH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp-out.malagasy.com (Postfix) with ESMTPS id CDA118D711
	for <git@vger.kernel.org>; Wed, 29 Jun 2011 16:45:24 +0300 (EAT)
Received: from localhost (spamassassin.malagasy.com [41.204.104.47])
	by smtp-1.blueline.mg (Postfix) with ESMTP id B44504A0BC
	for <git@vger.kernel.org>; Wed, 29 Jun 2011 16:45:24 +0300 (EAT)
X-Virus-Scanned: par antivirus.malagasy.com
X-Spam-Flag: NO
X-Spam-Score: -3.991
X-Spam-Level: 
X-Spam-Status: No, score=-3.991 required=7 tests=[ALL_TRUSTED=-1.8, AWL=0.408,
	BAYES_00=-2.599]
Received: from smtp-1.blueline.mg ([41.204.104.52])
	by localhost (spamassassin.malagasy.com [41.204.104.47]) (amavisd-new, port 10024)
	with ESMTP id FsWNPmiY6O6N for <git@vger.kernel.org>;
	Wed, 29 Jun 2011 16:45:18 +0300 (EAT)
Received: from packard.rktmb.org (staff-104-10.malagasy.com [41.204.104.10])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	(Authenticated sender: mihamina@bbs.mg)
	by smtp-1.blueline.mg (Postfix) with ESMTPSA id 849A54A0DF
	for <git@vger.kernel.org>; Wed, 29 Jun 2011 16:45:17 +0300 (EAT)
X-Mailer: Sylpheed 3.1.0beta2 (GTK+ 2.22.0; x86_64-pc-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/176442>

Hi,

Still newcomer in GIT ;-)

Let the nurpawiki SVN repo here:
http://code.google.com/p/nurpawiki/source/checkout

I know how to clone it using "git svn clone ..."
"git log" shows the whole history: fine!

Then I created an account in a forge (like github or so...), where I
had to clone an empty GIT repository in order to begin to work.
I dont have admin access to the forge, so no "scp" to the repo
hosting possible.

Now, I have 2 "local" repos:
- the one from the SVN
- the empty one from the forge

I am looking for a document that would teach me how to "import" the
"from-svn" into the empty one. What are the keywords for that action
(to help me searching)?

After I do that, I will just have to push to the previously empty
origin and I'm done.

Thanks for your help.


-- 
RMA.
