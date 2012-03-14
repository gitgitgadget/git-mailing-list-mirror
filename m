From: Christopher Tiwald <christiwald@gmail.com>
Subject: Re: [PATCH] push: Provide situational hints for non-fast-forward
 errors
Date: Wed, 14 Mar 2012 10:53:55 -0400
Message-ID: <20120314145355.GB3558@gmail.com>
References: <20120313232256.GA49626@democracyinaction.org>
 <7vobrzst7n.fsf@alter.siamese.dyndns.org>
 <20120314144802.GA3558@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: gitster@pobox.com
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Mar 14 15:54:17 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S7paf-00039X-2c
	for gcvg-git-2@plane.gmane.org; Wed, 14 Mar 2012 15:54:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759425Ab2CNOyF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 14 Mar 2012 10:54:05 -0400
Received: from mail-ey0-f174.google.com ([209.85.215.174]:65198 "EHLO
	mail-ey0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1030908Ab2CNOx6 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 Mar 2012 10:53:58 -0400
Received: by eaaq12 with SMTP id q12so930055eaa.19
        for <git@vger.kernel.org>; Wed, 14 Mar 2012 07:53:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=Ga/iQ82N2ZsS4dS4CBc7asXSIsRk+aGRbOtnxn9/69I=;
        b=jV8gwLyUTevwap+1Wf+lX9CzVIH7Q9jlaLIxpuUJbbGwgyRiVRTTJImsgRkIPV1amI
         AmEtHRjofMyOqMAukY2tGl8jChSceSmwSSIYAUhSYkvc4M0NTioO1aE8+0KwwvQfqjjn
         0vnSlIYWgEEp0c6R98kg2xMphG6e5nykL8DjS0cjTm6UspVfpQ7xpNXx2Y8rnc6ea0OB
         s7LPIZhBiKlJTCRX3lK/zfsc1ArXXi005FWpS690kRmPYCwbQimmaS7NDTz7e0SpYHik
         avSnPdfgXRNKwUs5B5pUhVMpq/KdHZFmu6UN3cwywrpuuEAQdx4XK1xZ7NVryfEzt1p0
         OVHA==
Received: by 10.229.76.139 with SMTP id c11mr988926qck.1.1331736837154;
        Wed, 14 Mar 2012 07:53:57 -0700 (PDT)
Received: from gmail.com ([216.55.38.246])
        by mx.google.com with ESMTPS id ef6sm9279078qab.7.2012.03.14.07.53.55
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 14 Mar 2012 07:53:56 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20120314144802.GA3558@gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/193120>

On Wed, Mar 14, 2012 at 10:48:03AM -0400, Christopher Tiwald wrote:
> <stuff>

Whoops. Also apologies for not following the correct To: and Cc:
convention in my most recent response.

--
Christopher Tiwald
