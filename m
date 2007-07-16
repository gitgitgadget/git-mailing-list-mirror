From: Junio C Hamano <gitster@pobox.com>
Subject: Re: git proxy issue
Date: Sun, 15 Jul 2007 20:19:36 -0700
Message-ID: <7vk5t1avcn.fsf@assigned-by-dhcp.cox.net>
References: <6d6a94c50707151921h7f2a65fes65c94c3c1090937a@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: "Aubrey Li" <aubreylee@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jul 16 05:19:42 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IAH7d-0007D9-Cg
	for gcvg-git@gmane.org; Mon, 16 Jul 2007 05:19:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759234AbXGPDTi (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 15 Jul 2007 23:19:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759297AbXGPDTi
	(ORCPT <rfc822;git-outgoing>); Sun, 15 Jul 2007 23:19:38 -0400
Received: from fed1rmmtao102.cox.net ([68.230.241.44]:55284 "EHLO
	fed1rmmtao102.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758999AbXGPDTh (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 15 Jul 2007 23:19:37 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao102.cox.net
          (InterMail vM.7.08.02.01 201-2186-121-102-20070209) with ESMTP
          id <20070716031937.XIEX1428.fed1rmmtao102.cox.net@fed1rmimpo02.cox.net>;
          Sun, 15 Jul 2007 23:19:37 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id Q3Kc1X00K1kojtg0000000; Sun, 15 Jul 2007 23:19:37 -0400
In-Reply-To: <6d6a94c50707151921h7f2a65fes65c94c3c1090937a@mail.gmail.com>
	(Aubrey Li's message of "Mon, 16 Jul 2007 10:21:01 +0800")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/52626>

"Aubrey Li" <aubreylee@gmail.com> writes:

> From which release version git proxy is supported?

v0.99.9k (Nov 25 2005) is the first tagged release (the patch
itself was from Nov 4 2005).
