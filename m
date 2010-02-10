From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [Announce] bup 0.09: git-based backup system for really huge datasets
Date: Wed, 10 Feb 2010 01:54:30 -0800 (PST)
Message-ID: <m3sk998lhq.fsf@localhost.localdomain>
References: <32541b131002091448o6f809322x1d86d2d7f74a80ed@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>
To: Avery Pennarun <apenwarr@gmail.com>
X-From: git-owner@vger.kernel.org Wed Feb 10 10:54:39 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Nf9HL-0005od-2S
	for gcvg-git-2@lo.gmane.org; Wed, 10 Feb 2010 10:54:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753772Ab0BJJye (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 10 Feb 2010 04:54:34 -0500
Received: from mail-fx0-f220.google.com ([209.85.220.220]:37031 "EHLO
	mail-fx0-f220.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752011Ab0BJJyc (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 10 Feb 2010 04:54:32 -0500
Received: by fxm20 with SMTP id 20so998392fxm.21
        for <git@vger.kernel.org>; Wed, 10 Feb 2010 01:54:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:received
         :x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type;
        bh=XyPT6opOWVZbZpfeC0nO3s/uEP/IqW8CEHsU3g55mMg=;
        b=xBSKehicxPxRdJvnEfsjf+xTKBBR8r0m5RkEa5qZ+z8bsH+nCWiEb2VVapJqp89s4q
         dMjrndgKunKhxSHbY48pm/60Uu62TcdYbIfx3nJ+Q83xR8XDTqHk/Kqfe1oRLBbQuHky
         RYyZDALlIahezxgqVxaTll1aBnVh+B4E/aU9c=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type;
        b=RmJ0rIs+Zjg6VysK9hCkZ7k9Ki/PODdNiryB4PYauups096+XFAz0C6f49sSIJV7Tf
         cOgLFBklaS2uw3SxdO4wNjPQYES+RqYHUzzhHr9+Fb7uNcTfQfZSbJ5LHzBBWKd5lAbv
         mSLSD0sxNzQ2JVYfF4eZ26K1EqKJDpS70DRqE=
Received: by 10.102.211.34 with SMTP id j34mr9611mug.5.1265795671235;
        Wed, 10 Feb 2010 01:54:31 -0800 (PST)
Received: from localhost.localdomain (abvh24.neoplus.adsl.tpnet.pl [83.8.205.24])
        by mx.google.com with ESMTPS id 25sm5694772mul.20.2010.02.10.01.54.30
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 10 Feb 2010 01:54:30 -0800 (PST)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id o1A9s3X6006806;
	Wed, 10 Feb 2010 10:54:13 +0100
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id o1A9rrXH006802;
	Wed, 10 Feb 2010 10:53:53 +0100
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@gmail.com using -f
In-Reply-To: <32541b131002091448o6f809322x1d86d2d7f74a80ed@mail.gmail.com>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/139502>

Avery Pennarun <apenwarr@gmail.com> writes:

> bup is a file backup tool based on the git packfile format.

[...]
> bup is still pretty experimental, but it's already a useful tool for
> backing up your files, even if those files include millions of files
> and hundreds of gigs of VM images.
> 
> You can find the source code (and README) at github:
> 
>     http://github.com/apenwarr/bup
> 
> To subscribe to the bup mailing list, send an email to:
> 
>     bup-list+subscribe@googlegroups.com
> 
> Looking forward to everyone's feedback.

Would you be adding short info about your project to
http://git.wiki.kernel.org/index.php/InterfacesFrontendsAndTools

-- 
Jakub Narebski
Poland
ShadeHawk on #git
