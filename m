From: Peter Krefting <peter@softwolves.pp.se>
Subject: Re: [PATCH] Added hint about using .gitignore in git status while 
 printing untracked files
Date: Thu, 18 Feb 2010 10:59:23 +0100 (CET)
Organization: /universe/earth/europe/norway/oslo
Message-ID: <alpine.DEB.2.00.1002181058450.11095@ds9.cixit.se>
References: <e72faaa81002180148k47881f47qdfd5d268e4b2b44@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Cc: Git List <git@vger.kernel.org>
To: Pavan Kumar Sunkara <pavan.sss1991@gmail.com>
X-From: git-owner@vger.kernel.org Thu Feb 18 10:59:40 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ni3Aa-0008Dz-9B
	for gcvg-git-2@lo.gmane.org; Thu, 18 Feb 2010 10:59:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756189Ab0BRJ71 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 18 Feb 2010 04:59:27 -0500
Received: from upper-gw.cixit.se ([92.43.32.133]:52088 "EHLO mail.cixit.se"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1754827Ab0BRJ70 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 18 Feb 2010 04:59:26 -0500
Received: from ds9.cixit.se (peter@localhost [127.0.0.1])
	by mail.cixit.se (8.14.3/8.14.3/Debian-5) with ESMTP id o1I9xNeY020547
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Thu, 18 Feb 2010 10:59:23 +0100
Received: from localhost (peter@localhost)
	by ds9.cixit.se (8.14.3/8.14.3/Submit) with ESMTP id o1I9xNEk020543;
	Thu, 18 Feb 2010 10:59:23 +0100
X-Authentication-Warning: ds9.cixit.se: peter owned process doing -bs
In-Reply-To: <e72faaa81002180148k47881f47qdfd5d268e4b2b44@mail.gmail.com>
User-Agent: Alpine 2.00 (DEB 1167 2008-08-23)
Accept: text/plain
X-Warning: Junk / bulk email will be reported
X-Rating: This message is not to be eaten by humans
X-Greylist: Sender is SPF-compliant, not delayed by milter-greylist-3.0 (mail.cixit.se [127.0.0.1]); Thu, 18 Feb 2010 10:59:23 +0100 (CET)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/140311>

Pavan Kumar Sunkara:

> +	color_fprintf_ln(s->fp, c, "#   (add it's path to .gitignore to
> intentionally untrack it)");

That should be "its", not "it is".

-- 
\\// Peter - http://www.softwolves.pp.se/
