From: Jari Aalto <jari.aalto@cante.net>
Subject: Re: [PATCH] Documentation/config.txt: Order variables alphabetically
Date: Wed, 01 Dec 2010 19:10:55 +0200
Organization: Private
Message-ID: <87vd3dv2ow.fsf@picasso.cante.net>
References: <1291209174-9239-1-git-send-email-jari.aalto@cante.net>
	<201012011557.30849.jnareb@gmail.com>
	<20101201150917.GD6537@picasso.cante.net>
	<201012011737.53652.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Dec 01 18:11:42 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PNqDV-0000kG-R4
	for gcvg-git-2@lo.gmane.org; Wed, 01 Dec 2010 18:11:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755434Ab0LARLK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 1 Dec 2010 12:11:10 -0500
Received: from lo.gmane.org ([80.91.229.12]:34922 "EHLO lo.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755387Ab0LARLK (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 1 Dec 2010 12:11:10 -0500
Received: from list by lo.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1PNqCw-0000Ou-Tm
	for git@vger.kernel.org; Wed, 01 Dec 2010 18:11:06 +0100
Received: from a91-155-187-216.elisa-laajakaista.fi ([91.155.187.216])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 01 Dec 2010 18:11:06 +0100
Received: from jari.aalto by a91-155-187-216.elisa-laajakaista.fi with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 01 Dec 2010 18:11:06 +0100
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@dough.gmane.org
X-Gmane-NNTP-Posting-Host: a91-155-187-216.elisa-laajakaista.fi
User-Agent: Gnus/5.110011 (No Gnus v0.11) Emacs/23.2 (gnu/linux)
Cancel-Lock: sha1:h7dBrW63wysojof3o4Zsjx4rjLg=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/162551>

2010-12-01 18:37 Jakub Narebski <jnareb@gmail.com>:
> Having related config variables together is IMVHO more important than
> having config variables sorted alphabetically.

That's subjective criteria. I doubt there are many related one that
can't be handled with standard "see also".

A small percentage of variables that "group" is bad criteria for general
use. Especially when confix.txt contains somewhere 250 options.

Most of the time you want to look up X. And alpha order is what doctor
ordered.

Same for command line options. You read zillions of scripts and cryptic
options. You want to consult manual page to see what an option means. Again
you're searching A-Z.

Jari
