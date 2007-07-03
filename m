From: Jonas Fonseca <fonseca@diku.dk>
Subject: Re: [TIG PATCH] Ignore generated manpages.
Date: Tue, 3 Jul 2007 18:23:39 +0200
Message-ID: <20070703162339.GA13779@diku.dk>
References: <20070703145012.GA11660@Hermes.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Brian Gernhardt <benji@silverinsanity.com>
X-From: git-owner@vger.kernel.org Tue Jul 03 18:23:46 2007
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I5lAI-00028V-0w
	for gcvg-git@gmane.org; Tue, 03 Jul 2007 18:23:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756030AbXGCQXn (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 3 Jul 2007 12:23:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755853AbXGCQXn
	(ORCPT <rfc822;git-outgoing>); Tue, 3 Jul 2007 12:23:43 -0400
Received: from mgw1.diku.dk ([130.225.96.91]:40560 "EHLO mgw1.diku.dk"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755545AbXGCQXn (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 Jul 2007 12:23:43 -0400
Received: from localhost (localhost [127.0.0.1])
	by mgw1.diku.dk (Postfix) with ESMTP id 90F3FF0067;
	Tue,  3 Jul 2007 18:23:41 +0200 (CEST)
X-Virus-Scanned: amavisd-new at diku.dk
Received: from mgw1.diku.dk ([127.0.0.1])
	by localhost (mgw1.diku.dk [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id vkPsR0ZsH8f3; Tue,  3 Jul 2007 18:23:40 +0200 (CEST)
Received: from nhugin.diku.dk (nhugin.diku.dk [130.225.96.140])
	by mgw1.diku.dk (Postfix) with ESMTP id 09FC9F005D;
	Tue,  3 Jul 2007 18:23:40 +0200 (CEST)
Received: from ask.diku.dk (ask.diku.dk [130.225.96.225])
	by nhugin.diku.dk (Postfix) with ESMTP
	id 91D5F6DF8B3; Tue,  3 Jul 2007 18:20:46 +0200 (CEST)
Received: by ask.diku.dk (Postfix, from userid 3873)
	id E9A0662A5D; Tue,  3 Jul 2007 18:23:39 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <20070703145012.GA11660@Hermes.local>
User-Agent: Mutt/1.5.6i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/51514>

Brian Gernhardt <benji@silverinsanity.com> wrote Tue, Jul 03, 2007:
> Adds tig.1 and tigrc.5 to .gitignore

Thanks. Applied and pushed out.

-- 
Jonas Fonseca
