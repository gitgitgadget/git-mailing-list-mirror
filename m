From: "Simon Sasburg" <simon.sasburg@gmail.com>
Subject: Re: Suggestion for mailing lists... split [PATCH]-es into own list
Date: Fri, 12 Oct 2007 09:27:42 +0200
Message-ID: <981e6de60710120027j5f390a9tbe2a4c76db9ed06d@mail.gmail.com>
References: <e47324780710110857s472bf099u3e350d17a2c29f78@mail.gmail.com>
	 <Pine.LNX.4.64.0710111704570.4174@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Thomas Harning Jr." <harningt@gmail.com>, git@vger.kernel.org
To: "Johannes Schindelin" <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Fri Oct 12 09:27:58 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IgEw4-0002bm-Df
	for gcvg-git-2@gmane.org; Fri, 12 Oct 2007 09:27:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753288AbXJLH1n (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 12 Oct 2007 03:27:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752872AbXJLH1n
	(ORCPT <rfc822;git-outgoing>); Fri, 12 Oct 2007 03:27:43 -0400
Received: from wa-out-1112.google.com ([209.85.146.178]:59743 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751776AbXJLH1m (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 12 Oct 2007 03:27:42 -0400
Received: by wa-out-1112.google.com with SMTP id v27so903190wah
        for <git@vger.kernel.org>; Fri, 12 Oct 2007 00:27:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=ZzLfHmOJJDc3w/gmzwj5O9TjCa/yBSba3MCB0aBampA=;
        b=brXpnytE9hRgn4DD2G35a8s/6LhAGsezbeMWRHMPMokOPzI1q+iwvn//1YZEOa4bo5DioA+cuXLXEOOLB2HU4+zOPPGB8pLS59OWsFLlqM2zPm0WFC3lEM53AovmMM+YTP6fwWJETEbMFOKVs5zX+1yDobVum0WPPa45oLlxiZg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=gnFju9CqTiggwIQ36axKFGHTH4MKqVE9lhJxYppFHqXS26+2+0L144Ga/7CJmO3/Xam8agTHzl7gY7w4dLoXGkEFgywJz3WSzYv4BEXXzOaOFbVSsRJdPW+qrAPqpCbb6QjAsD4OiXj3NkqY17uGc/xKR7lp0LNsTgdzTgfPaMo=
Received: by 10.115.94.1 with SMTP id w1mr3172477wal.1192174062153;
        Fri, 12 Oct 2007 00:27:42 -0700 (PDT)
Received: by 10.114.124.3 with HTTP; Fri, 12 Oct 2007 00:27:42 -0700 (PDT)
In-Reply-To: <Pine.LNX.4.64.0710111704570.4174@racer.site>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/60661>

On 10/11/07, Johannes Schindelin <Johannes.Schindelin@gmx.de> wrote:
> We did not even find a way to post patches via gmail's web interface, not
> without severely damaging the patches.

Oh? Turning off Rich formatting and copy/pasting the patch from my
editor worked for me.
