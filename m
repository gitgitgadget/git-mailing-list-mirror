From: "Ulrich Windl" <ulrich.windl@rz.uni-regensburg.de>
Subject: Re: [kernel.org users] [RFD] On deprecating "git-foo" for builtins
Date: Wed, 27 Aug 2008 08:04:23 +0200
Organization: Universitaetsklinikum Regensburg
Message-ID: <48B50A84.29823.A5D4BB6@Ulrich.Windl.rkdvmks1.ngate.uni-regensburg.de>
References: <1219664940.9583.42.camel@pmac.infradead.org>, <alpine.LFD.1.10.0808261004150.3363@nehalem.linux-foundation.org>, <20080826172742.GN26610@one.firstfloor.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Kristian H??gsberg <krh@redhat.com>,
	Matthias Kestenholz <mk@spinlock.ch>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	users@kernel.org, Jeff King <peff@peff.net>,
	Andi Kleen <andi@firstfloor.org>, Petr Baudis <pasky@suse.cz>,
	Junio C Hamano <gitster@pobox.com>,
	David Woodhouse <dwmw2@infradead.org>, git@vger.kernel.org
To: Andi Kleen <andi@firstfloor.org>
X-From: git-owner@vger.kernel.org Wed Aug 27 08:37:19 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KYEec-0002Lv-Rl
	for gcvg-git-2@gmane.org; Wed, 27 Aug 2008 08:37:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754617AbYH0Gfv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 27 Aug 2008 02:35:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754614AbYH0Gfu
	(ORCPT <rfc822;git-outgoing>); Wed, 27 Aug 2008 02:35:50 -0400
Received: from rrzd4.rz.uni-regensburg.de ([194.94.155.49]:1818 "EHLO
	rrzd4.rz.uni-regensburg.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754601AbYH0Gft (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 27 Aug 2008 02:35:49 -0400
Received: from rrzd4.rz.uni-regensburg.de (localhost [127.0.0.1])
	by localhost (Postfix) with SMTP id 0CA3B125C;
	Wed, 27 Aug 2008 08:04:58 +0200 (CEST)
Received: from mailgate.dvm.klinik.uni-regensburg.de (kgate2.klinik.uni-regensburg.de [132.199.176.19])
	by rrzd4.rz.uni-regensburg.de (Postfix) with ESMTP id 2862231DA;
	Wed, 27 Aug 2008 08:04:56 +0200 (CEST)
Received: from rkdvmks1.ngate.uni-regensburg.de (rkdvmks1.dvm.klinik.uni-regensburg.de [132.199.176.1])
	by mailgate.dvm.klinik.uni-regensburg.de (8.13.6/8.13.6/20060824MT-1) with ESMTP id m7R64miU019470;
	Wed, 27 Aug 2008 08:04:48 +0200
Received: from RKDVMKS1/SpoolDir by rkdvmks1.ngate.uni-regensburg.de (Mercury 1.48);
    27 Aug 08 08:04:49 +0200
Received: from SpoolDir by RKDVMKS1 (Mercury 1.48); 27 Aug 08 08:04:31 +0200
In-reply-to: <20080826172742.GN26610@one.firstfloor.org>
X-mailer: Pegasus Mail for Windows (4.41)
Content-description: Mail message body
X-Content-Conformance: HerringScan-0.27/Sophos-P=4.29.0+V=4.29+U=2.07.201+R=05 May 2008+T=405404@20080827.055307Z
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/93861>

On 26 Aug 2008 at 19:27, Andi Kleen wrote:

[...]
> I was assuming someone thinking about using git. At some point
> they will do the git<space><tab><tab> thing and be scared away.
[...]

Hi!

Honestly I think, the user will type "git<ENTER>" first.

Ulrich
