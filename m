From: David Kastrup <dak@gnu.org>
Subject: Re: [PATCH 0/4] remote-hg: more improvements
Date: Wed, 14 May 2014 11:55:21 +0200
Message-ID: <87iop8u1km.fsf@fencepost.gnu.org>
References: <1399169814-20201-1-git-send-email-felipe.contreras@gmail.com>
	<xmqq8uqdbgqg.fsf@gitster.dls.corp.google.com>
	<536a83097302f_76ff7a52ec6c@nysa.notmuch>
	<xmqqvbth8ha9.fsf@gitster.dls.corp.google.com>
	<536a999e2c0c_76ff7a52ec1e@nysa.notmuch>
	<xmqqoaz95ees.fsf@gitster.dls.corp.google.com>
	<536ad9601b73b_3caaa612ecdc@nysa.notmuch>
	<CAGK7Mr4DYuU34Zf_3fRQFkT+1TGOkpfLPUnQh=tYh6EMtBEt9A@mail.gmail.com>
	<xmqq8uq6rd30.fsf@gitster.dls.corp.google.com>
	<CAGK7Mr7AcqKnEBk1NwzJFJVSSQE9uWTE00zi+B9z6i0V5tBrEg@mail.gmail.com>
	<87mweku2pt.fsf@fencepost.gnu.org>
	<CAGK7Mr5ezbTVyq2wr7kYWjab6V1srrYwkqSGjo1GuPnkSuGWTQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Junio C Hamano <gitster@pobox.com>,
	"git\@vger.kernel.org" <git@vger.kernel.org>
To: Philippe Vaucher <philippe.vaucher@gmail.com>
X-From: git-owner@vger.kernel.org Wed May 14 11:55:43 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WkVuX-0001A4-Ug
	for gcvg-git-2@plane.gmane.org; Wed, 14 May 2014 11:55:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753850AbaENJzi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 14 May 2014 05:55:38 -0400
Received: from fencepost.gnu.org ([208.118.235.10]:40744 "EHLO
	fencepost.gnu.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752836AbaENJzf (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 May 2014 05:55:35 -0400
Received: from localhost ([127.0.0.1]:39785 helo=lola)
	by fencepost.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dak@gnu.org>)
	id 1WkVuQ-0002tr-Mc; Wed, 14 May 2014 05:55:34 -0400
Received: by lola (Postfix, from userid 1000)
	id B830BE0D4F; Wed, 14 May 2014 11:55:21 +0200 (CEST)
In-Reply-To: <CAGK7Mr5ezbTVyq2wr7kYWjab6V1srrYwkqSGjo1GuPnkSuGWTQ@mail.gmail.com>
	(Philippe Vaucher's message of "Wed, 14 May 2014 11:36:54 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.4.50 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/248906>

Philippe Vaucher <philippe.vaucher@gmail.com> writes:

>>> Thanks for the explanation. I think it underlines well the A)
>>> technical issues (quality commits) and the B) social issues (ability
>>> to communicate in a friendly way & respond constructively), which we
>>> discovered are both *essential* for contributing to git.
>>
>> I'm not entirely convinced of that: there is something akin to drop-dead
>> gorgeous code: code that is so well done that it would not matter with
>> regard to its maintenance whether or not its author dropped dead because
>> it's both done well as well as documented in a manner where the original
>> author could not offer significant additional help.
>
> I think this only means that you can get away with B issues if A's
> quality is very very very high, which doens't happen very often.

I would not exactly say "get away with B issues".  It's like saying you
can get away with looking like a sleazebag if you plan the time for a
complete border search whenever traveling abroad.

Of course that means that traveling into countries where "complete
border search" might entail depriving you of your civic rights and
locking you up for decades in a torture camp without due process is
plainly not an option.

But if you are honest: everybody has to be prepared for that.  It's just
less likely to occur in practice.

Basically you have to write in a manner "if a seedy stranger gave me
that code on a street corner, I would have no problem checking it in".
In practice, the shortcuts offering themselves through civil behavior
and mutual trust get a lot more work done.

But they _are_ a vector for "social engineering".

You have to admit that it seems pretty unlikely by now that Felipe is
trying to sneak in some NSA-written code without arousing people's
suspicions.

-- 
David Kastrup
