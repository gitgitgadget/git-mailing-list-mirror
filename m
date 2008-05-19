From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] t7701-repack-unpack-unreachable.sh: check timestamp of
	unpacked objects
Date: Mon, 19 May 2008 17:08:43 -0400
Message-ID: <20080519210843.GA25293@sigill.intra.peff.net>
References: <16342222.1211083116270.JavaMail.teamon@b306.teamon.com> <7vd4niaozy.fsf@gitster.siamese.dyndns.org> <OleexvYZfiSxUgrxHbDqLpGl2g7TsoOO7pwZXC1fiyL2KxKVuWLtWw@cipher.nrlssc.navy.mil> <E8K6ZsektNV-bzzpBDDSjLUNAu6_Tgxq9EV2896g2zCI6VyLsESxXw@cipher.nrlssc.navy.mil>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <junio@pobox.com>, gitster@pobox.com,
	git@vger.kernel.org
To: Brandon Casey <casey@nrlssc.navy.mil>
X-From: git-owner@vger.kernel.org Mon May 19 23:10:13 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JyCbx-0003CX-00
	for gcvg-git-2@gmane.org; Mon, 19 May 2008 23:09:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758526AbYESVIq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 19 May 2008 17:08:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756979AbYESVIq
	(ORCPT <rfc822;git-outgoing>); Mon, 19 May 2008 17:08:46 -0400
Received: from peff.net ([208.65.91.99]:1449 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756152AbYESVIp (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 19 May 2008 17:08:45 -0400
Received: (qmail 8019 invoked by uid 111); 19 May 2008 21:08:44 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.32) with ESMTP; Mon, 19 May 2008 17:08:44 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 19 May 2008 17:08:43 -0400
Content-Disposition: inline
In-Reply-To: <E8K6ZsektNV-bzzpBDDSjLUNAu6_Tgxq9EV2896g2zCI6VyLsESxXw@cipher.nrlssc.navy.mil>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/82451>

On Mon, May 19, 2008 at 03:27:02PM -0500, Brandon Casey wrote:

> Also, do you have a url to your posix reference?

I generally use:

  http://www.opengroup.org/onlinepubs/009695399/

Specifically:

  http://www.opengroup.org/onlinepubs/009695399/utilities/test.html

-Peff
