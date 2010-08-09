From: Mihamina Rakotomandimby <mihamina@gulfsat.mg>
Subject: workflow with blessed, lieutenant, and developers
Date: Mon, 9 Aug 2010 09:21:52 +0300
Organization: GULFSAT
Message-ID: <20100809092152.5f32646a@packard.rktmb.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Aug 09 08:22:25 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OiLkd-0000gQ-GM
	for gcvg-git-2@lo.gmane.org; Mon, 09 Aug 2010 08:22:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752417Ab0HIGWF convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 9 Aug 2010 02:22:05 -0400
Received: from smtp-out.malagasy.com ([41.204.104.33]:41071 "EHLO
	smtp-out.malagasy.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751270Ab0HIGWD convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 9 Aug 2010 02:22:03 -0400
Received: from smtp-1.blueline.mg (unknown [41.204.104.52])
	(using TLSv1 with cipher ADH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp-out.malagasy.com (Postfix) with ESMTPS id 6BE668CC94
	for <git@vger.kernel.org>; Mon,  9 Aug 2010 09:21:59 +0300 (EAT)
Received: from localhost (static-104-53.blueline.mg [41.204.104.53])
	by smtp-1.blueline.mg (Postfix) with ESMTP id 4FCD04A07E
	for <git@vger.kernel.org>; Mon,  9 Aug 2010 09:21:59 +0300 (EAT)
X-Virus-Scanned: par antivirus2.malagasy.com
X-Spam-Flag: NO
X-Spam-Score: -2.664
X-Spam-Level: 
X-Spam-Status: No, score=-2.664 required=7 tests=[AWL=-0.065, BAYES_00=-2.599]
Received: from smtp-1.blueline.mg ([41.204.104.52])
	by localhost (antivirus2.malagasy.com [41.204.104.53]) (amavisd-new, port 10024)
	with ESMTP id UUVsPY+ZxA3E for <git@vger.kernel.org>;
	Mon,  9 Aug 2010 09:21:53 +0300 (EAT)
Received: from packard.rktmb.org (static-104-10.blueline.mg [41.204.104.10])
	by smtp-1.blueline.mg (Postfix) with ESMTP id 778BE4A097
	for <git@vger.kernel.org>; Mon,  9 Aug 2010 09:21:53 +0300 (EAT)
X-Mailer: Claws Mail 3.7.4 (GTK+ 2.20.1; x86_64-pc-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/152952>

Manao ahoana, Hello, Bonjour,
I read http://whygitisbetterthanx.com/#any-workflow.
I might not understand everything but this is what I woudl like to
implement.

I would like to setup a similar thing but with=20
- Only one lieutenant (me)
- A blessed repository where I am the only one to push to
- Developers who push to me (the lieutenant)

Developers pull/clone from the blessed repository.
I initially clone from the blessed repository.

1=B0) What command line do developers use to push to me but not to the
blessed (origin)?
2=B0) After they pushed to me, I have the choice to "approve" or "rejec=
t"
a commit: what is the keyword and git option for that?
3=B0) I push the merge of approved commits to the blessed repository:
what keywords and git options?

Thank you for any tips :-)

Misaotra, Thanks, Merci.

--=20

       Architecte Informatique chez Blueline/Gulfsat:
    Administration Systeme, Recherche & Developpement
                                    +261 34 56 000 19
