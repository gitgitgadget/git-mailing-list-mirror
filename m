From: David Kastrup <dak@gnu.org>
Subject: Re: Sources for 3.18-rc1 not uploaded
Date: Tue, 21 Oct 2014 19:25:42 +0200
Message-ID: <87wq7t5o89.fsf@fencepost.gnu.org>
References: <20141020115943.GA27144@gmail.com>
	<CA+55aFyDuHskYE66rBVL_P-T2pxg6f2m6mUicfz-mk+ysePBxg@mail.gmail.com>
	<20141020222809.GB223410@vauxhall.crustytoothpaste.net>
	<CA+55aFyZ1Mzjdx+JsD4jmFnJo+xL8xLz5+mtbh+_25bCak-7hQ@mail.gmail.com>
	<54461483.9010600@drmicha.warpmail.net>
	<CA+55aFyfO_WVy52GobRH0ggBWqvBcUPLJzXo-vme13drXJnBEg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Michael J Gruber <git@drmicha.warpmail.net>,
	Konstantin Ryabitsev <konstantin@linuxfoundation.org>,
	Junio C Hamano <gitster@pobox.com>,
	infra-steering@kernel.org, Git Mailing List <git@vger.kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Tue Oct 21 19:27:01 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XgdD2-0002ww-Fi
	for gcvg-git-2@plane.gmane.org; Tue, 21 Oct 2014 19:27:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933345AbaJUR05 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 21 Oct 2014 13:26:57 -0400
Received: from fencepost.gnu.org ([208.118.235.10]:56220 "EHLO
	fencepost.gnu.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932849AbaJUR04 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 21 Oct 2014 13:26:56 -0400
Received: from localhost ([127.0.0.1]:55258 helo=lola)
	by fencepost.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dak@gnu.org>)
	id 1XgdCv-0007hG-QS; Tue, 21 Oct 2014 13:26:54 -0400
Received: by lola (Postfix, from userid 1000)
	id 6BE92E0648; Tue, 21 Oct 2014 19:25:42 +0200 (CEST)
In-Reply-To: <CA+55aFyfO_WVy52GobRH0ggBWqvBcUPLJzXo-vme13drXJnBEg@mail.gmail.com>
	(Linus Torvalds's message of "Tue, 21 Oct 2014 09:25:34 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.0.50 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Linus Torvalds <torvalds@linux-foundation.org> writes:

> On Tue, Oct 21, 2014 at 1:08 AM, Michael J Gruber
> <git@drmicha.warpmail.net> wrote:
>>
>> Unfortunately, the git archive doc clearly says that the umask is
>> applied to all archive entries. And that clearly wasn't the case (for
>> extended metadata headers) before Brian's fix.
>
> Hey, it's time for another round of the world-famous "Captain Obvious
> Quiz Game"! Yay!
>
> The questions these week are:
>
>  (1) "If reality and documentation do not match, where is the bug?"
>     (a) Documentation is buggy
>     (b) Reality is buggy
>
>  (2) "Where would you put the horse in relationship to a horse-drawn carriage?"
>     (a) in front
>     (b) in the carriage

You are aware that a buggy _is_ a horse-drawn carriage?

-- 
Captain Facepalm
