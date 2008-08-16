From: Stephan Beyer <s-beyer@gmx.net>
Subject: Re: [PATCH] git-am: ignore --binary option
Date: Sat, 16 Aug 2008 04:27:12 +0200
Message-ID: <20080816022712.GD8837@leksak.fem-net>
References: <1218238134-14231-1-git-send-email-s-beyer@gmx.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Aug 16 04:28:25 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KUBWi-0002h4-Od
	for gcvg-git-2@gmane.org; Sat, 16 Aug 2008 04:28:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751589AbYHPC1R (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 15 Aug 2008 22:27:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751345AbYHPC1R
	(ORCPT <rfc822;git-outgoing>); Fri, 15 Aug 2008 22:27:17 -0400
Received: from mail.gmx.net ([213.165.64.20]:38395 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751307AbYHPC1R (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 15 Aug 2008 22:27:17 -0400
Received: (qmail invoked by alias); 16 Aug 2008 02:27:15 -0000
Received: from q137.fem.tu-ilmenau.de (EHLO leksak.fem-net) [141.24.46.137]
  by mail.gmx.net (mp062) with SMTP; 16 Aug 2008 04:27:15 +0200
X-Authenticated: #1499303
X-Provags-ID: V01U2FsdGVkX19ZwEVB/hRZaCF7GCOSbcUAjGEQzBeu8+UW9Fc6Rl
	LfDErr0sr50e9N
Received: from sbeyer by leksak.fem-net with local (Exim 4.69)
	(envelope-from <s-beyer@gmx.net>)
	id 1KUBVY-0002VV-12; Sat, 16 Aug 2008 04:27:12 +0200
Content-Disposition: inline
In-Reply-To: <1218238134-14231-1-git-send-email-s-beyer@gmx.net>
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.79
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/92528>

Hi,

Stephan Beyer wrote:
> The git-apply documentation says that --binary is a historical option.
> This patch lets git-am ignore --binary and removes advertisements of this
> option.

I thought 1.6.0 would be the right release to not advertise the --binary
option any longer, but it seems that this is wrong.

Is there some reason that this patch is going into a wrong direction?
Or was it just overlooked?

Kind regards,
  Stephan

-- 
Stephan Beyer <s-beyer@gmx.net>, PGP 0x6EDDD207FCC5040F
