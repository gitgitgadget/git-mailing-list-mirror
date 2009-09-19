From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: SmartGit, a new GUI front-end for Git
Date: Sat, 19 Sep 2009 01:54:56 -0700 (PDT)
Message-ID: <m3my4r2u1v.fsf@localhost.localdomain>
References: <4AB38D64.9010903@syntevo.com> <4AB48E25.8020504@syntevo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Thomas Singer <thomas.singer@syntevo.com>
X-From: git-owner@vger.kernel.org Sat Sep 19 11:02:49 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MovqD-0003az-Hn
	for gcvg-git-2@lo.gmane.org; Sat, 19 Sep 2009 11:02:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754860AbZISJCi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 19 Sep 2009 05:02:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753174AbZISJCh
	(ORCPT <rfc822;git-outgoing>); Sat, 19 Sep 2009 05:02:37 -0400
Received: from mail-bw0-f210.google.com ([209.85.218.210]:35726 "EHLO
	mail-bw0-f210.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752805AbZISJCg (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 19 Sep 2009 05:02:36 -0400
Received: by bwz6 with SMTP id 6so1119989bwz.37
        for <git@vger.kernel.org>; Sat, 19 Sep 2009 02:02:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:received
         :x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type;
        bh=KJOl8Uweh/o1xw5TSxPUB8KzVwA5a44jOb0yBvm6gos=;
        b=gnBIIgR/Q3ww3kwj3MIxZFR0PAGgsDP65Fjf0QSR0ZIVX6pa0L6MB1DD+dPx9uN5/M
         ZVW5MEYoDiXr1uIEf9qQOeSY+ktY2wPtG4qg1yrVpsKOaGfzFdWEIjs4UUXZksekxpsK
         g4h/uc7jeqMk5F4uaOfjJYvJdHzqNcWeU8368=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type;
        b=s8CN34P/+V6DSOoC2xu0PuHaif3WyAmfZTBeIYJES6+bpLwJYZlXPOyfoPueKOZS06
         +tUlLCmvKxNeREM5DdAtbHmAfHskCrrVkAQhbTM+OEb3ffRnqqJ+Jbe5Yw2snqx9Sj1y
         Luv8d5GCbOH9A377A2rzYppKwRUPi1i2R9uNQ=
Received: by 10.204.154.85 with SMTP id n21mr2210103bkw.171.1253350497460;
        Sat, 19 Sep 2009 01:54:57 -0700 (PDT)
Received: from localhost.localdomain (abwd54.neoplus.adsl.tpnet.pl [83.8.227.54])
        by mx.google.com with ESMTPS id 26sm2796438fks.31.2009.09.19.01.54.55
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sat, 19 Sep 2009 01:54:56 -0700 (PDT)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id n8J8sslT022677;
	Sat, 19 Sep 2009 10:54:54 +0200
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id n8J8sqOL022674;
	Sat, 19 Sep 2009 10:54:52 +0200
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@gmail.com using -f
In-Reply-To: <4AB48E25.8020504@syntevo.com>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/128822>

Thomas Singer <thomas.singer@syntevo.com> writes:

> We would like to announce a new milestone build of our Git client "SmartGit"
> (don't be offended by the name, it's historically based) which we feel is
> ready now for a broader audience. SmartGit is quite stable and we want to
> invite everyone who is interested in giving it a try:
> 
>  http://www.syntevo.com/smartgit/index.html
> 
> Please don't expect all Git features and options implemented. We have
> tried to first concentrate on the most important ones - from our rather
> novice Git perspective.
[...]

Could you please add information about this Git client (Git GUI?)
to the http://git.or.cz/gitwiki/InterfacesFrontendsAndTools wiki
page?  

Thanks in advance.

-- 
Jakub Narebski
Poland
ShadeHawk on #git
