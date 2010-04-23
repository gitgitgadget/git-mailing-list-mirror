From: Matthias Andree <matthias.andree@gmx.de>
Subject: Re: Please default to 'commit -a' when no changes were added
Date: Fri, 23 Apr 2010 20:59:28 +0200
Message-ID: <4BD1EE10.4010009@gmx.de>
References: <20100422151037.2310.2429.reportbug@frosties.localdomain> <20100422155806.GC4801@progeny.tock>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: 578764@bugs.debian.org, git@vger.kernel.org
To: unlisted-recipients:; (no To-header on input)
X-From: git-owner@vger.kernel.org Fri Apr 23 20:59:41 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O5O6G-0001j7-QO
	for gcvg-git-2@lo.gmane.org; Fri, 23 Apr 2010 20:59:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754811Ab0DWS7e (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 23 Apr 2010 14:59:34 -0400
Received: from mail.gmx.net ([213.165.64.20]:41377 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752902Ab0DWS7d (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 23 Apr 2010 14:59:33 -0400
Received: (qmail invoked by alias); 23 Apr 2010 18:59:32 -0000
Received: from baloo.cs.uni-paderborn.de (EHLO baloo.cs.uni-paderborn.de) [131.234.21.116]
  by mail.gmx.net (mp036) with SMTP; 23 Apr 2010 20:59:32 +0200
X-Authenticated: #428038
X-Provags-ID: V01U2FsdGVkX18MWUtmAywMrf6NGZoVsiVc/FWSCj7sL0/Zuetwaw
	+ArVWj2s5oCSiG
Received: from [127.0.0.1]
	by baloo.cs.uni-paderborn.de with esmtp (Exim 4.70)
	(envelope-from <matthias.andree@gmx.de>)
	id L1CFF5-0002U8-R4; Fri, 23 Apr 2010 20:59:29 +0200
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 6.1; de; rv:1.9.1.9) Gecko/20100317 Lightning/1.0b1 Thunderbird/3.0.4
In-Reply-To: <20100422155806.GC4801@progeny.tock>
X-Enigmail-Version: 1.0.1
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.78000000000000003
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/145634>

I'd also concur that "default to commit -a" would be a most undesireable
astonishment for me.  Please don't go that way.  Thanks.
(Not that I believe it stands a chance of upstream integration, but to avoid
downstream distro-specific shipwrecks.)

-- 
Matthias Andree
