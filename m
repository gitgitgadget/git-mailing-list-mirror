From: Jari Aalto <jari.aalto@cante.net>
Subject: Re: [PATCH] git-commit.txt: Order options alphabetically
Date: Wed, 01 Dec 2010 20:39:41 +0200
Organization: Private
Message-ID: <87k4jtuyky.fsf@picasso.cante.net>
References: <1291215526-11428-1-git-send-email-jari.aalto@cante.net>
	<20101201165043.GF26120@burratino> <87r5e1v2g8.fsf@picasso.cante.net>
	<m362vd4c6h.fsf@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Dec 01 19:40:10 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PNrb7-0001h9-Hw
	for gcvg-git-2@lo.gmane.org; Wed, 01 Dec 2010 19:40:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756043Ab0LASkB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 1 Dec 2010 13:40:01 -0500
Received: from lo.gmane.org ([80.91.229.12]:34725 "EHLO lo.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755741Ab0LASkA (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 1 Dec 2010 13:40:00 -0500
Received: from list by lo.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1PNrax-0001bx-65
	for git@vger.kernel.org; Wed, 01 Dec 2010 19:39:59 +0100
Received: from a91-155-187-216.elisa-laajakaista.fi ([91.155.187.216])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 01 Dec 2010 19:39:59 +0100
Received: from jari.aalto by a91-155-187-216.elisa-laajakaista.fi with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 01 Dec 2010 19:39:59 +0100
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@dough.gmane.org
X-Gmane-NNTP-Posting-Host: a91-155-187-216.elisa-laajakaista.fi
User-Agent: Gnus/5.110011 (No Gnus v0.11) Emacs/23.2 (gnu/linux)
Cancel-Lock: sha1:4wnpigpinhfh7p0LE3QRk6feoZ0=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/162569>

2010-12-01 19:48 Jakub Narebski <jnareb@gmail.com>:
>> 2010-12-01 18:50 Jonathan Nieder <jrnieder@gmail.com>:
>
> But because some manpages "include" other pages (to refactor common
> options), it would be impossible to sort alphabetically options in all
> manpages.  So why bother with impossible?  It would only introduce
> inconsistency.

Decresing entropy is better goal even if we cannot make it perfect. We
do what we can. And there are many pages that don't use include.

I don't mind work. You just watch and lean back.

>> professional, it looks clean. And it works when searching (= no
>> orientation problems).
>
> It works if you have separate user's documentation from reference
> documentation.  GNU projects were meant to have manpages as reference,
> and info pages as user's documentation.  Options sorted alphabetically
> might make sense for reference documentation.

It makes sense regardless. Printing literature and how people read and
search information hasn't chnage since printing was invented.

> But git manpages doesn't serve _only_ as reference documentation.  And
> learning commands from manpages where options are sorted alphabetically
> instead of grouped together by function *suck* big time.

Nope. Manual pages are not where people learn things any more. They
Google. They buy books. Teh copy from fellow worker. 

The manual pages main use it as reference material. We don't need to
fight the obvious.

Jari
