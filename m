From: Miles Bader <miles@gnu.org>
Subject: Re: [PATCH 0/4] contrib/subtree: general updates
Date: Thu, 14 Mar 2013 11:52:14 +0900
Message-ID: <874ngebsm9.fsf@catnip.gol.com>
References: <1363213963-4065-1-git-send-email-pcampbell@kemitix.net>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git <git@vger.kernel.org>, David Greene <greened@obbligato.org>
To: Paul Campbell <pcampbell@kemitix.net>
X-From: git-owner@vger.kernel.org Thu Mar 14 03:52:51 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UFyHh-0003jm-7M
	for gcvg-git-2@plane.gmane.org; Thu, 14 Mar 2013 03:52:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932689Ab3CNCwW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 13 Mar 2013 22:52:22 -0400
Received: from smtp11.dentaku.gol.com ([203.216.5.73]:51074 "EHLO
	smtp11.dentaku.gol.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755032Ab3CNCwW (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 Mar 2013 22:52:22 -0400
Received: from 218.33.195.56.eo.eaccess.ne.jp ([218.33.195.56] helo=catnip.gol.com)
	by smtp11.dentaku.gol.com with esmtpa (Dentaku)
	(envelope-from <miles@gnu.org>)
	id 1UFyHA-0002cH-Oe; Thu, 14 Mar 2013 11:52:16 +0900
Received: by catnip.gol.com (Postfix, from userid 1000)
	id D10A9DFC1; Thu, 14 Mar 2013 11:52:14 +0900 (JST)
System-Type: x86_64-unknown-linux-gnu
In-Reply-To: <1363213963-4065-1-git-send-email-pcampbell@kemitix.net> (Paul
	Campbell's message of "Wed, 13 Mar 2013 22:32:39 +0000")
X-Virus-Scanned: ClamAV GOL (outbound)
X-Abuse-Complaints: abuse@gol.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/218109>

Paul Campbell <pcampbell@kemitix.net> writes:
> James and Michael's patches add if clauses that use the
> bashism 'if []' rather than 'if test'.

"Bashism"...?  I dunno how portable is, but "[" is an old unix alias
for "test" ... it certainly predates bash...

-miles

-- 
Occam's razor split hairs so well, I bought the whole argument!
