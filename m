From: Frank Lichtenheld <frank@lichtenheld.de>
Subject: Re: [PATCH] git-remote: document -n
Date: Sat, 30 Jun 2007 13:12:40 +0200
Message-ID: <20070630111240.GQ12721@planck.djpig.de>
References: <1183193782172-git-send-email-sam.vilain@catalyst.net.nz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Sam Vilain <sam.vilain@catalyst.net.nz>
X-From: git-owner@vger.kernel.org Sat Jun 30 13:12:58 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I4asn-0000Ap-TP
	for gcvg-git@gmane.org; Sat, 30 Jun 2007 13:12:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755585AbXF3LMw (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 30 Jun 2007 07:12:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755477AbXF3LMw
	(ORCPT <rfc822;git-outgoing>); Sat, 30 Jun 2007 07:12:52 -0400
Received: from planck.djpig.de ([85.10.192.180]:2922 "EHLO planck.djpig.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755310AbXF3LMv (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 30 Jun 2007 07:12:51 -0400
Received: from localhost (localhost [127.0.0.1])
	by planck.djpig.de (Postfix) with ESMTP id 3077988105;
	Sat, 30 Jun 2007 13:12:50 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at planck.djpig.de
Received: from planck.djpig.de ([127.0.0.1])
	by localhost (planck.djpig.de [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 40Iy7hyF72zK; Sat, 30 Jun 2007 13:12:41 +0200 (CEST)
Received: by planck.djpig.de (Postfix, from userid 1000)
	id E7956881B4; Sat, 30 Jun 2007 13:12:40 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <1183193782172-git-send-email-sam.vilain@catalyst.net.nz>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/51211>

On Sat, Jun 30, 2007 at 08:56:16PM +1200, Sam Vilain wrote:
> From: Sam Vilain <sam@vilain.net>
> 
> The 'show' and 'prune' commands accept an option '-n'; document what
> it does.

You might want to add that in the SYNOPSIS, too.

Gruesse,
-- 
Frank Lichtenheld <frank@lichtenheld.de>
www: http://www.djpig.de/
