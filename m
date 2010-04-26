From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [GSoC update] Acceptance
Date: Mon, 26 Apr 2010 16:50:28 -0700 (PDT)
Message-ID: <m3wrvtdbac.fsf@localhost.localdomain>
References: <l2rf3271551004261232h1bab9f17vb9e971ef12ec1857@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>,
	Sverre Rabbelier <srabbelier@gmail.com>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Tue Apr 27 01:50:39 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O6Y4S-0002Jk-UE
	for gcvg-git-2@lo.gmane.org; Tue, 27 Apr 2010 01:50:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754589Ab0DZXub (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 26 Apr 2010 19:50:31 -0400
Received: from mail-bw0-f219.google.com ([209.85.218.219]:45354 "EHLO
	mail-bw0-f219.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753391Ab0DZXua (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 26 Apr 2010 19:50:30 -0400
Received: by bwz19 with SMTP id 19so44301bwz.21
        for <git@vger.kernel.org>; Mon, 26 Apr 2010 16:50:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:received
         :x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type;
        bh=RVQNHEkqo3JKAHGWrUehk+2hlKz73lPItkOcMHoaEJQ=;
        b=RnDh+wdRtBCe90Z4KbSg1RWqXte+N1rJQs/FR/nBCkAf2M0j1tzY2CCoSQF6KIVqhK
         LMADXfw+Jh58PKsmZ2nRx71mcJbQZtmHPkEsRzk6r6YDECn0o+PtuQxmU5QgldyEwEm6
         sxqn5wZhoPpD4MQ9jUHvB2ZoLIGTfQ+3gGWz8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type;
        b=JoUH75VT/NSOf2MLUojdKGH0FHA6KcVXpYDeDtun5kWsfxAt2BnYFVT0GrvjMcT+60
         1gdWN0redOjH1UTIjKm924+Ek0CUQcQy1m3qaA7TZ/fhKJ/U+QcreuXjsq2/mXRrqV8q
         d/dzId7C88VqAwfNQnXE91Ptp+c+kj/qQ3BiQ=
Received: by 10.102.15.13 with SMTP id 13mr2681742muo.91.1272325828910;
        Mon, 26 Apr 2010 16:50:28 -0700 (PDT)
Received: from localhost.localdomain (abwh49.neoplus.adsl.tpnet.pl [83.8.231.49])
        by mx.google.com with ESMTPS id j2sm19330900mue.53.2010.04.26.16.50.27
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 26 Apr 2010 16:50:28 -0700 (PDT)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id o3QNo0sw005399;
	Tue, 27 Apr 2010 01:50:09 +0200
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id o3QNnlu1005393;
	Tue, 27 Apr 2010 01:49:47 +0200
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@gmail.com using -f
In-Reply-To: <l2rf3271551004261232h1bab9f17vb9e971ef12ec1857@mail.gmail.com>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/145863>

Ramkumar Ramachandra <artagnon@gmail.com> writes:

> I'm happy to announce that the project proposal titled "git-remote-svn
> | Native SVN support in Git" has been accepted - Sverre and I will be
> working on it this summer. As promised, I will post non-patch emails
> relating to my GSoC progress (atleast) every week and prefix the
> subject with "[GSoC update]". I've been relatively silent on the list
> for the past 10 days or so, owing to the fact that I have ongoing
> examinations- I'll resume working next week. My time zone will also
> change as I'll be in Copenhagen for the period of my summer vacations
> (~2.5 months).

Thanks for announcement.

By the way, when https://git.wiki.kernel.org/index.php/SoC2010Projects
page gets created (see "Which Git projects got accepted in GSoC 2010?"
post), you would be able to post condensed progress reports there, for
example in the form of milestones completed and milestones left.  See
how it was done for 2007 -- 2009 GSoC.

Thanks in advance
-- 
Jakub Narebski
Poland
