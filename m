From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC PATCH] Documentation: teach stash/pop workflow instead of stash/apply
Date: Thu, 28 May 2009 22:37:18 -0700
Message-ID: <7v1vq8h3ld.fsf@alter.siamese.dyndns.org>
References: <20090515021105.GA19241@coredump.intra.peff.net>
	<ef178b42f4db36811e07f1bca4436ed79e550957.1243502202.git.trast@student.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>,
	Daniel Trstenjak <Daniel.Trstenjak@science-computing.de>,
	Junio C Hamano <gitster@pobox.com>, spearce@spearce.org,
	John Tapsell <johnflux@gmail.com>,
	Brian Gernhardt <benji@silverinsanity.com>,
	Nanako Shiraishi <nanako3@lavabit.com>
To: Thomas Rast <trast@student.ethz.ch>
X-From: git-owner@vger.kernel.org Fri May 29 07:37:34 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M9umb-0007j5-De
	for gcvg-git-2@gmane.org; Fri, 29 May 2009 07:37:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751866AbZE2FhT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 29 May 2009 01:37:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751646AbZE2FhS
	(ORCPT <rfc822;git-outgoing>); Fri, 29 May 2009 01:37:18 -0400
Received: from fed1rmmtao107.cox.net ([68.230.241.39]:49111 "EHLO
	fed1rmmtao107.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751611AbZE2FhS (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 29 May 2009 01:37:18 -0400
Received: from fed1rmimpo03.cox.net ([70.169.32.75])
          by fed1rmmtao107.cox.net
          (InterMail vM.7.08.02.01 201-2186-121-102-20070209) with ESMTP
          id <20090529053718.RBCP18948.fed1rmmtao107.cox.net@fed1rmimpo03.cox.net>;
          Fri, 29 May 2009 01:37:18 -0400
Received: from localhost ([68.225.240.211])
	by fed1rmimpo03.cox.net with bizsmtp
	id xHdK1b0024aMwMQ04HdKul; Fri, 29 May 2009 01:37:19 -0400
X-Authority-Analysis: v=1.0 c=1 a=5ZWt54eUod0A:10 a=uU9tPDm-GgoA:10
 a=FAujdpC6sBU6fYSFK-IA:9 a=03S-reDxWBWrNw8lhMygtywNkDkA:4
X-CM-Score: 0.00
In-Reply-To: <ef178b42f4db36811e07f1bca4436ed79e550957.1243502202.git.trast@student.ethz.ch> (Thomas Rast's message of "Thu\, 28 May 2009 11\:40\:15 +0200")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/120249>

FWIW, I think the change makes sense.
