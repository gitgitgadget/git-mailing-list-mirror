From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH 2nd try] Make git-fmt-merge-msg a builtin
Date: Tue, 04 Jul 2006 00:56:35 -0700
Message-ID: <7vk66tls5o.fsf@assigned-by-dhcp.cox.net>
References: <Pine.LNX.4.63.0607031717540.29667@wbgn013.biozentrum.uni-wuerzburg.de>
	<7vwtaunwj1.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.63.0607040948170.29667@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jul 04 09:57:29 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Fxflw-0005yu-3V
	for gcvg-git@gmane.org; Tue, 04 Jul 2006 09:56:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750799AbWGDH4h (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 4 Jul 2006 03:56:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750826AbWGDH4h
	(ORCPT <rfc822;git-outgoing>); Tue, 4 Jul 2006 03:56:37 -0400
Received: from fed1rmmtao07.cox.net ([68.230.241.32]:679 "EHLO
	fed1rmmtao07.cox.net") by vger.kernel.org with ESMTP
	id S1750799AbWGDH4g (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 4 Jul 2006 03:56:36 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao07.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060704075636.JILP11027.fed1rmmtao07.cox.net@assigned-by-dhcp.cox.net>;
          Tue, 4 Jul 2006 03:56:36 -0400
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
In-Reply-To: <Pine.LNX.4.63.0607040948170.29667@wbgn013.biozentrum.uni-wuerzburg.de>
	(Johannes Schindelin's message of "Tue, 4 Jul 2006 09:50:37 +0200
	(CEST)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/23267>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> I should have put PATH/RFC. I did not want to remove the script right 
> away, so people could compare outputs (like Martin did with 
> git-format-patch).

Well the stuff is quite straightforward and I think we could fix
it in-tree while in "next".

>> I think we should extend boolean to accept 'yes' and 'no',
>
> In that case, could we have "YesPlease", "oui", "si" and "da", too? ;-)

Hai?  Nah, that's too much.
