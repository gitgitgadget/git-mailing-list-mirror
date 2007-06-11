From: Frank Lichtenheld <frank@lichtenheld.de>
Subject: Re: [PATCH 5/5] Add gitmodules(5)
Date: Tue, 12 Jun 2007 00:59:19 +0200
Message-ID: <20070611225918.GD4323@planck.djpig.de>
References: <11815891453464-git-send-email-hjemli@gmail.com> <11815891451258-git-send-email-hjemli@gmail.com> <1181589146478-git-send-email-hjemli@gmail.com> <1181589146685-git-send-email-hjemli@gmail.com> <1181589146188-git-send-email-hjemli@gmail.com> <11815891463922-git-send-email-hjemli@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Lars Hjemli <hjemli@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jun 12 00:59:35 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HxsrG-0005OG-T7
	for gcvg-git@gmane.org; Tue, 12 Jun 2007 00:59:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752502AbXFKW72 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 11 Jun 2007 18:59:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753262AbXFKW72
	(ORCPT <rfc822;git-outgoing>); Mon, 11 Jun 2007 18:59:28 -0400
Received: from planck.djpig.de ([85.10.192.180]:1100 "EHLO planck.djpig.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752502AbXFKW71 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 11 Jun 2007 18:59:27 -0400
Received: from localhost (localhost [127.0.0.1])
	by planck.djpig.de (Postfix) with ESMTP id 8ABB188102;
	Tue, 12 Jun 2007 00:59:24 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at planck.djpig.de
Received: from planck.djpig.de ([127.0.0.1])
	by localhost (planck.djpig.de [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id XuUHGM0ShuSK; Tue, 12 Jun 2007 00:59:19 +0200 (CEST)
Received: by planck.djpig.de (Postfix, from userid 1000)
	id 9FDA788105; Tue, 12 Jun 2007 00:59:19 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <11815891463922-git-send-email-hjemli@gmail.com>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/49895>

On Mon, Jun 11, 2007 at 09:12:25PM +0200, Lars Hjemli wrote:
> +Consider the following .gitmodules file:
> +
> +	[submodule 'libfoo']
> +		path = include/foo
> +		url = git://foo.com/git/lib.git
> +
> +	[submodule 'libbar']
> +		path = include/bar
> +		url = git://bar.com/git/lib.git
> +

Still the wrong quotes.

Gruesse,
-- 
Frank Lichtenheld <frank@lichtenheld.de>
www: http://www.djpig.de/
