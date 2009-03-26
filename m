From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 1/2] init: support --import to add all files and commit
	right after init
Date: Thu, 26 Mar 2009 06:13:26 -0400
Message-ID: <20090326101326.GA14963@coredump.intra.peff.net>
References: <1238062203-5809-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Thu Mar 26 11:15:15 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LmmcB-0000VY-7A
	for gcvg-git-2@gmane.org; Thu, 26 Mar 2009 11:15:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753215AbZCZKNj convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 26 Mar 2009 06:13:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752265AbZCZKNj
	(ORCPT <rfc822;git-outgoing>); Thu, 26 Mar 2009 06:13:39 -0400
Received: from peff.net ([208.65.91.99]:58660 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751226AbZCZKNi (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 26 Mar 2009 06:13:38 -0400
Received: (qmail 13433 invoked by uid 107); 26 Mar 2009 10:13:50 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Thu, 26 Mar 2009 06:13:50 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Thu, 26 Mar 2009 06:13:26 -0400
Content-Disposition: inline
In-Reply-To: <1238062203-5809-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/114768>

On Thu, Mar 26, 2009 at 09:10:03PM +1100, Nguy=E1=BB=85n Th=C3=A1i Ng=E1=
=BB=8Dc Duy wrote:

> This is equivalent to "git init;git add .;git commit -q -m blah".
> I find myself doing that too many times, hence this shortcut.
>=20
> In future, --fast-import support would also be nice if the import
> directory has a lot of files.
>=20
> Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gma=
il.com>

This version looks good to me. Thanks.

-Peff
