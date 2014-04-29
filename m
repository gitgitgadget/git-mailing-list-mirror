From: David Kastrup <dak@gnu.org>
Subject: Re: Recording the current branch on each commit?
Date: Tue, 29 Apr 2014 12:14:50 +0200
Message-ID: <87eh0g30it.fsf@fencepost.gnu.org>
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
	<87mwf431t3.fsf@fencepost.gnu.org>
	<535f76db38a34_6f23159b31099@nysa.notmuch>
Mime-Version: 1.0
Content-Type: text/plain
Cc: James Denholm <nod.helm@gmail.com>,
	Jeremy Morton <admin@game-point.net>,
	Johan Herland <johan@herland.net>,
	Git mailing list <git@vger.kernel.org>
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Tue Apr 29 12:14:57 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wf53w-0003AL-Ok
	for gcvg-git-2@plane.gmane.org; Tue, 29 Apr 2014 12:14:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756560AbaD2KOx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 29 Apr 2014 06:14:53 -0400
Received: from fencepost.gnu.org ([208.118.235.10]:56919 "EHLO
	fencepost.gnu.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751942AbaD2KOw (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 29 Apr 2014 06:14:52 -0400
Received: from localhost ([127.0.0.1]:55959 helo=lola)
	by fencepost.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dak@gnu.org>)
	id 1Wf53q-0006Pr-D2; Tue, 29 Apr 2014 06:14:50 -0400
Received: by lola (Postfix, from userid 1000)
	id 0EAE6E076E; Tue, 29 Apr 2014 12:14:50 +0200 (CEST)
In-Reply-To: <535f76db38a34_6f23159b31099@nysa.notmuch> (Felipe Contreras's
	message of "Tue, 29 Apr 2014 04:54:35 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.4.50 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/247560>

Felipe Contreras <felipe.contreras@gmail.com> writes:

> David Kastrup wrote:
>
>> Well, there you have it.  The ones that do any kind of relevant change
>> are the ones that need thinking about and consideration.  And when you
>> are so verbose about them that
>> 
>> a) you are getting on people's nerves
>> b) nobody else finds something worth saying that you did not already say
>> 
>> then the net effect is that it feels to the person in question he's
>> mainly doing you (and not all that many others) a favor by investing
>> the work for properly considering it and its consequences.
>
> This is the last time I say it: this is demonstrably false.

Feelings are not categorizable as "demonstrably false".

> You claim that relevant changes can be made if the submitter is not so
> verbose (and less aggressive and what not).
>
> This is obviously not the case. Show me any change of importance done
> in the last two years, hell, make it four. And by change I mean
> something that was one way before, and was another way after.

The default behavior of "git push".  Colorized diffs.  "git add dir/"
can now remove files.  "git gc --aggressive" has been sanitized.

-- 
David Kastrup
