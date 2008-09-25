From: Andreas Ericsson <ae@op5.se>
Subject: Re: On Sponsor Notices
Date: Thu, 25 Sep 2008 08:12:48 +0200
Message-ID: <48DB2BE0.208@op5.se>
References: <20080924204358.144077183@suse.cz> <20080924225120.GL10544@machine.or.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, spearce@spearce.org
To: Petr Baudis <pasky@suse.cz>
X-From: git-owner@vger.kernel.org Thu Sep 25 08:14:23 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Kik7J-0004qd-EH
	for gcvg-git-2@gmane.org; Thu, 25 Sep 2008 08:14:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752179AbYIYGNH convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 25 Sep 2008 02:13:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751684AbYIYGNG
	(ORCPT <rfc822;git-outgoing>); Thu, 25 Sep 2008 02:13:06 -0400
Received: from mail.op5.se ([193.201.96.20]:39393 "EHLO mail.op5.se"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751401AbYIYGNF (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 25 Sep 2008 02:13:05 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.op5.se (Postfix) with ESMTP id 05AD724B0042;
	Thu, 25 Sep 2008 08:03:47 +0200 (CEST)
X-Virus-Scanned: amavisd-new at 
X-Spam-Flag: NO
X-Spam-Score: -3.072
X-Spam-Level: 
X-Spam-Status: No, score=-3.072 tagged_above=-10 required=6.6
	tests=[AWL=-0.573, BAYES_00=-2.599, RDNS_NONE=0.1]
Received: from mail.op5.se ([127.0.0.1])
	by localhost (mail.op5.se [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id xxNbmjuyswNy; Thu, 25 Sep 2008 08:03:43 +0200 (CEST)
Received: from clix.int.op5.se (unknown [172.27.78.6])
	by mail.op5.se (Postfix) with ESMTP id 89C9A24B005A;
	Thu, 25 Sep 2008 08:03:42 +0200 (CEST)
User-Agent: Thunderbird 2.0.0.16 (X11/20080723)
In-Reply-To: <20080924225120.GL10544@machine.or.cz>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/96725>

Petr Baudis wrote:
>   Hi,
>=20
>   to follow up a little on the "This patch has been sponsored by
> Novartis" messages - I have been on a summer internship at Novartis b=
usy
> deploying Git and these patches (still quite a few more to come, most=
ly
> for gitweb) have been one of the main outputs of that work.
>=20
>   However, I'm not sure if acknowledging the Novartis-originated patc=
hes
> in the log message like this is the best practice and we will underst=
and
> if the maintainers will decide to strip these notices when applying t=
he
> patches. Usually, this kind of acknowledgement is made by using
> "sponsored" email addresses, however mine will probably stop working
> shortly after I leave and the only way to read it is, shall we say,
> utmostly inconvenient. ;-) Now, Shawn has proposed 'Sponsored-by:' li=
ne
> at the header footer, which is also an interesting possibility.
>=20

I like the "Sponsored-by" idea. I work for a company that sponsors quit=
e
a lot, and I thoroughly enjoy the idea that I can one day go to my boss
and say "hey, our company name is clearly visible here. We've sent this
many patches that got accepted upstream", and that other companies can
see that too.

As for the legal S-o-b stuff, I'd say a combination like this:
Sponsored-by: Example <contact@example.com>
Signed-off-by: Casper Intern (for Example) <random@real.com>

should work wonderfully. I know the guys holding the money like to see
the company name so it's a good thing to do to get a company to sponsor
development further, while the S-o-b marks the person responsible for
posting the patches to the project.

Just my =A40.02.

--=20
Andreas Ericsson                   andreas.ericsson@op5.se
OP5 AB                             www.op5.se
Tel: +46 8-230225                  Fax: +46 8-230231
