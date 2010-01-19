From: Peter Krefting <peter@softwolves.pp.se>
Subject: Re: Feature idea: Ignore content
Date: Tue, 19 Jan 2010 15:05:08 +0100 (CET)
Organization: /universe/earth/europe/norway/oslo
Message-ID: <alpine.DEB.2.00.1001191504020.23165@ds9.cixit.se>
References: <f3271551001190529h389ce321k52dcca6b03e4e8f0@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Cc: Git Mailing List <git@vger.kernel.org>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jan 19 15:05:21 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NXEhp-0008IG-MG
	for gcvg-git-2@lo.gmane.org; Tue, 19 Jan 2010 15:05:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751336Ab0ASOFN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 19 Jan 2010 09:05:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751227Ab0ASOFM
	(ORCPT <rfc822;git-outgoing>); Tue, 19 Jan 2010 09:05:12 -0500
Received: from upper-gw.cixit.se ([92.43.32.133]:34439 "EHLO mail.cixit.se"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1750943Ab0ASOFL (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 Jan 2010 09:05:11 -0500
Received: from ds9.cixit.se (peter@localhost [127.0.0.1])
	by mail.cixit.se (8.14.3/8.14.3/Debian-5) with ESMTP id o0JE58wE025290
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Tue, 19 Jan 2010 15:05:08 +0100
Received: from localhost (peter@localhost)
	by ds9.cixit.se (8.14.3/8.14.3/Submit) with ESMTP id o0JE58Kg025284;
	Tue, 19 Jan 2010 15:05:08 +0100
X-Authentication-Warning: ds9.cixit.se: peter owned process doing -bs
In-Reply-To: <f3271551001190529h389ce321k52dcca6b03e4e8f0@mail.gmail.com>
User-Agent: Alpine 2.00 (DEB 1167 2008-08-23)
Accept: text/plain
X-Warning: Junk / bulk email will be reported
X-Rating: This message is not to be eaten by humans
X-Greylist: Sender is SPF-compliant, not delayed by milter-greylist-3.0 (mail.cixit.se [127.0.0.1]); Tue, 19 Jan 2010 15:05:08 +0100 (CET)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/137459>

Ramkumar Ramachandra:

> Instead of moving that out to a separate file and ignoring that file, is 
> it a good idea to add a feature to Git to allow ignoring content instead 
> of whole files?

You should be able to do that by setting up a filter. Please see 
gitattributes(5) for more information (search for "filter").

-- 
\\// Peter - http://www.softwolves.pp.se/
