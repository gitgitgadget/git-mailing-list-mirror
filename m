From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: Gitolite documentation mkd files??
Date: Sat, 12 Mar 2011 03:05:53 -0800 (PST)
Message-ID: <m3y64k61lt.fsf@localhost.localdomain>
References: <AANLkTimQOzw-TYPO9ue3D_a0J8toFQZR4GDgoc2n2iin@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Howard Miller <howard@e-learndesign.co.uk>
X-From: git-owner@vger.kernel.org Sat Mar 12 12:06:11 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PyMe7-0002CF-C5
	for gcvg-git-2@lo.gmane.org; Sat, 12 Mar 2011 12:06:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753446Ab1CLLGB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 12 Mar 2011 06:06:01 -0500
Received: from mail-bw0-f46.google.com ([209.85.214.46]:41758 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753302Ab1CLLGA (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 12 Mar 2011 06:06:00 -0500
Received: by bwz15 with SMTP id 15so3311879bwz.19
        for <git@vger.kernel.org>; Sat, 12 Mar 2011 03:05:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:x-authentication-warning:to:cc:subject
         :references:from:date:in-reply-to:message-id:lines:user-agent
         :mime-version:content-type;
        bh=h50mTjppYbFdFcgLL0+p+zoFWwYdUbZ+yEWdWfhhwtU=;
        b=wgnrxQ8m6Bi7ZTSL52i91vw8qaLmAyqmtbMOHPSLAp6s09Iv0TGL6zBfi0vuIYvnDW
         xhH5/cPn4JY7zVFhHrjtm6SPU+4OTw+FGstp39TwcaaGUClZnXvXDwu8XzAuK9gvNoqP
         VBX+MR0pRpMHIqupiXMmuNW266viU224Bo60E=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type;
        b=Xn46OG+jv9idhLKT4BbyQncqr2qXAThF+01LHYKMPPPHKcJbB3dcJnXMrxh1xntYv0
         9GIhsFBDt5eK5XbjrzBTcbaD9EDdXYcFPJc8e8UBy7e9oD1K/MSxbOipHZh+CmniSaaa
         F8a5S4fgplTfZe14bs0SLMlE7UndFptoBFXGk=
Received: by 10.204.154.199 with SMTP id p7mr8570275bkw.114.1299927954667;
        Sat, 12 Mar 2011 03:05:54 -0800 (PST)
Received: from localhost.localdomain (aeho106.neoplus.adsl.tpnet.pl [79.186.196.106])
        by mx.google.com with ESMTPS id k5sm1913200bku.4.2011.03.12.03.05.52
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sat, 12 Mar 2011 03:05:53 -0800 (PST)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id p2CB5Jkd025628;
	Sat, 12 Mar 2011 12:05:29 +0100
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id p2CB53nu025621;
	Sat, 12 Mar 2011 12:05:03 +0100
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@gmail.com using -f
In-Reply-To: <AANLkTimQOzw-TYPO9ue3D_a0J8toFQZR4GDgoc2n2iin@mail.gmail.com>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/168940>

Howard Miller <howard@e-learndesign.co.uk> writes:

> I'm sorry if this is the wrong place to ask...
> 
> What's the story with '.mkd' files in which the docs are written for
> Gitolite? I would normally just check Google, but that doesn't seem to
> have heard of them either. What is there that reads them properly?
> It's only a minor inconvenience but I'm really just interested to
> know.

Those are files in Markdown[1] format, a lightweight document markup
language.  GitHub renders it to HTML automatically.  It is supposed to
be readable also in un-formatted form.

[1]: http://en.wikipedia.org/wiki/Markdown

-- 
Jakub Narebski
Poland
ShadeHawk on #git
