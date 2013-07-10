From: Jeff King <peff@peff.net>
Subject: Re: What's cooking in git.git (Jul 2013, #03; Tue, 9)
Date: Tue, 9 Jul 2013 20:26:31 -0400
Message-ID: <20130710002630.GB11643@sigill.intra.peff.net>
References: <7vr4f7tjo0.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jul 10 02:26:40 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UwiEx-0004EG-Hk
	for gcvg-git-2@plane.gmane.org; Wed, 10 Jul 2013 02:26:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753746Ab3GJA0f (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 9 Jul 2013 20:26:35 -0400
Received: from cloud.peff.net ([50.56.180.127]:43320 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752143Ab3GJA0f (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 9 Jul 2013 20:26:35 -0400
Received: (qmail 26166 invoked by uid 102); 10 Jul 2013 00:27:51 -0000
Received: from c-98-244-76-202.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (98.244.76.202)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Tue, 09 Jul 2013 19:27:51 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 09 Jul 2013 20:26:31 -0400
Content-Disposition: inline
In-Reply-To: <7vr4f7tjo0.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/230020>

On Tue, Jul 09, 2013 at 04:09:35PM -0700, Junio C Hamano wrote:

> * jk/argv-pushf-sentinel (2013-07-09) 1 commit
>  - argv-array: add sentinel attribute to argv_array_pushl
> 
>  Will merge to 'next'.

If you have not pushed it out already, I just posted a re-roll which
covers many other places, too.

-Peff
