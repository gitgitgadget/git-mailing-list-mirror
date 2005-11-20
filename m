From: Krzysztof Halasa <khc@pm.waw.pl>
Subject: Re: [PATCH] Support username and password inside URL
Date: Sun, 20 Nov 2005 21:46:59 +0100
Message-ID: <m3br0fujwc.fsf@defiant.localdomain>
References: <87u0e71zpx.fsf@litku.valo.iki.fi>
	<873blriqh0.fsf@litku.valo.iki.fi>
	<7vwtj3xe72.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Nov 20 21:47:32 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Edw5a-0003WF-OI
	for gcvg-git@gmane.org; Sun, 20 Nov 2005 21:47:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932082AbVKTUrD (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 20 Nov 2005 15:47:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932080AbVKTUrD
	(ORCPT <rfc822;git-outgoing>); Sun, 20 Nov 2005 15:47:03 -0500
Received: from khc.piap.pl ([195.187.100.11]:32516 "EHLO khc.piap.pl")
	by vger.kernel.org with ESMTP id S932085AbVKTUrB (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 20 Nov 2005 15:47:01 -0500
Received: by khc.piap.pl (Postfix, from userid 500)
	id 298A0108FC; Sun, 20 Nov 2005 21:47:00 +0100 (CET)
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7vwtj3xe72.fsf@assigned-by-dhcp.cox.net> (Junio C. Hamano's
 message of "Sun, 20 Nov 2005 12:21:53 -0800")
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/12399>

Junio C Hamano <junkio@cox.net> writes:

> It is handy to have weak "authentication" in some situations.  I
> am not ashamed to admit that I've used security-by-obscurity
> myself, when I sent an email to a friend, saying:
>
>         Hi, I have some pictures I took during our last trip
>         together, but due to their size I am not attaching them
>         to this e-mail.  Please pick them up at:
>
> 	        http://members.cox.net/junkio/r0ZIEF/5S54m/

If the above is security by obscurity then any password scheme is, too.
After all you're obscuring the password, right?
Well, private key and its password can be obscure as well. :-)


A common definition says that security by obscurity is using a hidden
algorithm and not a shared or private secret.
-- 
Krzysztof Halasa
