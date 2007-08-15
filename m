From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Add read_cache to builtin-check-attr
Date: Tue, 14 Aug 2007 22:45:57 -0700
Message-ID: <7veji5jqp6.fsf@assigned-by-dhcp.cox.net>
References: <11870975181798-git-send-email-bdowning@lavos.net>
	<7vhcn2c673.fsf@assigned-by-dhcp.cox.net>
	<20070814184541.GL21692@lavos.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Marius Storm-Olsen <marius@trolltech.com>,
	Steffen Prohaska <prohaska@zib.de>, dmitry.kakurin@gmail.com,
	git@vger.kernel.org
To: bdowning@lavos.net (Brian Downing)
X-From: git-owner@vger.kernel.org Wed Aug 15 07:46:06 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1ILBhl-0006UG-By
	for gcvg-git@gmane.org; Wed, 15 Aug 2007 07:46:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751900AbXHOFqA (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 15 Aug 2007 01:46:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751879AbXHOFp7
	(ORCPT <rfc822;git-outgoing>); Wed, 15 Aug 2007 01:45:59 -0400
Received: from fed1rmmtao102.cox.net ([68.230.241.44]:55065 "EHLO
	fed1rmmtao102.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751814AbXHOFp7 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 15 Aug 2007 01:45:59 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao102.cox.net
          (InterMail vM.7.08.02.01 201-2186-121-102-20070209) with ESMTP
          id <20070815054557.RAHB21830.fed1rmmtao102.cox.net@fed1rmimpo02.cox.net>;
          Wed, 15 Aug 2007 01:45:57 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id c5lx1X00A1kojtg0000000; Wed, 15 Aug 2007 01:45:58 -0400
In-Reply-To: <20070814184541.GL21692@lavos.net> (Brian Downing's message of
	"Tue, 14 Aug 2007 13:45:41 -0500")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/55881>

Ah, silly me.  The patch was to builtin-check-attr.  I somehow
thought it was to attr.c::git_checkattr().

Thanks, will apply.
