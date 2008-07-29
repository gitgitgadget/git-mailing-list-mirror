From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Git Community Book
Date: Tue, 29 Jul 2008 12:09:26 -0700
Message-ID: <7vod4gecd5.fsf@gitster.siamese.dyndns.org>
References: <d411cc4a0807290920p62f5d7e1r727a62ef2b4611fc@mail.gmail.com>
 <20080729170955.GK32184@machine.or.cz>
 <d411cc4a0807291130p228f77d5r1f390090ec29aef4@mail.gmail.com>
 <7vwsj4edm1.fsf@gitster.siamese.dyndns.org>
 <Pine.LNX.4.64.0807291957410.1779@reaper.quantumfyre.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Scott Chacon <schacon@gmail.com>, Petr Baudis <pasky@suse.cz>,
	git list <git@vger.kernel.org>
To: Julian Phillips <julian@quantumfyre.co.uk>
X-From: git-owner@vger.kernel.org Tue Jul 29 21:10:38 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KNuai-00016o-Sn
	for gcvg-git-2@gmane.org; Tue, 29 Jul 2008 21:10:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751323AbYG2TJh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 29 Jul 2008 15:09:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751372AbYG2TJh
	(ORCPT <rfc822;git-outgoing>); Tue, 29 Jul 2008 15:09:37 -0400
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:46142 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750986AbYG2TJg (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 29 Jul 2008 15:09:36 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id 82A794253A;
	Tue, 29 Jul 2008 15:09:34 -0400 (EDT)
Received: from pobox.com (ip68-225-240-211.oc.oc.cox.net [68.225.240.211])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id C320F42537; Tue, 29 Jul 2008 15:09:28 -0400 (EDT)
In-Reply-To: <Pine.LNX.4.64.0807291957410.1779@reaper.quantumfyre.co.uk>
 (Julian Phillips's message of "Tue, 29 Jul 2008 20:00:55 +0100 (BST)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: E177BB30-5DA1-11DD-9112-3113EBD4C077-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/90668>

Julian Phillips <julian@quantumfyre.co.uk> writes:

> On Tue, 29 Jul 2008, Junio C Hamano wrote:
>
>> "Scott Chacon" <schacon@gmail.com> writes:
>>
>>> I simply didn't want to get asciidoc working locally - it's always
>>> been a bit of a pain to compile (I've heard it referred to more than
>>> once as the only 'nightmare dependancy' in git), and I don't need to
>>> make man pages or anything, so it seemed Markdown would be a better
>>> choice for my output targets.  There are a number of good Markdown
>>> interpreters and they're easy to get running.
>>
>> I personally like markdown, but doesn't your refusal to work with existing
>> practices pose a significant problem, unless:
>> ...
>> (2) somebody tries to find markdown to manpage, and we convert
>>     Documentation/ to markdown.
> 
> Haven't used it personally, and without commenting on the "political"
> side of such an approach - there does exist at least one tool that
> claims to be able to convert from markdown to man:
> http://johnmacfarlane.net/pandoc/

Oh, there is nothing political about this.  It is not like some of us is
employed by AsciiDoc company and defecting to markdown would cost
somebody's job or life ;-)

It is good to know that an option is availble to make it easier to go
back-and-forth, when/if it becomes necessary.
