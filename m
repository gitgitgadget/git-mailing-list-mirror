From: Jeff King <peff@peff.net>
Subject: Re: [RFC PATCH 1/2] add a --delete option to git push
Date: Fri, 14 Aug 2009 03:01:10 -0400
Message-ID: <20090814070109.GC7113@coredump.intra.peff.net>
References: <1250226349-20397-1-git-send-email-srabbelier@gmail.com>
 <1250226349-20397-2-git-send-email-srabbelier@gmail.com>
 <7vab22ubr5.fsf@alter.siamese.dyndns.org>
 <20090814070021.GB7113@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Sverre Rabbelier <srabbelier@gmail.com>,
	Jakub Narebski <jnareb@gmail.com>,
	Git List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Aug 14 09:01:19 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Mbqms-0002FZ-Uv
	for gcvg-git-2@gmane.org; Fri, 14 Aug 2009 09:01:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932191AbZHNHBL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 14 Aug 2009 03:01:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755487AbZHNHBK
	(ORCPT <rfc822;git-outgoing>); Fri, 14 Aug 2009 03:01:10 -0400
Received: from peff.net ([208.65.91.99]:57020 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755459AbZHNHBK (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 14 Aug 2009 03:01:10 -0400
Received: (qmail 15437 invoked by uid 107); 14 Aug 2009 07:01:13 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Fri, 14 Aug 2009 03:01:13 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Fri, 14 Aug 2009 03:01:10 -0400
Content-Disposition: inline
In-Reply-To: <20090814070021.GB7113@coredump.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/125909>

On Fri, Aug 14, 2009 at 03:00:21AM -0400, Jeff King wrote:

> Thank you for succintly explaining what I was trying to put my finger on
> elsewhere in the thread. To sum up what I was trying to say:
> 
> I don't have anything against the "delete mode" mental model, but I
> don't have a particular use for it. My counter-proposal was "syntactic
> sugar without changing the mental model". Between the two, I don't have
> a strong feeling (and my "this is wrong" comments were about where you
> had mixed the two, and I think you agreed with them).

To clarify: "you" in the first paragraph is Junio, and in the second it
is Sverre. :)

-Peff
