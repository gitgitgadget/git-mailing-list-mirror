From: Andreas Ericsson <ae@op5.se>
Subject: Re: git blame crashes with internal error
Date: Sun, 14 Oct 2007 16:51:46 +0200
Message-ID: <47122D02.9060204@op5.se>
References: <20071014143628.GA22568@atjola.homenet>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: gitster@pobox.com, git@vger.kernel.org
To: =?UTF-8?B?QmrDtnJuIFN0ZWluYnJpbms=?= <B.Steinbrink@gmx.de>
X-From: git-owner@vger.kernel.org Sun Oct 14 16:52:06 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ih4ox-0004Yv-QM
	for gcvg-git-2@gmane.org; Sun, 14 Oct 2007 16:52:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754924AbXJNOvu convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 14 Oct 2007 10:51:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755002AbXJNOvt
	(ORCPT <rfc822;git-outgoing>); Sun, 14 Oct 2007 10:51:49 -0400
Received: from mail.op5.se ([193.201.96.20]:44911 "EHLO mail.op5.se"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754924AbXJNOvt (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 14 Oct 2007 10:51:49 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.op5.se (Postfix) with ESMTP id D413E17306EF;
	Sun, 14 Oct 2007 16:49:32 +0200 (CEST)
X-Virus-Scanned: amavisd-new at 
X-Spam-Flag: NO
X-Spam-Score: -2.499
X-Spam-Level: 
X-Spam-Status: No, score=-2.499 tagged_above=-10 required=6.6
	tests=[BAYES_00=-2.599, RDNS_NONE=0.1]
Received: from mail.op5.se ([127.0.0.1])
	by localhost (mail.op5.se [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id LgnKk8j++wvI; Sun, 14 Oct 2007 16:49:32 +0200 (CEST)
Received: from nox.op5.se (unknown [172.27.77.30])
	by mail.op5.se (Postfix) with ESMTP id 5278817306EE;
	Sun, 14 Oct 2007 16:49:32 +0200 (CEST)
User-Agent: Thunderbird 2.0.0.5 (X11/20070727)
In-Reply-To: <20071014143628.GA22568@atjola.homenet>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/60852>

Bj=C3=B6rn Steinbrink wrote:
>=20
> I tried all git releases from 1.5.3 to 1.5.3.4 as well as the current
> master and all of them crashed. A small shell script to reproduce the
> problem is attached.
>=20

Manual bisect? Ugh. This *is* the century of the competent developer
tools, you know... ;-)

--=20
Andreas Ericsson                   andreas.ericsson@op5.se
OP5 AB                             www.op5.se
Tel: +46 8-230225                  Fax: +46 8-230231
