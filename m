From: Pierre Habouzit <madcoder@madism.org>
Subject: Re: Problem with "dashless options"
Date: Wed, 9 Sep 2009 18:30:01 +0200
Message-ID: <20090909163001.GE4859@laphroaig.corp>
References: <D69FA890-4249-4DC9-B8AE-C9F105F1AD3B@isy.liu.se>
 <20090909143455.GA10092@sigill.intra.peff.net>
 <AB9C50E3-E2BB-4449-B8F9-75777ADE1602@isy.liu.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org
To: Henrik Tidefelt <tidefelt@isy.liu.se>
X-From: git-owner@vger.kernel.org Wed Sep 09 18:36:55 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MlQAB-0002Se-5D
	for gcvg-git-2@lo.gmane.org; Wed, 09 Sep 2009 18:36:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753796AbZIIQg1 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 9 Sep 2009 12:36:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753318AbZIIQg0
	(ORCPT <rfc822;git-outgoing>); Wed, 9 Sep 2009 12:36:26 -0400
Received: from pan.madism.org ([88.191.52.104]:53072 "EHLO hermes.madism.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753312AbZIIQg0 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 9 Sep 2009 12:36:26 -0400
X-Greylist: delayed 384 seconds by postgrey-1.27 at vger.kernel.org; Wed, 09 Sep 2009 12:36:26 EDT
Received: from laphroaig.corp (def92-12-88-177-251-208.fbx.proxad.net [88.177.251.208])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(Client did not present a certificate)
	by hermes.madism.org (Postfix) with ESMTPSA id 80BEA45390;
	Wed,  9 Sep 2009 18:30:04 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <AB9C50E3-E2BB-4449-B8F9-75777ADE1602@isy.liu.se>
X-Face: $(^e[V4D-[`f2EmMGz@fgWK!e.B~2g.{08lKPU(nc1J~z\4B>*JEVq:E]7G-\6$Ycr4<;Z!|VY6Grt]+RsS$IMV)f>2)M="tY:ZPcU;&%it2D81X^kNya0=L]"vZmLP+UmKhgq+u*\.dJ8G!N&=EvlD
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/128074>

On Wed, Sep 09, 2009 at 06:26:37PM +0200, Henrik Tidefelt wrote:
> Yes, that was a strange error.  I applied the patch, but could not
> reproduce the error any more.  Also, Gustaf Hendeby built git
> directly from the git distribution (not via MacPorts) on my machine,
> and could not reproduce the error.  Then I simply tried to clean and
> build the git from MacPorts again, and voila!, now it works.
> Something very strange must have happened during the previous build.

Are you using a keyboard mapping where AltGr+space produces an &nbsp; ?

--=20
=C2=B7O=C2=B7  Pierre Habouzit
=C2=B7=C2=B7O                                                madcoder@d=
ebian.org
OOO                                                http://www.madism.or=
g
