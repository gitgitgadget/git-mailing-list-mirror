From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <Uwe.Kleine-Koenig@digi.com>
Subject: Re: [PATCH] bash completion only provides revs, not paths
Date: Thu, 24 Apr 2008 07:52:51 +0200
Message-ID: <20080424055251.GA17978@digi.com>
References: <20080422112129.GA30923@digi.com> <20080423015236.GM29771@spearce.org> <20080423055637.GA25446@digi.com> <20080424012129.GU29771@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, <git@vger.kernel.org>
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Thu Apr 24 08:01:45 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JouWW-0000nh-QD
	for gcvg-git-2@gmane.org; Thu, 24 Apr 2008 08:01:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752892AbYDXGAc convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 24 Apr 2008 02:00:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753279AbYDXGAb
	(ORCPT <rfc822;git-outgoing>); Thu, 24 Apr 2008 02:00:31 -0400
Received: from mail164.messagelabs.com ([216.82.253.131]:15743 "EHLO
	mail164.messagelabs.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752892AbYDXGAa (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 24 Apr 2008 02:00:30 -0400
X-VirusChecked: Checked
X-Env-Sender: Uwe.Kleine-Koenig@digi.com
X-Msg-Ref: server-4.tower-164.messagelabs.com!1209016828!9818575!2
X-StarScan-Version: 5.5.12.14.2; banners=-,-,-
X-Originating-IP: [66.77.174.13]
Received: (qmail 32312 invoked from network); 24 Apr 2008 06:00:29 -0000
Received: from mail.mx1.digi.com (HELO mcl-sms-ns1.digi.com) (66.77.174.13)
  by server-4.tower-164.messagelabs.com with RC4-SHA encrypted SMTP; 24 Apr 2008 06:00:29 -0000
Received: from mcl-sms-exch01.digi.com (10.5.8.50) by mail.mx1.digi.com
 (172.16.1.13) with Microsoft SMTP Server (TLS) id 8.1.263.0; Thu, 24 Apr 2008
 01:00:36 -0500
Received: from mtk-sms-mail01.digi.com (10.10.8.120) by
 mcl-sms-exch01.digi.com (10.5.8.50) with Microsoft SMTP Server id 8.1.263.0;
 Thu, 24 Apr 2008 01:00:27 -0500
Received: from dor-sms-mail1.digi.com ([10.49.1.105]) by
 mtk-sms-mail01.digi.com with Microsoft SMTPSVC(6.0.3790.3959);	 Thu, 24 Apr
 2008 00:52:54 -0500
Received: from zentaur.digi.com ([10.100.10.144]) by dor-sms-mail1.digi.com
 with Microsoft SMTPSVC(6.0.3790.3959);	 Thu, 24 Apr 2008 07:52:51 +0200
Received: by zentaur.digi.com (Postfix, from userid 1080)	id 76C5E2AB13; Thu,
 24 Apr 2008 07:52:51 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <20080424012129.GU29771@spearce.org>
User-Agent: Mutt/1.5.13 (2006-08-11)
X-OriginalArrivalTime: 24 Apr 2008 05:52:51.0889 (UTC) FILETIME=[6EFC2210:01C8A5CF]
X-TM-AS-Product-Ver: SMEX-8.0.0.1181-5.500.1026-15866.007
X-TM-AS-Result: No--19.646000-8.000000-31
X-TM-AS-User-Approved-Sender: No
X-TM-AS-User-Blocked-Sender: No
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/80291>

Hello,

Shawn O. Pearce wrote:
> Uwe Kleine-Knig <Uwe.Kleine-Koenig@digi.com> wrote:
> > > How is this?
> >
> > I like it and have already applied it.
> ...
> > > Suggested-by: Uwe Kleine-Knig <Uwe.Kleine-Koenig@digi.com>
> >
> > There is a letter missing in my name.  I wonder why it's always the=
 only
> > non-ascii one :-)
>=20
> Damn.  I'm sorry.  My mailer seems to be dropping it when I
> quote you, and I copied your name from the "... wrote:" line
> at the top of my message.  I should have copied from the
> To: header, where it hasn't been munged.
=46ine.

BTW, even with your patch the problem still exists for git-diff.  I
havn't yet looked into it.

Uwe

--=20
Uwe Kleine-K=F6nig, Software Engineer
Digi International GmbH Branch Breisach, K=FCferstrasse 8, 79206 Breisa=
ch, Germany
Tax: 315/5781/0242 / VAT: DE153662976 / Reg. Amtsgericht Dortmund HRB 1=
3962
