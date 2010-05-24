From: Jeff King <peff@peff.net>
Subject: Re: serious performance issues with images, audio files, and other
 "non-code" data
Date: Mon, 24 May 2010 02:45:54 -0400
Message-ID: <20100524064554.GA12262@coredump.intra.peff.net>
References: <4BED47EA.9090905@puckerupgames.com>
 <20100517231642.GB12092@coredump.intra.peff.net>
 <4BF2E168.2020706@puckerupgames.com>
 <20100518191933.GB2383@coredump.intra.peff.net>
 <alpine.LFD.2.00.1005181528550.12758@xanadu.home>
 <20100518194105.GA4723@coredump.intra.peff.net>
 <alpine.LFD.2.00.1005181557250.12758@xanadu.home>
 <4BF9C678.6010108@puckerupgames.com>
 <20100524053955.GA4528@coredump.intra.peff.net>
 <4BFA2054.6060002@puckerupgames.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Nicolas Pitre <nico@fluxnic.net>, git@vger.kernel.org
To: John <john@puckerupgames.com>
X-From: git-owner@vger.kernel.org Mon May 24 08:46:10 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OGRQL-0000pq-NT
	for gcvg-git-2@lo.gmane.org; Mon, 24 May 2010 08:46:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755757Ab0EXGp7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 24 May 2010 02:45:59 -0400
Received: from peff.net ([208.65.91.99]:39663 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751784Ab0EXGp7 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 24 May 2010 02:45:59 -0400
Received: (qmail 773 invoked by uid 107); 24 May 2010 06:46:01 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Mon, 24 May 2010 02:46:01 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Mon, 24 May 2010 02:45:55 -0400
Content-Disposition: inline
In-Reply-To: <4BFA2054.6060002@puckerupgames.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/147603>

On Mon, May 24, 2010 at 02:44:36AM -0400, John wrote:

> I agree, no defaults are better than arbitrary defaults.  So why is
> the default "text"?

Because git was designed as a source control system?

-Peff
