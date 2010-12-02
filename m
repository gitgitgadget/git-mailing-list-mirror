From: Jari Aalto <jari.aalto@cante.net>
Subject: Re: [PATCH] git-reset.txt: Use commit~1 notation over commit^
Date: Thu, 02 Dec 2010 14:14:11 +0200
Organization: Private
Message-ID: <87bp54s770.fsf@picasso.cante.net>
References: <1291227258-17922-1-git-send-email-jari.aalto@cante.net>
	<1291230820.11917.25.camel@drew-northup.unet.maine.edu>
	<877hftuvvz.fsf@picasso.cante.net>
	<7vfwuhtafr.fsf@alter.siamese.dyndns.org>
	<AANLkTik8TNedGBQh7KXvRSf3HTTQf2-yMJC4VA4OOBjQ@mail.gmail.com>
	<87sjygspgy.fsf@picasso.cante.net>
	<buo39qg8zrf.fsf@dhlpc061.dev.necel.com>
Mime-Version: 1.0
Content-Type: text/plain
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Dec 02 13:14:34 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PO83V-00053y-Ei
	for gcvg-git-2@lo.gmane.org; Thu, 02 Dec 2010 13:14:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757433Ab0LBMO1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 2 Dec 2010 07:14:27 -0500
Received: from lo.gmane.org ([80.91.229.12]:50346 "EHLO lo.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751633Ab0LBMO0 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 2 Dec 2010 07:14:26 -0500
Received: from list by lo.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1PO83N-00051w-RM
	for git@vger.kernel.org; Thu, 02 Dec 2010 13:14:25 +0100
Received: from a91-155-187-216.elisa-laajakaista.fi ([91.155.187.216])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 02 Dec 2010 13:14:25 +0100
Received: from jari.aalto by a91-155-187-216.elisa-laajakaista.fi with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 02 Dec 2010 13:14:25 +0100
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@dough.gmane.org
X-Gmane-NNTP-Posting-Host: a91-155-187-216.elisa-laajakaista.fi
User-Agent: Gnus/5.110011 (No Gnus v0.11) Emacs/23.2 (gnu/linux)
Cancel-Lock: sha1:vo/xVDCtLs6PNoJdssfrDQf1Ebk=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/162695>

2010-12-02 08:17 Miles Bader <miles@gnu.org>:
> Jari Aalto <jari.aalto@cante.net> writes:
>
>>> Additionaly, you must know about the ^ notation. That is the only way
>>> refer to the second parent HEAD^2, for example.
>>
>> If "must" is a requirement, I have to regret that there has yet to have
>> been a situation where I would ahve a need to refer to "second parent".
>>
>> I guess most of the basic features can be used without it.
>
> It doesn't matter.  There needs to be a better reason than "Jari doesn't
> like it."

This has nothing to do with liking. It how infomation is read. When
information is consistent, it lessens cognitive load.

In the  "fine print" git-rev-parse(1) there can be the gory details.

most of the commenters probably are already experts and therefor wear
"expert glasses on". It's not necessarily the same for starters.
Certainly not when you try to teach 100 people. One form is much better
in that situation than variations. You only do it at the end:

    "[After finishing 6 week training] Btw, if you need more details
    look at...."

Experts can later pick anything they want.

Jari
