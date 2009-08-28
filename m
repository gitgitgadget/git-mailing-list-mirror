From: Peter Krefting <peter@softwolves.pp.se>
Subject: Re: [PATCH v3] import-tars: Allow per-tar author and commit
 message.
Date: Fri, 28 Aug 2009 19:56:47 +0100 (CET)
Organization: /universe/earth/europe/norway/oslo
Message-ID: <alpine.DEB.2.00.0908281955160.24273@ds9.cixit.se>
References: <20090826193015.962A7189B12@perkele> <7viqg96ehf.fsf@alter.siamese.dyndns.org> <alpine.DEB.2.00.0908270741170.6459@perkele.intern.softwolves.pp.se> <7vskfcd8ep.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Aug 28 21:00:03 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Mh6g6-00081P-Pa
	for gcvg-git-2@lo.gmane.org; Fri, 28 Aug 2009 21:00:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752710AbZH1S44 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 28 Aug 2009 14:56:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752705AbZH1S4y
	(ORCPT <rfc822;git-outgoing>); Fri, 28 Aug 2009 14:56:54 -0400
Received: from upper-gw.cixit.se ([92.43.32.133]:56710 "EHLO mail.cixit.se"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1752494AbZH1S4v (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 28 Aug 2009 14:56:51 -0400
Received: from ds9.cixit.se (peter@localhost [127.0.0.1])
	by mail.cixit.se (8.14.3/8.14.3/Debian-5) with ESMTP id n7SIul7M025236
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Fri, 28 Aug 2009 20:56:47 +0200
Received: from localhost (peter@localhost)
	by ds9.cixit.se (8.14.3/8.14.3/Submit) with ESMTP id n7SIul0c025232;
	Fri, 28 Aug 2009 20:56:47 +0200
X-Authentication-Warning: ds9.cixit.se: peter owned process doing -bs
In-Reply-To: <7vskfcd8ep.fsf@alter.siamese.dyndns.org>
User-Agent: Alpine 2.00 (DEB 1167 2008-08-23)
Accept: text/plain
X-Warning: Junk / bulk email will be reported
X-Rating: This message is not to be eaten by humans
X-Greylist: Sender is SPF-compliant, not delayed by milter-greylist-3.0 (mail.cixit.se [127.0.0.1]); Fri, 28 Aug 2009 20:56:48 +0200 (CEST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/127328>

Junio C Hamano:

> Don't you at least want to avoid misparsing a msg file that looks like
> this?

Good point... Will post a fixed version.

-- 
\\// Peter - http://www.softwolves.pp.se/
