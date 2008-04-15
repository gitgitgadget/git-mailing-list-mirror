From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: RFC: Website redesign
Date: Tue, 15 Apr 2008 00:59:49 -0700 (PDT)
Message-ID: <m3mynvsg40.fsf@localhost.localdomain>
References: <3175605f-ff32-4fd6-bed3-7ae596ecbcde@q1g2000prf.googlegroups.com>
	<2c6b72b30804140656g14c24d8cwae016d62fe12f4a7@mail.gmail.com>
	<56e37551-4b8f-4164-a71d-79dba8635b7d@l28g2000prd.googlegroups.com>
	<96F7571C-1D9D-4F0A-99F1-A2307DAB0374@wincent.com>
	<bd6139dc0804141129h25c829e2i320f227594763d71@mail.gmail.com>
	<pan.2008.04.14.20.39.10@progsoc.org>
	<20080414213339.GB10300@dpotapov.dyndns.org>
	<pan.2008.04.15.03.25.00@progsoc.org>
	<8607f754-92c8-49ca-9bc9-11e58b66ef40@q1g2000prf.googlegroups.com>
	<acfbfe5b-f3a1-4c22-a873-ed329552d1bb@b5g2000pri.googlegroups.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Dill <sarpulhu@gmail.com>
X-From: git-owner@vger.kernel.org Tue Apr 15 10:01:28 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jlg6Z-0007qO-3j
	for gcvg-git-2@gmane.org; Tue, 15 Apr 2008 10:01:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752750AbYDOIAS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 15 Apr 2008 04:00:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756798AbYDOH76
	(ORCPT <rfc822;git-outgoing>); Tue, 15 Apr 2008 03:59:58 -0400
Received: from fg-out-1718.google.com ([72.14.220.158]:44513 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755217AbYDOH7y (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 15 Apr 2008 03:59:54 -0400
Received: by fg-out-1718.google.com with SMTP id l27so1901061fgb.17
        for <git@vger.kernel.org>; Tue, 15 Apr 2008 00:59:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:received:x-authentication-warning:to:cc:subject:references:from:in-reply-to:message-id:lines:user-agent:mime-version:content-type:date;
        bh=DEp3AqRYyG928awACQWzE5ebLtUTDucBME1JNjH5Sv4=;
        b=JmR1WhRcSOSjgAOQvq61orGSkp/A+asUjBLYGAYyagwklvSrEj985p71y2nYXH9olzDF3vU1cBr4tziUUw1mzxdU1NbED+ABO6uOkgjThBZw1Sp6B+jkSZ6Sg7tktDLP1cQibLWjNI/51Mm0USLFqK8Vr33PpAMTIZ5DVogBUHg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:from:in-reply-to:message-id:lines:user-agent:mime-version:content-type:date;
        b=mtf8DpzaA1L1xgmxG+AoaLqov0NxCiMNli/94HwFjFm0HF0kSmCfy0eq5LMbzDNLhypCcRp2gvjvooI4fTvE7SGx2traKw1tJJS3jxTEh40MBaIu6sBnjaTiA4/I5pM8ldxWd1BixyY0aCkThhswSJdc4t5doYr0lTKp+Fk+5hY=
Received: by 10.86.1.1 with SMTP id 1mr15545935fga.2.1208246390311;
        Tue, 15 Apr 2008 00:59:50 -0700 (PDT)
Received: from localhost.localdomain ( [83.8.219.135])
        by mx.google.com with ESMTPS id e11sm5516051fga.5.2008.04.15.00.59.48
        (version=TLSv1/SSLv3 cipher=OTHER);
        Tue, 15 Apr 2008 00:59:49 -0700 (PDT)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id m3F7xjcH017755;
	Tue, 15 Apr 2008 09:59:46 +0200
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id m3F7xi3S017752;
	Tue, 15 Apr 2008 09:59:44 +0200
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@gmail.com using -f
In-Reply-To: <acfbfe5b-f3a1-4c22-a873-ed329552d1bb@b5g2000pri.googlegroups.com>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/79575>

Dill <sarpulhu@gmail.com> writes:

> Perhaps we should just make the home page a wiki! It would work really
> good! If we use a theme like they do at wiki.ubuntu.com or somewhere
> else we could make it look really nice for a home page. Then once it's
> set up, no one has to manage the page, worry about commits, who's
> doing what, etc, and just have the pages edited and worked on by the
> community at large who register at the site to edit. 

First, as far as I now all _popular_ wikis offer quite limited markup.

Second, current git homepage has information about latest release, and
latest release date etc. updated *automatically*, by the script IIRC
examinimg announcement on git mailing list.  This I think would be not
possible with wiki.

> (Unlike the wiki in use now something would have to be done to stop
> the spam, like having those boxes at registration where you have
> pick the letters out).

If you have wiki which is popular page you would have spam.  Or you
wouldn't have contributors (or at least as many contributors) if you
would bring barriers to entry (e.g. register to edit, validation via
email, CAPTCHA) against spam.

[cut] 
Many more projects IMVHO have _both_ homepage and wiki, than only wiki
(wiki as homepage).

P.S. Please do not toppost.  If your post doesn't refer to the message
you are replying to, simply post it as clean message, without quoted
text.
-- 
Jakub Narebski
Poland
ShadeHawk on #git
