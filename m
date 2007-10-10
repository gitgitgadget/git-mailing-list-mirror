From: "Joakim Tjernlund" <joakim.tjernlund@transmode.se>
Subject: [FEATURE REQUEST] git clone, just clone selected branches?
Date: Wed, 10 Oct 2007 20:55:18 +0200
Message-ID: <011401c80b6f$1a11d1f0$04ac10ac@Jocke>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Oct 10 20:55:35 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IfgiT-0000vT-C4
	for gcvg-git-2@gmane.org; Wed, 10 Oct 2007 20:55:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753679AbXJJSzX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 10 Oct 2007 14:55:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753862AbXJJSzX
	(ORCPT <rfc822;git-outgoing>); Wed, 10 Oct 2007 14:55:23 -0400
Received: from mail.transmode.se ([83.241.175.147]:55267 "EHLO
	tmnt04.transmode.se" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753679AbXJJSzW (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 10 Oct 2007 14:55:22 -0400
Received: from Jocke ([84.217.95.61]) by tmnt04.transmode.se with Microsoft SMTPSVC(5.0.2195.6713);
	 Wed, 10 Oct 2007 20:55:19 +0200
X-Mailer: Microsoft Office Outlook 11
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.3138
Thread-Index: AcgLbxmf+182PCf6SNqrHcUWClYJhg==
X-OriginalArrivalTime: 10 Oct 2007 18:55:19.0263 (UTC) FILETIME=[1A6C26F0:01C80B6F]
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/60526>

To my knowlede a git clone always clones all branches from the remote repo.
I would like the possibly to clone selected branches, like
 git clone <repo URL> -b master -b upstream
which will only fetch the master and upstream branch.

I know I can use git remote to do this, but it is a bit clumsy 
when starting a new repo.

What do you think?

 Jocke
