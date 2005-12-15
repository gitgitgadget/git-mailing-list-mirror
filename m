From: =?utf-8?Q?Santi_B=C3=A9jar?= <sbejar@gmail.com>
Subject: gitk: color in the merge diffs
Date: Thu, 15 Dec 2005 16:13:03 +0100
Message-ID: <87d5jytmv4.fsf@ifae.es>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Thu Dec 15 16:15:03 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Emulc-0008Fa-3M
	for gcvg-git@gmane.org; Thu, 15 Dec 2005 16:11:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750748AbVLOPLZ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 15 Dec 2005 10:11:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750754AbVLOPLZ
	(ORCPT <rfc822;git-outgoing>); Thu, 15 Dec 2005 10:11:25 -0500
Received: from ifae-s0.ifae.es ([192.101.162.68]:54483 "EHLO ifae-s0.ifae.es")
	by vger.kernel.org with ESMTP id S1750748AbVLOPLZ (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 15 Dec 2005 10:11:25 -0500
Received: from bela (caronte.ifae.es [192.101.162.199])
	by ifae-s0.ifae.es (8.11.6/8.11.6) with ESMTP id jBFFBHJ19770
	for <git@vger.kernel.org>; Thu, 15 Dec 2005 16:11:17 +0100
To: Git Mailing List <git@vger.kernel.org>
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/22.0.50 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/13697>

Hello *,

      In the diff of a merge it is used some colors for the parents, red
      for the first parent, blue for the second, then green, purple,
      brown, and the rest are grey. It would help to remember this code
      if the Parent's line in the comments used the same colors.

Parent: 2db8aaeca1dca4e940829b87d1164e5b42ff49b4 (rebase: ....)
Parent: b3f041fb0f7de167dbb6711b0a231d36c4b5de08 (git-am ...)
        ^^^^ in red the first and blue the second...

      Thanks.
