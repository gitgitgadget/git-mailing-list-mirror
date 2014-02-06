From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 1/6] test: rename http fetch and push test files
Date: Thu, 6 Feb 2014 14:33:40 -0500
Message-ID: <20140206193339.GA14552@sigill.intra.peff.net>
References: <1391699439-22781-1-git-send-email-pclouds@gmail.com>
 <1391699439-22781-2-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	"Shawn O. Pearce" <spearce@spearce.org>
To: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Thu Feb 06 20:33:49 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WBUho-0004Bc-GH
	for gcvg-git-2@plane.gmane.org; Thu, 06 Feb 2014 20:33:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754297AbaBFTdo convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 6 Feb 2014 14:33:44 -0500
Received: from cloud.peff.net ([50.56.180.127]:45908 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752486AbaBFTdn (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 6 Feb 2014 14:33:43 -0500
Received: (qmail 23771 invoked by uid 102); 6 Feb 2014 19:33:43 -0000
Received: from mobile-032-128-012-224.mycingular.net (HELO sigill.intra.peff.net) (32.128.12.224)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Thu, 06 Feb 2014 13:33:43 -0600
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 06 Feb 2014 14:33:40 -0500
Content-Disposition: inline
In-Reply-To: <1391699439-22781-2-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/241714>

On Thu, Feb 06, 2014 at 10:10:34PM +0700, Nguy=E1=BB=85n Th=C3=A1i Ng=E1=
=BB=8Dc Duy wrote:

> Make clear which one is for dumb protocol, which one is for smart fro=
m
> their file name.
>=20
> Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gma=
il.com>

Yay. This has often bugged me, and I can't believe we went this long
without fixing it.

-Peff
