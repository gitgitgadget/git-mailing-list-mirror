From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: git top links: 2010-7
Date: Sun, 18 Jul 2010 06:23:13 -0700 (PDT)
Message-ID: <m3eif0ncva.fsf@localhost.localdomain>
References: <AANLkTilmTwl9RaX31MDmVY3YCeATg5RKF3RQbNqb3Soq@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Sun Jul 18 15:23:28 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OaTq4-0001Tc-Au
	for gcvg-git-2@lo.gmane.org; Sun, 18 Jul 2010 15:23:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754928Ab0GRNXP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 18 Jul 2010 09:23:15 -0400
Received: from mail-bw0-f46.google.com ([209.85.214.46]:51007 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754845Ab0GRNXP (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 18 Jul 2010 09:23:15 -0400
Received: by bwz1 with SMTP id 1so1871021bwz.19
        for <git@vger.kernel.org>; Sun, 18 Jul 2010 06:23:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:received
         :x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type;
        bh=8vZvGk+bXeoU4v5mvJG832rhqnuSz/llPZ92rczJwYo=;
        b=FeJSUNxhNQpuLN5mJxZYaNKR9Ck6vzGOvkXg5zpBPGiqeWRvFTsUlXfSIwJGEGga8C
         TbZPs7Tc28JZc8eT25vS4GtU3Mc4Xn+Zzms5csTeSyHfsqorRMLQlR8ezbEyvxCp3GCV
         62P7n60BXTgPesrIaS41XkoMkgHV2uaw4aJrw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type;
        b=lJyQZatGE+VfbF4S+GhLjDOEye+3peJ6oAuqe/eLVvcOKicBrnKBiLUY+MPLEp9nUj
         QLkPY5KVyBVaxilPnYfbxMrDSatZkYL9FISjewrZMg1o+co8dPDArCZ3mRrjpNAb5fqC
         SNo/QEYwCAbx58go1IwtVBvkiYnMUpqKsErqQ=
Received: by 10.204.10.140 with SMTP id p12mr2631125bkp.58.1279459393554;
        Sun, 18 Jul 2010 06:23:13 -0700 (PDT)
Received: from localhost.localdomain (abwa30.neoplus.adsl.tpnet.pl [83.8.224.30])
        by mx.google.com with ESMTPS id y2sm20780855bkx.20.2010.07.18.06.23.12
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 18 Jul 2010 06:23:13 -0700 (PDT)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id o6IDMkS7017677;
	Sun, 18 Jul 2010 15:22:57 +0200
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id o6IDMY5X017659;
	Sun, 18 Jul 2010 15:22:34 +0200
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@gmail.com using -f
In-Reply-To: <AANLkTilmTwl9RaX31MDmVY3YCeATg5RKF3RQbNqb3Soq@mail.gmail.com>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/151209>

Felipe Contreras <felipe.contreras@gmail.com> writes:

> 6. Distributed Version Control is here to stay, baby (14)
> A story of why Stack Overflow's podcast regarding DVCS was plain wrong
> http://www.joelonsoftware.com/items/2010/03/17.html

And if you read this blog post carefully, you would see that Joel
still doesn't f***ing get it.

> 9. Git for the nervous developer (10)
> Explaining git from a convert
> http://beust.com/weblog/2010/04/06/git-for-the-nervous-developer/

This quote from abovementioned blog is especially apt

 "Here is an analogy that might help, though: to me, learning Git is
  very similar to learning a foreign language. Natural languages are
  notoriously hard to learn for adults because their organic growth
  has resulted in all kinds of inconsistencies and oddities. At the
  end of the day, the only way to learn a foreign language is to
  memorize, memorize and memorize. As years go by, practice make
  memory regurgitation more automatic and the use of that language
  requires less and less conscious effort, but the learning curve is
  something that just can't be avoided."

The Git UI was result of organic growth.  It is not as much as it was
designed, rather than "happened".

-- 
Jakub Narebski
Poland
ShadeHawk on #git
