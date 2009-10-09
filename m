From: Peter Krefting <peter@softwolves.pp.se>
Subject: Re: [PATCH] import-tars: Add missing closing bracket
Date: Fri, 9 Oct 2009 13:52:08 +0100 (CET)
Organization: /universe/earth/europe/norway/oslo
Message-ID: <alpine.DEB.2.00.0910091351030.7840@ds9.cixit.se>
References: <1255090111-32612-1-git-send-email-ingmar@exherbo.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Cc: Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>
To: Ingmar Vanhassel <ingmar@exherbo.org>
X-From: git-owner@vger.kernel.org Fri Oct 09 15:03:18 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MwF7j-0003wK-AD
	for gcvg-git-2@lo.gmane.org; Fri, 09 Oct 2009 15:03:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758799AbZJINCa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 9 Oct 2009 09:02:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758045AbZJINCa
	(ORCPT <rfc822;git-outgoing>); Fri, 9 Oct 2009 09:02:30 -0400
Received: from upper-gw.cixit.se ([92.43.32.133]:58499 "EHLO mail.cixit.se"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1756544AbZJINC3 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 9 Oct 2009 09:02:29 -0400
X-Greylist: delayed 572 seconds by postgrey-1.27 at vger.kernel.org; Fri, 09 Oct 2009 09:02:29 EDT
Received: from ds9.cixit.se (peter@localhost [127.0.0.1])
	by mail.cixit.se (8.14.3/8.14.3/Debian-5) with ESMTP id n99Cq8Eq027874
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Fri, 9 Oct 2009 14:52:08 +0200
Received: from localhost (peter@localhost)
	by ds9.cixit.se (8.14.3/8.14.3/Submit) with ESMTP id n99Cq8Av027870;
	Fri, 9 Oct 2009 14:52:08 +0200
X-Authentication-Warning: ds9.cixit.se: peter owned process doing -bs
In-Reply-To: <1255090111-32612-1-git-send-email-ingmar@exherbo.org>
User-Agent: Alpine 2.00 (DEB 1167 2008-08-23)
Accept: text/plain
X-Warning: Junk / bulk email will be reported
X-Rating: This message is not to be eaten by humans
X-Greylist: Sender is SPF-compliant, not delayed by milter-greylist-3.0 (mail.cixit.se [127.0.0.1]); Fri, 09 Oct 2009 14:52:08 +0200 (CEST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/129799>

Ingmar Vanhassel:

> This fixes an obvious syntax error that snuck in commit 7e787953:

Now, that is embarrassing... :-/ Sorry.

> Signed-off-by: Ingmar Vanhassel <ingmar@exherbo.org>

Tested-by: Peter Krefting <peter@softwolves.pp.se>

-- 
\\// Peter - http://www.softwolves.pp.se/
