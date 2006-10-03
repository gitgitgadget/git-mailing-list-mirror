From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] gitweb: document webserver configuration for common gitweb/repo URLs.
Date: Tue, 03 Oct 2006 13:15:38 -0700
Message-ID: <7v1wppnok5.fsf@assigned-by-dhcp.cox.net>
References: <20061003080328.GI2871@admingilde.org>
	<E1GUkQe-0007qU-AN@home.chandlerfamily.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Oct 03 22:17:43 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GUqg4-0006rS-L7
	for gcvg-git@gmane.org; Tue, 03 Oct 2006 22:15:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964856AbWJCUPl (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 3 Oct 2006 16:15:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964868AbWJCUPl
	(ORCPT <rfc822;git-outgoing>); Tue, 3 Oct 2006 16:15:41 -0400
Received: from fed1rmmtao10.cox.net ([68.230.241.29]:11497 "EHLO
	fed1rmmtao10.cox.net") by vger.kernel.org with ESMTP
	id S964856AbWJCUPk (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 Oct 2006 16:15:40 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao10.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20061003201539.IGBF18985.fed1rmmtao10.cox.net@fed1rmimpo01.cox.net>;
          Tue, 3 Oct 2006 16:15:39 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id VwFZ1V00B1kojtg0000000
	Tue, 03 Oct 2006 16:15:33 -0400
To: "Alan Chandler" <alan@chandlerfamily.org.uk>
In-Reply-To: <E1GUkQe-0007qU-AN@home.chandlerfamily.org.uk> (Alan Chandler's
	message of "Tue, 03 Oct 2006 14:35:24 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/28296>

"Alan Chandler" <alan@chandlerfamily.org.uk> writes:

> Martin Waitz writes:
>
>> Add a small apache configuration which shows how to use apache
>> to put gitweb and GIT repositories at the same URL.
>
> It might be helpful to include
>
> SetEnv GITWEB_CONFIG /etc/gitweb.conf
>
> in that little apache snippet, to show how specify a config file for
> gitweb.

I agree.  Please make it so by sending in a one-liner patch with
sign-off so that we can get attribution right without minimum
fuss.
