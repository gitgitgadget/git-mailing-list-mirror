From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 00/18] http*: refactor (v3)
Date: Sun, 24 May 2009 13:43:16 -0700
Message-ID: <7veiueut97.fsf@alter.siamese.dyndns.org>
References: <20090524222101.3e6f0496.rctay89@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Mike Hommey <mh@glandium.org>
To: Tay Ray Chuan <rctay89@gmail.com>
X-From: git-owner@vger.kernel.org Sun May 24 23:14:51 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M8L1o-0004lT-76
	for gcvg-git-2@gmane.org; Sun, 24 May 2009 23:14:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752162AbZEXVOU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 24 May 2009 17:14:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751972AbZEXVOS
	(ORCPT <rfc822;git-outgoing>); Sun, 24 May 2009 17:14:18 -0400
Received: from fed1rmmtai106.cox.net ([68.230.241.54]:56454 "EHLO
	fed1rmmtai106.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751691AbZEXVOS (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 24 May 2009 17:14:18 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao103.cox.net
          (InterMail vM.7.08.02.01 201-2186-121-102-20070209) with ESMTP
          id <20090524204317.JTWD2915.fed1rmmtao103.cox.net@fed1rmimpo02.cox.net>;
          Sun, 24 May 2009 16:43:17 -0400
Received: from localhost ([68.225.240.211])
	by fed1rmimpo02.cox.net with bizsmtp
	id vYjH1b0014aMwMQ04YjHDv; Sun, 24 May 2009 16:43:17 -0400
X-Authority-Analysis: v=1.0 c=1 a=qwdnp4Nz6bEA:10 a=7Sgdii_ML3EA:10
 a=pGLkceISAAAA:8 a=cebhVQIampwH_Az88YEA:9 a=ztvrpP2j1aEOQwOffoffBzy0ewMA:4
 a=MSl-tDqOz04A:10
X-CM-Score: 0.00
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/119862>

Tay Ray Chuan <rctay89@gmail.com> writes:

> Junio, I've reworked the patches after "http-push: fix missing "#ifdef
> USE_CURL_MULTI" around "is_running_queue" in rc/http-push. (I thought
> resending everything would clutter things up, but I could for your
> convenience if you want me to.)

Sending replacements like this while the series is only in 'pu' is
perfectly fine as long as what patch I have in 'pu' are being replaced.  I
can just drop everything between rc/http-push~11 to its tip and apply the
new series.

Thanks.
