From: Junio C Hamano <gitster@pobox.com>
Subject: Re: most commonly used git commands?
Date: Mon, 25 Jun 2007 00:10:44 -0700
Message-ID: <7vlke833wr.fsf@assigned-by-dhcp.pobox.com>
References: <20070625064017.GA2839@mellanox.co.il>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: "Michael S. Tsirkin" <mst@dev.mellanox.co.il>
X-From: git-owner@vger.kernel.org Mon Jun 25 09:10:51 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I2iim-0007Yf-Kp
	for gcvg-git@gmane.org; Mon, 25 Jun 2007 09:10:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755270AbXFYHKq (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 25 Jun 2007 03:10:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754432AbXFYHKq
	(ORCPT <rfc822;git-outgoing>); Mon, 25 Jun 2007 03:10:46 -0400
Received: from fed1rmmtao107.cox.net ([68.230.241.39]:49546 "EHLO
	fed1rmmtao107.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753492AbXFYHKq (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 25 Jun 2007 03:10:46 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao107.cox.net
          (InterMail vM.7.08.02.01 201-2186-121-102-20070209) with ESMTP
          id <20070625071046.GUDB2558.fed1rmmtao107.cox.net@fed1rmimpo01.cox.net>;
          Mon, 25 Jun 2007 03:10:46 -0400
Received: from assigned-by-dhcp.pobox.com ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id FjAk1X0051kojtg0000000; Mon, 25 Jun 2007 03:10:45 -0400
In-Reply-To: <20070625064017.GA2839@mellanox.co.il> (Michael S. Tsirkin's
	message of "Mon, 25 Jun 2007 09:40:17 +0300")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/50868>

"Michael S. Tsirkin" <mst@dev.mellanox.co.il> writes:

> I did this by mistake:
>
> $git fet linux-2.6
> git: 'fet' is not a git-command
>
> The most commonly used git commands are:
>    add     Add file contents to the changeset to be committed next
>    apply   Apply a patch on a git index file and a working tree
> (use 'git help -a' to get a list of all installed git commands)
>
> why does git say that add and apply are most commonly used git commands?

Perhaps they are most commonly used by the person who came up
with that list first ;-)?

I think "add" deserves to be there, I am not sure "apply" is.
