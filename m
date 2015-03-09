From: David Kastrup <dak@gnu.org>
Subject: Re: git-scm.com website
Date: Mon, 09 Mar 2015 19:02:49 +0100
Message-ID: <87h9tukq0m.fsf@fencepost.gnu.org>
References: <CAJo=hJsbbfK-_qX6sg3Azk30Kz5ebLfyMbVF98VzHZe8YyaLcQ@mail.gmail.com>
	<87y4n6kvdu.fsf@fencepost.gnu.org>
	<CAP2yMa+Bw0KCSz9YEtviZUykAp4jpdsEWSK-jRxtd9MjzjHKfg@mail.gmail.com>
	<87lhj6kqng.fsf@fencepost.gnu.org>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Shawn Pearce <spearce@spearce.org>,
	Michael J Gruber <git@drmicha.warpmail.net>,
	Christian Couder <christian.couder@gmail.com>,
	Junio C Hamano <gitster@pobox.com>, git <git@vger.kernel.org>
To: Scott Chacon <schacon@gmail.com>
X-From: git-owner@vger.kernel.org Mon Mar 09 19:03:00 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YV215-00038t-Jo
	for gcvg-git-2@plane.gmane.org; Mon, 09 Mar 2015 19:02:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753604AbbCISCy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 9 Mar 2015 14:02:54 -0400
Received: from fencepost.gnu.org ([208.118.235.10]:50426 "EHLO
	fencepost.gnu.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751400AbbCISCv (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 9 Mar 2015 14:02:51 -0400
Received: from localhost ([127.0.0.1]:49464 helo=lola)
	by fencepost.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dak@gnu.org>)
	id 1YV20w-0004Jd-Bi; Mon, 09 Mar 2015 14:02:50 -0400
Received: by lola (Postfix, from userid 1000)
	id DAC57E062D; Mon,  9 Mar 2015 19:02:49 +0100 (CET)
In-Reply-To: <87lhj6kqng.fsf@fencepost.gnu.org> (David Kastrup's message of
	"Mon, 09 Mar 2015 18:49:07 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.0.50 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/265187>

David Kastrup <dak@gnu.org> writes:

> Scott Chacon <schacon@gmail.com> writes:
>
>> On Mon, Mar 9, 2015 at 9:06 AM, David Kastrup <dak@gnu.org> wrote:
>>> Personally, I consider the recent migration of the Emacs repository to
>>> Git a bigger endorsement but then that's me.
>>
>> I would love to have Emacs on that page, actually. If you guys want me
>> to add that, I'm happy to. I didn't know they moved over, I thought
>> they were still a bzr shop.
>
> I don't know who "you guys" is, but it would be my guess that
> Stallman/FSF would not be enthused to see the Emacs logo added to that
> particular list.
>
> Emacs used Bzr particularly to promote an alternative to Git more open
> to the free software philosophy promoted by the FSF.  Once Bzr
> development became non-responsive and Canonical turned it more into a
> Canonical-owned rather than a community project, it became sort of
> pointless to stick with a technically less popular choice.
>
> So Emacs fairly recently switched to Git.

I might add that the abysmal performance of git-blame on Emacs'
src/xdisp.c was given as one fairly important argument against switching
to Git, and in consequence I promised to take a look at it.  Git runs
about a factor of 4 faster on src/xdisp.c now, but I can safely say that
I consider letting myself get involved here a rather expensive mistake.

Live and learn.

-- 
David Kastrup
