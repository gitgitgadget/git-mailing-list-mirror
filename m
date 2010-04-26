From: Jeff King <peff@peff.net>
Subject: Re: [PATCH v2 2/3] pretty: make %H/%h dependent on
 --abbrev[-commit]
Date: Sun, 25 Apr 2010 23:42:54 -0400
Message-ID: <20100426034254.GA16500@coredump.intra.peff.net>
References: <1272232579-18895-1-git-send-email-wmpalmer@gmail.com>
 <1272232579-18895-2-git-send-email-wmpalmer@gmail.com>
 <1272232579-18895-3-git-send-email-wmpalmer@gmail.com>
 <20100426031012.GA29953@progeny.tock>
 <20100426033147.GB14421@coredump.intra.peff.net>
 <20100426033813.GA30544@progeny.tock>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Will Palmer <wmpalmer@gmail.com>, git@vger.kernel.org,
	gitster@pobox.com
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Mon Apr 26 05:43:05 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O6FDq-0002ri-Tw
	for gcvg-git-2@lo.gmane.org; Mon, 26 Apr 2010 05:43:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754455Ab0DZDm5 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 25 Apr 2010 23:42:57 -0400
Received: from peff.net ([208.65.91.99]:38121 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752697Ab0DZDm5 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 25 Apr 2010 23:42:57 -0400
Received: (qmail 3001 invoked by uid 107); 26 Apr 2010 03:43:06 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Sun, 25 Apr 2010 23:43:06 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Sun, 25 Apr 2010 23:42:54 -0400
Content-Disposition: inline
In-Reply-To: <20100426033813.GA30544@progeny.tock>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/145785>

On Sun, Apr 25, 2010 at 10:38:13PM -0500, Jonathan Nieder wrote:

> > You parse '%%H' incorrectly.
>=20
> I=E2=80=99m pretty sure I don=E2=80=99t.

Sorry, you're right. I should read more carefully.

-Peff
