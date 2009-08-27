From: Johan Herland <johan@herland.net>
Subject: Re: [PATCH jh/cvs-helper 0/2] Fix building when python is not available
Date: Thu, 27 Aug 2009 18:57:46 +0200
Message-ID: <200908271857.47035.johan@herland.net>
References: <Rxz2NOwzg1UZ0TgAtOhrA7e8wE02XwcSzNC9cc1EL_W_oN1BjtZn8ClmG5zKB_DKmTgVP0PlMYI@cipher.nrlssc.navy.mil>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=iso-8859-15
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org, gitster@pobox.com
To: Brandon Casey <casey@nrlssc.navy.mil>
X-From: git-owner@vger.kernel.org Thu Aug 27 18:57:59 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MgiIO-0001hL-NX
	for gcvg-git-2@lo.gmane.org; Thu, 27 Aug 2009 18:57:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750766AbZH0Q5r (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 27 Aug 2009 12:57:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750739AbZH0Q5r
	(ORCPT <rfc822;git-outgoing>); Thu, 27 Aug 2009 12:57:47 -0400
Received: from smtp.getmail.no ([84.208.15.66]:52020 "EHLO
	get-mta-out02.get.basefarm.net" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1750738AbZH0Q5q (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 27 Aug 2009 12:57:46 -0400
Received: from mx.getmail.no ([10.5.16.4]) by get-mta-out02.get.basefarm.net
 (Sun Java(tm) System Messaging Server 7.0-0.04 64bit (built Jun 20 2008))
 with ESMTP id <0KP100BTOOGBO970@get-mta-out02.get.basefarm.net> for
 git@vger.kernel.org; Thu, 27 Aug 2009 18:57:47 +0200 (MEST)
Received: from alpha.localnet ([84.215.102.95])
 by get-mta-in03.get.basefarm.net
 (Sun Java(tm) System Messaging Server 7.0-0.04 64bit (built Jun 20 2008))
 with ESMTP id <0KP100D7OOGBSE10@get-mta-in03.get.basefarm.net> for
 git@vger.kernel.org; Thu, 27 Aug 2009 18:57:47 +0200 (MEST)
X-PMX-Version: 5.5.5.374460, Antispam-Engine: 2.7.1.369594,
 Antispam-Data: 2009.8.27.164541
User-Agent: KMail/1.12.0 (Linux/2.6.30-ARCH; KDE/4.3.0; x86_64; ; )
In-reply-to: <Rxz2NOwzg1UZ0TgAtOhrA7e8wE02XwcSzNC9cc1EL_W_oN1BjtZn8ClmG5zKB_DKmTgVP0PlMYI@cipher.nrlssc.navy.mil>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/127178>

On Thursday 27 August 2009, Brandon Casey wrote:
> These two are built on top of pu.  I'm pretty sure jh/cvs-helper is
> the relevant branch.
>
> Brandon Casey (2):
>   Makefile: write NO_PYTHON setting to GIT-BUILD-OPTIONS file
>   t/test-lib.sh: don't perform python preparations when NO_PYTHON is
>     set

Thanks. Both are

Acked-by: Johan Herland <johan@herland.net>

I'll fold these into the next iteration of jh/cvs-helper.


Have fun! :)

...Johan


-- 
Johan Herland, <johan@herland.net>
www.herland.net
