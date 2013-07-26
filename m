From: Konstantin Khomoutov <flatworm@users.sourceforge.net>
Subject: Re: Why can't I push from a shallow clone?
Date: Fri, 26 Jul 2013 13:38:52 +0400
Message-ID: <20130726133852.f1f9a1cc9c9207e5bbb74013@domain007.com>
References: <CANEZYrdsCgH+3NnZnnmsn_znt=+01aNn02u4mWyb3td9XypUog@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Gulshan Singh <gsingh2011@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jul 26 11:39:02 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V2eUH-000792-K4
	for gcvg-git-2@plane.gmane.org; Fri, 26 Jul 2013 11:39:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751058Ab3GZJi5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 26 Jul 2013 05:38:57 -0400
Received: from mailhub.007spb.ru ([84.204.203.130]:56891 "EHLO
	mailhub.007spb.ru" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750699Ab3GZJi5 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 26 Jul 2013 05:38:57 -0400
Received: from programmer.Domain007.com (programmer.domain007.com [192.168.2.100])
	by mailhub.007spb.ru (8.14.3/8.14.3/Debian-5+lenny1) with SMTP id r6Q9cqee030466;
	Fri, 26 Jul 2013 13:38:53 +0400
In-Reply-To: <CANEZYrdsCgH+3NnZnnmsn_znt=+01aNn02u4mWyb3td9XypUog@mail.gmail.com>
X-Mailer: Sylpheed 3.3.0 (GTK+ 2.10.14; i686-pc-mingw32)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/231175>

On Thu, 25 Jul 2013 19:33:16 -0700
Gulshan Singh <gsingh2011@gmail.com> wrote:

> I've been trying to figure out why I can't push from a shallow clone
> (using --depth) to a repository. I've made simple examples where it
> works, but I've read that in doesn't work in every case. However, I
> can't come up with a case where it doesn't work. Googling gives this
> answer:
> http://stackoverflow.com/questions/6900103/why-cant-i-push-from-a-shallow-clone,
> but I don't completely understand the explanation, so I was hoping
> someone could explain it.

See also this thread [1] which originated from this SO question [2].

1. http://thread.gmane.org/gmane.comp.version-control.git/221634
2. http://stackoverflow.com/q/16077691/720999
