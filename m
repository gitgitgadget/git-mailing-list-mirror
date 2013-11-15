From: ycollette.nospam@free.fr
Subject: Re: Add a bugzilla website
Date: Fri, 15 Nov 2013 11:34:17 +0100 (CET)
Message-ID: <361384464.315129845.1384511657291.JavaMail.root@zimbra35-e6.priv.proxad.net>
References: <20131115135132.431d3e344dadee64e2be5127@domain007.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Nov 15 11:34:35 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VhGjT-0005yR-7B
	for gcvg-git-2@plane.gmane.org; Fri, 15 Nov 2013 11:34:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754182Ab3KOKe1 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 15 Nov 2013 05:34:27 -0500
Received: from smtp4-g21.free.fr ([212.27.42.4]:53564 "EHLO smtp4-g21.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752951Ab3KOKeZ convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 15 Nov 2013 05:34:25 -0500
Received: from zimbra35-e6.priv.proxad.net (unknown [172.20.243.185])
	by smtp4-g21.free.fr (Postfix) with ESMTP id 8C6964C81EE
	for <git@vger.kernel.org>; Fri, 15 Nov 2013 11:34:18 +0100 (CET)
In-Reply-To: <20131115135132.431d3e344dadee64e2be5127@domain007.com>
X-Originating-IP: [93.31.210.54]
X-Mailer: Zimbra 7.2.0-GA2598 (ZimbraWebClient - FF3.0 (Win)/7.2.0-GA2598)
X-Authenticated-User: ycollette.nospam@free.fr
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/237897>

OK, thanks for these informations.
=46rom a user perspective, having this volume of devel mails flooding a=
ll the bugs mail is very annoying.
And following the status of a bug and the history of this bug is very h=
ard too.
The bugzilla approach is really useful for the user who is reporting bu=
gs: all the bugs are tracked, you can see if a bug has been already fil=
led and put some additional informations if necessary.

I will have a look at the JIRA thing.

YC

----- Mail original -----
De: "Konstantin Khomoutov" <flatworm@users.sourceforge.net>
=C3=80: "ycollette nospam" <ycollette.nospam@free.fr>
Cc: git@vger.kernel.org
Envoy=C3=A9: Vendredi 15 Novembre 2013 10:51:32
Objet: Re: Add a bugzilla website

On Fri, 15 Nov 2013 10:40:47 +0100 (CET)
ycollette.nospam@free.fr wrote:

> And the conclusion is ? No bugzilla tool installed because somebody
> want to build a gitbased bugzilla thing ?

Well, no, the real answer is that for those who actually write code and
apply patches, an e-mail based workflow is simpler: Git has tools to
apply patches right from Unix mailboxes, so one is able to just save a
thread with the final patch series to a file and apply it.  Some people
also prefer discussing patches inline -- in the same e-mail thread
the patch series being discussed had started.

I'm aware of at least one big project sporting the same approach
to handling bugs -- PostgreSQL.

But there was an announcement that an experimental JIRA instance has
been set up for Git [1].  I'm not sure what its current status is, but
you could look at it.

Also Git's mirror on github [2] supposedly provides for pull requests.
Again, not sure whether/how they're handled.

1. http://git-blame.blogspot.ru/2012/02/experimental-git-bug-tracker.ht=
ml
2. https://github.com/git/git/
