From: =?ISO-8859-1?Q?Gr=E9goire_Barbier?= <devel@gbarbier.org>
Subject: Re: Project Hosting with git ?
Date: Sat, 12 Jan 2008 19:01:28 +0100
Message-ID: <47890078.3050809@gbarbier.org>
References: <912ec82a0801120553u3621c991u7c4cb4793960159c@mail.gmail.com>	 <9b3e2dc20801120845n15d59fe6q178ba257c12a28e0@mail.gmail.com>	 <4788FBDE.6090903@gbarbier.org> <9b3e2dc20801120954k24f7ccb6vf019f30843ff1b84@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Stephen Sinclair <radarsat1@gmail.com>
X-From: git-owner@vger.kernel.org Sat Jan 12 19:01:55 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JDkg6-0003kG-75
	for gcvg-git-2@gmane.org; Sat, 12 Jan 2008 19:01:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754998AbYALSB0 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 12 Jan 2008 13:01:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754742AbYALSB0
	(ORCPT <rfc822;git-outgoing>); Sat, 12 Jan 2008 13:01:26 -0500
Received: from relay4-v.mail.gandi.net ([217.70.178.78]:33353 "EHLO
	relay4-v.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753884AbYALSB0 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 12 Jan 2008 13:01:26 -0500
Received: from localhost (mfilter3-v.gandi.net [217.70.178.37])
	by relay4-v.mail.gandi.net (Postfix) with ESMTP id 2F81FBA26;
	Sat, 12 Jan 2008 19:01:23 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at mfilter3-v.mgt.gandi.net
Received: from relay4-v.mail.gandi.net ([217.70.178.78])
	by localhost (mfilter3-v.mgt.gandi.net [217.70.178.37]) (amavisd-new, port 10024)
	with ESMTP id e1tQXxy8cQDA; Sat, 12 Jan 2008 18:26:03 +0100 (CET)
Received: from [192.168.79.1] (soy95-1-82-229-96-169.fbx.proxad.net [82.229.96.169])
	by relay4-v.mail.gandi.net (Postfix) with ESMTP id E5038BA17;
	Sat, 12 Jan 2008 19:01:21 +0100 (CET)
User-Agent: Thunderbird 2.0.0.9 (Windows/20071031)
In-Reply-To: <9b3e2dc20801120954k24f7ccb6vf019f30843ff1b84@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/70339>

Stephen Sinclair a =E9crit :
>> I disagree: git does not work "fine" over http, it only works fine f=
or
>> fetch/pull.
>=20
> You're taking me out of context.  I meant it works fine for public
> hosting so that users can easily clone and create patches.  This is
> the main motivation for publishing your repo, so in that sense it
> "works fine".  (for me)

I agree.

> Since SF supports ssh, there's no reason to need http-push.  I wish
> they would just provide some recent git binaries on the sourceforge
> server, then we could git-push properly over ssh instead of using to
> use scp or rsync.  I think that would be a good start. *shrug*
>=20
> In any case, http-push over webdav would still require git binaries t=
o
> be installed somewhere on SF, so it's essentially the same problem.

I don't think so. A working http-push over webdav would be a dumb=20
protocol (passive filesystem upload).
However as you said before, this would not be taken in account by SF=20
statistics and menus.

--=20
Gr=E9goire Barbier - gb =E0 gbarbier.org - +33 6 21 35 73 49
