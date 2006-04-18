From: David Woodhouse <dwmw2@infradead.org>
Subject: Re: Clone with local alternates?
Date: Wed, 19 Apr 2006 00:59:43 +0100
Message-ID: <1145404784.16166.98.camel@shinybook.infradead.org>
References: <1145404132.16166.97.camel@shinybook.infradead.org>
	 <20060418235658.GB8915@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Apr 19 01:59:43 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FW06f-0007gD-Qv
	for gcvg-git@gmane.org; Wed, 19 Apr 2006 01:59:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750869AbWDRX7j (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 18 Apr 2006 19:59:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750877AbWDRX7i
	(ORCPT <rfc822;git-outgoing>); Tue, 18 Apr 2006 19:59:38 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:41117 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1750869AbWDRX7i (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 18 Apr 2006 19:59:38 -0400
Received: from shinybook.infradead.org ([81.187.2.165])
	by pentafluge.infradead.org with esmtpsa (Exim 4.61 #1 (Red Hat Linux))
	id 1FW06a-0001ES-Qp; Wed, 19 Apr 2006 00:59:37 +0100
To: Shawn Pearce <spearce@spearce.org>
In-Reply-To: <20060418235658.GB8915@spearce.org>
X-Mailer: Evolution 2.6.0 (2.6.0-1.dwmw2.1) 
X-SRS-Rewrite: SMTP reverse-path rewritten from <dwmw2@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/18887>

On Tue, 2006-04-18 at 19:56 -0400, Shawn Pearce wrote:
>   git clone --reference=/foo git://remote/foo
> 
> would do the trick.  This is new in 1.3.0.  I just noticed its also
> not documented in 1.3.0.  :-)

Aha. Thanks.

-- 
dwmw2
