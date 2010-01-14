From: Miles Bader <miles@gnu.org>
Subject: Re: [PATCH] git push --track
Date: Thu, 14 Jan 2010 09:28:13 +0900
Message-ID: <87vdf55y3m.fsf@catnip.gol.com>
References: <op.u6g8jnixg402ra@nb-04> <20100113154310.GA7348@Knoppix>
Reply-To: Miles Bader <miles@gnu.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Rudolf Polzer <divVerent@alientrap.org>, git@vger.kernel.org
To: Ilari Liusvaara <ilari.liusvaara@elisanet.fi>
X-From: git-owner@vger.kernel.org Thu Jan 14 01:28:28 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NVDZb-0001LY-Gs
	for gcvg-git-2@lo.gmane.org; Thu, 14 Jan 2010 01:28:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756721Ab0ANA2V (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 13 Jan 2010 19:28:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756711Ab0ANA2V
	(ORCPT <rfc822;git-outgoing>); Wed, 13 Jan 2010 19:28:21 -0500
Received: from smtp12.dentaku.gol.com ([203.216.5.74]:38748 "EHLO
	smtp12.dentaku.gol.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756164Ab0ANA2U (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 Jan 2010 19:28:20 -0500
Received: from 218.231.177.74.eo.eaccess.ne.jp ([218.231.177.74] helo=catnip.gol.com)
	by smtp12.dentaku.gol.com with esmtpa (Dentaku)
	id 1NVDZN-0006PZ-Jt; Thu, 14 Jan 2010 09:28:13 +0900
Received: by catnip.gol.com (Postfix, from userid 1000)
	id 778B7DF73; Thu, 14 Jan 2010 09:28:13 +0900 (JST)
System-Type: x86_64-unknown-linux-gnu
In-Reply-To: <20100113154310.GA7348@Knoppix> (Ilari Liusvaara's message of
	"Wed, 13 Jan 2010 17:43:10 +0200")
X-Virus-Scanned: ClamAV GOL (outbound)
X-Abuse-Complaints: abuse@gol.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/136904>

Ilari Liusvaara <ilari.liusvaara@elisanet.fi> writes:
> - Is --track the best name for this?

I think "--track" is absolutely the right name for this option -- it's
the option name used for "set up tracking" option in other commands, and
it's just very natural (when I've thought about implementing a similar
functionality myself, I also chose the name "--track").

-Miles

-- 
Youth, n. The Period of Possibility, when Archimedes finds a fulcrum,
Cassandra has a following and seven cities compete for the honor of endowing a
living Homer.
