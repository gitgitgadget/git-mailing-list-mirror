From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 0/6] Towards a generalized sequencer
Date: Thu, 11 Aug 2011 14:03:12 -0500
Message-ID: <20110811190312.GD2277@elie.gateway.2wire.net>
References: <1313088705-32222-1-git-send-email-artagnon@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
	Christian Couder <chriscool@tuxfamily.org>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Jeff King <peff@peff.net>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Thu Aug 11 21:03:24 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QraXI-0007qV-UY
	for gcvg-git-2@lo.gmane.org; Thu, 11 Aug 2011 21:03:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753184Ab1HKTDQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 11 Aug 2011 15:03:16 -0400
Received: from mail-gw0-f46.google.com ([74.125.83.46]:47370 "EHLO
	mail-gw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752912Ab1HKTDQ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 11 Aug 2011 15:03:16 -0400
Received: by gwaa12 with SMTP id a12so1528285gwa.19
        for <git@vger.kernel.org>; Thu, 11 Aug 2011 12:03:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=pB/2h2hMuex5hBtAWj/W1hD40fMAFcIRi4oynTKJtTI=;
        b=B0pUnGKyc5aQJVXrC79WKG+Li0IAruoLnlwg/Uz2IuevMhYDqBW3Iq5GSYSNMVhW8n
         /8KjGqnysHByHtBBWjmCwIsqGzjsBKRPUq7p2EaeiOPaTfrae64tfPSt1PuM3iXtZ6Yy
         odE7Ux4dixnpz6JjQpRXx3z9Y4EWpO1z6UeNE=
Received: by 10.100.82.9 with SMTP id f9mr12505anb.0.1313089395600;
        Thu, 11 Aug 2011 12:03:15 -0700 (PDT)
Received: from elie.gateway.2wire.net (adsl-69-209-69-68.dsl.chcgil.ameritech.net [69.209.69.68])
        by mx.google.com with ESMTPS id c5sm1826887anh.27.2011.08.11.12.03.14
        (version=SSLv3 cipher=OTHER);
        Thu, 11 Aug 2011 12:03:14 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1313088705-32222-1-git-send-email-artagnon@gmail.com>
User-Agent: Mutt/1.5.21+46 (b01d63af6fea) (2011-07-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/179135>

Ramkumar Ramachandra wrote:

> No new ideas; just the same ideas implemented in a more sane
> way.

Thanks!  Will try it out.

> Note: I didn't know what to do with the license header in the fifth
> patch.  I just assumed that it was some historical cruft and removed
> it.

Please don't.  Technically it's allowed by the license if I understand
correctly (since the copyright notices are not accompanied by a
disclaimer of warranty) but it's almost always the wrong thing to do
to remove a copyright notice without the author's permission.
