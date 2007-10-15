From: David Kastrup <dak@gnu.org>
Subject: Re: [PATCH 0/7] Bisect dunno
Date: Mon, 15 Oct 2007 10:25:32 +0200
Message-ID: <86odf0pywz.fsf@lola.quinscape.zz>
References: <20071014142826.8caa0a9f.chriscool@tuxfamily.org> <F32B0EEF-496C-4D6D-BD9A-B6A0C04E0EE3@wincent.com> <854pgtonp5.fsf@lola.goethe.zz> <200710141709.51579.chriscool@tuxfamily.org> <4712400C.2080900@lsrfire.ath.cx>  =?ISO-8859-1?Q?=20<?=
	=?ISO-8859-1?Q?85y7e5ll38.fsf@l?= =?ISO-8859-1?Q?ola.goethe.zz=04>?= <522E90CF-FC15-472F-B0A8-91C310CAF9BF@wincent.com> <471250BC.7070307@trolltech.com> <85d4vhlh8y.fsf@lola.goethe.zz> <471302D2.6010405@trolltech.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Oct 15 10:44:32 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IhLYt-0003Le-P4
	for gcvg-git-2@gmane.org; Mon, 15 Oct 2007 10:44:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755507AbXJOIoT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 15 Oct 2007 04:44:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755455AbXJOIoT
	(ORCPT <rfc822;git-outgoing>); Mon, 15 Oct 2007 04:44:19 -0400
Received: from main.gmane.org ([80.91.229.2]:35696 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755263AbXJOIoS (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 Oct 2007 04:44:18 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1IhLRe-0007N3-1t
	for git@vger.kernel.org; Mon, 15 Oct 2007 08:37:02 +0000
Received: from pd95b0fdb.dip0.t-ipconnect.de ([217.91.15.219])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 15 Oct 2007 08:37:02 +0000
Received: from dak by pd95b0fdb.dip0.t-ipconnect.de with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 15 Oct 2007 08:37:02 +0000
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: pd95b0fdb.dip0.t-ipconnect.de
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/23.0.50 (gnu/linux)
Cancel-Lock: sha1:l0N60QuUX37mla7DXGLl7UbRFk4=
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/60962>

Marius Storm-Olsen <marius@trolltech.com> writes:

> David Kastrup said the following on 14.10.2007 19:48:
>> Marius Storm-Olsen <marius@trolltech.com> writes:
>>
>>> Wincent Colaiuta said the following on 14.10.2007 18:35:
>>>
>>>> "undecided" sounds good to me. It should be clear to non-native
>>>> speakers of English (at least, clearer than "dunno").
>>> What about just "unknown"?
>>
>> I tend to nitpick to the degree of silliness when my own suggestions
>> are concerned, but "unknown" sounds to me like the state _before_ the
>> test.  If a person says he is "undecided" about something that means
>> that he _has_ thought about it already.  "Undecidable" might bring
>> this distinction across more strongly, but it is a more complicated
>> word and it insinuates that it is _impossible_ to come to a decision
>> regardless of the spent effort.
>>
>> "unknown" clearly is much better than "dunno" though even if my own
>> favorite would be "undecided".
>
> What then about a good'ol programming favorite, "void"? :-)

Huh?  void is a type, not a value.  void would insinuate that it was
wrong to ask the question, not that its answer could not be
determined.

> I agree that "unknown" might be a state even _before_ a person has
> determined if a case is good or bad (same for 'dunno' actually: "-
> Do you know if it works? - I dunno yet") When I think more about it,
> I really like "void"..

Well, I don't.

Basically, I would say that this seems to be so much a matter of
personal taste that we should at this point of time leave the decision
of how to pick this to Junio.  Whether this gets resolved by vote or
by authority: seems like the fine lines are no longer worth the time
invested in discussing them.

-- 
David Kastrup
