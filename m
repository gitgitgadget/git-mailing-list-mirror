From: Christian Couder <chriscool@tuxfamily.org>
Subject: Re: Google Summer of Code 2009
Date: Mon, 12 Jan 2009 14:20:25 +0100
Message-ID: <200901121420.25420.chriscool@tuxfamily.org>
References: <20090107183033.GB10790@spearce.org> <496B2690.2010902@op5.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: "Shawn O. Pearce" <spearce@spearce.org>, git@vger.kernel.org
To: Andreas Ericsson <ae@op5.se>
X-From: git-owner@vger.kernel.org Mon Jan 12 14:21:11 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LMMj6-0001Sq-1t
	for gcvg-git-2@gmane.org; Mon, 12 Jan 2009 14:21:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751804AbZALNTo convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 12 Jan 2009 08:19:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751778AbZALNTo
	(ORCPT <rfc822;git-outgoing>); Mon, 12 Jan 2009 08:19:44 -0500
Received: from smtp1-g21.free.fr ([212.27.42.1]:58768 "EHLO smtp1-g21.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751523AbZALNTn convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 12 Jan 2009 08:19:43 -0500
Received: from smtp1-g21.free.fr (localhost [127.0.0.1])
	by smtp1-g21.free.fr (Postfix) with ESMTP id 7C310940130;
	Mon, 12 Jan 2009 14:19:35 +0100 (CET)
Received: from bureau.boubyland (gre92-7-82-243-130-161.fbx.proxad.net [82.243.130.161])
	by smtp1-g21.free.fr (Postfix) with ESMTP id 9719B940162;
	Mon, 12 Jan 2009 14:19:33 +0100 (CET)
User-Agent: KMail/1.9.9
In-Reply-To: <496B2690.2010902@op5.se>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/105339>

Le lundi 12 janvier 2009, Andreas Ericsson a =E9crit :
> Just chiming in that I can probably help mentoring whoever goes
> with libgit2. I do not have enough spare time for me to promise
> that I can be there as much as I think is necessary and proper,
> but I'll gladly help out.
>
> On a side-note, I think all mentors should urge the students in
> the strongest possible terms to deliver their work to git@vger
> as soon as possible.=20

I agree, but I think there is also a merge problem. I mean we should al=
so=20
perhaps urge students to get what they have done merged as soon as poss=
ible=20
even if it means that they rework 5 or 10 time the code instead of=20
developing features according to the schedule.

But unfortunately even something merged into next can be removed afterw=
ards,=20
so it's really difficult, because big features cannot for obvious reaso=
ns=20
be merged into master and the git release cycle doesn't always go along=
=20
well with the GSoC schedule.

> From previous years experience, successful=20
> projects are those that the list sees code from within a week
> or two after the project's started, while the projects that are
> kept in the dark rarely (if ever?) finish successfully.

I don't think things are so simple.

Regards,
Christian.
