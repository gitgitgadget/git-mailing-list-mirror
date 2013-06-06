From: Peter Krefting <peter@softwolves.pp.se>
Subject: Re: [PATCH 3/6] completion: add common options for blame
Date: Thu, 6 Jun 2013 10:58:58 +0100 (CET)
Organization: /universe/earth/europe/norway/oslo
Message-ID: <alpine.DEB.2.00.1306061057010.14650@ds9.cixit.se>
References: <1370181822-23450-1-git-send-email-artagnon@gmail.com> <1370181822-23450-4-git-send-email-artagnon@gmail.com> <87mwr7zhv5.fsf@linux-k42r.v.cablecom.net> <CALkWK0kR2fCQcO9XurzjOGF19vaC67p5kMpkJL=Vbu1Ovku18w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Cc: Thomas Rast <trast@inf.ethz.ch>, Git List <git@vger.kernel.org>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jun 06 11:59:15 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UkWyQ-0000DC-TJ
	for gcvg-git-2@plane.gmane.org; Thu, 06 Jun 2013 11:59:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754619Ab3FFJ7J (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 6 Jun 2013 05:59:09 -0400
Received: from upper-gw.cixit.se ([92.43.32.133]:59564 "EHLO mail.cixit.se"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1753592Ab3FFJ7H (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 6 Jun 2013 05:59:07 -0400
Received: from ds9.cixit.se (peter@localhost [127.0.0.1])
	by mail.cixit.se (8.14.3/8.14.3/Debian-9.4) with ESMTP id r569wwfE022756
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Thu, 6 Jun 2013 11:58:58 +0200
Received: from localhost (peter@localhost)
	by ds9.cixit.se (8.14.3/8.14.3/Submit) with ESMTP id r569wwB3022753;
	Thu, 6 Jun 2013 11:58:58 +0200
X-Authentication-Warning: ds9.cixit.se: peter owned process doing -bs
In-Reply-To: <CALkWK0kR2fCQcO9XurzjOGF19vaC67p5kMpkJL=Vbu1Ovku18w@mail.gmail.com>
User-Agent: Alpine 2.00 (DEB 1167 2008-08-23)
Accept: text/plain
X-Warning: Junk / bulk email will be reported
X-Rating: This message is not to be eaten by humans
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.3.7 (mail.cixit.se [127.0.0.1]); Thu, 06 Jun 2013 11:58:58 +0200 (CEST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/226499>

Ramkumar Ramachandra:

> Yeah.  We generally prefer the long-form equivalents while doing 
> completions, but these blame options do not have equivalent 
> long-forms.

Perhaps that is the real bug, then. -M and -C already have long names 
for diff (and its friends), perhaps blame should have the same long 
option names for them?

-- 
\\// Peter - http://www.softwolves.pp.se/
