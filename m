From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] git-svn: refuse to dcommit non-UTF-8 messages
Date: Fri, 29 May 2009 00:09:38 -0700
Message-ID: <7vskioe66l.fsf@alter.siamese.dyndns.org>
References: <op.uuljhmmg1e62zd@balu.cs.uni-paderborn.de>
	<20090528080706.GA9239@dcvr.yhbt.net>
	<20090528081804.GB9239@dcvr.yhbt.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, users@subversion.tigris.org,
	Matthias Andree <matthias.andree@gmx.de>
To: Eric Wong <normalperson@yhbt.net>
X-From: git-owner@vger.kernel.org Fri May 29 09:09:50 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M9wDs-00081A-QP
	for gcvg-git-2@gmane.org; Fri, 29 May 2009 09:09:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754024AbZE2HJi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 29 May 2009 03:09:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752021AbZE2HJh
	(ORCPT <rfc822;git-outgoing>); Fri, 29 May 2009 03:09:37 -0400
Received: from fed1rmmtao102.cox.net ([68.230.241.44]:35260 "EHLO
	fed1rmmtao102.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751866AbZE2HJh (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 29 May 2009 03:09:37 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao102.cox.net
          (InterMail vM.7.08.02.01 201-2186-121-102-20070209) with ESMTP
          id <20090529070939.HUPQ20976.fed1rmmtao102.cox.net@fed1rmimpo02.cox.net>;
          Fri, 29 May 2009 03:09:39 -0400
Received: from localhost ([68.225.240.211])
	by fed1rmimpo02.cox.net with bizsmtp
	id xK9e1b0064aMwMQ04K9eGg; Fri, 29 May 2009 03:09:38 -0400
X-Authority-Analysis: v=1.0 c=1 a=X5p2AuBCShgA:10 a=iP3C-SWiKv8A:10
 a=oqWz6O3WQgK43QLhCZkA:9 a=YJn36GQstMn5tgGN9KsQZb-lKF0A:4
X-CM-Score: 0.00
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/120251>

Thanks.
