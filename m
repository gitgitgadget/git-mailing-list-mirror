From: Eric Wong <normalperson@yhbt.net>
Subject: Re: [PATCH 4/4] Documentation/git-svn.txt: Fix formatting errors
Date: Thu, 1 Mar 2007 12:38:33 -0800
Message-ID: <20070301203833.GB25782@localdomain>
References: <1172778077659-git-send-email-vsu@altlinux.ru> <11727780872894-git-send-email-vsu@altlinux.ru> <11727780982140-git-send-email-vsu@altlinux.ru> <11727781092949-git-send-email-vsu@altlinux.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
To: Sergey Vlasov <vsu@altlinux.ru>
X-From: git-owner@vger.kernel.org Thu Mar 01 21:38:45 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HMs2z-00040K-Qg
	for gcvg-git@gmane.org; Thu, 01 Mar 2007 21:38:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030228AbXCAUii (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 1 Mar 2007 15:38:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030206AbXCAUii
	(ORCPT <rfc822;git-outgoing>); Thu, 1 Mar 2007 15:38:38 -0500
Received: from hand.yhbt.net ([66.150.188.102]:34999 "EHLO hand.yhbt.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1030228AbXCAUii (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 1 Mar 2007 15:38:38 -0500
Received: from hand.yhbt.net (localhost [127.0.0.1])
	by hand.yhbt.net (Postfix) with SMTP id 674257DC094;
	Thu,  1 Mar 2007 12:38:36 -0800 (PST)
Received: by hand.yhbt.net (sSMTP sendmail emulation); Thu, 01 Mar 2007 12:38:33 -0800
Content-Disposition: inline
In-Reply-To: <11727781092949-git-send-email-vsu@altlinux.ru>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/41124>

Sergey Vlasov <vsu@altlinux.ru> wrote:
> Fix some formatting problems:
> 
>   - Some list labels were missing their "::" characters.
>   - Some of continuation paragraphs in labeled lists were incorrectly
>     formatted as literal paragraphs.
>   - In one case "[verse]" was missing before the config key list.
>   - The "Basic Examples" section was incorrectly nested inside the
>     "Config File-Only Options" section.

Thanks.  However, are the indentation changes in the source absolutely
necessary for asciidoc to correctly format these things?  I try to
avoid building the docs because my computers are too slow.

If so:

Acked-by: Eric Wong <normalperson@yhbt.net>

> Signed-off-by: Sergey Vlasov <vsu@altlinux.ru>
> Cc: Eric Wong <normalperson@yhbt.net>

-- 
Eric Wong
