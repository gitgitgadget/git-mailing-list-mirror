From: =?iso-8859-1?Q?Bj=F6rn?= Steinbrink <B.Steinbrink@gmx.de>
Subject: Re: [PATCH] Add option to git-branch to set up automatic rebasing
Date: Thu, 19 Jun 2008 17:43:50 +0200
Message-ID: <20080619154350.GA21625@atjola.homenet>
References: <1213836802-3163-1-git-send-email-pdebie@ai.rug.nl> <alpine.DEB.1.00.0806191459150.6439@racer>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Pieter de Bie <pdebie@ai.rug.nl>,
	Git Mailinglist <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Thu Jun 19 17:46:16 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K9MKg-0005hq-Ld
	for gcvg-git-2@gmane.org; Thu, 19 Jun 2008 17:45:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760559AbYFSPoA convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 19 Jun 2008 11:44:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760554AbYFSPn6
	(ORCPT <rfc822;git-outgoing>); Thu, 19 Jun 2008 11:43:58 -0400
Received: from mail.gmx.net ([213.165.64.20]:34654 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1760487AbYFSPn5 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 19 Jun 2008 11:43:57 -0400
Received: (qmail invoked by alias); 19 Jun 2008 15:43:53 -0000
Received: from i577BB2CE.versanet.de (EHLO atjola.local) [87.123.178.206]
  by mail.gmx.net (mp003) with SMTP; 19 Jun 2008 17:43:53 +0200
X-Authenticated: #5039886
X-Provags-ID: V01U2FsdGVkX19kHKFTrJxkpAfqs7UaJ5tCMZvQ1mWnGUOHZpKRsp
	P0cMIlWDsuluSK
Content-Disposition: inline
In-Reply-To: <alpine.DEB.1.00.0806191459150.6439@racer>
User-Agent: Mutt/1.5.18 (2008-05-17)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/85484>

On 2008.06.19 15:00:19 +0100, Johannes Schindelin wrote:
> Hi,
>=20
> On Thu, 19 Jun 2008, Pieter de Bie wrote:
>=20
> > This functionality was actually introduced in
> >  0a02186f924aee1bd69f18ed01f645aa332ce0d1, but can only be activate=
d by the
> > configuration flag. Now we can also setup auto rebasing using the -=
-rebase
> > flag in git-branch or git-checkout, similar to how --track works.
>=20
> How about "--rebasing"?  I would scratch my head a bit how a new bran=
ch=20
> and a rebase would go together.

Hm, --rebasing sounds weird to me as well. Maybe --track=3Dmerge and
--track=3Drebase, with --track being equal to --track=3Dmerge?

Bj=F6rn
