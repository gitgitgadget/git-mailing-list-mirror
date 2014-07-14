From: Jeff King <peff@peff.net>
Subject: Re: 745224e0 gcc-4.9 emmintrin.h build error
Date: Mon, 14 Jul 2014 02:00:13 -0400
Message-ID: <20140714060013.GB5593@sigill.intra.peff.net>
References: <CAOvwQ4hNVvzeCUczi7Qurcycp8HA8KU=u1ntu3fzBwu4fTEzPQ@mail.gmail.com>
 <1405024438.3775.3.camel@stross>
 <CAOvwQ4hq5AZ0ZhB-1etUZfLfJ4X=11_03syH2pgY_fi=FSLAPQ@mail.gmail.com>
 <1405025616.3775.6.camel@stross>
 <CAOvwQ4h=uFCN36dQt4uqwJv8393iVhiCh09+71DhhzyWrbCfUA@mail.gmail.com>
 <CAOvwQ4in4aufZX2PGkAoX4vWhg_mq+n6Baov_ifGjiyfR_UbPQ@mail.gmail.com>
 <20140712045616.GA14459@sigill.intra.peff.net>
 <CAOvwQ4gjfzh4+fNg9-7DecdubzYRW=6t4-4Exq7+mNLAPumb1w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: David Turner <dturner@twopensource.com>, git@vger.kernel.org
To: Tuncer Ayaz <tuncer.ayaz@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jul 14 08:00:20 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1X6ZJD-0004JY-QQ
	for gcvg-git-2@plane.gmane.org; Mon, 14 Jul 2014 08:00:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752719AbaGNGAQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 14 Jul 2014 02:00:16 -0400
Received: from cloud.peff.net ([50.56.180.127]:33434 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752616AbaGNGAP (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 14 Jul 2014 02:00:15 -0400
Received: (qmail 402 invoked by uid 102); 14 Jul 2014 06:00:15 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Mon, 14 Jul 2014 01:00:15 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 14 Jul 2014 02:00:13 -0400
Content-Disposition: inline
In-Reply-To: <CAOvwQ4gjfzh4+fNg9-7DecdubzYRW=6t4-4Exq7+mNLAPumb1w@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/253475>

On Sat, Jul 12, 2014 at 10:47:03AM +0200, Tuncer Ayaz wrote:

> Yes, Andi's patch works.
> 
> Any idea when ak/profile-feedback-build will land in master?

Junio posts updates in his "What's Cooking" messages (usually about
twice a week). Last Tuesday's listed it as "will merge to next".  Unless
anybody finds problems with it, I'd expect it in master within a week or
two, and probably part of v2.1 when it releases.

-Peff
