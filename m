From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
	<ukleinek@informatik.uni-freiburg.de>
Subject: Re: [StGit PATCH 1/6] Split git.merge into two functions
Date: Tue, 21 Aug 2007 21:35:05 +0200
Organization: Universitaet Freiburg, Institut f. Informatik
Message-ID: <20070821193504.GA20823@informatik.uni-freiburg.de>
References: <11875975232619-git-send-email-davidk@lysator.liu.se> <1187597523433-git-send-email-davidk@lysator.liu.se> <87odh2d1q7.fsf@morpheus.local> <7vejhxrcgl.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: David =?iso-8859-1?Q?K=E5gedal?= <davidk@lysator.liu.se>,
	git <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Aug 21 21:35:26 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1INZVd-0002hF-4y
	for gcvg-git@gmane.org; Tue, 21 Aug 2007 21:35:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753153AbXHUTfT convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Tue, 21 Aug 2007 15:35:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753347AbXHUTfT
	(ORCPT <rfc822;git-outgoing>); Tue, 21 Aug 2007 15:35:19 -0400
Received: from atlas.informatik.uni-freiburg.de ([132.230.150.3]:39955 "EHLO
	atlas.informatik.uni-freiburg.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750819AbXHUTfQ (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 21 Aug 2007 15:35:16 -0400
Received: from login.informatik.uni-freiburg.de ([132.230.151.6])
	by atlas.informatik.uni-freiburg.de with esmtps (TLSv1:DES-CBC3-SHA:168)
	(Exim 4.66)
	(envelope-from <zeisberg@informatik.uni-freiburg.de>)
	id 1INZVP-0005Z9-R8; Tue, 21 Aug 2007 21:35:11 +0200
Received: from login.informatik.uni-freiburg.de (localhost [127.0.0.1])
	by login.informatik.uni-freiburg.de (8.13.8+Sun/8.12.11) with ESMTP id l7LJZ9Eb021080;
	Tue, 21 Aug 2007 21:35:09 +0200 (MEST)
Received: (from zeisberg@localhost)
	by login.informatik.uni-freiburg.de (8.13.8+Sun/8.12.11/Submit) id l7LJZ5SX021079;
	Tue, 21 Aug 2007 21:35:05 +0200 (MEST)
Mail-Followup-To: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <ukleinek@informatik.uni-freiburg.de>,
	Junio C Hamano <gitster@pobox.com>,
	David =?iso-8859-1?Q?K=E5gedal?= <davidk@lysator.liu.se>,
	git <git@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <7vejhxrcgl.fsf@gitster.siamese.dyndns.org>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/56324>

Hello David,

Junio C Hamano wrote:
> David K=E5gedal <davidk@lysator.liu.se> writes:
>=20
> > David K=E5gedal <davidk@lysator.liu.se> writes:
> >
> > It seems that git-send-email didn't like me for some reason.  Doubl=
e
> > UTF-8 encoding is not very pretty.
>=20
> I believe Uwe (CC'ed) had a few patches to deal with this area.
> Do they help?
My patches are already in next, the relevant being probably
v1.5.3-rc4-38-g94638f8.

David, can you retry with a more recent version that includes that
patch?

And IIRC send-email expects the patch being encoded in UTF-8, but I'm
not sure.  If you could send me the patches you sent as a tar-ball or
something similar, I can look into it.

Best regards
Uwe

--=20
Uwe Kleine-K=F6nig

$ dc << EOF
[d1-d1<a]sa99d1<a1[rdn555760928P*pz1<a]salax
EOF
