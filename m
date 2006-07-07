From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] do not use locale specific strftime when preparing 2822 date
Date: Fri, 07 Jul 2006 12:08:22 -0700
Message-ID: <7vzmflw7vd.fsf@assigned-by-dhcp.cox.net>
References: <7vlkr7bvc1.fsf@assigned-by-dhcp.cox.net>
	<1152298675925-git-send-email-jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jul 07 21:08:30 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Fyvgi-00063s-FY
	for gcvg-git@gmane.org; Fri, 07 Jul 2006 21:08:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932231AbWGGTIZ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 7 Jul 2006 15:08:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932265AbWGGTIZ
	(ORCPT <rfc822;git-outgoing>); Fri, 7 Jul 2006 15:08:25 -0400
Received: from fed1rmmtao06.cox.net ([68.230.241.33]:13986 "EHLO
	fed1rmmtao06.cox.net") by vger.kernel.org with ESMTP
	id S932264AbWGGTIY (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 7 Jul 2006 15:08:24 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao06.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060707190823.FSTJ6235.fed1rmmtao06.cox.net@assigned-by-dhcp.cox.net>;
          Fri, 7 Jul 2006 15:08:23 -0400
To: Jakub Narebski <jnareb@gmail.com>
In-Reply-To: <1152298675925-git-send-email-jnareb@gmail.com> (Jakub Narebski's
	message of "Fri, 7 Jul 2006 20:57:55 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/23457>

Jakub Narebski <jnareb@gmail.com> writes:

> Signed-off-by: Junio C Hamano <junkio@cox.net>
> Acked-by: Jakub Narebski <jnareb@gmail.com>
> ---
> This patch is sent from patched version of git-send-email.perl
> with git tools 1.3.0. This patch is generated from current master
> after Junio's patch 
>   Message-ID: <7vd5cnv1v5.fsf@assigned-by-dhcp.cox.net>
> applied.

Good test.  Thanks.
