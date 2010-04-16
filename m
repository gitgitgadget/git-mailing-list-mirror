From: Jari Aalto <jari.aalto@cante.net>
Subject: Re: [PATCH] git-send-email.txt: Add EXAMPLES section. Write 1st level sections in uppercase
Date: Fri, 16 Apr 2010 20:05:52 +0300
Organization: Private
Message-ID: <87eiifqqdr.fsf@jondo.cante.net>
References: <1271345823-19685-1-git-send-email-jari.aalto@cante.net>
	<4BC81975.9000907@drmicha.warpmail.net>
	<8739yvsjqv.fsf@jondo.cante.net>
	<4BC8605F.5070306@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Fri Apr 16 19:06:12 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O2ozV-0002ES-Ep
	for gcvg-git-2@lo.gmane.org; Fri, 16 Apr 2010 19:06:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758645Ab0DPRF6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 16 Apr 2010 13:05:58 -0400
Received: from emh06.mail.saunalahti.fi ([62.142.5.116]:49191 "EHLO
	emh06.mail.saunalahti.fi" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758627Ab0DPRF5 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 16 Apr 2010 13:05:57 -0400
Received: from saunalahti-vams (vs3-10.mail.saunalahti.fi [62.142.5.94])
	by emh06-2.mail.saunalahti.fi (Postfix) with SMTP id 09A63C805F;
	Fri, 16 Apr 2010 20:05:56 +0300 (EEST)
Received: from emh06.mail.saunalahti.fi ([62.142.5.116])
	by vs3-10.mail.saunalahti.fi ([62.142.5.94])
	with SMTP (gateway) id A03129067ED; Fri, 16 Apr 2010 20:05:56 +0300
Received: from jondo.cante.net (a91-155-187-216.elisa-laajakaista.fi [91.155.187.216])
	by emh06.mail.saunalahti.fi (Postfix) with ESMTP id B8290E51A2;
	Fri, 16 Apr 2010 20:05:53 +0300 (EEST)
In-Reply-To: <4BC8605F.5070306@drmicha.warpmail.net> (Michael J. Gruber's
	message of "Fri, 16 Apr 2010 15:04:31 +0200")
User-Agent: Gnus/5.110011 (No Gnus v0.11) Emacs/23.1 (gnu/linux)
X-Antivirus: VAMS
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/145087>

Michael J Gruber <git@drmicha.warpmail.net> writes:

> I just think that using all these options on the command line is very
> atypical. It would be helpful to see the defaults in one place:

Now, think this:

    You have 30 servers.

    You notice a problem.

    You need that command, whatever that is.

    Consult manual page, yay (Wow, or "Ugh")

    <blink> there is EXMAPLE, options and - Hurray: Copy/Paste and use.

You don't necessarily have full blown "environment" in front of you, so
we need both

    * Full command line exmaples. They are commadn line options after
      all
    * And configuration examples

The more copy/paste ready, the better. The more FAQ like, the better.
Let's make FAQs obsolete.

Thansk for the examples, I'll be revising the patch
Jari
