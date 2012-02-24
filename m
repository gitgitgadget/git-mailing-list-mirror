From: Jeff King <peff@peff.net>
Subject: Re: [BugReport] git tag -a / git show
Date: Fri, 24 Feb 2012 16:44:28 -0500
Message-ID: <20120224214428.GA16828@sigill.intra.peff.net>
References: <b05f03b381140ca57a7d03a934f605bd@rom1v.com>
 <4F47E48D.4080501@in.waw.pl>
 <1330113345.2727.3.camel@rom-laptop>
 <20120224205203.GA21780@sigill.intra.peff.net>
 <1330119763.2727.10.camel@rom-laptop>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Zbigniew =?utf-8?Q?J=C4=99drzejewski-Szmek?= <zbyszek@in.waw.pl>,
	git@vger.kernel.org
To: Romain Vimont =?utf-8?B?KMKub20p?= <rom@rom1v.com>
X-From: git-owner@vger.kernel.org Fri Feb 24 22:44:37 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S12wM-0005wQ-Qf
	for gcvg-git-2@plane.gmane.org; Fri, 24 Feb 2012 22:44:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758127Ab2BXVoa convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 24 Feb 2012 16:44:30 -0500
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:56078
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754766Ab2BXVo3 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 24 Feb 2012 16:44:29 -0500
Received: (qmail 29657 invoked by uid 107); 24 Feb 2012 21:44:31 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Fri, 24 Feb 2012 16:44:31 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 24 Feb 2012 16:44:28 -0500
Content-Disposition: inline
In-Reply-To: <1330119763.2727.10.camel@rom-laptop>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/191489>

On Fri, Feb 24, 2012 at 10:42:43PM +0100, Romain Vimont (=C2=AEom) wrot=
e:

> Thank you, I didn't know this '^' thing ;-)

You might find the "Specifying Revisions" section of "git help
rev-parse" enlightening. :)

-Peff
