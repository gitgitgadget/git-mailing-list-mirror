From: =?ISO-8859-1?Q?Ren=E9_Scharfe?= <rene.scharfe@lsrfire.ath.cx>
Subject: Re: [PATCH] grep: don't support "grep.color"-like config options
Date: Tue, 21 Apr 2009 17:45:29 +0200
Message-ID: <49EDEA19.2000900@lsrfire.ath.cx>
References: <1240268295-10296-1-git-send-email-markus.heidelberg@web.de> <alpine.DEB.1.00.0904210145260.10279@pacific.mpi-cbg.de> <7vy6tua6uh.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Markus Heidelberg <markus.heidelberg@web.de>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Apr 21 17:48:15 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LwICY-0007Jg-EM
	for gcvg-git-2@gmane.org; Tue, 21 Apr 2009 17:48:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753037AbZDUPpz convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 21 Apr 2009 11:45:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752982AbZDUPpz
	(ORCPT <rfc822;git-outgoing>); Tue, 21 Apr 2009 11:45:55 -0400
Received: from india601.server4you.de ([85.25.151.105]:35066 "EHLO
	india601.server4you.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752512AbZDUPpy (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 21 Apr 2009 11:45:54 -0400
Received: from [10.0.1.101] (p57B7DCA4.dip.t-dialin.net [87.183.220.164])
	by india601.server4you.de (Postfix) with ESMTPSA id F14952F8028;
	Tue, 21 Apr 2009 17:45:51 +0200 (CEST)
User-Agent: Thunderbird 2.0.0.21 (Windows/20090302)
In-Reply-To: <7vy6tua6uh.fsf@gitster.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/117134>

Junio C Hamano schrieb:
> While I do not think these lines themselves will cost us a lot of
> maintenance effort, people tend to mimick existing code, and these
> patterns can proliferate if unchecked, and *that* would add to
> maintenance.

I have to admit that I blindly copied these option names from diff to g=
rep..

> As the feature has aleady been in master for 6 weeks or so,
> Markus's patch is now-or-never, and I'd rather say we take it before =
the
> 1.6.3 final.

Agreed.

Ren=E9
