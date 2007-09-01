From: Jari Aalto <jari.aalto@cante.net>
Subject: Re: [PATCH] git-reset.txt: Use uniform HEAD~N notation in all examples
Date: Sat, 01 Sep 2007 23:40:55 +0300
Organization: Private
Message-ID: <veauqfu0.fsf@cante.net>
References: <tzqfsijk.fsf@cante.net>
	<7vy7frzfzg.fsf@gitster.siamese.dyndns.org> <hcmesrse.fsf@cante.net>
	<7vabs6u3jt.fsf@gitster.siamese.dyndns.org>
	<20070901150153.GD7422@mediacenter.austin.rr.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Sep 01 22:37:35 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IRZin-0003c8-72
	for gcvg-git@gmane.org; Sat, 01 Sep 2007 22:37:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752658AbXIAUh3 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 1 Sep 2007 16:37:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752494AbXIAUh3
	(ORCPT <rfc822;git-outgoing>); Sat, 1 Sep 2007 16:37:29 -0400
Received: from main.gmane.org ([80.91.229.2]:33268 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752622AbXIAUh2 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 1 Sep 2007 16:37:28 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1IRZiW-0001JD-7P
	for git@vger.kernel.org; Sat, 01 Sep 2007 22:37:16 +0200
Received: from a81-197-175-198.elisa-laajakaista.fi ([81.197.175.198])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sat, 01 Sep 2007 22:37:16 +0200
Received: from jari.aalto by a81-197-175-198.elisa-laajakaista.fi with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sat, 01 Sep 2007 22:37:16 +0200
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: a81-197-175-198.elisa-laajakaista.fi
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.3 (windows-nt)
Cancel-Lock: sha1:CpjEe8H9vFPLgnRjZAf1POQNcR0=
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/57281>

Shawn Bohrer <shawn.bohrer@gmail.com> writes:

> On Sat, Sep 01, 2007 at 02:40:22AM -0700, Junio C Hamano wrote:
>
>> Jari Aalto <jari.aalto@cante.net> writes:
>> 
>> > Like:
>> >
>> >     HEAD, HEAD~1, HEAD~2
>> >
>> > If the syntax is changed in the middle (as it was in manual page),
>> > that interrupts the kognitive flow of reading.
>> >
>> >     HEAD, HEAD^, HEAD~2
>> >
>> 
>> I still would prefer to teach people HEAD^ earlier.  If you _REALLY_
>> insist, I can live with spelling the HEAD~2 as HEAD^^ for
>> consistency.
>
> Well I am a new user to git and I didn't find the mixed notation
> confusing at all.  Perhaps this is because I read the tutorial first,
> then the git user manual which both explain this clearly.

Naturally one's learning path is naturally different. Did you come
from other SCM/VCS before intorduced to git?

> In either case I think eliminating either notation from the man pages is
> a bad idea.

That was not proposed. There a mnay pages that use and shoudl use the
^ notations. I was proposing that only (git-COMMAND) were dealt with.

After all, the ^ very differento to what other SCM/VCSs use.

Jari

-- 
Welcome to FOSS revolution: we fix and modify until it shines
