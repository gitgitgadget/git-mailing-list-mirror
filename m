From: =?ISO-8859-1?Q?Andr=E9_Walker?= <andre@andrewalker.net>
Subject: Re: GSoC mentors for Git.pm
Date: Sun, 01 Apr 2012 20:43:39 -0300
Message-ID: <4F78E82B.4080801@andrewalker.net>
References: <4F78B234.3060901@andrewalker.net> <4F78D4F5.4020603@pileofstuff.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>
To: Andrew Sayers <andrew-git@pileofstuff.org>
X-From: git-owner@vger.kernel.org Mon Apr 02 01:43:54 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SEUR7-000583-8q
	for gcvg-git-2@plane.gmane.org; Mon, 02 Apr 2012 01:43:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753561Ab2DAXnq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 1 Apr 2012 19:43:46 -0400
Received: from oproxy9.bluehost.com ([69.89.24.6]:45047 "HELO
	oproxy9.bluehost.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1752753Ab2DAXnp (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 1 Apr 2012 19:43:45 -0400
Received: (qmail 9885 invoked by uid 0); 1 Apr 2012 23:43:45 -0000
Received: from unknown (HELO host245.hostmonster.com) (74.220.215.245)
  by oproxy9.bluehost.com with SMTP; 1 Apr 2012 23:43:45 -0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=andrewalker.net; s=default;
	h=Content-Transfer-Encoding:Content-Type:In-Reply-To:References:Subject:CC:To:MIME-Version:From:Date:Message-ID; bh=UG5Uhwjw3Z6Nqv506GXKW+KO5HzdVbAZmbLco7z7u18=;
	b=RJ91/kGpsHNr4omZU7vhZ7wIVrOsa3Ni60kfvSJqMNPb9G906nEFdeV1mv/0NrTBuXpBZNCzudC1GWQ/bVbGQ/fIH3g5L0WnAyEeuUBzPEPQLnX7C1bt3UK9wkSlBxWO;
Received: from [189.79.200.72] (helo=[192.168.2.103])
	by host245.hostmonster.com with esmtpsa (TLSv1:AES256-SHA:256)
	(Exim 4.76)
	(envelope-from <andre@andrewalker.net>)
	id 1SEUQy-0001A0-GU; Sun, 01 Apr 2012 17:43:45 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:10.0.1) Gecko/20120209 Thunderbird/10.0.1
In-Reply-To: <4F78D4F5.4020603@pileofstuff.org>
X-Identified-User: {2744:host245.hostmonster.com:picloadc:andrewalker.net} {sentby:smtp auth 189.79.200.72 authed with andre@andrewalker.net}
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/194494>

On 04/01/2012 07:21 PM, Andrew Sayers wrote:
> I'd be interested in doing what I can to help, but I'm not in a position
> to put myself up as a full mentor.  The good news is that I've got
> several years of Perl and JS experience under my belt, and am quite used
> to finding where people are stuck and nudging them along.  The bad news
> is that I know next to nothing about git internals or about XS (which
> I'd expect to feature heavily in a new Git.pm).  I'm also settling in to
> a new job, so can't give strong guarantees about availability - for
> example, I'm pretty sure IRC access from work isn't going to happen, and
> have no idea what the olympics will do to my commute in the summer.
>
> If Jakub needs some kind of teaching assistant to help with code review
> and firming questions up then I'd be happy to help.  But if it needs to
> be someone who can infuse a strong vision for the end result then you're
> better off looking elsewhere.
Well, this sounds great, at least to me. Jakub will probably know better 
how and if you're fit as a mentor. From what I can tell, specially if 
there is more than one mentor for a project, you wouldn't have to spend 
more than 5 hours a week on it. Probably even less. And I think the Perl 
+ JS experience is good enough for it. Maybe you'd be more fit for the 
JavaScript framework in gitweb project?
