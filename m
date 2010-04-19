From: Pavan Kumar Sunkara <pavan.sss1991@gmail.com>
Subject: Re: GSoC 2010: "Integrated Web Client for git" proposal
Date: Mon, 19 Apr 2010 05:57:33 -0700
Message-ID: <p2we72faaa81004190557t240823bcu63f95b0f8a885cbb@mail.gmail.com>
References: <201004180246.18263.jnareb@gmail.com>
	 <20100418021223.GP10939@machine.or.cz>
	 <n2le72faaa81004180152pb84cef2cn2a7eb95da64420b1@mail.gmail.com>
	 <20100418223120.GB3563@machine.or.cz>
	 <u2ve72faaa81004182346zdf4bd0b3m3341717b1555c0a9@mail.gmail.com>
	 <vpqeiicey0d.fsf@bauges.imag.fr>
	 <7vfx2rsy6y.fsf@alter.siamese.dyndns.org>
	 <v2me72faaa81004190038y4aeefa80g9f60bb3b1e795e4b@mail.gmail.com>
	 <20100419090734.GA10939@machine.or.cz>
	 <vpq8w8j1vb7.fsf@bauges.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Petr Baudis <pasky@suse.cz>, Junio C Hamano <gitster@pobox.com>,
	Jakub Narebski <jnareb@gmail.com>,
	Christian Couder <chriscool@tuxfamily.org>,
	git@vger.kernel.org, Sverre Rabbelier <srabbelier@gmail.com>,
	Shawn O Pearce <spearce@spearce.org>,
	Scott Chacon <schacon@gmail.com>, Sam Vilain <sam@vilain.net>
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Mon Apr 19 14:57:40 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O3qXk-00059b-0R
	for gcvg-git-2@lo.gmane.org; Mon, 19 Apr 2010 14:57:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754949Ab0DSM5g (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 19 Apr 2010 08:57:36 -0400
Received: from mail-yw0-f194.google.com ([209.85.211.194]:52537 "EHLO
	mail-yw0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754935Ab0DSM5e (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 19 Apr 2010 08:57:34 -0400
Received: by ywh32 with SMTP id 32so2711397ywh.33
        for <git@vger.kernel.org>; Mon, 19 Apr 2010 05:57:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:received:message-id:subject:from:to:cc:content-type;
        bh=X9UZ0dpOzCed2RL4DQY7fsPy2gL5zZap0I8cKh6XAGU=;
        b=tBl1DCw+079OuMGbzUbjNj0aLXhf+gtlCplIAnZAsRezd0wQBLNYdlrNTsJZGxfkJb
         be5pVf0snO1izDp65vPmq8mA/lERo8KJSqYOGorTqocHpQqexa0cuS97ud63ctXEdp84
         sK9nlU7N0/QUYdYOqn3GZdMeCVhqGU8ABzr+A=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=WL7IsiRYOGxy/SKZDx+y9tqIae+SRS9PdRGQjQvbJEkYKAadGCLDEiDWgTfhGAc/sW
         ninwtF2pxrt4+dUz1UAns4I1V4eySXZtkqiEMZowJkZPQ4lBJwREOK1sTvEvYcfDZ3UG
         slHHDIckVs4PrqpuIRI58inhfhsHbpJlCq1es=
Received: by 10.90.118.4 with HTTP; Mon, 19 Apr 2010 05:57:33 -0700 (PDT)
In-Reply-To: <vpq8w8j1vb7.fsf@bauges.imag.fr>
Received: by 10.91.18.28 with SMTP id v28mr2834627agi.94.1271681853687; Mon, 
	19 Apr 2010 05:57:33 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/145295>

All of us are supporting using GET parameters rather than sessions for
project name and others which is fine for me as the reasons are valid.
But I would like to develop sessions manager incase they want to use
authentication support.

What do you say ?

-pavan
