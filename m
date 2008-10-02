From: Wincent Colaiuta <win@wincent.com>
Subject: Re: [PATCH] git commit: Repaint the output format bikeshed (again)
Date: Thu, 2 Oct 2008 10:36:31 +0200
Message-ID: <FDB56497-8600-40DA-994D-7A519B0BABE3@wincent.com>
References: <20081001154425.GE21310@spearce.org> <48E3E66E.7020501@op5.se> <20081001220604.GB18058@coredump.intra.peff.net>
Mime-Version: 1.0 (Apple Message framework v926)
Content-Type: text/plain; charset=ISO-8859-1;
	format=flowed	delsp=yes
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Andreas Ericsson <ae@op5.se>, Shawn Pearce <spearce@spearce.org>,
	Git Mailing List <git@vger.kernel.org>
To: Jeff King <jrk@wrek.org>
X-From: git-owner@vger.kernel.org Thu Oct 02 10:38:45 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KlJhm-0002g0-Sa
	for gcvg-git-2@gmane.org; Thu, 02 Oct 2008 10:38:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752985AbYJBIgn convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 2 Oct 2008 04:36:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752993AbYJBIgn
	(ORCPT <rfc822;git-outgoing>); Thu, 2 Oct 2008 04:36:43 -0400
Received: from wincent1.inetu.net ([209.235.192.161]:38584 "EHLO
	wincent1.inetu.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752953AbYJBIgl convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 2 Oct 2008 04:36:41 -0400
Received: from cuzco.lan (208.pool85-53-6.dynamic.orange.es [85.53.6.208])
	(authenticated bits=0)
	by wincent1.inetu.net (8.13.8/8.13.8) with ESMTP id m928aW6g005497
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NO);
	Thu, 2 Oct 2008 04:36:35 -0400
In-Reply-To: <20081001220604.GB18058@coredump.intra.peff.net>
X-Mailer: Apple Mail (2.926)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/97293>

El 2/10/2008, a las 0:06, Jeff King escribi=F3:

> better. But in the interests of just agreeing on something, I am =20
> willing
> to accept this. FWIW, the git-reset command doesn't use any delimiter
> for the message:
>
>   <branch> is now at <hash> <subject>
>
> So perhaps they should be the same. I don't think it overly matters.

If you're wanting to trim horizontal fat then the "is" isn't really =20
required.

<branch> now at <hash> <subject>

Reads just as well.

Cheers,
Wincent
