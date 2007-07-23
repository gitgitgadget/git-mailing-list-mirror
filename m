From: Junio C Hamano <gitster@pobox.com>
Subject: Re: git-apply versus git-am
Date: Mon, 23 Jul 2007 01:54:51 -0700
Message-ID: <7vsl7flctg.fsf@assigned-by-dhcp.cox.net>
References: <a2e879e50707230054m60d45293ua1d57887367914c1@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: "Sean Kelley" <svk.sweng@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jul 23 10:55:33 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1ICthV-0000GT-3D
	for gcvg-git@gmane.org; Mon, 23 Jul 2007 10:55:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760921AbXGWIyz (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 23 Jul 2007 04:54:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1765968AbXGWIyy
	(ORCPT <rfc822;git-outgoing>); Mon, 23 Jul 2007 04:54:54 -0400
Received: from fed1rmmtao104.cox.net ([68.230.241.42]:45722 "EHLO
	fed1rmmtao104.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1765837AbXGWIyx (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 23 Jul 2007 04:54:53 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao104.cox.net
          (InterMail vM.7.08.02.01 201-2186-121-102-20070209) with ESMTP
          id <20070723085452.VMYD1393.fed1rmmtao104.cox.net@fed1rmimpo01.cox.net>;
          Mon, 23 Jul 2007 04:54:52 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id Swur1X0091kojtg0000000; Mon, 23 Jul 2007 04:54:52 -0400
In-Reply-To: <a2e879e50707230054m60d45293ua1d57887367914c1@mail.gmail.com>
	(Sean Kelley's message of "Mon, 23 Jul 2007 02:54:31 -0500")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/53414>

"Sean Kelley" <svk.sweng@gmail.com> writes:

> Why doesn't git-apply include an option for a signoff line like git-am?
>
> git-applymbox /tmp/mbox ~/.signoff
>
> Or am I missing something?  (most likely the case!)

applymbox is going away.
