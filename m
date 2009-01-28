From: Jeff King <peff@peff.net>
Subject: Re: How to install and use a custom merge driver
Date: Wed, 28 Jan 2009 01:18:48 -0500
Message-ID: <20090128061848.GA19165@coredump.intra.peff.net>
References: <497FCC9A.9080008@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Alec Clews <alec.clews@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jan 28 07:20:20 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LS3mc-0007eC-KA
	for gcvg-git-2@gmane.org; Wed, 28 Jan 2009 07:20:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752226AbZA1GSx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 28 Jan 2009 01:18:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752021AbZA1GSx
	(ORCPT <rfc822;git-outgoing>); Wed, 28 Jan 2009 01:18:53 -0500
Received: from peff.net ([208.65.91.99]:43732 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751878AbZA1GSw (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 28 Jan 2009 01:18:52 -0500
Received: (qmail 19128 invoked by uid 107); 28 Jan 2009 06:18:59 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Wed, 28 Jan 2009 01:18:59 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Wed, 28 Jan 2009 01:18:48 -0500
Content-Disposition: inline
In-Reply-To: <497FCC9A.9080008@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/107482>

On Wed, Jan 28, 2009 at 02:10:18PM +1100, Alec Clews wrote:

> Setup:
>
> I have set up my ..git/info/gitattributes as follows
>
> *      merge=overwrite

Your setup looks right, except that the correct file is
".git/info/attributes".

-Peff
