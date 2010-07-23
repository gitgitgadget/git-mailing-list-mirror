From: Thomas Rast <trast@student.ethz.ch>
Subject: Re: URL decoding changed semantics of + in URLs
Date: Fri, 23 Jul 2010 15:21:52 +0200
Message-ID: <201007231521.52750.trast@student.ethz.ch>
References: <201007231518.31071.trast@student.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: <git@vger.kernel.org>, <jstpierre@mecheye.net>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Jul 23 15:22:01 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OcICP-0000VF-6T
	for gcvg-git-2@lo.gmane.org; Fri, 23 Jul 2010 15:22:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759393Ab0GWNVy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 23 Jul 2010 09:21:54 -0400
Received: from gwse.ethz.ch ([129.132.178.238]:6493 "EHLO gwse.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752781Ab0GWNVx (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 23 Jul 2010 09:21:53 -0400
Received: from CAS20.d.ethz.ch (172.31.51.110) by gws01.d.ethz.ch
 (129.132.178.238) with Microsoft SMTP Server (TLS) id 8.2.254.0; Fri, 23 Jul
 2010 15:21:51 +0200
Received: from thomas.localnet (129.132.153.233) by CAS20.d.ethz.ch
 (172.31.51.110) with Microsoft SMTP Server (TLS) id 14.0.702.0; Fri, 23 Jul
 2010 15:21:51 +0200
User-Agent: KMail/1.13.5 (Linux/2.6.31.12-0.2-desktop; KDE/4.4.93; x86_64; ; )
In-Reply-To: <201007231518.31071.trast@student.ethz.ch>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/151530>

Thomas Rast wrote:
> Hi Jeff
> 
> As pointed out by Jasper St. Pierre on #git, it is no longer possible
> to clone
> 
>   git://git.gnome.org/gtk+

Well, that reads wrong now that I'm seeing it again.

I of course meant to say that the above URL no longer works and must
be spelled

    git://git.gnome.org/gtk%2B

instead.

-- 
Thomas Rast
trast@{inf,student}.ethz.ch
