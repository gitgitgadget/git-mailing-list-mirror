From: Robin Rosenberg <robin.rosenberg.lists@dewire.com>
Subject: Re: jGit Eclipse Plugin Feature
Date: Sat, 7 Mar 2009 18:45:20 +0100
Message-ID: <200903071845.20855.robin.rosenberg.lists@dewire.com>
References: <efe536470903070205w1dbff989je6dd6126d09e4a74@mail.gmail.com> <49B299B7.80009@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Robert Navarro <crshman@gmail.com>, git@vger.kernel.org
To: Tor Arne =?iso-8859-1?q?Vestb=F8?= <torarnv@gmail.com>
X-From: git-owner@vger.kernel.org Sat Mar 07 18:55:30 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lg0kB-0007Nz-GN
	for gcvg-git-2@gmane.org; Sat, 07 Mar 2009 18:55:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755175AbZCGRuI convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 7 Mar 2009 12:50:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753613AbZCGRuI
	(ORCPT <rfc822;git-outgoing>); Sat, 7 Mar 2009 12:50:08 -0500
Received: from mail.dewire.com ([83.140.172.130]:24368 "EHLO dewire.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751870AbZCGRuH convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 7 Mar 2009 12:50:07 -0500
Received: from localhost (localhost [127.0.0.1])
	by dewire.com (Postfix) with ESMTP id E998815E0DF2;
	Sat,  7 Mar 2009 18:49:58 +0100 (CET)
X-Virus-Scanned: by amavisd-new at dewire.com
Received: from dewire.com ([127.0.0.1])
	by localhost (torino.dewire.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id K5BjGZhAj0p8; Sat,  7 Mar 2009 18:49:58 +0100 (CET)
Received: from sleipner.localnet (unknown [10.9.0.5])
	by dewire.com (Postfix) with ESMTP id F221215E0DF1;
	Sat,  7 Mar 2009 18:49:57 +0100 (CET)
User-Agent: KMail/1.11.1 (Linux/2.6.27-12-generic; KDE/4.2.1; i686; ; )
In-Reply-To: <49B299B7.80009@gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/112557>

l=F6rdag 07 mars 2009 16:58:47 skrev Tor Arne Vestb=F8 <torarnv@gmail.c=
om>:
> Robert Navarro wrote:
> > Hello,
> >=20
> > Sorry about my last "subscribe" email, skipped over this part in th=
e
> > wiki...."You don't even need to be subscribed to post, just send an
> > email to: "
> >=20
> > Anyways.....I wasn't sure where to post this but I'll give it a sho=
t
> > here.....I know there is an eclipse jGit plugin in the works and I
> > wanted to know if it would be possible to get a remember or recentl=
y
> > used servers feature added to the push/pull feature.
>=20
> I have done some initial prototyping of a Remotes View. I'll see if I
> can bring that to life somehow.

I assumed the feature is about the push dialog. If we have a remotes
view it'd be nice to see it there too. Where should it remembered? In
the workspace or .git/config?

-- robin
