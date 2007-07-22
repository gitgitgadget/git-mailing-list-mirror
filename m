From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Avoid to duplicate commit message when is not encoded
Date: Sun, 22 Jul 2007 01:40:44 -0700
Message-ID: <7vd4yksuer.fsf@assigned-by-dhcp.cox.net>
References: <e5bfff550707220123g5826cbf5n3e2ff7256d9b5366@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Git Mailing List" <git@vger.kernel.org>
To: "Marco Costalba" <mcostalba@gmail.com>
X-From: git-owner@vger.kernel.org Sun Jul 22 10:40:54 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1ICWzj-0006AI-KU
	for gcvg-git@gmane.org; Sun, 22 Jul 2007 10:40:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755276AbXGVIkq (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 22 Jul 2007 04:40:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755412AbXGVIkq
	(ORCPT <rfc822;git-outgoing>); Sun, 22 Jul 2007 04:40:46 -0400
Received: from fed1rmmtao102.cox.net ([68.230.241.44]:44209 "EHLO
	fed1rmmtao102.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755107AbXGVIkp (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 22 Jul 2007 04:40:45 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao102.cox.net
          (InterMail vM.7.08.02.01 201-2186-121-102-20070209) with ESMTP
          id <20070722084045.HPIH1428.fed1rmmtao102.cox.net@fed1rmimpo01.cox.net>;
          Sun, 22 Jul 2007 04:40:45 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id SYgk1X00G1kojtg0000000; Sun, 22 Jul 2007 04:40:44 -0400
In-Reply-To: <e5bfff550707220123g5826cbf5n3e2ff7256d9b5366@mail.gmail.com>
	(Marco Costalba's message of "Sun, 22 Jul 2007 10:23:05 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/53235>

Thanks.
