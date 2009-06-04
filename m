From: Sam Vilain <sam@vilain.net>
Subject: Disappearing submissions to vger
Date: Fri, 05 Jun 2009 08:48:25 +1200
Message-ID: <1244148505.6066.1.camel@maia.lan>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jun 04 22:47:53 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MCJqq-0005bD-0s
	for gcvg-git-2@gmane.org; Thu, 04 Jun 2009 22:47:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751713AbZFDUrm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 4 Jun 2009 16:47:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751457AbZFDUrl
	(ORCPT <rfc822;git-outgoing>); Thu, 4 Jun 2009 16:47:41 -0400
Received: from watts.utsl.gen.nz ([202.78.240.73]:51656 "EHLO mail.utsl.gen.nz"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751364AbZFDUrl (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 4 Jun 2009 16:47:41 -0400
Received: by mail.utsl.gen.nz (Postfix, from userid 1004)
	id 73C6D21CDCC; Fri,  5 Jun 2009 08:47:38 +1200 (NZST)
X-Spam-Checker-Version: SpamAssassin 3.2.5 (2008-06-10) on
	mail.musashi.utsl.gen.nz
X-Spam-Level: 
X-Spam-Status: No, score=-4.3 required=5.0 tests=ALL_TRUSTED,AWL,BAYES_00,
	WEIRD_PORT autolearn=no version=3.2.5
Received: from [192.168.69.182] (203-97-235-49.cable.telstraclear.net [203.97.235.49])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.utsl.gen.nz (Postfix) with ESMTPSA id 9B60D21CCF0
	for <git@vger.kernel.org>; Fri,  5 Jun 2009 08:47:33 +1200 (NZST)
X-Mailer: Evolution 2.24.1 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/120708>

Here are my receipts

Jun  5 02:25:04 mail postfix/smtp[12125]: 881AD21CE1C:
to=<git@vger.kernel.org>, relay=vger.kernel.org[209.132.176.167]:25,
delay=499, delays=497/0.01/0.66/1.4, dsn=2.7.1, status=sent (250 2.7.1
Looks like Linux source DIFF email.. BF:<H 0>; S1757175AbZFDOZA)
Jun  5 02:31:56 mail postfix/smtp[12834]: E92AC21C155:
to=<git@vger.kernel.org>, relay=vger.kernel.org[209.132.176.167]:25,
delay=10, delays=0.02/0.02/9.7/0.73, dsn=2.7.0, status=sent (250 2.7.0
nothing apparently wrong in the message. BF:<H 0>; S1751692AbZFDObx)
Jun  5 02:32:46 mail postfix/smtp[12946]: D608BFD5FC:
to=<git@vger.kernel.org>, relay=vger.kernel.org[209.132.176.167]:25,
delay=5.1, delays=0.9/0.01/0.62/3.6, dsn=2.7.1, status=sent (250 2.7.1
Looks like Linux source DIFF email.. BF:<H 0>; S1752679AbZFDOcm)
Jun  5 02:32:50 mail postfix/smtp[12955]: 3FA82FD5FD:
to=<git@vger.kernel.org>, relay=vger.kernel.org[209.132.176.167]:25,
delay=1.3, delays=0.03/0.01/0.63/0.62, dsn=2.7.1, status=sent (250 2.7.1
Looks like Linux source DIFF email.. BF:<H 0>; S1753489AbZFDOcr)
Jun  5 02:32:55 mail postfix/smtp[12962]: DE0E421CDB9:
to=<git@vger.kernel.org>, relay=vger.kernel.org[209.132.176.167]:25,
delay=1.6, delays=0.03/0.01/0.62/0.92, dsn=2.7.1, status=sent (250 2.7.1
Looks like Linux source DIFF email.. BF:<H 0>; S1752661AbZFDOcw)
Jun  5 02:33:00 mail postfix/smtp[12969]: C0D7713E7B7:
to=<git@vger.kernel.org>, relay=vger.kernel.org[209.132.176.167]:25,
delay=1.9, delays=0.07/0.02/0.62/1.2, dsn=2.7.1, status=sent (250 2.7.1
Looks like Linux source DIFF email.. BF:<H 0>; S1752661AbZFDOc5)
Jun  5 02:33:04 mail postfix/smtp[12969]: C5B8613E7B9:
to=<git@vger.kernel.org>, relay=vger.kernel.org[209.132.176.167]:25,
delay=2.2, delays=0.05/0/0.62/1.5, dsn=2.7.1, status=sent (250 2.7.1
Looks like Linux source DIFF email.. BF:<H 0>; S1752661AbZFDOdB)
Jun  5 02:33:11 mail postfix/smtp[12955]: 418F513E7BA:
to=<git@vger.kernel.org>, relay=vger.kernel.org[209.132.176.167]:25,
delay=1.3, delays=0.03/0/0.63/0.67, dsn=2.7.1, status=sent (250 2.7.1
Looks like Linux source DIFF email.. BF:<H 0>; S1752661AbZFDOdI)
Jun  5 02:33:17 mail postfix/smtp[12962]: A31E413E7BB:
to=<git@vger.kernel.org>, relay=vger.kernel.org[209.132.176.167]:25,
delay=1.5, delays=0.01/0/0.62/0.91, dsn=2.7.1, status=sent (250 2.7.1
Looks like Linux source DIFF email.. BF:<H 0>; S1752661AbZFDOdO)

Where are my posts?

Sam
