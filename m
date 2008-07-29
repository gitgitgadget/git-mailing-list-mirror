From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Git Community Book
Date: Tue, 29 Jul 2008 12:57:13 -0700
Message-ID: <7vzlo0cvl2.fsf@gitster.siamese.dyndns.org>
References: <d411cc4a0807290920p62f5d7e1r727a62ef2b4611fc@mail.gmail.com>
 <20080729170955.GK32184@machine.or.cz>
 <d411cc4a0807291130p228f77d5r1f390090ec29aef4@mail.gmail.com>
 <7vwsj4edm1.fsf@gitster.siamese.dyndns.org>
 <d411cc4a0807291234q794344e0oee09f6164286ffd1@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Petr Baudis" <pasky@suse.cz>, "git list" <git@vger.kernel.org>
To: "Scott Chacon" <schacon@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jul 29 21:58:25 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KNvKx-0000jV-7O
	for gcvg-git-2@gmane.org; Tue, 29 Jul 2008 21:58:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752144AbYG2T5V (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 29 Jul 2008 15:57:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752134AbYG2T5V
	(ORCPT <rfc822;git-outgoing>); Tue, 29 Jul 2008 15:57:21 -0400
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:35153 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752044AbYG2T5U (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 29 Jul 2008 15:57:20 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id 96B8C428E5;
	Tue, 29 Jul 2008 15:57:19 -0400 (EDT)
Received: from pobox.com (ip68-225-240-211.oc.oc.cox.net [68.225.240.211])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id 9711C428E3; Tue, 29 Jul 2008 15:57:15 -0400 (EDT)
In-Reply-To: <d411cc4a0807291234q794344e0oee09f6164286ffd1@mail.gmail.com>
 (Scott Chacon's message of "Tue, 29 Jul 2008 12:34:43 -0700")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 8D3736A2-5DA8-11DD-9354-3113EBD4C077-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/90678>

"Scott Chacon" <schacon@gmail.com> writes:

> The book is basically a fork of all three of the guides I mentioned
> (User Manual and both Tutorials), and with the scope and goals I
> currently have in mind, will not be kept in sync - it's just not going
> to be possible.  I think in the end, the goals of the texts are so
> very different that sections it will simply not make sense to try to
> keep them in sync in some sort of automated fashion.  That's one of
> the reasons why I choose Markdown - I saw no need to use asciidoc, as
> the book will not be shipped around with Git or built using the same
> processes, and I had no need for the advantages of asciidoc in my
> project.  I don't think it makes much sense to have the book be a man
> page at all.
>
> However, I will watch the manual and guides and try to incorporate
> changes to them as appropriate, and I will likely have some updates to
> them myself as I've been more closely scrutinizing them.

If that is the approach you decided for your book, I am Ok with that.

Not that you need my blessing to do your own book.  It was unclear what
your goals were, and if one of the goals were to keep the hassle of
maintaining shared materials in both manuals up-to-date, choice of
markdown seemed suboptimal to me, hence my comments.

Thanks.

... /me goes back to work after lunch break ...
