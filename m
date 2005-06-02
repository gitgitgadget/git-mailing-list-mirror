From: Radoslaw Szkodzinski <astralstorm@gorzow.mm.pl>
Subject: Re: Problem with cogito and Linux tree tags
Date: Thu, 02 Jun 2005 22:01:21 +0200
Message-ID: <429F6591.8080005@gorzow.mm.pl>
References: <429F5FA5.2030306@gorzow.mm.pl> <429F6270.50009@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-2
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jun 02 21:59:26 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Ddvq5-0005e8-Fl
	for gcvg-git@gmane.org; Thu, 02 Jun 2005 21:58:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261297AbVFBUBi (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 2 Jun 2005 16:01:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261313AbVFBUBe
	(ORCPT <rfc822;git-outgoing>); Thu, 2 Jun 2005 16:01:34 -0400
Received: from goliat.kalisz.mm.pl ([217.96.42.226]:28044 "EHLO kalisz.mm.pl")
	by vger.kernel.org with ESMTP id S261297AbVFBUBS (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 2 Jun 2005 16:01:18 -0400
Received: (qmail 18845 invoked from network); 2 Jun 2005 20:01:08 -0000
Received: from unknown (HELO zen.uplink) (astralstorm@[81.190.161.223])
          (envelope-sender <astralstorm@gorzow.mm.pl>)
          by 0 (qmail-ldap-1.03) with SMTP
          for <holmsand@gmail.com>; 2 Jun 2005 20:01:08 -0000
Received: from [127.0.0.1] (localhost [127.0.0.1])
	by zen.uplink (Postfix) with ESMTP id 2562358389F;
	Thu,  2 Jun 2005 22:01:21 +0200 (CEST)
User-Agent: Mozilla Thunderbird 1.0.2 (X11/20050425)
X-Accept-Language: en-us, en
To: Dan Holmsand <holmsand@gmail.com>
In-Reply-To: <429F6270.50009@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Dan Holmsand wrote:

>
> Radoslaw Szkodzinski wrote:
>  The v2.6.12-rc5 tag hash isn't a tree or commit hash, it is unusable.
>
>> I don't know what causes that...
>
>
> It's a tag object. If you cg-pull via http, you won't get any of
> those, though.
>
I thought it was one of these. Seems cogito can't handle them yet.

> Try rsync instead:
>
Guess what, I did it by rsync.

AstralStorm
