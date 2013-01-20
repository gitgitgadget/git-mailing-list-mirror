From: Thomas Rast <trast@student.ethz.ch>
Subject: Re: Aw: [PATCH 0/2] GIT, Git, git
Date: Sun, 20 Jan 2013 12:56:37 +0100
Message-ID: <87d2x0xe2y.fsf@pctrast.inf.ethz.ch>
References: <304952858.714413.1358671123163.JavaMail.ngmail@webmail06.arcor-online.net>
Mime-Version: 1.0
Content-Type: text/plain
Cc: <git@vger.kernel.org>
To: Thomas Ackermann <th.acker@arcor.de>
X-From: git-owner@vger.kernel.org Sun Jan 20 12:57:05 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TwtWJ-0000tl-CU
	for gcvg-git-2@plane.gmane.org; Sun, 20 Jan 2013 12:57:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751915Ab3ATL4m (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 20 Jan 2013 06:56:42 -0500
Received: from edge20.ethz.ch ([82.130.99.26]:27778 "EHLO edge20.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751867Ab3ATL4l (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 20 Jan 2013 06:56:41 -0500
Received: from CAS21.d.ethz.ch (172.31.51.111) by edge20.ethz.ch
 (82.130.99.26) with Microsoft SMTP Server (TLS) id 14.2.298.4; Sun, 20 Jan
 2013 12:56:37 +0100
Received: from pctrast.inf.ethz.ch.ethz.ch (46.126.8.85) by CAS21.d.ethz.ch
 (172.31.51.111) with Microsoft SMTP Server (TLS) id 14.2.298.4; Sun, 20 Jan
 2013 12:56:37 +0100
In-Reply-To: <304952858.714413.1358671123163.JavaMail.ngmail@webmail06.arcor-online.net>
	(Thomas Ackermann's message of "Sun, 20 Jan 2013 09:38:43 +0100
	(CET)")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.2 (gnu/linux)
X-Originating-IP: [46.126.8.85]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/214008>

Thomas Ackermann <th.acker@arcor.de> writes:

>> Git changed its 'official' system name from 'GIT' to 'Git' in v1.6.5.3
>> (as can be seen in the corresponding release note where 'GIT' was 
>> changed to 'Git' in the header line).
>> 
>> Alas the documention uses 'GIT', 'Git' or even 'git' to refer to the
>> Git system. So change every occurrence of 'GIT" and 'git' to 'Git'
>> whenever Git as a system is referred to (but don't do this change
>> in the release notes because they constitute a history orthogonal
>> to the history versioned by Git).
>> 
>> [PATCH 1/2] Change old system name 'GIT' to 'Git'
>> [PATCH 2/2] Change 'git' to 'Git' whenever the whole system is referred to
>> 
>
> My second patch somehow got lost in the mailing system (I suspect
> due to its size of >300kB). I will wait for some more comments
> and then do a reroll thereby splitting the second patch in smaller
> parts ...

For such big patches it also helps if you push them somewhere public,
and post the URL and branch name, so that interested parties can still
have a look.

But yes, vger.kernel.org silently discards all mail above 100KB, see

  http://vger.kernel.org/majordomo-info.html

in the last section.

-- 
Thomas Rast
trast@{inf,student}.ethz.ch
