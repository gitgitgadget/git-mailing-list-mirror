From: David Kastrup <dak@gnu.org>
Subject: Re: Recording the current branch on each commit?
Date: Tue, 29 Apr 2014 11:47:04 +0200
Message-ID: <87mwf431t3.fsf@fencepost.gnu.org>
References: <535C47BF.2070805@game-point.net>
	<CALKQrgfmBByMwMhxu3HkJqJGWy2Rwvij6Hi1_4npjfsxcSgpaQ@mail.gmail.com>
	<535D4085.4040707@game-point.net>
	<CALKQrgemFx=2JaC1BaRqCwEV+knC8QftxcZ7K0AsT9azzuyVdA@mail.gmail.com>
	<535D6EB1.9080208@game-point.net>
	<535e18cdc7bce_338911e930c72@nysa.notmuch>
	<87bnvl6bdg.fsf@fencepost.gnu.org>
	<535e8e4253196_45651483310b3@nysa.notmuch>
	<152626b3-0642-4e26-9333-7d911d45c669@email.android.com>
	<535edfb9baa4a_4c5c11c92f0bc@nysa.notmuch>
	<CAHYYfeGBLXGgK-cTQLEreFXJakp1jBE829=LrhmKR3MttBiw+A@mail.gmail.com>
	<535f1d4d8cbbb_762310ef30c9c@nysa.notmuch>
	<220967ee-98a9-4731-88c0-43a9cba7220a@email.android.com>
	<535f62c1e740a_45e485b30887@nysa.notmuch>
	<87r44g33z4.fsf@fencepost.gnu.org>
	<535f702352d21_3aee3b2f0b9@nysa.notmuch>
Mime-Version: 1.0
Content-Type: text/plain
Cc: James Denholm <nod.helm@gmail.com>,
	Jeremy Morton <admin@game-point.net>,
	Johan Herland <johan@herland.net>,
	Git mailing list <git@vger.kernel.org>
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Tue Apr 29 11:47:40 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wf4dT-0007vp-4G
	for gcvg-git-2@plane.gmane.org; Tue, 29 Apr 2014 11:47:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757392AbaD2Jrc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 29 Apr 2014 05:47:32 -0400
Received: from fencepost.gnu.org ([208.118.235.10]:56161 "EHLO
	fencepost.gnu.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756895AbaD2JrS (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 29 Apr 2014 05:47:18 -0400
Received: from localhost ([127.0.0.1]:55203 helo=lola)
	by fencepost.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dak@gnu.org>)
	id 1Wf4dA-0002pv-VO; Tue, 29 Apr 2014 05:47:17 -0400
Received: by lola (Postfix, from userid 1000)
	id 36943DF343; Tue, 29 Apr 2014 11:47:04 +0200 (CEST)
In-Reply-To: <535f702352d21_3aee3b2f0b9@nysa.notmuch> (Felipe Contreras's
	message of "Tue, 29 Apr 2014 04:25:55 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.4.50 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/247558>

Felipe Contreras <felipe.contreras@gmail.com> writes:

> David Kastrup wrote:
>
>> Even while the ones getting the benefits from your work will not
>> feel an obligation to make it worth your while, there is a
>> difference in satisfaction between getting your work trashed and
>> getting it used.
>
> I don't know why this keeps poping up in the thread, but it is
> starting to seem to me that you are under the impression that I'm
> somehow unable to get my patches merged.
>
> Look at the list of contributors of the past year, see who is #2:
>
> https://www.ohloh.net/p/git/contributors?query=&sort=commits_12_mo
>
> I know what kind of patches can get in, and what patches can't (the
> ones that do any kind of relevant change). I know that from
> experience.

Well, there you have it.  The ones that do any kind of relevant change
are the ones that need thinking about and consideration.  And when you
are so verbose about them that

a) you are getting on people's nerves
b) nobody else finds something worth saying that you did not already say

then the net effect is that it feels to the person in question he's
mainly doing you (and not all that many others) a favor by investing the
work for properly considering it and its consequences.

Which is not much of an incentive.  At any rate, we are in a phase
supposed to be shortly before the release of 2.0.  So it is actually
quite by design that patches doing any kind of relevant changes are not
currently going through.  You can be as nice or ugly about it as you
want right now and it will not affect 2.0 any more.

But it might do so regarding 2.1.

-- 
David Kastrup
