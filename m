From: Heiko Voigt <hvoigt@hvoigt.net>
Subject: Re: [RFC/WIP PATCH 0/4] less ignorance of submodules for ignore=all
Date: Wed, 4 Dec 2013 23:26:29 +0100
Message-ID: <20131204222629.GF7326@sandbox-ub>
References: <528FC638.5060403@web.de>
 <20131122215454.GA4952@sandbox-ub>
 <20131122220953.GI4212@google.com>
 <52910BC4.1030800@web.de>
 <20131124005256.GA3500@sandbox-ub>
 <52922962.3090407@web.de>
 <CAErtv2729o-xf=49xY06aVL1ZJzJpeH+cc_Pd1cAP52r32Ss_g@mail.gmail.com>
 <20131125174945.GA3847@sandbox-ub>
 <CAErtv259jxCtvbJYZHgQZv-VJ9U+JwNzWo0tn007SDTCCBScrA@mail.gmail.com>
 <20131204221659.GA7326@sandbox-ub>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jens Lehmann <Jens.Lehmann@web.de>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Jeff King <peff@peff.net>, Git List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>
To: Sergey Sharybin <sergey.vfx@gmail.com>
X-From: git-owner@vger.kernel.org Wed Dec 04 23:26:43 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VoKtz-0003Vy-QQ
	for gcvg-git-2@plane.gmane.org; Wed, 04 Dec 2013 23:26:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755059Ab3LDW0f (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 4 Dec 2013 17:26:35 -0500
Received: from smtprelay06.ispgateway.de ([80.67.31.103]:43613 "EHLO
	smtprelay06.ispgateway.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753206Ab3LDW0f (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 4 Dec 2013 17:26:35 -0500
Received: from [77.21.76.49] (helo=sandbox-ub)
	by smtprelay06.ispgateway.de with esmtpsa (TLSv1:AES128-SHA:128)
	(Exim 4.68)
	(envelope-from <hvoigt@hvoigt.net>)
	id 1VoKtq-0002Zj-MD; Wed, 04 Dec 2013 23:26:30 +0100
Content-Disposition: inline
In-Reply-To: <20131204221659.GA7326@sandbox-ub>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Df-Sender: aHZvaWd0QGh2b2lndC5uZXQ=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/238822>

On Wed, Dec 04, 2013 at 11:16:59PM +0100, Heiko Voigt wrote:
>  * The git diff $commit question Junio mentioned here[1] it does not yet
>    show diffs of ignore=all submodules.

Forgot to add this here:

[1] http://article.gmane.org/gmane.comp.version-control.git/238348
