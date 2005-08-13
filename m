From: Matthias Urlichs <smurf@smurf.noris.de>
Subject: Re: [PATCH] Debian packaging for 0.99.4
Date: Sat, 13 Aug 2005 02:41:25 +0200
Message-ID: <20050813004125.GO5411@kiste.smurf.noris.de>
References: <7v8xzfde7t.fsf@assigned-by-dhcp.cox.net> <7vr7d6z3pn.fsf@assigned-by-dhcp.cox.net> <7vacjsdcbj.fsf@assigned-by-dhcp.cox.net> <7vwtmw5nx7.fsf_-_@assigned-by-dhcp.cox.net> <pan.2005.08.10.21.15.41.143251@smurf.noris.de> <pan.2005.08.10.22.11.25.242201@smurf.noris.de> <7vd5olqtvp.fsf@assigned-by-dhcp.cox.net> <20050810235436.GW28270@kiste.smurf.noris.de> <7vpssiucss.fsf@assigned-by-dhcp.cox.net> <46a038f905081215547618441c@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Aug 13 02:43:42 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1E3k6h-0003O3-S8
	for gcvg-git@gmane.org; Sat, 13 Aug 2005 02:42:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751315AbVHMAmh (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 12 Aug 2005 20:42:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750843AbVHMAmh
	(ORCPT <rfc822;git-outgoing>); Fri, 12 Aug 2005 20:42:37 -0400
Received: from run.smurf.noris.de ([192.109.102.41]:51171 "EHLO
	server.smurf.noris.de") by vger.kernel.org with ESMTP
	id S1750836AbVHMAmh (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 12 Aug 2005 20:42:37 -0400
Received: from kiste.smurf.noris.de ([192.109.102.35] ident=mail)
	by server.smurf.noris.de with smtp (Exim 4.50)
	id 1E3k5W-0002fA-E8; Sat, 13 Aug 2005 02:41:39 +0200
Received: (nullmailer pid 11100 invoked by uid 501);
	Sat, 13 Aug 2005 00:41:25 -0000
To: Martin Langhoff <martin.langhoff@gmail.com>
Content-Disposition: inline
In-Reply-To: <46a038f905081215547618441c@mail.gmail.com>
User-Agent: Mutt/1.5.6+20040907i
X-Smurf-Spam-Score: -2.5 (--)
X-Smurf-Whitelist: +relay_from_hosts
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Hi,

Martin Langhoff:
> It is correct to have Architecture: i386, as you'd naturally have
> multiple binary packages.

However, git(-t)k doesn't contain any i386 code, just a tk script.

> Packages with arch 'all' are interpreted languages.

Exactly. ;-)

-- 
Matthias Urlichs   |   {M:U} IT Design @ m-u-it.de   |  smurf@smurf.noris.de
Disclaimer: The quote was selected randomly. Really. | http://smurf.noris.de
 - -
compuberty, n:
	The uncomfortable period of emotional and hormonal changes a
	computer experiences when the operating system is upgraded and
	a sun4 is put online sharing files.
