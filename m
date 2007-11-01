From: Junio C Hamano <gitster@pobox.com>
Subject: Re: What's cooking in git.git (topics)
Date: Thu, 01 Nov 2007 15:50:39 -0700
Message-ID: <7vwst17f7k.fsf@gitster.siamese.dyndns.org>
References: <20071022063222.GS14735@spearce.org>
	<916BE4AD-5BD9-48E6-8026-B1AC7387E28D@adacore.com>
	<7v4pg5btis.fsf@gitster.siamese.dyndns.org>
	<200711012232.57286.johan@herland.net>
	<7v8x5hab3d.fsf@gitster.siamese.dyndns.org>
	<alpine.LFD.0.999.0711011459490.3342@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johan Herland <johan@herland.net>, git@vger.kernel.org,
	Geert Bosch <bosch@adacore.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Thu Nov 01 23:51:02 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1InisP-0006NP-Ml
	for gcvg-git-2@gmane.org; Thu, 01 Nov 2007 23:51:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755178AbXKAWur (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 1 Nov 2007 18:50:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753757AbXKAWur
	(ORCPT <rfc822;git-outgoing>); Thu, 1 Nov 2007 18:50:47 -0400
Received: from sceptre.pobox.com ([207.106.133.20]:59882 "EHLO
	sceptre.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753500AbXKAWuq (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 1 Nov 2007 18:50:46 -0400
Received: from sceptre (localhost.localdomain [127.0.0.1])
	by sceptre.pobox.com (Postfix) with ESMTP id 8E3A62F9;
	Thu,  1 Nov 2007 18:51:07 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by sceptre.sasl.smtp.pobox.com (Postfix) with ESMTP id 1366C912FF;
	Thu,  1 Nov 2007 18:51:02 -0400 (EDT)
In-Reply-To: <alpine.LFD.0.999.0711011459490.3342@woody.linux-foundation.org>
	(Linus Torvalds's message of "Thu, 1 Nov 2007 15:05:44 -0700 (PDT)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/63031>

Linus Torvalds <torvalds@linux-foundation.org> writes:

> But yeah, I guess we could make the "clean.Imagirlyman" option (or however 
> the "please-don't-hurt-me-by-default" option is spelled) the default. That 
> way I'd just feel *extra* manly for immediately disabling it, and laughing 
> at you wimps.

That makes me a girly man, I would guess, as I just suggested
making clean.requireForce default to true in the next (or one
after) version of git ;-).
