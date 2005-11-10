From: Ben Clifford <benc@hawaga.org.uk>
Subject: Re: latest stg/git commandline completions code
Date: Thu, 10 Nov 2005 12:59:09 +1100
Message-ID: <33CE6BA8-415D-405F-89B3-982811C3A0CF@hawaga.org.uk>
References: <Pine.LNX.4.60.0510251222510.8565@mundungus.clifford.ac> <200510251642.46169.blaisorblade@yahoo.it> <A44A02AA-BDA8-4623-825E-288F1107A5ED@hawaga.org.uk> <20051109222338.GK16061@pasky.or.cz>
Mime-Version: 1.0 (Apple Message framework v734)
Content-Type: text/plain; charset=UTF-8;
	delsp=yes	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>,
	Blaisorblade <blaisorblade@yahoo.it>
X-From: git-owner@vger.kernel.org Thu Nov 10 03:01:00 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Ea1is-0008Pd-23
	for gcvg-git@gmane.org; Thu, 10 Nov 2005 02:59:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751498AbVKJB7T convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Wed, 9 Nov 2005 20:59:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751658AbVKJB7S
	(ORCPT <rfc822;git-outgoing>); Wed, 9 Nov 2005 20:59:18 -0500
Received: from mundungus.clifford.ac ([81.187.211.39]:26892 "EHLO
	mundungus.clifford.ac") by vger.kernel.org with ESMTP
	id S1751498AbVKJB7Q convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 9 Nov 2005 20:59:16 -0500
Received: from [127.0.0.1] (localhost [127.0.0.1])
	by mundungus.clifford.ac (8.13.3/8.13.3) with ESMTP id jAA1x3xn018090;
	Thu, 10 Nov 2005 01:59:07 GMT
In-Reply-To: <20051109222338.GK16061@pasky.or.cz>
To: Petr Baudis <pasky@suse.cz>
X-Mailer: Apple Mail (2.734)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/11459>


On 10 Nov 2005, at 09:23, Petr Baudis wrote:
>
> Nice, I would like to add cg completion to Cogito's contrib/ - =20
> could you
> please add some header to it with (c) information and stuff? (And mak=
e
> it available somewhere just as a plain file.)

OK, will do.

> Besides, it would be probably best to just autogenerate the
> auto-completion code - the usage information in Cogito is supposed =20
> to be
> 100% consistent and correct, so it should be a reliable source for =20
> that.

yeah, I was thinking about that this morning -- maybe I'll be in the =20
mood to implement...

There are a few small common functions that are used by all the git =20
completions, though. I suppose for going into cogito's contrib/ I =20
should include them directly in cogito completion code, but that =20
seems a little messy, as it would be nice to keep them in-sync with =20
what is used in the other completion files. hmm.

Ben

--=20
Ben =E3=83=99=E3=83=B3 =D0=91=D1=8D=D0=BD
http://www.hawaga.org.uk/ben/
