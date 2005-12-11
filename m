From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH 21/25] git-send-email: Usage message clean-up.
Date: Sat, 10 Dec 2005 20:30:20 -0800
Message-ID: <7vslt0tfvn.fsf@assigned-by-dhcp.cox.net>
References: <1134243476675-git-send-email-freku045@student.liu.se>
	<11342434792231-git-send-email-freku045@student.liu.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Dec 11 05:32:07 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1ElIqv-000568-4R
	for gcvg-git@gmane.org; Sun, 11 Dec 2005 05:30:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932772AbVLKEaW (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 10 Dec 2005 23:30:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932794AbVLKEaW
	(ORCPT <rfc822;git-outgoing>); Sat, 10 Dec 2005 23:30:22 -0500
Received: from fed1rmmtao02.cox.net ([68.230.241.37]:50357 "EHLO
	fed1rmmtao02.cox.net") by vger.kernel.org with ESMTP
	id S932772AbVLKEaW (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 10 Dec 2005 23:30:22 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao02.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20051211042902.NCWY17006.fed1rmmtao02.cox.net@assigned-by-dhcp.cox.net>;
          Sat, 10 Dec 2005 23:29:02 -0500
To: freku045@student.liu.se
In-Reply-To: <11342434792231-git-send-email-freku045@student.liu.se>
	(freku045@student.liu.se's message of "Sat, 10 Dec 2005 20:37:59
	+0100")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/13484>

freku045@student.liu.se writes:

> +sub usage {
> +	print <<EOT;
> +$0 [options] <file | directory> [... file | directory ]

Not going to STDERR?
