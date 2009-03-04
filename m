From: layer <layer@known.net>
Subject: Re: [PATCH] clone: run post-checkout hook when checking out
Date: Tue, 03 Mar 2009 21:01:09 -0800
Message-ID: <5444.1236142869@relay.known.net>
References: <20273.1236033817@relay.known.net> <20090303042848.GC18136@coredump.intra.peff.net> <23978.1236056549@relay.known.net> <20090303053750.GA30201@coredump.intra.peff.net>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Mar 04 06:02:42 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LejFi-0003wA-0j
	for gcvg-git-2@gmane.org; Wed, 04 Mar 2009 06:02:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750761AbZCDFBP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 4 Mar 2009 00:01:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750739AbZCDFBO
	(ORCPT <rfc822;git-outgoing>); Wed, 4 Mar 2009 00:01:14 -0500
Received: from relay.known.net ([67.121.255.169]:45705 "HELO relay.known.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1750717AbZCDFBN (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 4 Mar 2009 00:01:13 -0500
Received: from localhost (127.0.0.1) by relay.known.net
    (Allegro Maild v1.2.17) id 000000027757; Tue, 3 Mar 2009 21:01:09 -0800
In-reply-to: <20090303053750.GA30201@coredump.intra.peff.net>
Comments: In-reply-to Jeff King <peff@peff.net>
   message dated "Tue, 03 Mar 2009 00:37:51 -0500."
X-Mailer: MH-E 8.1; nmh 1.3; GNU Emacs 22.3.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/112179>

Jeff,

Thanks very much for doing this.

Kevin
