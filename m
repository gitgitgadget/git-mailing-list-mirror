From: Erik de Castro Lopo <erikd@mega-nerd.com>
Subject: Re: Retrieving a file at a before a specified commit
Date: Thu, 30 May 2013 10:59:56 +1000
Organization: Erik Conspiracy Secret Labs
Message-ID: <20130530105956.dbf5e3363fa0abbc0143d463@mega-nerd.com>
References: <20130529164735.5489ab47953406745d9034ef@mega-nerd.com>
	<20130529075811.GA7204@sigill.intra.peff.net>
	<20130530104932.d7ba4bfb426044ab9653057e@mega-nerd.com>
Reply-To: git@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: Jeff King <peff@peff.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu May 30 03:10:13 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UhrNc-0000Ez-7n
	for gcvg-git-2@plane.gmane.org; Thu, 30 May 2013 03:10:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759695Ab3E3BKI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 29 May 2013 21:10:08 -0400
Received: from hendrix.mega-nerd.net ([203.206.230.162]:38110 "EHLO
	hendrix.mega-nerd.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754763Ab3E3BKH (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 29 May 2013 21:10:07 -0400
X-Greylist: delayed 608 seconds by postgrey-1.27 at vger.kernel.org; Wed, 29 May 2013 21:10:07 EDT
Received: from rollins.mnn (pharoah-vpn [10.9.8.2])
	by hendrix.mega-nerd.net (Postfix) with SMTP id 77A95106DF9;
	Thu, 30 May 2013 10:59:56 +1000 (EST)
In-Reply-To: <20130530104932.d7ba4bfb426044ab9653057e@mega-nerd.com>
X-Mailer: Sylpheed 3.3.0 (GTK+ 2.24.10; x86_64-pc-linux-gnu)
X-gpg-fingerprint: 7357 1E85 C19F 4281 D8C9  7AA8 6CA4 1A77 43B8 D6C8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/225905>

Erik de Castro Lopo wrote:

> Does this explanation make sense?

Just to answer my own question, Yes it does.

The file was added in commit 53266574 and was actually zero length
at that time.

Cheers,
Erik
----------------------------------------------------------------------
Erik de Castro Lopo
http://www.mega-nerd.com/
