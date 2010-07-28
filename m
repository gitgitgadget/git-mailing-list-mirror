From: Mihamina Rakotomandimby <mihamina@gulfsat.mg>
Subject: removing very old commits (including initial)
Date: Wed, 28 Jul 2010 11:53:09 +0300
Organization: GULFSAT
Message-ID: <20100728115309.08ed6fdd@packard.rktmb.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jul 28 10:59:31 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Oe2U6-0007oi-OX
	for gcvg-git-2@lo.gmane.org; Wed, 28 Jul 2010 10:59:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754433Ab0G1I7Z (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 28 Jul 2010 04:59:25 -0400
Received: from smtp-out.malagasy.com ([41.204.104.33]:46725 "EHLO
	smtp-out.malagasy.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754324Ab0G1I7Y (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 28 Jul 2010 04:59:24 -0400
X-Greylist: delayed 365 seconds by postgrey-1.27 at vger.kernel.org; Wed, 28 Jul 2010 04:59:24 EDT
Received: from smtp-2.blueline.mg (unknown [41.204.104.56])
	(using TLSv1 with cipher ADH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp-out.malagasy.com (Postfix) with ESMTPS id BB0708C829
	for <git@vger.kernel.org>; Wed, 28 Jul 2010 11:53:16 +0300 (EAT)
Received: from localhost (spamassassin.malagasy.com [41.204.104.47])
	by smtp-2.blueline.mg (Postfix) with ESMTP id 9CA21600AC
	for <git@vger.kernel.org>; Wed, 28 Jul 2010 11:53:16 +0300 (EAT)
X-Virus-Scanned: par antivirus.malagasy.com
X-Spam-Flag: NO
X-Spam-Score: -2.602
X-Spam-Level: 
X-Spam-Status: No, score=-2.602 required=7 tests=[AWL=-0.003, BAYES_00=-2.599]
Received: from smtp-2.blueline.mg ([41.204.104.56])
	by localhost (spamassassin.malagasy.com [41.204.104.47]) (amavisd-new, port 10024)
	with ESMTP id 0l6ePT-lFOQk for <git@vger.kernel.org>;
	Wed, 28 Jul 2010 11:53:09 +0300 (EAT)
Received: from packard.rktmb.org (static-104-10.blueline.mg [41.204.104.10])
	by smtp-2.blueline.mg (Postfix) with ESMTP id 9A56D6010D
	for <git@vger.kernel.org>; Wed, 28 Jul 2010 11:53:09 +0300 (EAT)
X-Mailer: Claws Mail 3.7.4 (GTK+ 2.20.1; x86_64-pc-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/152059>

Manao ahoana, Hello, Bonjour,

I work on a personnal project that become a little bit bigger over the
time.
Initially, it was a single file one, and that file contained database
credentials.
Later, I splat the project and put the credentials in another untracked
file (.gitignore).
When I want to publish this project, the history contains the initial
file, with the credentials. I dont want to publish that.

It's not a problem to definitely wipe the "single file" part of history
of this project, but interesting to keep the history after the
split&untracking.

How to?
Publishing will be through gitweb.

Misaotra, Thanks, Merci.

-- 

       Architecte Informatique chez Blueline/Gulfsat:
    Administration Systeme, Recherche & Developpement
                                    +261 34 56 000 19
