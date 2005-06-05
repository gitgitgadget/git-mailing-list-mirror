From: Radoslaw Szkodzinski <astralstorm@gorzow.mm.pl>
Subject: Re: cg-init bug
Date: Sun, 05 Jun 2005 19:59:11 +0200
Message-ID: <42A33D6F.8060003@gorzow.mm.pl>
References: <20050605153053.GA6890@tumblerings.org> <42A323F4.2010109@gorzow.mm.pl> <20050605162739.GB15291@tumblerings.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: pasky@ucw.cz, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jun 05 19:56:07 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DezLn-0005RY-8e
	for gcvg-git@gmane.org; Sun, 05 Jun 2005 19:55:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261594AbVFER7Y (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 5 Jun 2005 13:59:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261599AbVFER7Y
	(ORCPT <rfc822;git-outgoing>); Sun, 5 Jun 2005 13:59:24 -0400
Received: from goliat.kalisz.mm.pl ([217.96.42.226]:40875 "EHLO kalisz.mm.pl")
	by vger.kernel.org with ESMTP id S261594AbVFER7V (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 5 Jun 2005 13:59:21 -0400
Received: (qmail 19486 invoked from network); 5 Jun 2005 17:59:18 -0000
Received: from unknown (HELO zen.uplink) (astralstorm@[81.190.161.223])
          (envelope-sender <astralstorm@gorzow.mm.pl>)
          by 0 (qmail-ldap-1.03) with SMTP
          for <zbrown@tumblerings.org>; 5 Jun 2005 17:59:18 -0000
Received: from [127.0.0.1] (localhost [127.0.0.1])
	by zen.uplink (Postfix) with ESMTP id 136905C0998;
	Sun,  5 Jun 2005 19:59:12 +0200 (CEST)
User-Agent: Mozilla Thunderbird 1.0.2 (X11/20050425)
X-Accept-Language: en-us, en
To: Zack Brown <zbrown@tumblerings.org>
In-Reply-To: <20050605162739.GB15291@tumblerings.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Zack Brown wrote:

>But shouldn't cg-init take care of that for me automatically when I create the
>repo?
>
>Be well,
>Zack
>  
>
It should, it's most probably a bug...
Maybe you don't have read permission on some of the files?
I can't explain it in any other way.

AstralStorm
