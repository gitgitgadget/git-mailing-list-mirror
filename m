From: Petr Baudis <pasky@suse.cz>
Subject: Re: [PATCH Cogito] Fix README asciidoc formatting
Date: Tue, 11 Oct 2005 23:43:18 +0200
Message-ID: <20051011214318.GY22079@pasky.or.cz>
References: <20051002105601.GB9934@diku.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Oct 11 23:46:45 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EPRuE-0000y2-EF
	for gcvg-git@gmane.org; Tue, 11 Oct 2005 23:43:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751146AbVJKVn1 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 11 Oct 2005 17:43:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751152AbVJKVn1
	(ORCPT <rfc822;git-outgoing>); Tue, 11 Oct 2005 17:43:27 -0400
Received: from w241.dkm.cz ([62.24.88.241]:31698 "EHLO machine.or.cz")
	by vger.kernel.org with ESMTP id S1751146AbVJKVn1 (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 11 Oct 2005 17:43:27 -0400
Received: (qmail 4635 invoked by uid 2001); 11 Oct 2005 23:43:18 +0200
To: Jonas Fonseca <fonseca@diku.dk>
Content-Disposition: inline
In-Reply-To: <20051002105601.GB9934@diku.dk>
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
User-Agent: Mutt/1.5.10i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/9988>

Dear diary, on Sun, Oct 02, 2005 at 12:56:01PM CEST, I got a letter
where Jonas Fonseca <fonseca@diku.dk> told me that...
> BTW, what about adding some notatation info for those boxes? It looks
> very creative for an introduction document.

What do you mean by "notation info"?

> commit ca52918a9a6e02e55d878d8f5e68672432940337
> tree 60d270e8b45beeee9361b13284ff2eefec746fd6
> parent 9356837de630644323c800e2accad2618d7393f9
> author Jonas Fonseca <fonseca@diku.dk> Sun, 02 Oct 2005 12:45:03 +0200
> committer Jonas Fonseca <fonseca@antimatter.(none)> Sun, 02 Oct 2005 12:45:03 +0200
> 
>  README |    5 +++++
>  1 files changed, 5 insertions(+), 0 deletions(-)
> 
> diff --git a/README b/README
> --- a/README
> +++ b/README
> @@ -305,11 +305,13 @@ will `cg-clone` do?
>  
>  	+--------+
>  	+--------+
> +
>  First it creates an empty repository
>  
>  	+--------+
>  	$  origin<
>  	+--------+
> +
>  Then it creates an 'origin' head, and will copy all the history from the
>  remote repository's 'master' head there. So this head exists to reflect
>  the state of the remote repository. The important point is that it is
..snip..

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
VI has two modes: the one in which it beeps and the one in which
it doesn't.
