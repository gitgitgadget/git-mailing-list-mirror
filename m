From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [ANNOUNCE] TFS2GIT. Script that will import Microsoft Team Foundation Server repositories in a Git repository.
Date: Tue, 21 Sep 2010 15:49:56 -0700 (PDT)
Message-ID: <m3iq1yk90b.fsf@localhost.localdomain>
References: <AANLkTinmhhrerxPJGU8b2iuGSNV-=vz-Y6fCvHJODXAs@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Wilbert van Dolleweerd <wilbert@arentheym.com>
X-From: git-owner@vger.kernel.org Wed Sep 22 00:50:14 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OyBfA-0005wr-9B
	for gcvg-git-2@lo.gmane.org; Wed, 22 Sep 2010 00:50:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752204Ab0IUWuF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 21 Sep 2010 18:50:05 -0400
Received: from mail-bw0-f46.google.com ([209.85.214.46]:49031 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751749Ab0IUWuD (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 21 Sep 2010 18:50:03 -0400
Received: by bwz11 with SMTP id 11so58647bwz.19
        for <git@vger.kernel.org>; Tue, 21 Sep 2010 15:50:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:received
         :x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type;
        bh=2ubgeqoHuvJhLimzRCOXWEGoOYXul83FTbTs9WYfD/k=;
        b=apz28634b4qkuE0WVATuuEyEd+j4oiZ6cVxKjoNWO/yrzQBZgNIp1LZAXdu2flWHRg
         jM829+9swgS/hKpSCu8QrsANOSTb98WXROpuL5X9EuFb/kT3eFhvnhPHvhkpU8ZGManw
         nLtswKV2fiEj4OizJc39fsqXKNoxph6xrWEMA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type;
        b=bExxjkntH/X9P/B6Bx3BtpwXQzH5xNfv2bvnUZ91ckdPgS7n1TMNN7AeS58j+nNR12
         MgdaCZ27uwkTVHwojQVr0e3MvQQ0EYbtLnQ4u7z277wNqwfewcY2f+B68hsXPhEU1kc7
         4EZ/IHgajMfL2kQoBo3t4QVceZ5h0A8hWpZr0=
Received: by 10.204.48.75 with SMTP id q11mr8601188bkf.0.1285109398145;
        Tue, 21 Sep 2010 15:49:58 -0700 (PDT)
Received: from localhost.localdomain (abvk112.neoplus.adsl.tpnet.pl [83.8.208.112])
        by mx.google.com with ESMTPS id f18sm8031370bkf.3.2010.09.21.15.49.55
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 21 Sep 2010 15:49:56 -0700 (PDT)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id o8LMnOnI032613;
	Wed, 22 Sep 2010 00:49:34 +0200
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id o8LMn8Pa032606;
	Wed, 22 Sep 2010 00:49:08 +0200
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@gmail.com using -f
In-Reply-To: <AANLkTinmhhrerxPJGU8b2iuGSNV-=vz-Y6fCvHJODXAs@mail.gmail.com>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/156767>

Wilbert van Dolleweerd <wilbert@arentheym.com> writes:

> Hello,
> 
> I had a personal itch to import Microsoft Team Foundation Server
> repositories into a Git repository. I wrote a small Powershell script
> and released this on Github at
> http://github.com/WilbertOnGithub/TFS2GIT
> 
> I also wrote a small article about its usage at
> http://walkingthestack.wordpress.com/2010/09/21/importing-a-tfs-repository-into-a-git-repository-using-powershell/

Could you add information about this script it in appropriate place on
Git Wiki: https://git.wiki.kernel.org/index.php/InterfacesFrontendsAndTools

Thanks in advance
-- 
Jakub Narebski
Poland
ShadeHawk on #git
