From: Junio C Hamano <junkio@cox.net>
Subject: Re: Fix: remove generated template files
Date: Fri, 26 Aug 2005 11:52:31 -0700
Message-ID: <7vll2obkeo.fsf@assigned-by-dhcp.cox.net>
References: <20050826182624.86421.qmail@web26306.mail.ukl.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Aug 26 20:52:46 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1E8jJk-0007SG-6N
	for gcvg-git@gmane.org; Fri, 26 Aug 2005 20:52:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030191AbVHZSwd (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 26 Aug 2005 14:52:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030190AbVHZSwd
	(ORCPT <rfc822;git-outgoing>); Fri, 26 Aug 2005 14:52:33 -0400
Received: from fed1rmmtao11.cox.net ([68.230.241.28]:22250 "EHLO
	fed1rmmtao11.cox.net") by vger.kernel.org with ESMTP
	id S1030188AbVHZSwc (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 26 Aug 2005 14:52:32 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao11.cox.net
          (InterMail vM.6.01.04.00 201-2131-118-20041027) with ESMTP
          id <20050826185232.OJXT12158.fed1rmmtao11.cox.net@assigned-by-dhcp.cox.net>;
          Fri, 26 Aug 2005 14:52:32 -0400
To: Marco Costalba <mcostalba@yahoo.it>
In-Reply-To: <20050826182624.86421.qmail@web26306.mail.ukl.yahoo.com> (Marco
	Costalba's message of "Fri, 26 Aug 2005 11:26:24 -0700 (PDT)")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/7822>

Marco Costalba <mcostalba@yahoo.it> writes:

> 01168c6044e7ebb570e851b4707b4fe0c7f40c15
> diff --git a/templates/blt/description b/templates/blt/description

Could I please see output of the following command in your
repository?

  $ git whatchanged 01168c6044e7ebb570e851b4707b4fe0c7f40c15 templates/
