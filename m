From: Jeff King <peff@peff.net>
Subject: Re: [PATCH v2 4/4] git-p4: add support for large file systems
Date: Fri, 4 Sep 2015 04:58:04 -0400
Message-ID: <20150904085803.GA32751@sigill.intra.peff.net>
References: <1441298148-63885-1-git-send-email-larsxschneider@gmail.com>
 <1441298148-63885-5-git-send-email-larsxschneider@gmail.com>
 <55E8A7A7.9010401@diamand.org>
 <6D21B562-6527-480F-9E8B-39F7574C3A2D@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Luke Diamand <luke@diamand.org>, Git List <git@vger.kernel.org>
To: Lars Schneider <larsxschneider@gmail.com>
X-From: git-owner@vger.kernel.org Fri Sep 04 10:58:34 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZXmpL-0001tV-NQ
	for gcvg-git-2@plane.gmane.org; Fri, 04 Sep 2015 10:58:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756484AbbIDI6K convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 4 Sep 2015 04:58:10 -0400
Received: from cloud.peff.net ([50.56.180.127]:54854 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753896AbbIDI6I (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 4 Sep 2015 04:58:08 -0400
Received: (qmail 26599 invoked by uid 102); 4 Sep 2015 08:58:08 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Fri, 04 Sep 2015 03:58:08 -0500
Received: (qmail 18093 invoked by uid 107); 4 Sep 2015 08:58:11 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Fri, 04 Sep 2015 04:58:11 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 04 Sep 2015 04:58:04 -0400
Content-Disposition: inline
In-Reply-To: <6D21B562-6527-480F-9E8B-39F7574C3A2D@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/277294>

On Thu, Sep 03, 2015 at 10:49:36PM +0200, Lars Schneider wrote:

> Do you want to test this feature against a real backend? In that case
> you would need a LFS enabled GitHub account. If you don=E2=80=99t hav=
e one,
> maybe _Jeff King_ can help?

You can sign up here:

  https://github.com/early_access/git-lfs

I don't know what the turnaround time is like, but if you (or anybody
doing development work around git-lfs) needs it expedited, email me
off-list and I can look into it.

-Peff
