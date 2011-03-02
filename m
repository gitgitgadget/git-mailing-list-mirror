From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
	<u.kleine-koenig@pengutronix.de>
Subject: Re: gitweb: cloud tags feature produces malformed XML for errors
Date: Wed, 2 Mar 2011 22:55:56 +0100
Message-ID: <20110302215556.GL22310@pengutronix.de>
References: <20110301190229.11297.17767.reportbug@cassiopeia.kleinek>
 <20110301222141.GB7918@elie>
 <4D6D97FB.3050106@kernel.org>
 <201103022218.46640.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: "J.H." <warthog9@kernel.org>, Jonathan Nieder <jrnieder@gmail.com>,
	git@vger.kernel.org, admin@repo.or.cz
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Wed Mar 02 22:56:13 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Puu1i-0003Ff-Ng
	for gcvg-git-2@lo.gmane.org; Wed, 02 Mar 2011 22:56:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757365Ab1CBV4E convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 2 Mar 2011 16:56:04 -0500
Received: from metis.ext.pengutronix.de ([92.198.50.35]:38346 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756306Ab1CBV4C (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 2 Mar 2011 16:56:02 -0500
Received: from octopus.hi.pengutronix.de ([2001:6f8:1178:2:215:17ff:fe12:23b0])
	by metis.ext.pengutronix.de with esmtp (Exim 4.72)
	(envelope-from <ukl@pengutronix.de>)
	id 1Puu1X-0000NY-HC; Wed, 02 Mar 2011 22:55:59 +0100
Received: from ukl by octopus.hi.pengutronix.de with local (Exim 4.69)
	(envelope-from <ukl@pengutronix.de>)
	id 1Puu1U-0002cc-7h; Wed, 02 Mar 2011 22:55:56 +0100
Content-Disposition: inline
In-Reply-To: <201103022218.46640.jnareb@gmail.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
X-SA-Exim-Connect-IP: 2001:6f8:1178:2:215:17ff:fe12:23b0
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: git@vger.kernel.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/168354>

Hello Jakub,

On Wed, Mar 02, 2011 at 10:18:44PM +0100, Jakub Narebski wrote:
> What is most important that makes this feature to be considered for
> removal (or rehauling) is that only half of this feature is implement=
ed
> in gitweb: the displaying part.  There is half-attempt of providing
> some web interface for managing tags... which needs external script w=
ith
> strict coupling, doesn't offer any access control as far as I know, d=
o
> not allow deleting tags, etc.
=46or a small set of repositories the need to hand-edit the tags is OK
IMHO.  That's what I intended to do.

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig        =
    |
Industrial Linux Solutions                 | http://www.pengutronix.de/=
  |
