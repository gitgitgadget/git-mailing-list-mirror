From: Sam Vilain <sam@vilain.net>
Subject: Re: [PATCH] Change 'Deltifying objects' to 'Delta compressing	objects'
Date: Fri, 19 Oct 2007 15:19:28 +1300
Message-ID: <47181430.2080907@vilain.net>
References: <20071019004527.GA12930@spearce.org> <20071019021255.GD3290@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Cc: "Shawn O. Pearce" <spearce@spearce.org>, git@vger.kernel.org,
	Nicolas Pitre <nico@cam.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Oct 19 04:19:51 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IihSn-00085H-HJ
	for gcvg-git-2@gmane.org; Fri, 19 Oct 2007 04:19:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760580AbXJSCTi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 18 Oct 2007 22:19:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759226AbXJSCTi
	(ORCPT <rfc822;git-outgoing>); Thu, 18 Oct 2007 22:19:38 -0400
Received: from watts.utsl.gen.nz ([202.78.240.73]:51651 "EHLO
	magnus.utsl.gen.nz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756867AbXJSCTh (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 18 Oct 2007 22:19:37 -0400
Received: by magnus.utsl.gen.nz (Postfix, from userid 65534)
	id 0D741205A67; Fri, 19 Oct 2007 15:19:36 +1300 (NZDT)
Received: from [192.168.2.22] (leibniz.catalyst.net.nz [202.78.240.7])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by magnus.utsl.gen.nz (Postfix) with ESMTP id 599DF21CFDB;
	Fri, 19 Oct 2007 15:19:31 +1300 (NZDT)
User-Agent: Icedove 1.5.0.12 (X11/20070606)
In-Reply-To: <20071019021255.GD3290@coredump.intra.peff.net>
X-Enigmail-Version: 0.94.2.0
X-Spam-Checker-Version: SpamAssassin 3.0.2 (2004-11-16) on 
	mail.magnus.utsl.gen.nz
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=5.0 tests=ALL_TRUSTED autolearn=failed 
	version=3.0.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/61604>

Jeff King wrote:
> Boo. I _like_ "deltifying". Sure, it's probably not in the dictionary,
> but that's how languages change: saying "delta compressing" all the time
> will get awkward, so people invent a new word using existing rules to
> explain a common phenomenon.

This is not very considerate to non-native speakers, though, who might
not grasp the neogolism.

Perhaps just "compressing" if it gets awkward.

Sam.
