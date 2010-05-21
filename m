From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: gitblogger
Date: Fri, 21 May 2010 08:54:59 -0700 (PDT)
Message-ID: <m3zkztqmhb.fsf@localhost.localdomain>
References: <ht3reo$b6i$1@dough.gmane.org>
	<AANLkTilpaRyrIgHN5eK_jRFJoukOSYlyEMwU1-LdGT0K@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Andy Parkins <andyparkins@gmail.com>, git <git@vger.kernel.org>
To: Ping Yin <pkufranky@gmail.com>
X-From: git-owner@vger.kernel.org Fri May 21 17:55:14 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OFUZ5-0006VR-Tz
	for gcvg-git-2@lo.gmane.org; Fri, 21 May 2010 17:55:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758241Ab0EUPzF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 21 May 2010 11:55:05 -0400
Received: from mail-fx0-f46.google.com ([209.85.161.46]:60480 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753774Ab0EUPzD (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 21 May 2010 11:55:03 -0400
Received: by fxm5 with SMTP id 5so988058fxm.19
        for <git@vger.kernel.org>; Fri, 21 May 2010 08:55:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:received
         :x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type;
        bh=1iyAB7a9sNIM2Bz5pbB71e2NIk5bAJsPSYR3Z6kr4hs=;
        b=i9PU1JylgZw6wg0h2340b/00Zy2ZWWIxai77e8TOCZycZhT6h4KFfFHZLKeVVrYgge
         u1Hjz0z+3cmvwlfQpjVH/UsCt3lSypR8IP65YuBEkiR2lbtz1xoJCiRFoNLx6q11lUvV
         2WL9pzaYQuLmqbjlnUGSp7532NVzaMBsRDxDw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type;
        b=vu08mHbRBEvDqrlbqgh79Kz63c1FpFrLGlhpO+BdTSOSg4HJmGFWVmqxNqeicrI7iE
         jvOjn5UzkBqThL6xel8T0NDpEw057FhA60xeDbUd/dscGZbh2VB9i0fm3SgAINhhnLLk
         SEA+q7HlK6WOse+HExpTkTcW8Aha2+w5a4zkQ=
Received: by 10.223.26.130 with SMTP id e2mr1601713fac.101.1274457300423;
        Fri, 21 May 2010 08:55:00 -0700 (PDT)
Received: from localhost.localdomain (abvl111.neoplus.adsl.tpnet.pl [83.8.209.111])
        by mx.google.com with ESMTPS id 15sm5097212fad.10.2010.05.21.08.54.59
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 21 May 2010 08:54:59 -0700 (PDT)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id o4LFsZYO011035;
	Fri, 21 May 2010 17:54:40 +0200
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id o4LFsO68011030;
	Fri, 21 May 2010 17:54:24 +0200
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@gmail.com using -f
In-Reply-To: <AANLkTilpaRyrIgHN5eK_jRFJoukOSYlyEMwU1-LdGT0K@mail.gmail.com>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/147472>

Ping Yin <pkufranky@gmail.com> writes:
> On Fri, May 21, 2010 at 1:29 AM, Andy Parkins <andyparkins@gmail.com> wrote:
> >
> > http://gitorious.org/git_blogger
> >
> 
> You may want to have a look at toto ( http://github.com/cloudhead/toto )
> git + github + herokou + markdown + txt store

Could you please add information about those projects to Git Wiki:
http://git.wiki.kernel.org/index.php/InterfacesFrontendsAndTools

Thanks in advance
-- 
Jakub Narebski
Poland
ShadeHawk on #git
