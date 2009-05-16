From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC PATCH] builtin-log: Add options to --coverletter
Date: Fri, 15 May 2009 19:32:14 -0700
Message-ID: <7vy6sxrd5d.fsf@alter.siamese.dyndns.org>
References: <1242349041.646.8.camel@Joe-Laptop.home>
	<7v63g2tewu.fsf@alter.siamese.dyndns.org>
	<1242418762.3373.90.camel@Joe-Laptop.home>
	<7vljoyrq4z.fsf@alter.siamese.dyndns.org>
	<1242434796.4070.2.camel@Joe-Laptop.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Joe Perches <joe@perches.com>
X-From: git-owner@vger.kernel.org Sat May 16 04:32:22 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M59hG-0005gv-52
	for gcvg-git-2@gmane.org; Sat, 16 May 2009 04:32:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755113AbZEPCcO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 15 May 2009 22:32:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754904AbZEPCcO
	(ORCPT <rfc822;git-outgoing>); Fri, 15 May 2009 22:32:14 -0400
Received: from fed1rmmtao103.cox.net ([68.230.241.43]:49503 "EHLO
	fed1rmmtao103.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754238AbZEPCcO (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 15 May 2009 22:32:14 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao103.cox.net
          (InterMail vM.7.08.02.01 201-2186-121-102-20070209) with ESMTP
          id <20090516023214.PVFI2915.fed1rmmtao103.cox.net@fed1rmimpo02.cox.net>;
          Fri, 15 May 2009 22:32:14 -0400
Received: from localhost ([68.225.240.211])
	by fed1rmimpo02.cox.net with bizsmtp
	id s2YE1b00K4aMwMQ042YEM9; Fri, 15 May 2009 22:32:15 -0400
X-Authority-Analysis: v=1.0 c=1 a=80QVIHGmj5cA:10 a=52mTYfW24d0A:10
 a=IJv9LcIfAAAA:8 a=Y9bjvd2maTzQltTvYIcA:9 a=wnYyygzdTt2PgjjGT8P-8FKwYS4A:4
 a=K6kUPx8HyhEA:10
X-CM-Score: 0.00
In-Reply-To: <1242434796.4070.2.camel@Joe-Laptop.home> (Joe Perches's message of "Fri\, 15 May 2009 17\:46\:36 -0700")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/119319>

Joe Perches <joe@perches.com> writes:

> Perhaps this?

Yup, but that comes after the --- we see below ;-).

> Signed-off-by: Joe Perches <joe@perches.com>
> ---

The patch looks good.
