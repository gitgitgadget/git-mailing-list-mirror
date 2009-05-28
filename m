From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: git & bug tracking
Date: Thu, 28 May 2009 11:53:00 -0700 (PDT)
Message-ID: <m3prdtawl3.fsf@localhost.localdomain>
References: <F3DFF098-5198-4252-9F69-2805E5566155@btinternet.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-16be
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: =?utf-16be?b?/v8AfgA6ACcAJwAgMEIwijBMMGgwRjBUMFYwRDB+MFcA?=
	 =?utf-16be?b?MF8wAg==?= <j.chetwynd@btinternet.com>
X-From: git-owner@vger.kernel.org Thu May 28 20:53:15 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M9kj1-00047w-B5
	for gcvg-git-2@gmane.org; Thu, 28 May 2009 20:53:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760170AbZE1SxA convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 28 May 2009 14:53:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758715AbZE1SxA
	(ORCPT <rfc822;git-outgoing>); Thu, 28 May 2009 14:53:00 -0400
Received: from fg-out-1718.google.com ([72.14.220.156]:40136 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756842AbZE1Sw7 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 28 May 2009 14:52:59 -0400
Received: by fg-out-1718.google.com with SMTP id d23so1588649fga.17
        for <git@vger.kernel.org>; Thu, 28 May 2009 11:53:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:received
         :x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type
         :content-transfer-encoding;
        bh=u3iUGm8wHVdvcmk/quENM8Q9a6cahfW9TP+mET6sBxc=;
        b=cdXHpB4ZMTz4NjuKqdlq8ef6+3P5JUeQwqbRLP5T1U0dWgDQ0juSPozuVo8Jf3TOLn
         7hMky+kWIbqTiantzcMXAPxNYWQoqoXltvaJ0aJUuijDn51pqYjexjR5cqKdUc2KMLZz
         kaDCmwmiBOR6UY8akuxe4K4H73lDqt+sUIjp8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type
         :content-transfer-encoding;
        b=qsrZITbxDdVt9p7AqQPc5ISiLi9f33zZnA05uJrHL/6d971I4tsa3bz8RExhfHen6f
         IdOmsT4ewgwKMReiJgR9/1ExQoqP1k1nPXIUhs24Yzjsh9JrzedgurgQauXg2+XYZOG2
         QEZvVlsbKZ2lz/OxdRss/ToSNB2Na++Rt8l7I=
Received: by 10.86.86.10 with SMTP id j10mr1898899fgb.37.1243536780757;
        Thu, 28 May 2009 11:53:00 -0700 (PDT)
Received: from localhost.localdomain (abtj91.neoplus.adsl.tpnet.pl [83.8.155.91])
        by mx.google.com with ESMTPS id e20sm6011998fga.5.2009.05.28.11.52.59
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 28 May 2009 11:53:00 -0700 (PDT)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id n4SIqxHV001778;
	Thu, 28 May 2009 20:53:00 +0200
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id n4SIqvaj001771;
	Thu, 28 May 2009 20:52:57 +0200
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@gmail.com using -f
In-Reply-To: <F3DFF098-5198-4252-9F69-2805E5566155@btinternet.com>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/120209>

"~:'' =FE=FF0B0=8A0L0h0F0T0V0D0~0W0_0=02" <j.chetwynd@btinternet.com> w=
rites:

> git & bug tracking**
>=20
> what is the reason that bug tracking was not part* of the development
> and implementation of git?

[...]
> *the 'graphical' relationship between the git & bug tracking threads
> is of interest.
> beyond open source I'm interested in inviting naive users to
> participate in the development process, for instance by bug filing.
>=20
> **found this related threads
> http://thread.gmane.org/gmane.comp.version-control.git/110117

Because while I think that Git gets distributed version control right,
there is still debate about how to do distributed bugtracking?
Because of "one tool for one thing" or "do one thing, and do it well"?
Because you might not need bugtracker or code review tool: mailing
list is sometimes well enough?

Or I have misunderstood you because you didn't explain what you meant
clearly enough?

--=20
Jakub Narebski
Poland
ShadeHawk on #git
