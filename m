From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] t8005: use egrep when extended regular expressions are required
Date: Wed, 06 May 2009 11:48:46 -0700
Message-ID: <7vd4amukxd.fsf@alter.siamese.dyndns.org>
References: <oO0aWq8IlAMsKZ9ZA1BW41Q2yED3E3Gy0etERczi2cjwFaZDei2brNq_BxSt-DnUld4xgNrFZ64@cipher.nrlssc.navy.mil>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: gitster@pobox.com, pclouds@gmail.com, git@vger.kernel.org
To: Brandon Casey <casey@nrlssc.navy.mil>
X-From: git-owner@vger.kernel.org Wed May 06 20:48:57 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M1mAq-0004nx-OG
	for gcvg-git-2@gmane.org; Wed, 06 May 2009 20:48:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755690AbZEFSss (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 6 May 2009 14:48:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754390AbZEFSsr
	(ORCPT <rfc822;git-outgoing>); Wed, 6 May 2009 14:48:47 -0400
Received: from fed1rmmtao102.cox.net ([68.230.241.44]:59856 "EHLO
	fed1rmmtao102.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753778AbZEFSsq (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 6 May 2009 14:48:46 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao102.cox.net
          (InterMail vM.7.08.02.01 201-2186-121-102-20070209) with ESMTP
          id <20090506184847.FDZH20976.fed1rmmtao102.cox.net@fed1rmimpo02.cox.net>;
          Wed, 6 May 2009 14:48:47 -0400
Received: from localhost ([68.225.240.211])
	by fed1rmimpo02.cox.net with bizsmtp
	id oJom1b00F4aMwMQ04JomgT; Wed, 06 May 2009 14:48:46 -0400
X-Authority-Analysis: v=1.0 c=1 a=zls0kCKJkYQA:10 a=pOCrgjwckOEA:10
 a=OpicTgToztSBrTkzAUwA:9 a=8_ePjJ_b85FgyyHWzC2R26_6ejUA:4
X-CM-Score: 0.00
In-Reply-To: <oO0aWq8IlAMsKZ9ZA1BW41Q2yED3E3Gy0etERczi2cjwFaZDei2brNq_BxSt-DnUld4xgNrFZ64@cipher.nrlssc.navy.mil> (Brandon Casey's message of "Wed\,  6 May 2009 13\:31\:42 -0500")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/118371>

Brandon Casey <casey@nrlssc.navy.mil> writes:

> Not all versions of grep understand backslashed extended regular
> expressions.  Possibly only gnu grep does.

Thanks.
