From: =?ISO-8859-1?Q?Jos=E9?= Fonseca <jrfonseca@tungstengraphics.com>
Subject: Re: [RFE/PATCH] git-fetch-rebase
Date: Sat, 15 Dec 2007 00:37:05 +0000
Message-ID: <1197679025.21175.40.camel@localhost>
References: <1197670351.21175.33.camel@localhost>
	 <7vy7bwomza.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Dec 15 01:38:10 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J3L2g-0000gY-9p
	for gcvg-git-2@gmane.org; Sat, 15 Dec 2007 01:38:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752336AbXLOAhr convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 14 Dec 2007 19:37:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751539AbXLOAhr
	(ORCPT <rfc822;git-outgoing>); Fri, 14 Dec 2007 19:37:47 -0500
Received: from fg-out-1718.google.com ([72.14.220.153]:12570 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750777AbXLOAhq (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 14 Dec 2007 19:37:46 -0500
Received: by fg-out-1718.google.com with SMTP id e21so12973fga.17
        for <git@vger.kernel.org>; Fri, 14 Dec 2007 16:37:45 -0800 (PST)
Received: by 10.86.50.8 with SMTP id x8mr3613232fgx.30.1197679064855;
        Fri, 14 Dec 2007 16:37:44 -0800 (PST)
Received: from ?192.168.0.105? ( [87.196.18.52])
        by mx.google.com with ESMTPS id 4sm6699241fgg.2007.12.14.16.37.43
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 14 Dec 2007 16:37:44 -0800 (PST)
In-Reply-To: <7vy7bwomza.fsf@gitster.siamese.dyndns.org>
X-Mailer: Evolution 2.12.2 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/68365>

On Fri, 2007-12-14 at 15:50 -0800, Junio C Hamano wrote:
> Jos=E9 Fonseca <jrfonseca@tungstengraphics.com> writes:
>=20
> > For those who use git as a better centralized SCM, it became a comm=
on
> > practice to do git-fetch + git-rebase instead of just git-pull, so =
that
> > the history is linear, instead of being full of tiny merges.=20
>=20
> "git pull --rebase"?

I didn't find it before. It seems a very recent functionality. Anyway,
I'm glad it exists now.

Cheers,

Jos=E9 Fonseca
