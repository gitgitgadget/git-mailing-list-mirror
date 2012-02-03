From: Jeff King <peff@peff.net>
Subject: Re: [PATCH v2] Use correct grammar in diffstat summary line
Date: Fri, 3 Feb 2012 07:24:01 -0500
Message-ID: <20120203122401.GE31441@sigill.intra.peff.net>
References: <1328019840-6168-1-git-send-email-pclouds@gmail.com>
 <1328100907-20397-1-git-send-email-pclouds@gmail.com>
 <7vhaza2qjw.fsf@alter.siamese.dyndns.org>
 <20120202142255.GA25871@do>
 <7v8vklxfe4.fsf@alter.siamese.dyndns.org>
 <CACsJy8CcBB9OF=8a1hQEpDFzqsrkbpFKnVAcU65h_5Cnym90SQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Jonathan Nieder <jrnieder@gmail.com>,
	=?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= <avarab@gmail.com>,
	Frederik Schwarzer <schwarzerf@gmail.com>,
	Brandon Casey <drafnel@gmail.com>
To: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Fri Feb 03 13:24:12 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RtIBX-0007eW-T1
	for gcvg-git-2@plane.gmane.org; Fri, 03 Feb 2012 13:24:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753323Ab2BCMYF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 3 Feb 2012 07:24:05 -0500
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:55834
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751817Ab2BCMYE (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 3 Feb 2012 07:24:04 -0500
Received: (qmail 31069 invoked by uid 107); 3 Feb 2012 12:31:08 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Fri, 03 Feb 2012 07:31:08 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 03 Feb 2012 07:24:01 -0500
Content-Disposition: inline
In-Reply-To: <CACsJy8CcBB9OF=8a1hQEpDFzqsrkbpFKnVAcU65h_5Cnym90SQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/189753>

On Fri, Feb 03, 2012 at 08:11:23AM +0700, Nguyen Thai Ngoc Duy wrote:

> >> I take it --summary is un-i18n-able,...
> >
> > ... because?
> 
> .. of scripts? We have --numstat for scripts, but I see no alternative
> to --summary. Does anybody parse --summary output?

I would think it is spelled "--raw".

-Peff
