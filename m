From: Peter Krefting <peter@softwolves.pp.se>
Subject: Re: gitosis user on Windows
Date: Tue, 12 Jan 2010 11:22:39 +0100 (CET)
Organization: /universe/earth/europe/norway/oslo
Message-ID: <alpine.DEB.2.00.1001121121380.30408@ds9.cixit.se>
References: <26ae428a1001120142j36619d62xcf3ffee3539a03b7@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Cc: Git Mailing List <git@vger.kernel.org>
To: Howard Miller <howard@e-learndesign.co.uk>
X-From: git-owner@vger.kernel.org Tue Jan 12 11:22:49 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NUdth-0006N2-65
	for gcvg-git-2@lo.gmane.org; Tue, 12 Jan 2010 11:22:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753973Ab0ALKWo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 12 Jan 2010 05:22:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753969Ab0ALKWo
	(ORCPT <rfc822;git-outgoing>); Tue, 12 Jan 2010 05:22:44 -0500
Received: from upper-gw.cixit.se ([92.43.32.133]:50405 "EHLO mail.cixit.se"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1753588Ab0ALKWo (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 12 Jan 2010 05:22:44 -0500
Received: from ds9.cixit.se (peter@localhost [127.0.0.1])
	by mail.cixit.se (8.14.3/8.14.3/Debian-5) with ESMTP id o0CAMdeW009780
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Tue, 12 Jan 2010 11:22:39 +0100
Received: from localhost (peter@localhost)
	by ds9.cixit.se (8.14.3/8.14.3/Submit) with ESMTP id o0CAMdRc009777;
	Tue, 12 Jan 2010 11:22:39 +0100
X-Authentication-Warning: ds9.cixit.se: peter owned process doing -bs
In-Reply-To: <26ae428a1001120142j36619d62xcf3ffee3539a03b7@mail.gmail.com>
User-Agent: Alpine 2.00 (DEB 1167 2008-08-23)
Accept: text/plain
X-Warning: Junk / bulk email will be reported
X-Rating: This message is not to be eaten by humans
X-Greylist: Sender is SPF-compliant, not delayed by milter-greylist-3.0 (mail.cixit.se [127.0.0.1]); Tue, 12 Jan 2010 11:22:39 +0100 (CET)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/136711>

Howard Miller:

> I have been using gitosis for a while with much success. I now have a user 
> on Windows (XP) wanting to access the repositories. I obviously need a key
>  from him but asking just elicited a blank look.

  From Git Gui, use Help -> Show SSH Key. If that shows up blank, press the 
"Generate Key" button and follow the instructions.

-- 
\\// Peter - http://www.softwolves.pp.se/
