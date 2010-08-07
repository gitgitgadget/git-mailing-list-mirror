From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: [PATCH svnrdump-standalone] Sync with upstream
Date: Sat, 7 Aug 2010 08:17:05 +0530
Message-ID: <20100807024703.GB15410@kytes>
References: <1279064176-6645-1-git-send-email-artagnon@gmail.com>
 <7vsk3myuyo.fsf@alter.siamese.dyndns.org>
 <20100715105527.GC22574@debian>
 <20100806175709.GA2683@burratino>
 <20100807023026.GA3111@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Sat Aug 07 04:48:35 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OhZSc-0002dy-L6
	for gcvg-git-2@lo.gmane.org; Sat, 07 Aug 2010 04:48:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1762469Ab0HGCsa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 6 Aug 2010 22:48:30 -0400
Received: from mail-pz0-f46.google.com ([209.85.210.46]:54565 "EHLO
	mail-pz0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1762134Ab0HGCs2 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 6 Aug 2010 22:48:28 -0400
Received: by pzk26 with SMTP id 26so3078109pzk.19
        for <git@vger.kernel.org>; Fri, 06 Aug 2010 19:48:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=Fo66XtQEcY7jljwn1Q0HmLB5trWL9tG+UVCsb8VU0oM=;
        b=kdgQ6RdqPd3FnuG/pSpKajFP8aNO7+HHq7Wp3+nZUAgfvaB0hm8mAwd5Hx+Y19STvF
         isqCnBXtJ22IqwG8XeE+C0NpI16PuFolFQ3sCTb2YuFdlhOODbsC2PgSOMo5i6QYDLwe
         kqwdn3YiO9AqHzQ7hBqoE8EBVBzlwOegP9aB4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=kVcXkzGYUJ5nXrlxcBOSAVRvapKSolUFG7chD5lFmU1kEtCdM4euSKPKa3gJ9uAind
         xZwAiPEnJ+bZOLz3BOUlF7UxsBaAZUnowb6VSiyWO2b+QJS+BKdFGhbmP0VJwDQto4ze
         ICHIgbpBzrMYROQVxZGFvcW5Xpen4xm6HsTH8=
Received: by 10.114.124.18 with SMTP id w18mr14963521wac.6.1281149305833;
        Fri, 06 Aug 2010 19:48:25 -0700 (PDT)
Received: from kytes ([203.110.240.41])
        by mx.google.com with ESMTPS id s5sm4084953wak.12.2010.08.06.19.48.23
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 06 Aug 2010 19:48:24 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20100807023026.GA3111@burratino>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/152836>

Hi Jonathan,

Jonathan Nieder writes:
> Jonathan Nieder wrote:
> 
> > Caveats: Most load tests do not pass.
> 
> They pass now.  Thanks for the help!

:)

> You can
> 
>   git clone git://repo.or.cz/svnrdump/jrn.git
> 
> for the tree.  The todo branch documents how to revive the
> git-svn branches.

Thanks for this- I can easily maintain an out-of-trunk version that
compiles against 1.6 now. Much nicer than your massive patches :)

-- Ram
