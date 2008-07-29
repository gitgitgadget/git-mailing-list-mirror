From: Julian Phillips <julian@quantumfyre.co.uk>
Subject: Re: Git Community Book
Date: Tue, 29 Jul 2008 20:00:55 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0807291957410.1779@reaper.quantumfyre.co.uk>
References: <d411cc4a0807290920p62f5d7e1r727a62ef2b4611fc@mail.gmail.com>
 <20080729170955.GK32184@machine.or.cz> <d411cc4a0807291130p228f77d5r1f390090ec29aef4@mail.gmail.com>
 <7vwsj4edm1.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Cc: Scott Chacon <schacon@gmail.com>, Petr Baudis <pasky@suse.cz>,
	git list <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Jul 29 21:03:10 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KNuTF-0006tN-61
	for gcvg-git-2@gmane.org; Tue, 29 Jul 2008 21:02:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751471AbYG2TBt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 29 Jul 2008 15:01:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751423AbYG2TBt
	(ORCPT <rfc822;git-outgoing>); Tue, 29 Jul 2008 15:01:49 -0400
Received: from electron.quantumfyre.co.uk ([87.106.55.16]:36284 "EHLO
	electron.quantumfyre.co.uk" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751084AbYG2TBs (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 29 Jul 2008 15:01:48 -0400
Received: from neutron.quantumfyre.co.uk (neutron.quantumfyre.co.uk [212.159.54.235])
	by electron.quantumfyre.co.uk (Postfix) with ESMTP id 2F362EBA95
	for <git@vger.kernel.org>; Tue, 29 Jul 2008 20:01:47 +0100 (BST)
Received: (qmail 4740 invoked by uid 103); 29 Jul 2008 20:00:55 +0100
Received: from 212.159.54.234 by neutron.quantumfyre.co.uk (envelope-from <julian@quantumfyre.co.uk>, uid 201) with qmail-scanner-1.25st 
 (clamdscan: 0.92.1/7870. spamassassin: 3.2.1. perlscan: 1.25st.  
 Clear:RC:1(212.159.54.234):. 
 Processed in 0.027529 secs); 29 Jul 2008 19:00:55 -0000
Received: from darkphoton.datavampyre.co.uk (212.159.54.234)
  by neutron.quantumfyre.co.uk with SMTP; 29 Jul 2008 20:00:55 +0100
X-X-Sender: jp3@reaper.quantumfyre.co.uk
In-Reply-To: <7vwsj4edm1.fsf@gitster.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/90667>

On Tue, 29 Jul 2008, Junio C Hamano wrote:

> "Scott Chacon" <schacon@gmail.com> writes:
>
>>>
>>> There is no license in the source code - what are the copying terms?
>>>
>>
>> I copied in the COPYING file from Git - GPL2.
>>
>>> It is maybe somewhat unfortunate that this is in a different format that
>>> the standard git choice asciidoc, but the formats do look rather similar
>>> so I assume it should not be hard to even convert from one to another if
>>> needed.
>>
>> I simply didn't want to get asciidoc working locally - it's always
>> been a bit of a pain to compile (I've heard it referred to more than
>> once as the only 'nightmare dependancy' in git), and I don't need to
>> make man pages or anything, so it seemed Markdown would be a better
>> choice for my output targets.  There are a number of good Markdown
>> interpreters and they're easy to get running.
>
> I personally like markdown, but doesn't your refusal to work with existing
> practices pose a significant problem, unless:
>
> (0) you do not consider it a goal to keep the documentation shipped with
>     git and your book in sync; or
>
> (1) you have either markdown to asciidoc (or the other way around)
>     converter; the book is written in markdown, and its conversion back
>     to asciidoc is fed to Documentation as patches (or the other way
>     around); or
>
> (2) somebody tries to find markdown to manpage, and we convert
>     Documentation/ to markdown.

Haven't used it personally, and without commenting on the "political" side 
of such an approach - there does exist at least one tool that claims to be 
able to convert from markdown to man: http://johnmacfarlane.net/pandoc/

> Or is this, "fork once and borrow reviewer's time, but never be able to
> contribute back to the original text because the result is so different"
> approach?
>
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>

-- 
Julian

  ---
[The French Riviera is] a sunny place for shady people.
 		-- Somerset Maugham
