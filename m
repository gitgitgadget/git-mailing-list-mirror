From: Seth Falcon <sfalcon@fhcrc.org>
Subject: Re: suggestion for git rebase -i
Date: Sat, 28 Jul 2007 16:11:24 -0700
Message-ID: <m2bqdwrun7.fsf@ziti.fhcrc.org>
References: <m26445t98z.fsf@ziti.fhcrc.org>
	<Pine.LNX.4.64.0707280941380.14781@racer.site>
	<m2vec4seyf.fsf@ziti.fhcrc.org>
	<Pine.LNX.4.64.0707282109090.14781@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Seth Falcon <sfalcon@fhcrc.org>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Sun Jul 29 01:11:46 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IEvRo-0007PB-31
	for gcvg-git@gmane.org; Sun, 29 Jul 2007 01:11:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757986AbXG1XLa (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 28 Jul 2007 19:11:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757783AbXG1XLa
	(ORCPT <rfc822;git-outgoing>); Sat, 28 Jul 2007 19:11:30 -0400
Received: from JARLITE.FHCRC.ORG ([140.107.42.11]:45057 "EHLO
	jarlite.fhcrc.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757576AbXG1XL3 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 28 Jul 2007 19:11:29 -0400
X-Greylist: delayed 65586 seconds by postgrey-1.27 at vger.kernel.org; Sat, 28 Jul 2007 19:11:29 EDT
Received: from jade.fhcrc.org (JADE.FHCRC.ORG [140.107.42.223])
	by jarlite.fhcrc.org (8.12.11.20060308/8.12.11/SuSE Linux 0.7) with ESMTP id l6SNBQTc029049
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Sat, 28 Jul 2007 16:11:26 -0700
Received: from ziti.fhcrc.org (DORMOUSE.FHCRC.ORG [140.107.170.158])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by jade.fhcrc.org (Postfix) with ESMTP id F3932E869;
	Sat, 28 Jul 2007 16:11:25 -0700 (PDT)
In-Reply-To: <Pine.LNX.4.64.0707282109090.14781@racer.site> (Johannes Schindelin's message of "Sat\, 28 Jul 2007 21\:09\:47 +0100 \(BST\)")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.1 (darwin)
X-PMX-Version: 5.3.2.304607, Antispam-Engine: 2.5.1.298604, Antispam-Data: 2007.7.28.155133
X-FHCRC-SCANNED: Sat Jul 28 16:11:27 2007
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/54067>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
> Okay, fair enough.  But since you want that feature, you get to do the 
> patch.  Hint: it is just one line that has to be changed.

Heh, I actually wrote the patch first, but thought it was so
trivial...  :-)

ok, I will send the patch and hopefully not screw up the formatting,
etc.  Feedback and hints welcome.

+ seth
