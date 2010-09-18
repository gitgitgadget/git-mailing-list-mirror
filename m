From: Miles Bader <miles@gnu.org>
Subject: Re: [PATCH] smart-http: Don't change POST to GET when following redirect
Date: Sat, 18 Sep 2010 23:09:19 +0900
Message-ID: <87vd639m9c.fsf@catnip.gol.com>
References: <877hijvff7.fsf@catnip.gol.com>
	<20100918070315.GA30872@LK-Perkele-V2.elisa-laajakaista.fi>
	<m262y3cvpy.fsf@whitebox.home> <m21v8rcua1.fsf_-_@whitebox.home>
Reply-To: Miles Bader <miles@gnu.org>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Ilari Liusvaara <ilari.liusvaara@elisanet.fi>, git@vger.kernel.org
To: Andreas Schwab <schwab@linux-m68k.org>
X-From: git-owner@vger.kernel.org Sat Sep 18 16:09:39 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Owy6j-0007Pr-0f
	for gcvg-git-2@lo.gmane.org; Sat, 18 Sep 2010 16:09:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755359Ab0IROJc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 18 Sep 2010 10:09:32 -0400
Received: from smtp12.dentaku.gol.com ([203.216.5.74]:57305 "EHLO
	smtp12.dentaku.gol.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755049Ab0IROJb (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 18 Sep 2010 10:09:31 -0400
Received: from 218.231.154.125.eo.eaccess.ne.jp ([218.231.154.125] helo=catnip.gol.com)
	by smtp12.dentaku.gol.com with esmtpa (Dentaku)
	id 1Owy6T-0001qW-8J; Sat, 18 Sep 2010 23:09:21 +0900
Received: by catnip.gol.com (Postfix, from userid 1000)
	id 12151DF8B; Sat, 18 Sep 2010 23:09:19 +0900 (JST)
System-Type: x86_64-unknown-linux-gnu
In-Reply-To: <m21v8rcua1.fsf_-_@whitebox.home> (Andreas Schwab's message of
	"Sat, 18 Sep 2010 10:47:50 +0200")
X-Virus-Scanned: ClamAV GOL (outbound)
X-Abuse-Complaints: abuse@gol.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/156454>

Thanks Andreas!

-miles

-- 
Acquaintance, n. A person whom we know well enough to borrow from, but not
well enough to lend to.
