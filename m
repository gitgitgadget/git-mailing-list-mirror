From: Thomas Rast <tr@thomasrast.ch>
Subject: Re: bash completion patch
Date: Sun, 09 Feb 2014 09:58:33 +0100
Message-ID: <874n48ll1i.fsf@thomasrast.ch>
References: <CAHtLG6Qgxq84Eo__vaXw5RAmyRuPnK-pt6n36+cjT8nVnRQN=w@mail.gmail.com>
	<vpqk3d9o83t.fsf@anie.imag.fr>
	<xmqq4n4d5rcn.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	=?utf-8?B?5LmZ6YW46Yuw?= <ch3cooli@gmail.com>,
	git <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Feb 09 09:58:54 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WCQE2-0004GJ-3l
	for gcvg-git-2@plane.gmane.org; Sun, 09 Feb 2014 09:58:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751612AbaBII6s (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 9 Feb 2014 03:58:48 -0500
Received: from ip1.thgersdorf.net ([148.251.9.194]:35289 "EHLO mail.psioc.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751469AbaBII6r (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 9 Feb 2014 03:58:47 -0500
Received: from localhost (localhost [127.0.0.1])
	by localhost.psioc.net (Postfix) with ESMTP id 791BA4D6588;
	Sun,  9 Feb 2014 09:58:45 +0100 (CET)
X-Virus-Scanned: amavisd-new at psioc.net
Received: from mail.psioc.net ([127.0.0.1])
	by localhost (mail.psioc.net [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id 20lAy9xtDZml; Sun,  9 Feb 2014 09:58:35 +0100 (CET)
Received: from linux-1gf2.thomasrast.ch (unknown [213.55.184.165])
	(using TLSv1.2 with cipher AES128-GCM-SHA256 (128/128 bits))
	(Client did not present a certificate)
	by mail.psioc.net (Postfix) with ESMTPSA id B937C4D64BD;
	Sun,  9 Feb 2014 09:58:34 +0100 (CET)
In-Reply-To: <xmqq4n4d5rcn.fsf@gitster.dls.corp.google.com> (Junio C. Hamano's
	message of "Wed, 05 Feb 2014 10:47:36 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/241871>

Junio C Hamano <gitster@pobox.com> writes:

> Matthieu Moy <Matthieu.Moy@grenoble-inp.fr> writes:
>
[...]
>> don't forget to Cc Junio if
>> you think your patch is ready for inclusion.
>
> Heh, thanks.  Everybody seems to think anything they send out to the
> list is ready for inclusion, so the last part may not be a piece of
> advice that is practically very useful, though ;-)

That happens to me a lot, too.  Perhaps it would be a clearer signal if
you had an alias (or just something like gitster+patch) that we can send
it to if we mean "please include" instead of "what do you think of this"?

-- 
Thomas Rast
tr@thomasrast.ch
