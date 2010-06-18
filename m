From: Peter Krefting <peter@softwolves.pp.se>
Subject: Re: rebasing a merge
Date: Fri, 18 Jun 2010 10:10:58 +0100 (CET)
Organization: /universe/earth/europe/norway/oslo
Message-ID: <alpine.DEB.2.00.1006181010220.12445@ds9.cixit.se>
References: <AANLkTilY_9j2sXlplhYB4FPAIAzuPBg2UyUTEk4DaaYF@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; format=flowed; charset=US-ASCII
Cc: git <git@vger.kernel.org>
To: Jay Soffian <jaysoffian@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jun 18 11:11:18 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OPXbU-000312-1r
	for gcvg-git-2@lo.gmane.org; Fri, 18 Jun 2010 11:11:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758207Ab0FRJLF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 18 Jun 2010 05:11:05 -0400
Received: from upper-gw.cixit.se ([92.43.32.133]:60365 "EHLO mail.cixit.se"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1756281Ab0FRJLD (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 18 Jun 2010 05:11:03 -0400
Received: from ds9.cixit.se (peter@localhost [127.0.0.1])
	by mail.cixit.se (8.14.3/8.14.3/Debian-5) with ESMTP id o5I9AwVQ024242
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Fri, 18 Jun 2010 11:10:58 +0200
Received: from localhost (peter@localhost)
	by ds9.cixit.se (8.14.3/8.14.3/Submit) with ESMTP id o5I9Awop024238;
	Fri, 18 Jun 2010 11:10:58 +0200
X-Authentication-Warning: ds9.cixit.se: peter owned process doing -bs
In-Reply-To: <AANLkTilY_9j2sXlplhYB4FPAIAzuPBg2UyUTEk4DaaYF@mail.gmail.com>
User-Agent: Alpine 2.00 (DEB 1167 2008-08-23)
Accept: text/plain
X-Warning: Junk / bulk email will be reported
X-Rating: This message is not to be eaten by humans
X-Greylist: Sender is SPF-compliant, not delayed by milter-greylist-3.0 (mail.cixit.se [127.0.0.1]); Fri, 18 Jun 2010 11:10:58 +0200 (CEST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/149338>

Jay Soffian:

> Here's how I've been doing it, but I'll bet there's a less convoluted way:

Do you have git-rerere enabled? I have found that to be a major timesaver 
for cases like these.

-- 
\\// Peter - http://www.softwolves.pp.se/
