From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [PATCH v3 3/6] t9001: shorten send-email's output
Date: Thu, 09 Jun 2016 08:03:48 +0200
Message-ID: <vpq4m92yk3f.fsf@anie.imag.fr>
References: <1464369102-7551-1-git-send-email-tom.russello@grenoble-inp.org>
	<20160607140148.23242-1-tom.russello@grenoble-inp.org>
	<20160607140148.23242-4-tom.russello@grenoble-inp.org>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, erwan.mathoniere@grenoble-inp.org,
	samuel.groot@grenoble-inp.org, jordan.de-gea@grenoble-inp.org,
	e@80x24.org, aaron@schrab.com, gitster@pobox.com
To: Tom Russello <tom.russello@grenoble-inp.org>
X-From: git-owner@vger.kernel.org Thu Jun 09 08:04:10 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1bAt4a-0004D4-UT
	for gcvg-git-2@plane.gmane.org; Thu, 09 Jun 2016 08:04:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423121AbcFIGED (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 9 Jun 2016 02:04:03 -0400
Received: from mx1.imag.fr ([129.88.30.5]:55121 "EHLO mx1.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1161753AbcFIGEB (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 9 Jun 2016 02:04:01 -0400
Received: from clopinette.imag.fr (clopinette.imag.fr [129.88.34.215])
	by mx1.imag.fr (8.13.8/8.13.8) with ESMTP id u5963mBf018155
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NO);
	Thu, 9 Jun 2016 08:03:48 +0200
Received: from anie (anie.imag.fr [129.88.42.32])
	by clopinette.imag.fr (8.13.8/8.13.8) with ESMTP id u5963mnK026348;
	Thu, 9 Jun 2016 08:03:48 +0200
In-Reply-To: <20160607140148.23242-4-tom.russello@grenoble-inp.org> (Tom
	Russello's message of "Tue, 7 Jun 2016 16:01:45 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.4 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (mx1.imag.fr [129.88.30.5]); Thu, 09 Jun 2016 08:03:48 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: u5963mBf018155
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1466057031.2518@INTkTohxeI+VwYVbF4oCnQ
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/296871>

Tom Russello <tom.russello@grenoble-inp.org> writes:

> Messages displayed by `send-email` should be shortened to avoid displaying
> unnecesseray informations.

We usually use imperative tone in commit messages:

Shorten messages displayed by `send-email` to avoid displaying
unnecessary information.

Actually, I'd rather have a bit more explanation about why this info is
"unnecessary".

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
