From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH] docs: give more hints about how "add -e" works
Date: Thu, 21 Oct 2010 14:04:35 -0500
Message-ID: <20101021190435.GB11759@burratino>
References: <20101021143034.GA16083@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>,
	Miklos Vajna <vmiklos@frugalware.org>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Oct 21 21:08:28 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P90V2-0002TF-1L
	for gcvg-git-2@lo.gmane.org; Thu, 21 Oct 2010 21:08:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757426Ab0JUTIW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 21 Oct 2010 15:08:22 -0400
Received: from mail-wy0-f174.google.com ([74.125.82.174]:38019 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757091Ab0JUTIV (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 21 Oct 2010 15:08:21 -0400
Received: by wyb33 with SMTP id 33so66458wyb.19
        for <git@vger.kernel.org>; Thu, 21 Oct 2010 12:08:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=pyeNI1FfOVFrekcNZS5gbZkP8ZejgveBGuUjWVdVW2E=;
        b=wnQbyG23YRMMZ2yNWJOXCJwEGyAcmvyMa4syd4VOg7jl3bO6lbJObgjHKWuWlpn36w
         Rn11OES9nIHbximJpDCXrkTto7w6y1ZF2ltT1R9X4FACGEOpVm6WFsuzqXQuiUUglUbK
         CFf7pvpe3OU7vGFScxLfLlWkcLpvEGt0SFRx4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=aubbBcch97yYqOtOqHEqPB0mWn15aVxlSVT95GTpjl1HEz/1iLIwd9MUlpM9HkmPu/
         nGYw/TjkN9FBLWTykKDfxgW6lRu3EyASatUsRW0Qbo/oaMRUgGYg137PQ9qz80BKsWdS
         DaHv9DNuuU4m3kxKkm59YLkLQsuyYLVN5EmLI=
Received: by 10.227.143.75 with SMTP id t11mr1507181wbu.190.1287688100225;
        Thu, 21 Oct 2010 12:08:20 -0700 (PDT)
Received: from burratino (adsl-68-255-106-176.dsl.chcgil.ameritech.net [68.255.106.176])
        by mx.google.com with ESMTPS id l51sm936063wer.2.2010.10.21.12.08.18
        (version=SSLv3 cipher=RC4-MD5);
        Thu, 21 Oct 2010 12:08:19 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20101021143034.GA16083@sigill.intra.peff.net>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/159541>

Jeff King wrote:

>                                                         This
> patch attempts to cover explicitly what can be done at the
> individual line level, and cautions the user that
> conceptually larger changes (like modifying a line) require
> some understanding of the patch format.

For what it's worth:
Reviewed-by: Jonathan Nieder <jrnieder@gmail.com>
