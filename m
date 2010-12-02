From: jari <jari.aalto@cante.net>
Subject: Re: [PATCH] git-reset.txt: Use commit~1 notation over commit^
Date: Thu, 2 Dec 2010 15:20:53 +0200
Message-ID: <20101202132053.GF6537@picasso.cante.net>
References: <1291227258-17922-1-git-send-email-jari.aalto@cante.net>
 <1291230820.11917.25.camel@drew-northup.unet.maine.edu>
 <877hftuvvz.fsf@picasso.cante.net>
 <7vfwuhtafr.fsf@alter.siamese.dyndns.org>
 <AANLkTik8TNedGBQh7KXvRSf3HTTQf2-yMJC4VA4OOBjQ@mail.gmail.com>
 <87sjygspgy.fsf@picasso.cante.net>
 <buo39qg8zrf.fsf@dhlpc061.dev.necel.com>
 <87bp54s770.fsf@picasso.cante.net>
 <87mxoos4a8.fsf@catnip.gol.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Miles Bader <miles@gnu.org>
X-From: git-owner@vger.kernel.org Thu Dec 02 14:21:04 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PO95r-0003J0-67
	for gcvg-git-2@lo.gmane.org; Thu, 02 Dec 2010 14:21:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757459Ab0LBNU6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 2 Dec 2010 08:20:58 -0500
Received: from emh03.mail.saunalahti.fi ([62.142.5.109]:60361 "EHLO
	emh03.mail.saunalahti.fi" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757253Ab0LBNU5 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 2 Dec 2010 08:20:57 -0500
Received: from saunalahti-vams (vs3-12.mail.saunalahti.fi [62.142.5.96])
	by emh03-2.mail.saunalahti.fi (Postfix) with SMTP id 15DDCEBEDA;
	Thu,  2 Dec 2010 15:20:56 +0200 (EET)
Received: from emh02.mail.saunalahti.fi ([62.142.5.108])
	by vs3-12.mail.saunalahti.fi ([62.142.5.96])
	with SMTP (gateway) id A03239CAF42; Thu, 02 Dec 2010 15:20:55 +0200
Received: from picasso.cante.net (a91-155-187-216.elisa-laajakaista.fi [91.155.187.216])
	by emh02.mail.saunalahti.fi (Postfix) with ESMTP id DB3B42BD4F;
	Thu,  2 Dec 2010 15:20:53 +0200 (EET)
Received: from jaalto by picasso.cante.net with local (Exim 4.72)
	(envelope-from <jaalto@picasso.cante.net>)
	id 1PO95h-0001Iz-7W; Thu, 02 Dec 2010 15:20:53 +0200
Content-Disposition: inline
In-Reply-To: <87mxoos4a8.fsf@catnip.gol.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: jaalto@picasso.cante.net
X-SA-Exim-Scanned: No (on picasso.cante.net); SAEximRunCond expanded to false
X-Antivirus: VAMS
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/162704>

| ^ (and ^^, etc) is a simpler and easier concept to deal with, and
| ... very easy to get counts for ~ wrong).  So it's ~ that's the
| "expert notation", not ^.

Not that it matters, but have you happende to notice that all git
outputs use

    commit~N

notation. Not the

    commit^

Jari
