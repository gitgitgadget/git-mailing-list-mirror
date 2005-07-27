From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] git-status-script was missed during the conversion from N -> A
Date: Wed, 27 Jul 2005 14:45:18 -0700
Message-ID: <7vhdefrki9.fsf@assigned-by-dhcp.cox.net>
References: <20050727083608.GF19290@mythryan2.michonline.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jul 27 23:56:21 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Dxtse-0001Fq-O9
	for gcvg-git@gmane.org; Wed, 27 Jul 2005 23:56:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261166AbVG0VqR (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 27 Jul 2005 17:46:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261160AbVG0VqG
	(ORCPT <rfc822;git-outgoing>); Wed, 27 Jul 2005 17:46:06 -0400
Received: from fed1rmmtao05.cox.net ([68.230.241.34]:8149 "EHLO
	fed1rmmtao05.cox.net") by vger.kernel.org with ESMTP
	id S261154AbVG0VpU (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Jul 2005 17:45:20 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao05.cox.net
          (InterMail vM.6.01.04.00 201-2131-118-20041027) with ESMTP
          id <20050727214511.INF8651.fed1rmmtao05.cox.net@assigned-by-dhcp.cox.net>;
          Wed, 27 Jul 2005 17:45:11 -0400
To: Ryan Anderson <ryan@michonline.com>
In-Reply-To: <20050727083608.GF19290@mythryan2.michonline.com> (Ryan Anderson's message of "Wed, 27 Jul 2005 04:36:08 -0400")
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Ryan Anderson <ryan@michonline.com> writes:

> git-status-script was missed during the conversion from "N" to "A" as
> the new-file marker flag.

Thanks.  Applied and pushed out.
