From: Alexey Nezhdanov <snake@penza-gsm.ru>
Subject: Re: "git cvsimport" with branches?
Date: Sun, 17 Jul 2005 14:48:08 +0400
Message-ID: <200507171448.09049.snake@penza-gsm.ru>
References: <20050717084053.94D603525D1@atlas.denx.de> <pan.2005.07.17.09.37.58.463540@smurf.noris.de>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Cc: Matthias Urlichs <smurf@smurf.noris.de>
X-From: git-owner@vger.kernel.org Sun Jul 17 12:48:59 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Du6he-0004Jt-Al
	for gcvg-git@gmane.org; Sun, 17 Jul 2005 12:48:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261243AbVGQKsw (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 17 Jul 2005 06:48:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261246AbVGQKsw
	(ORCPT <rfc822;git-outgoing>); Sun, 17 Jul 2005 06:48:52 -0400
Received: from host-80-95-32-178.leasedlines.sura.ru ([80.95.32.178]:64702
	"HELO penza-gsm.ru") by vger.kernel.org with SMTP id S261243AbVGQKsP
	(ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 17 Jul 2005 06:48:15 -0400
Received: (qmail 8747 invoked from network); 17 Jul 2005 10:48:13 -0000
Received: from unknown (HELO snake-modem.penza-gsm.ru) (192.168.5.2)
  by fileserver.penza-gsm.ru with SMTP; 17 Jul 2005 10:48:10 -0000
To: git@vger.kernel.org
User-Agent: KMail/1.7.2
In-Reply-To: <pan.2005.07.17.09.37.58.463540@smurf.noris.de>
Content-Disposition: inline
X-Spam-Checker-Version: SpamAssassin 3.0.2 (2004-11-16) on fileserver
X-Spam-Level: 
X-Spam-Status: No, score=-102.8 required=5.0 tests=ALL_TRUSTED,AWL,
	USER_IN_WHITELIST autolearn=unavailable version=3.0.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Sunday, 17 July 2005 13:37 Matthias Urlichs wrote:
> Hi, Wolfgang Denk wrote:
> > Is there a way to make "git cvsimport" create branches in git for any
> > branches it encounters in the CVS repository?
>
> That's what it does.
But it does not, at least in some cases.
See my previous mail:
http://marc.theaimsgroup.com/?l=git&m=112159075029007&w=2
It have simple script attached that reproduces the problem.

-- 
Respectfully
Alexey Nezhdanov
