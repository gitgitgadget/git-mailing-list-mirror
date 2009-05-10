From: Junio C Hamano <gitster@pobox.com>
Subject: What's in git.git (May 2009, #01; Sat, 09)
Date: Sat, 09 May 2009 23:53:22 -0700
Message-ID: <7vljp530v1.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun May 10 08:53:43 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M32us-0006W6-Mi
	for gcvg-git-2@gmane.org; Sun, 10 May 2009 08:53:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751827AbZEJGxX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 10 May 2009 02:53:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751510AbZEJGxX
	(ORCPT <rfc822;git-outgoing>); Sun, 10 May 2009 02:53:23 -0400
Received: from fed1rmmtao104.cox.net ([68.230.241.42]:36225 "EHLO
	fed1rmmtao104.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751299AbZEJGxX (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 10 May 2009 02:53:23 -0400
Received: from fed1rmimpo03.cox.net ([70.169.32.75])
          by fed1rmmtao104.cox.net
          (InterMail vM.7.08.02.01 201-2186-121-102-20070209) with ESMTP
          id <20090510065323.EEJZ17135.fed1rmmtao104.cox.net@fed1rmimpo03.cox.net>;
          Sun, 10 May 2009 02:53:23 -0400
Received: from localhost ([68.225.240.211])
	by fed1rmimpo03.cox.net with bizsmtp
	id pitP1b0014aMwMQ04itP2k; Sun, 10 May 2009 02:53:23 -0400
X-Authority-Analysis: v=1.0 c=1 a=hIzbb5t55NgA:10 a=Rioxy5wNaOkA:10
 a=mcmASS3XupipBYguGpoA:9 a=8H4Zn8fOZlIXUAaxFKES45c-xx4A:4
X-CM-Score: 0.00
X-maint-at: ec00d6e0038e030cf73182374e21025c2776cb23
X-master-at: 6345d7a0d151afc3d2a10ada3ecacf54c3fee2d0
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/118706>

1.6.3 is out; 'maint' branch is now for 1.6.3.X maintenance series.

* The 'maint' branch has these fixes since v1.6.3.

Alex Riesen (1):
  Clarify kind of conflict in merge-one-file helper

Alexander Potashev (1):
  Documentation: cloning to empty directory is allowed

Felipe Contreras (1):
  git config: clarify --add and --get-color

Junio C Hamano (2):
  Start 1.6.3.1 maintenance series.
  archive-tar.c: squelch a type mismatch warning


* The 'master' branch has these since v1.6.3, in addition to the above.

Jakub Narebski (1):
  gitweb: Remove function prototypes (cleanup)

Junio C Hamano (1):
  Start 1.6.4 development

Sitaram Chamarty (1):
  allow -t abbreviation for --track in git branch
