From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] Git segmentation faults if submodule path is empty.
Date: Mon, 19 Aug 2013 16:48:40 -0400
Message-ID: <20130819204840.GA30907@sigill.intra.peff.net>
References: <277BEB82-D618-48D9-A276-4B0E76A11A38@eyesopen.com>
 <520DCB4B.6090309@web.de>
 <20130816130957.GB20138@sigill.intra.peff.net>
 <20130816131406.GC20138@sigill.intra.peff.net>
 <AFCBD71A-21CB-45CC-8386-C65173B6D173@eyesopen.com>
 <0C422E09-EE33-4C3F-91D3-F6007F743A38@eyesopen.com>
 <20130816205246.GA6487@sigill.intra.peff.net>
 <B692A7F2-C5C2-4B5A-8FFC-6CF5C9DB72D8@eyesopen.com>
 <7vzjsdldbi.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Jharrod LaFon <jlafon@eyesopen.com>,
	Jens Lehmann <Jens.Lehmann@web.de>,
	"git@vger.kernel.org" <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Aug 19 22:48:52 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VBWNb-0004CA-SN
	for gcvg-git-2@plane.gmane.org; Mon, 19 Aug 2013 22:48:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751137Ab3HSUso (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 19 Aug 2013 16:48:44 -0400
Received: from cloud.peff.net ([50.56.180.127]:59056 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750925Ab3HSUsn (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 19 Aug 2013 16:48:43 -0400
Received: (qmail 4223 invoked by uid 102); 19 Aug 2013 20:48:44 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Mon, 19 Aug 2013 15:48:44 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 19 Aug 2013 16:48:40 -0400
Content-Disposition: inline
In-Reply-To: <7vzjsdldbi.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/232564>

On Mon, Aug 19, 2013 at 11:56:17AM -0700, Junio C Hamano wrote:

> Jharrod LaFon <jlafon@eyesopen.com> writes:
> 
> > Updated the patch and the patch submission.
> >
> 
> Getting a lot warmer ;-).

Thanks, I agree with all of the stuff you said. The end result that you
included looks good to me.

-Peff
