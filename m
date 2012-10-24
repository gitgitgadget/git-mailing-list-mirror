From: Peter Krefting <peter@softwolves.pp.se>
Subject: Re: L10n regression in 1.8.0.rc2: diffstat summary (git diff --stat,
 git format-patch)
Date: Wed, 24 Oct 2012 08:54:38 +0100 (CET)
Organization: /universe/earth/europe/norway/oslo
Message-ID: <alpine.DEB.2.00.1210240853220.22443@ds9.cixit.se>
References: <alpine.DEB.2.00.1210171145360.12699@ds9.cixit.se> <CACsJy8CS9TKGaT8+MQ_JOEQD+fgnc9HVAbr1pjQ3JE_3ZjE9=A@mail.gmail.com> <alpine.DEB.2.00.1210200035220.15821@ds9.cixit.se>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Cc: Git Mailing List <git@vger.kernel.org>,
	Jiang Xin <worldhello.net@gmail.com>
To: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Wed Oct 24 09:54:58 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TQvnl-0008V6-38
	for gcvg-git-2@plane.gmane.org; Wed, 24 Oct 2012 09:54:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754702Ab2JXHyp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 24 Oct 2012 03:54:45 -0400
Received: from upper-gw.cixit.se ([92.43.32.133]:53006 "EHLO mail.cixit.se"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751976Ab2JXHyo (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 24 Oct 2012 03:54:44 -0400
Received: from ds9.cixit.se (peter@localhost [127.0.0.1])
	by mail.cixit.se (8.14.3/8.14.3/Debian-9.4) with ESMTP id q9O7sdQY023561
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Wed, 24 Oct 2012 09:54:39 +0200
Received: from localhost (peter@localhost)
	by ds9.cixit.se (8.14.3/8.14.3/Submit) with ESMTP id q9O7sctx023558;
	Wed, 24 Oct 2012 09:54:38 +0200
X-Authentication-Warning: ds9.cixit.se: peter owned process doing -bs
In-Reply-To: <alpine.DEB.2.00.1210200035220.15821@ds9.cixit.se>
User-Agent: Alpine 2.00 (DEB 1167 2008-08-23)
Accept: text/plain
X-Warning: Junk / bulk email will be reported
X-Rating: This message is not to be eaten by humans
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.3.7 (mail.cixit.se [127.0.0.1]); Wed, 24 Oct 2012 09:54:39 +0200 (CEST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/208296>

> I'll see if I can come up with a patch that cater for both use-cases.

I see that I forgot to Cc you; please see the patch series starting 
with the Subject "[RFC PATCH 0/2] Localize log output", which I posted 
here yesterday.

-- 
\\// Peter - http://www.softwolves.pp.se/
