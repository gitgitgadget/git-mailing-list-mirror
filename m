From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: Git weekly links: 2008-51
Date: Sat, 20 Dec 2008 11:50:25 -0800 (PST)
Message-ID: <m3ej02d3tq.fsf@localhost.localdomain>
References: <94a0d4530812200416m1caa96f2je2bf478f65bd7d12@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "git list" <git@vger.kernel.org>
To: "Felipe Contreras" <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Sat Dec 20 20:52:44 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LE7sS-0004pR-4e
	for gcvg-git-2@gmane.org; Sat, 20 Dec 2008 20:52:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753046AbYLTTua (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 20 Dec 2008 14:50:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752775AbYLTTu3
	(ORCPT <rfc822;git-outgoing>); Sat, 20 Dec 2008 14:50:29 -0500
Received: from ug-out-1314.google.com ([66.249.92.170]:31244 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752735AbYLTTu3 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 20 Dec 2008 14:50:29 -0500
Received: by ug-out-1314.google.com with SMTP id 39so635627ugf.37
        for <git@vger.kernel.org>; Sat, 20 Dec 2008 11:50:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:received
         :x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type;
        bh=2NlW+UtvHD1J6WfkYdUc7P1P+Q5ypSl21zul16+hfmM=;
        b=R4wI10ksrdp9hDu7NIzB1xVGZ72ABXthCtPF4JekDee6lyf2QMYtNFVld9A5m+bRQQ
         /zQqAfWFTisynFPFe4EOLd9JE8Vbu8KttW7EkQ3vosg5/3AxPLP7+rJN8n1xE16zDMR3
         bhMXri6zOI2x22pwZ0LyUmNlEIO/Io73ypsFE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type;
        b=x5Co1a+zJpQkS8AaE/ElotXTnbRKx0pGLalph4PpzmeC3M6iM5F9LIL3mkr+uL+zVV
         a7LjBp1bV9+PEHvpGKwV8QYwIzUZWaRUQ1+kPtK4HnXGGR4HqvYL9SYNQ1DhyZd8x0L6
         wJ20kFFw1X/BPYVfbgY0eSRyPZ75uB2pW605g=
Received: by 10.67.92.10 with SMTP id u10mr5443525ugl.21.1229802626183;
        Sat, 20 Dec 2008 11:50:26 -0800 (PST)
Received: from localhost.localdomain (abwp146.neoplus.adsl.tpnet.pl [83.8.239.146])
        by mx.google.com with ESMTPS id 20sm5245266uga.49.2008.12.20.11.50.24
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sat, 20 Dec 2008 11:50:25 -0800 (PST)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id mBKJo4ku011162;
	Sat, 20 Dec 2008 20:50:15 +0100
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id mBKJnrwg011156;
	Sat, 20 Dec 2008 20:49:53 +0100
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@gmail.com using -f
In-Reply-To: <94a0d4530812200416m1caa96f2je2bf478f65bd7d12@mail.gmail.com>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/103655>

"Felipe Contreras" <felipe.contreras@gmail.com> writes:

> This week tortoisegit stole the spotlight. Maybe there weren't many
> other links, or maybe I failed to notice them. Also, many people liked
> the comment of Linus Torvalds regarding C++ in git.
> 
> blog version:
> http://gitlog.wordpress.com/2008/12/20/git-weekly-links-2008-51/
> 
> == Articles ==
>
> Re: [RFC] Convert builin-mailinfo.c to use The Better String Library.
> Linus Torvalds creates some buzz
> http://lwn.net/Articles/249460/

A not countered counter:
C++ is a horrible language
http://skepticalmethodologist.wordpress.com/2008/12/17/c-is-a-horrible-language/
 
> == General links ==
> 
> tortoisegit
> http://code.google.com/p/tortoisegit/

What about "Git Extensions":
https://sourceforge.net/projects/gitextensions/
http://github.com/spdr870/gitextensions/

And "TortoiseGit Challenge":
http://github.com/blog/256-tortoisegit-challenge

-- 
Jakub Narebski
Poland
ShadeHawk on #git
