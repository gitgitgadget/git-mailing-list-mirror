From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 0/2] teach am and rebase -q/--quiet
Date: Sat, 13 Jun 2009 16:07:14 -0700
Message-ID: <7vfxe3vil9.fsf@alter.siamese.dyndns.org>
References: <1244924500-27391-1-git-send-email-bebarino@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Stephen Boyd <bebarino@gmail.com>
X-From: git-owner@vger.kernel.org Sun Jun 14 01:07:25 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MFcJn-0000Tl-Nb
	for gcvg-git-2@gmane.org; Sun, 14 Jun 2009 01:07:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757722AbZFMXHN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 13 Jun 2009 19:07:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757197AbZFMXHN
	(ORCPT <rfc822;git-outgoing>); Sat, 13 Jun 2009 19:07:13 -0400
Received: from fed1rmmtao105.cox.net ([68.230.241.41]:59967 "EHLO
	fed1rmmtao105.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753952AbZFMXHM (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 13 Jun 2009 19:07:12 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao105.cox.net
          (InterMail vM.7.08.02.01 201-2186-121-102-20070209) with ESMTP
          id <20090613230715.YDZN20430.fed1rmmtao105.cox.net@fed1rmimpo02.cox.net>;
          Sat, 13 Jun 2009 19:07:15 -0400
Received: from localhost ([68.225.240.211])
	by fed1rmimpo02.cox.net with bizsmtp
	id 3b7E1c00G4aMwMQ04b7E4b; Sat, 13 Jun 2009 19:07:14 -0400
X-VR-Score: 0.00
X-Authority-Analysis: v=1.0 c=1 a=uoIjCrTgn_IA:10 a=KdErG-BSOSEA:10
 a=vRLbITDm_guYW0oiVk8A:9 a=XI6G8vF3-HDoF4HP9fQ_liABOY0A:4
X-CM-Score: 0.00
In-Reply-To: <1244924500-27391-1-git-send-email-bebarino@gmail.com> (Stephen Boyd's message of "Sat\, 13 Jun 2009 13\:21\:38 -0700")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/121526>

Perhaps you would want to do the same for "stash apply/pop" that runs "git
status", listing untracked files and whatnot?
