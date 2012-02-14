From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH v3 0/2] test: tests for the "double > from mailmap" bug
Date: Tue, 14 Feb 2012 15:27:42 -0600
Message-ID: <20120214212742.GB9651@burratino>
References: <1329235894-20581-1-git-send-email-felipe.contreras@gmail.com>
 <20120214203431.GB13210@burratino>
 <20120214211402.GC23291@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Felipe Contreras <felipe.contreras@gmail.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Feb 14 22:28:00 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RxPuo-0003AL-TB
	for gcvg-git-2@plane.gmane.org; Tue, 14 Feb 2012 22:27:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932294Ab2BNV1y (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 14 Feb 2012 16:27:54 -0500
Received: from mail-iy0-f174.google.com ([209.85.210.174]:40403 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932133Ab2BNV1x (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 14 Feb 2012 16:27:53 -0500
Received: by iacb35 with SMTP id b35so441994iac.19
        for <git@vger.kernel.org>; Tue, 14 Feb 2012 13:27:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=v5IaoQOfWJXT//tsosktEiu6X2RQ+uk/JDpNsz/kXXI=;
        b=iRe4qDFGBdw8IV0V5urIybeWDoL6taHbfwFuAl9aSRuYBQ531Fr5xDMAmVAnpg+hE/
         9fbRDpcuNd1W52DXOi8ABse4t5q7MqL+VNad2MTmXUhjpf+CHSvHt3SVZOMxgadSsXci
         dfwCLPzawGnuPV2U4cr8b4zciF/PYpHY6HoFM=
Received: by 10.50.94.228 with SMTP id df4mr38087693igb.12.1329254873378;
        Tue, 14 Feb 2012 13:27:53 -0800 (PST)
Received: from burratino (c-24-1-56-9.hsd1.il.comcast.net. [24.1.56.9])
        by mx.google.com with ESMTPS id ko6sm21322122igc.2.2012.02.14.13.27.52
        (version=SSLv3 cipher=OTHER);
        Tue, 14 Feb 2012 13:27:53 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20120214211402.GC23291@sigill.intra.peff.net>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/190761>

Jeff King wrote:

> The short answer is that both patches look OK to me.

Thanks for looking them over and for a nice explanation of the process.
