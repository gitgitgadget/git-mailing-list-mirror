From: Peter Krefting <peter@softwolves.pp.se>
Subject: Re: [PATCH 05/10] Import wildmatch from rsync
Date: Fri, 5 Oct 2012 11:30:54 +0100 (CET)
Organization: /universe/earth/europe/norway/oslo
Message-ID: <alpine.DEB.2.00.1210051129510.16797@ds9.cixit.se>
References: <1349412069-627-1-git-send-email-pclouds@gmail.com> <1349412069-627-6-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Cc: Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>,
	Michael Haggerty <mhagger@alum.mit.edu>
To: pclouds@gmail.com
X-From: git-owner@vger.kernel.org Fri Oct 05 12:31:21 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TK5Bf-0005fU-Qq
	for gcvg-git-2@plane.gmane.org; Fri, 05 Oct 2012 12:31:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932113Ab2JEKbJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 5 Oct 2012 06:31:09 -0400
Received: from upper-gw.cixit.se ([92.43.32.133]:48546 "EHLO mail.cixit.se"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S932067Ab2JEKbH (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 5 Oct 2012 06:31:07 -0400
Received: from ds9.cixit.se (peter@localhost [127.0.0.1])
	by mail.cixit.se (8.14.3/8.14.3/Debian-9.4) with ESMTP id q95AUuUa021679
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Fri, 5 Oct 2012 12:30:56 +0200
Received: from localhost (peter@localhost)
	by ds9.cixit.se (8.14.3/8.14.3/Submit) with ESMTP id q95AUscN021670;
	Fri, 5 Oct 2012 12:30:54 +0200
X-Authentication-Warning: ds9.cixit.se: peter owned process doing -bs
In-Reply-To: <1349412069-627-6-git-send-email-pclouds@gmail.com>
User-Agent: Alpine 2.00 (DEB 1167 2008-08-23)
Accept: text/plain
X-Warning: Junk / bulk email will be reported
X-Rating: This message is not to be eaten by humans
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.3.7 (mail.cixit.se [127.0.0.1]); Fri, 05 Oct 2012 12:30:56 +0200 (CEST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/207094>

> These files are from rsync.git commit
> f92f5b166e3019db42bc7fe1aa2f1a9178cd215d, which was the last commit
> before rsync turned GPL-3.

However:

> diff --git a/test-wildmatch.c b/test-wildmatch.c
[...]
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License as published by
> + * the Free Software Foundation; either version 3 of the License, or
> + * (at your option) any later version.

-- 
\\// Peter - http://www.softwolves.pp.se/
