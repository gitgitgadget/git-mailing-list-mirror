From: Jeff King <peff@peff.net>
Subject: Re: Composing git repositories
Date: Tue, 2 Apr 2013 13:58:39 -0400
Message-ID: <20130402175839.GF24698@sigill.intra.peff.net>
References: <7vmwtqt8rs.fsf@alter.siamese.dyndns.org>
 <CALkWK0kNH2A4eLML22RTofarR3MB++OECiNXMi-bWLLMWK1GAg@mail.gmail.com>
 <7vvc8comj5.fsf@alter.siamese.dyndns.org>
 <CALkWK0nARWAtC-D3UiNLccuaSwjR6meJb+Cu590N=8Ti8O7OMg@mail.gmail.com>
 <51537A7B.7050206@web.de>
 <CALkWK0nfNCu775MBB-Y28=V93RkV24kbTLTDKWO2dZ-0yxX=Sw@mail.gmail.com>
 <5154AACC.7050006@web.de>
 <CALkWK0k=g3iFjmpUQA1VkuH2kZsVX1_Hpo=LZ7CuotwHz_1++g@mail.gmail.com>
 <20130331225747.GB11704@elie.Belkin>
 <CALkWK0mgtfYFd+sT=J-hAMLq=HVF-_a-kT_xxE9-ZzfiBiFBQA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	Jens Lehmann <Jens.Lehmann@web.de>,
	Junio C Hamano <gitster@pobox.com>,
	Git List <git@vger.kernel.org>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Tue Apr 02 19:59:17 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UN5UH-0003Hb-1f
	for gcvg-git-2@plane.gmane.org; Tue, 02 Apr 2013 19:59:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759108Ab3DBR6o (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 2 Apr 2013 13:58:44 -0400
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:52406 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757895Ab3DBR6o (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 2 Apr 2013 13:58:44 -0400
Received: (qmail 12121 invoked by uid 107); 2 Apr 2013 18:00:32 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Tue, 02 Apr 2013 14:00:32 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 02 Apr 2013 13:58:39 -0400
Content-Disposition: inline
In-Reply-To: <CALkWK0mgtfYFd+sT=J-hAMLq=HVF-_a-kT_xxE9-ZzfiBiFBQA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/219822>

On Tue, Apr 02, 2013 at 11:14:49PM +0530, Ramkumar Ramachandra wrote:

> > If you are curious, at a quieter time it might be useful to ask for
> > pointers to the discussions that led to the current design, and folks
> > on the list might be glad to help.
> 
> Will do.  The search on GMane is no good, and taking a local dump to
> search using real tools is just too painful; does someone already have
> a local dump?

Yes, I have a maildir with the complete list archive, which I index
using mairix (or sometimes grep if I'm doing something particularly
tricky). I find the search on gmane to be abysmal.

I'm happy to make my dump available to anyone who wants it, but it's
kind of big (about 1.4G uncompressed).

-Peff
