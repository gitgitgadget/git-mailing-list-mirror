From: jari <jari.aalto@cante.net>
Subject: Re: [PATCH] Documentation/config.txt: Order variables
 alphabetically
Date: Wed, 1 Dec 2010 16:34:36 +0200
Message-ID: <20101201143436.GC6537@picasso.cante.net>
References: <1291209174-9239-1-git-send-email-jari.aalto@cante.net>
 <m3eia14mu7.fsf@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Wed Dec 01 15:41:34 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PNns8-0004NE-1M
	for gcvg-git-2@lo.gmane.org; Wed, 01 Dec 2010 15:41:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755039Ab0LAOlX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 1 Dec 2010 09:41:23 -0500
Received: from emh03.mail.saunalahti.fi ([62.142.5.109]:51774 "EHLO
	emh03.mail.saunalahti.fi" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752752Ab0LAOlW (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 1 Dec 2010 09:41:22 -0500
X-Greylist: delayed 402 seconds by postgrey-1.27 at vger.kernel.org; Wed, 01 Dec 2010 09:41:22 EST
Received: from saunalahti-vams (vs3-12.mail.saunalahti.fi [62.142.5.96])
	by emh03-2.mail.saunalahti.fi (Postfix) with SMTP id 10E6BEBFFA;
	Wed,  1 Dec 2010 16:34:39 +0200 (EET)
Received: from emh03.mail.saunalahti.fi ([62.142.5.109])
	by vs3-12.mail.saunalahti.fi ([62.142.5.96])
	with SMTP (gateway) id A0414A02C54; Wed, 01 Dec 2010 16:34:39 +0200
Received: from picasso.cante.net (a91-155-187-216.elisa-laajakaista.fi [91.155.187.216])
	by emh03.mail.saunalahti.fi (Postfix) with ESMTP id 89AC1158A65;
	Wed,  1 Dec 2010 16:34:36 +0200 (EET)
Received: from jaalto by picasso.cante.net with local (Exim 4.72)
	(envelope-from <jaalto@picasso.cante.net>)
	id 1PNnlU-0002ir-2B; Wed, 01 Dec 2010 16:34:36 +0200
Content-Disposition: inline
In-Reply-To: <m3eia14mu7.fsf@localhost.localdomain>
User-Agent: Mutt/1.5.20 (2009-06-14)
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: jaalto@picasso.cante.net
X-SA-Exim-Scanned: No (on picasso.cante.net); SAEximRunCond expanded to false
X-Antivirus: VAMS
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/162521>

On 2010-12-01 05:58, Jakub Narebski wrote:
| >  		Advice shown when you used linkgit::git-checkout[1] to
| >  		move to the detach HEAD state, to instruct how to create
| > -		a local branch after the fact.  Default: true.
| > +		a local branch after the fact.	Default: true.
| 
| This change has nothing to do with ordering variables alphabetically,
| therefore IMHO it belongs in separate patch.

Hm, I tabified the content, so it chnaged inserted " " to "^I". Fix
will follow.

Jari
