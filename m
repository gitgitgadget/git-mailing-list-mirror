From: Rocco Rutte <pdmef@gmx.net>
Subject: Re: Creating diffs
Date: Thu, 3 Aug 2006 14:58:50 +0000
Organization: Berlin University of Technology
Message-ID: <20060803145850.GK5016@robert.daprodeges.fqdn.th-h.de>
References: <20060803122937.GI5016@robert.daprodeges.fqdn.th-h.de> <easqpi$o51$1@sea.gmane.org> <eat29j$lil$1@sea.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
X-From: git-owner@vger.kernel.org Thu Aug 03 16:59:27 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1G8efC-00082y-DG
	for gcvg-git@gmane.org; Thu, 03 Aug 2006 16:59:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932556AbWHCO7D (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 3 Aug 2006 10:59:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932557AbWHCO7B
	(ORCPT <rfc822;git-outgoing>); Thu, 3 Aug 2006 10:59:01 -0400
Received: from mail.gmx.de ([213.165.64.21]:9696 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S932556AbWHCO7A (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 3 Aug 2006 10:59:00 -0400
Received: (qmail invoked by alias); 03 Aug 2006 14:58:59 -0000
Received: from cable-62-117-26-83.cust.blue-cable.de (EHLO peter.daprodeges.fqdn.th-h.de) [62.117.26.83]
  by mail.gmx.net (mp034) with SMTP; 03 Aug 2006 16:58:59 +0200
X-Authenticated: #1642131
Received: from robert.daprodeges.fqdn.th-h.de (robert.daprodeges.dyndns.org [192.168.0.113])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by peter.daprodeges.fqdn.th-h.de (Postfix) with ESMTP id 7024420F01
	for <git@vger.kernel.org>; Thu,  3 Aug 2006 14:58:58 +0000 (UTC)
Received: from robert.daprodeges.fqdn.th-h.de (robert.daprodeges.fqdn.th-h.de [192.168.0.113])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by robert.daprodeges.fqdn.th-h.de (Postfix) with ESMTP id 6B0E733FC3
	for <git@vger.kernel.org>; Thu,  3 Aug 2006 14:58:51 +0000 (UTC)
To: git@vger.kernel.org
Mail-Followup-To: git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <eat29j$lil$1@sea.gmane.org>
X-GnuPG-Key: http://user.cs.tu-berlin.de/~pdmef/rrutte.gpg
X-Blog: http://user.cs.tu-berlin.de/~pdmef/horst.cgi?o
X-System: robert (FreeBSD 6.1-STABLE i386)
User-Agent: Mutt/1.5.12-pdmef (2006-07-20)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/24726>

Hi,

* Jakub Narebski [06-08-03 16:47:49 +0200] wrote:

>The patches are:
>  http://www.gelato.unsw.edu.au/archives/git/0607/24325.html
>  http://www.gelato.unsw.edu.au/archives/git/0607/24326.html

Hmm, ok, thanks for the pointer. What made me wonder in the first place 
is that the format differs from the diff-two-branches case because I 
assumed the algorithm basically is what I want to do (except it just 
does not exclude files) (i.e. diff-two-trees := get changed files and 
for each file, dump diff).

And what about the reverted diff contents? I don't know git too well so 
it take me quite long to provide a patch...

   bye, Rocco
-- 
:wq!
