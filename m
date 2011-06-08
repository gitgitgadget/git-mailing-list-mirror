From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 04/19] teach remote-testgit to import non-HEAD refs
Date: Wed, 8 Jun 2011 18:15:38 -0400
Message-ID: <20110608221535.GA15530@sigill.intra.peff.net>
References: <1307558930-16074-1-git-send-email-srabbelier@gmail.com>
 <1307558930-16074-5-git-send-email-srabbelier@gmail.com>
 <20110608193049.GG27715@elie>
 <BANLkTin6u_oZpaHiRfEzsL2kSbj9coZcrQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	Git List <git@vger.kernel.org>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Ramkumar Ramachandra <artagnon@gmail.com>
To: Sverre Rabbelier <srabbelier@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jun 09 00:15:51 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QUR2U-0007Ds-1J
	for gcvg-git-2@lo.gmane.org; Thu, 09 Jun 2011 00:15:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756091Ab1FHWPp convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 8 Jun 2011 18:15:45 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:34004
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751277Ab1FHWPp (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 8 Jun 2011 18:15:45 -0400
Received: (qmail 5110 invoked by uid 107); 8 Jun 2011 22:15:52 -0000
Received: from m9a2036d0.tmodns.net (HELO sigill.intra.peff.net) (208.54.32.154)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Wed, 08 Jun 2011 18:15:52 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 08 Jun 2011 18:15:38 -0400
Content-Disposition: inline
In-Reply-To: <BANLkTin6u_oZpaHiRfEzsL2kSbj9coZcrQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/175468>

On Wed, Jun 08, 2011 at 09:47:38PM +0200, Sverre Rabbelier wrote:

> On Wed, Jun 8, 2011 at 21:30, Jonathan Nieder <jrnieder@gmail.com> wr=
ote:
> >> =C2=A0 Unchanged from Peff's series.
> >
> > Looks good. =C2=A0What happened to Peff's signoff?
>=20
> I pulled the series from his github repo, which didn't have it.

Ah, yeah, I stick it in when I send the email. Now that I am publishing
my topic branches, I should maybe do it at commit time.

-Peff
