From: Frank Lichtenheld <frank@lichtenheld.de>
Subject: Re: [PATCH] Add option -L to git-tag.
Date: Sat, 2 Jun 2007 16:49:07 +0200
Message-ID: <20070602144906.GB29603@planck.djpig.de>
References: <1180789848873-git-send-email-mmelchior@xs4all.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
To: Matthijs Melchior <mmelchior@xs4all.nl>
X-From: git-owner@vger.kernel.org Sat Jun 02 16:49:28 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HuUuy-0002iq-VI
	for gcvg-git@gmane.org; Sat, 02 Jun 2007 16:49:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759615AbXFBOtR (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 2 Jun 2007 10:49:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759847AbXFBOtR
	(ORCPT <rfc822;git-outgoing>); Sat, 2 Jun 2007 10:49:17 -0400
Received: from planck.djpig.de ([85.10.192.180]:3944 "EHLO planck.djpig.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759615AbXFBOtQ (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 2 Jun 2007 10:49:16 -0400
Received: from localhost (localhost [127.0.0.1])
	by planck.djpig.de (Postfix) with ESMTP id 649A1881B4;
	Sat,  2 Jun 2007 16:49:12 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at planck.djpig.de
Received: from planck.djpig.de ([127.0.0.1])
	by localhost (planck.djpig.de [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id bVje7JOM17J3; Sat,  2 Jun 2007 16:49:08 +0200 (CEST)
Received: by planck.djpig.de (Postfix, from userid 1000)
	id BD976881B5; Sat,  2 Jun 2007 16:49:07 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <1180789848873-git-send-email-mmelchior@xs4all.nl>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/48930>

On Sat, Jun 02, 2007 at 03:10:48PM +0200, Matthijs Melchior wrote:
> +`-L <pattern>` lists tags, including their annotations, that match
> +the given pattern (or all if no pattern is given).

>From the descriptions it is not clear to me if the pattern is applied to
the tag names, the annotations or both. Maybe one could reorder that
sentence to make it less confusing?

Gruesse,
-- 
Frank Lichtenheld <frank@lichtenheld.de>
www: http://www.djpig.de/
