From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: GSoC - Some questions on the idea of
Date: Wed, 11 Apr 2012 14:03:51 -0500
Message-ID: <20120411190351.GF4248@burratino>
References: <20120330203430.GB20376@sigill.intra.peff.net>
 <CA+M5ThR6jtxqs0-Kz-8fcRuOFRbLr-GvsJcTmrOQ7_geNspDLg@mail.gmail.com>
 <4F76E430.6020605@gmail.com>
 <4F772E48.3030708@gmail.com>
 <20120402210708.GA28926@sigill.intra.peff.net>
 <4F84DD60.20903@gmail.com>
 <20120411060357.GA15805@burratino>
 <4F85B4E7.7090603@gmail.com>
 <20120411172034.GE4248@burratino>
 <7vty0qje4g.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Neal Kreitzinger <nkreitzinger@gmail.com>,
	Jeff King <peff@peff.net>,
	Sergio Callegari <sergio.callegari@gmail.com>,
	Bo Chen <chen@chenirvine.org>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Apr 11 21:04:05 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SI2pn-0004L9-J9
	for gcvg-git-2@plane.gmane.org; Wed, 11 Apr 2012 21:04:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760885Ab2DKTD6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 11 Apr 2012 15:03:58 -0400
Received: from mail-gx0-f174.google.com ([209.85.161.174]:41833 "EHLO
	mail-gx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756120Ab2DKTD5 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 Apr 2012 15:03:57 -0400
Received: by gghe5 with SMTP id e5so676118ggh.19
        for <git@vger.kernel.org>; Wed, 11 Apr 2012 12:03:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=UrmmHC1wbfre6aViYoxlbuBa6qmy5/v6eQIoIKlzCvk=;
        b=LlSH/GSTxD8DPrmMYMXkmZniqfMEsw76e41cGDjqKExA/bRrIgZHAWEr4zWTwl3YT3
         WewvAioHLPcppyvyaPpuA4RBIWkdO2QSHxjh7RaAsAn83lC4l/o3C8HY8BWoB8xTA2I9
         FBG5BLDVnI0GoVCAiChcGWcCfl9of8sV23Fey+MihdZ38QRcZA1R8DeN2XHzd/bRbWrt
         mGbuf0TB8ItuPToIxA/d/mSJCyNnfey2QoQLyRnVQk/dwUv5G7xqQz0N5qJAsM0Lwn0g
         nfaGALKt3t8FljTdACb8XYE3b6J1u2g+8uFNSW0iRWwRni6V4cVZYFZsoGNEb4vxpIQz
         3ETg==
Received: by 10.50.85.130 with SMTP id h2mr3239196igz.47.1334171036810;
        Wed, 11 Apr 2012 12:03:56 -0700 (PDT)
Received: from burratino (c-24-1-56-9.hsd1.il.comcast.net. [24.1.56.9])
        by mx.google.com with ESMTPS id bh8sm9855087igc.9.2012.04.11.12.03.55
        (version=SSLv3 cipher=OTHER);
        Wed, 11 Apr 2012 12:03:56 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <7vty0qje4g.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/195239>

Junio C Hamano wrote:

> You could have just underlined "if possible" part in your message

Yes, that's a more important point than the one I responded to. :)
