From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: looking for "market share" analysis of SCMs.
Date: Tue, 20 May 2008 15:34:05 -0700 (PDT)
Message-ID: <m3hccs4nbz.fsf@localhost.localdomain>
References: <48329282.1040407@tikalk.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Ittay Dror <ittayd@tikalk.com>
X-From: git-owner@vger.kernel.org Wed May 21 00:35:29 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JyaQP-0001am-Ju
	for gcvg-git-2@gmane.org; Wed, 21 May 2008 00:35:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934270AbYETWeM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 20 May 2008 18:34:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759372AbYETWeL
	(ORCPT <rfc822;git-outgoing>); Tue, 20 May 2008 18:34:11 -0400
Received: from ug-out-1314.google.com ([66.249.92.169]:32212 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934114AbYETWeJ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 20 May 2008 18:34:09 -0400
Received: by ug-out-1314.google.com with SMTP id h2so26972ugf.16
        for <git@vger.kernel.org>; Tue, 20 May 2008 15:34:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:received:x-authentication-warning:to:cc:subject:references:from:in-reply-to:message-id:lines:user-agent:mime-version:content-type:date;
        bh=lwsvCGhP2mUCU9OovpDlYxLkAlTA/NjdI6Bm7qQs6JA=;
        b=mJTzUI0S21d/0AvSlvldcg9q2zA/5fEWJSuMKKXrN0+NNYIHo+JUj++5gdXVVKJRW4ZHOSExOgKMrhXUSGtbXJ4eKNtypsRoKAEbnqhN/fqKJ6u43lRCg0STGYP2sKimB/016dhOHZbFCThdT2et3ufb94KB2jj6jg+zCw72WqY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:from:in-reply-to:message-id:lines:user-agent:mime-version:content-type:date;
        b=s6sEkQyVYfMzV1JXUB0JMMIvWfqwDUlujYseareM80Xfi4wveKhW68Uczl6/7QTxsZbDNNfqJsVxG9eVq2XcX1JjlkE5nbkAmLRneqZjO+XAlDKy0p46iFDtc0W4nJ1j2wp1znYzE2uZ3tPSl4oU7dsZktTdQQagxoQfUE8UPvw=
Received: by 10.67.115.1 with SMTP id s1mr98861ugm.74.1211322846943;
        Tue, 20 May 2008 15:34:06 -0700 (PDT)
Received: from localhost.localdomain ( [83.8.224.111])
        by mx.google.com with ESMTPS id 6sm2931830ugc.66.2008.05.20.15.34.04
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 20 May 2008 15:34:05 -0700 (PDT)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id m4KMYAdl012090;
	Wed, 21 May 2008 00:34:11 +0200
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id m4KMY8UM012086;
	Wed, 21 May 2008 00:34:08 +0200
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@gmail.com using -f
In-Reply-To: <48329282.1040407@tikalk.com>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/82515>

Ittay Dror <ittayd@tikalk.com> writes:

> I'm looking for a survey that analyses the market share of the major
> SCMs (including git of course). If someone knows about something like
> that, can you please point me to it? (optimally, such a survey will
> take into account how large the projects are)

It's not exactly "market share", and answers are obviously severly
biased, but you can take a look at answers and _comments_ to question
"10. What other SCMs did/do you use?" in Git User's Survey 2007:
http://git.or.cz/gitwiki/GitSurvey2007#head-4ed59e7615e2dc4f4baa8fa0beccde52c93789f8
(comments mention Ohloh stacks and Debian popularity contents,
popcon).

You can also read the following articles on Elijahs' blog:
  http://blogs.gnome.org/newren/2007/11/17/adoption-of-various-vcses/
  http://blogs.gnome.org/newren/2008/03/01/happenings-in-the-vcs-world/

HTH
-- 
Jakub Narebski
Poland
ShadeHawk on #git
