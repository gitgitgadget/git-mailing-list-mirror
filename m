From: Junio C Hamano <junkio@cox.net>
Subject: Re: 0.99.9 on Saturday next week.
Date: Tue, 25 Oct 2005 10:02:58 -0700
Message-ID: <7virvlh6m5.fsf@assigned-by-dhcp.cox.net>
References: <7vvezpetpv.fsf@assigned-by-dhcp.cox.net>
	<tnx64rlrjux.fsf@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Oct 25 19:06:32 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EUSCW-00053h-VW
	for gcvg-git@gmane.org; Tue, 25 Oct 2005 19:03:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932210AbVJYRDA (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 25 Oct 2005 13:03:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932212AbVJYRDA
	(ORCPT <rfc822;git-outgoing>); Tue, 25 Oct 2005 13:03:00 -0400
Received: from fed1rmmtao06.cox.net ([68.230.241.33]:44529 "EHLO
	fed1rmmtao06.cox.net") by vger.kernel.org with ESMTP
	id S932210AbVJYRDA (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 25 Oct 2005 13:03:00 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao06.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20051025170217.ZXRI24014.fed1rmmtao06.cox.net@assigned-by-dhcp.cox.net>;
          Tue, 25 Oct 2005 13:02:17 -0400
To: Catalin Marinas <catalin.marinas@gmail.com>
In-Reply-To: <tnx64rlrjux.fsf@arm.com> (Catalin Marinas's message of "Tue, 25
	Oct 2005 11:06:46 +0100")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/10599>

Catalin Marinas <catalin.marinas@gmail.com> writes:

>>  - Configuration files (Linus).
>
> Since the configuration files use the .ini like syntax, is it OK for
> StGIT to use the same file, with an "[stgit]" section?

I think that is a reasonable thing to do.
