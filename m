From: Jeff King <peff@peff.net>
Subject: Re: [RFC PATCH] tests: print failed test numbers at the end of the
 test run
Date: Tue, 26 Jul 2011 00:10:38 -0600
Message-ID: <20110726061038.GB29486@sigill.intra.peff.net>
References: <4E2B1DF2.4000003@web.de>
 <CACsJy8CuqHSoG4PVMiT=5EUv2hn=42y5B+6Rhny2VkXW32WR8Q@mail.gmail.com>
 <20110726054236.GC25046@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Jens Lehmann <Jens.Lehmann@web.de>,
	Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>
To: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jul 26 08:11:06 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QlarC-0005nb-Hq
	for gcvg-git-2@lo.gmane.org; Tue, 26 Jul 2011 08:11:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751296Ab1GZGKn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 26 Jul 2011 02:10:43 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:56555
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751079Ab1GZGKm (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 26 Jul 2011 02:10:42 -0400
Received: (qmail 17397 invoked by uid 107); 26 Jul 2011 06:11:12 -0000
Received: from S010690840de80b38.ss.shawcable.net (HELO sigill.intra.peff.net) (70.64.172.81)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Tue, 26 Jul 2011 02:11:12 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 26 Jul 2011 00:10:38 -0600
Content-Disposition: inline
In-Reply-To: <20110726054236.GC25046@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/177845>

On Mon, Jul 25, 2011 at 11:42:36PM -0600, Jeff King wrote:

> Or use "prove", which can do fancy things like putting the last-failed
> (so you can see the likely failures immediately and start to probe them
> while the rest of the suite runs).

Oops, that should read "...putting the last-failed tests at the
beginning".

-Peff
