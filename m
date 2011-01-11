From: Stephen Bash <bash@genarts.com>
Subject: Re: git-repack & big files
Date: Tue, 11 Jan 2011 14:12:40 -0500 (EST)
Message-ID: <19558451.124576.1294773160655.JavaMail.root@mail.hq.genarts.com>
References: <1294772603.3435.67.camel@voubian.casa>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Phillip Susi <psusi@cfl.rr.com>
To: Pietro Battiston <me@pietrobattiston.it>
X-From: git-owner@vger.kernel.org Tue Jan 11 20:13:00 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PcjeN-00051O-US
	for gcvg-git-2@lo.gmane.org; Tue, 11 Jan 2011 20:13:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932606Ab1AKTMz convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 11 Jan 2011 14:12:55 -0500
Received: from hq.genarts.com ([173.9.65.1]:20685 "HELO mail.hq.genarts.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S932543Ab1AKTMy convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 11 Jan 2011 14:12:54 -0500
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.hq.genarts.com (Postfix) with ESMTP id 248C71E26043;
	Tue, 11 Jan 2011 14:12:47 -0500 (EST)
X-Virus-Scanned: amavisd-new at mail.hq.genarts.com
Received: from mail.hq.genarts.com ([127.0.0.1])
	by localhost (mail.hq.genarts.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id XuJ0SDWYNV1C; Tue, 11 Jan 2011 14:12:40 -0500 (EST)
Received: from mail.hq.genarts.com (mail.hq.genarts.com [10.102.202.62])
	by mail.hq.genarts.com (Postfix) with ESMTP id B5FC11E2604F;
	Tue, 11 Jan 2011 14:12:40 -0500 (EST)
In-Reply-To: <1294772603.3435.67.camel@voubian.casa>
X-Mailer: Zimbra 6.0.10_GA_2692 (ZimbraWebClient - SAF3 (Mac)/6.0.10_GA_2692)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/164975>

----- Original Message -----
> From: "Pietro Battiston" <me@pietrobattiston.it>
> To: "Phillip Susi" <psusi@cfl.rr.com>
> Sent: Tuesday, January 11, 2011 2:03:23 PM
> Subject: Re: git-repack & big files
>
> > > 2) do I have any hope that in one way or another my 500+ MB
> > > mailboxes
> > > with relatively small changes over time are archived smartly
> > > (=3Ddiffs) by
> > > git at the current state of development? If I understand
> > > correctly, the
> > > project git-bigfiles=C2=B3 would just "solve" my problems by not =
making
> > > differences of big files.
> >
> > Git is not a backup tool. You should use rsync rdiff-backup instead=
=2E
>=20
> That's unfortunate - I think I prefer to split my mailboxes than to
> loose many of the nice features git provides. But thanks a lot for th=
e
> suggestion.

Off topic: Do you have the option to change to a solution that uses Mai=
lDir as the storage format rather than mbox?
  =20
   http://en.wikipedia.org/wiki/Maildir

Stephen
