From: Peter Krefting <peter@softwolves.pp.se>
Subject: Re: Requirements for integrating a new git subcommand
Date: Mon, 26 Nov 2012 12:01:29 +0100 (CET)
Organization: /universe/earth/europe/norway/oslo
Message-ID: <alpine.DEB.2.00.1211261201000.11881@ds9.cixit.se>
References: <20121122053012.GA17265@thyrsus.com> <alpine.DEB.2.00.1211231022440.1431@ds9.cixit.se> <20121123153541.GA20097@thyrsus.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Cc: git@vger.kernel.org
To: "Eric S. Raymond" <esr@thyrsus.com>
X-From: git-owner@vger.kernel.org Mon Nov 26 12:01:54 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TcwRj-0006sN-3r
	for gcvg-git-2@plane.gmane.org; Mon, 26 Nov 2012 12:01:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754337Ab2KZLBg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 26 Nov 2012 06:01:36 -0500
Received: from upper-gw.cixit.se ([92.43.32.133]:57305 "EHLO mail.cixit.se"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1754331Ab2KZLBf (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 26 Nov 2012 06:01:35 -0500
Received: from ds9.cixit.se (peter@localhost [127.0.0.1])
	by mail.cixit.se (8.14.3/8.14.3/Debian-9.4) with ESMTP id qAQB1Ufu017641
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Mon, 26 Nov 2012 12:01:30 +0100
Received: from localhost (peter@localhost)
	by ds9.cixit.se (8.14.3/8.14.3/Submit) with ESMTP id qAQB1TSo017634;
	Mon, 26 Nov 2012 12:01:29 +0100
X-Authentication-Warning: ds9.cixit.se: peter owned process doing -bs
In-Reply-To: <20121123153541.GA20097@thyrsus.com>
User-Agent: Alpine 2.00 (DEB 1167 2008-08-23)
Accept: text/plain
X-Warning: Junk / bulk email will be reported
X-Rating: This message is not to be eaten by humans
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.3.7 (mail.cixit.se [127.0.0.1]); Mon, 26 Nov 2012 12:01:30 +0100 (CET)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/210428>

Eric S. Raymond:

> and (b) include the removal of import-directories.perl in my 
> integration patch.

Yes, please.

-- 
\\// Peter - http://www.softwolves.pp.se/
