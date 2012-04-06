From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Cc tags in the commit message (Re: [PATCH 1/5] argv-array: Add
 argv_array_pop function [v2])
Date: Thu, 5 Apr 2012 23:19:07 -0500
Message-ID: <20120406041907.GA3843@burratino>
References: <1333136922-12872-1-git-send-email-nhorman@tuxdriver.com>
 <1333654745-7898-1-git-send-email-nhorman@tuxdriver.com>
 <1333654745-7898-2-git-send-email-nhorman@tuxdriver.com>
 <7vd37m5458.fsf@alter.siamese.dyndns.org>
 <20120405232429.GA8654@hmsreliant.think-freely.org>
 <7vobr53bbe.fsf@alter.siamese.dyndns.org>
 <20120406022058.GA16264@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>,
	Neil Horman <nhorman@tuxdriver.com>, git@vger.kernel.org,
	Phil Hord <phil.hord@gmail.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Apr 06 06:19:38 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SG0e6-000788-Cg
	for gcvg-git-2@plane.gmane.org; Fri, 06 Apr 2012 06:19:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752211Ab2DFETT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 6 Apr 2012 00:19:19 -0400
Received: from mail-iy0-f174.google.com ([209.85.210.174]:52845 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750926Ab2DFETR (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 6 Apr 2012 00:19:17 -0400
Received: by iagz16 with SMTP id z16so2649830iag.19
        for <git@vger.kernel.org>; Thu, 05 Apr 2012 21:19:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=irnzNVdsWaQQt8hmUHs8IpmzB6YxzsdGXI+jIEUEu9E=;
        b=IizNtd2monfx0J4mYWrY1jiQtVwOVw8e81rDD57JkxO/FpQ7HRg0g389bdnVC8QlUs
         YmRtTUINbTJd5z5pvFE3qEu4AV8wzxhrCytf10xfEoNFI2kcLZ+zk5UBSygVjdFqaL7M
         302To7uGmmrwDuVyNfKTjN289QR/LReNB8eGXzi8cRD5k49K4iWS3iWlQMGaq/v2bwmL
         fj3ciO0KJw+Gx99ju+eYcy0XTyoAnBdYbfqXtRba5z4ZvFDCcBGIpKY4LdgGKEcA6xYa
         RATUP+QADT5jTtjSezPm5eg0oAUf1EDfPm1GWamcgflyf8eeLPXhPCBB/ZYRbHNgvEK0
         lC2g==
Received: by 10.50.76.136 with SMTP id k8mr4029814igw.2.1333685956492;
        Thu, 05 Apr 2012 21:19:16 -0700 (PDT)
Received: from burratino (c-24-1-56-9.hsd1.il.comcast.net. [24.1.56.9])
        by mx.google.com with ESMTPS id mk10sm1595510igc.4.2012.04.05.21.19.14
        (version=SSLv3 cipher=OTHER);
        Thu, 05 Apr 2012 21:19:15 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20120406022058.GA16264@sigill.intra.peff.net>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/194843>

Jeff King wrote:

> It's not clear exactly what "cc" tags in a commit message mean, because
> it is really a per-project thing. I don't work on the kernel, but I
> always took their cc tag to mean "these are people interested in this
> topic area".

Here's a link from a previous time it came up: [1]

:)
Jonathan

[1] http://thread.gmane.org/gmane.comp.version-control.git/157707/focus=157757
