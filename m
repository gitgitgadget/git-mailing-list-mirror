From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH jn/perl-makemaker-leading-paths] perl/Makefile: Fix a
 missing double-quote
Date: Fri, 29 Jun 2012 03:55:44 -0500
Message-ID: <20120629085544.GC3430@burratino>
References: <1339781427-10568-1-git-send-email-adam@roben.org>
 <20120615180505.GH10752@burratino>
 <7vwr388dyp.fsf@alter.siamese.dyndns.org>
 <20120615230234.GA3547@burratino>
 <4FED6250.7010103@viscovery.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, Adam Roben <adam@roben.org>,
	git@vger.kernel.org, Eric Wong <normalperson@yhbt.net>,
	=?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To: Johannes Sixt <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Fri Jun 29 10:56:08 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SkWzn-00058s-Kq
	for gcvg-git-2@plane.gmane.org; Fri, 29 Jun 2012 10:56:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752847Ab2F2Izu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 29 Jun 2012 04:55:50 -0400
Received: from mail-yw0-f42.google.com ([209.85.213.42]:32861 "EHLO
	mail-yw0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751677Ab2F2Izt (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 29 Jun 2012 04:55:49 -0400
Received: by yhfq11 with SMTP id q11so3544873yhf.1
        for <git@vger.kernel.org>; Fri, 29 Jun 2012 01:55:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=YVxZsGmZvU9lLWmzcIuSyJVdiUC3w/oWOyNXNpK8/1M=;
        b=GKyfTiRRD4NfuFS91bMoVXwFanWb5+wl2+6nwgtxl1F+syfh6AX6DqJ5pMxSA/DOHo
         j7TmmzNZTQezNro9cEAvWF4fChlUy4GL/4u6wwzLMKvfrPq+ko2aqMXUuAtWUHwABq7I
         vOdnmQuDoEXxqn1uPmFjDzVne37fEiPnbqt5MG84LCgYvvrQJIcwgmR2nfnmG586mWw+
         2g9KC3ZJJbYdRw5icjiMgAdfRLyvImxuToiG8CO2RTc4q1oAvoxtor8535EkNMro7ysl
         xgZBSUkf09F4RF2x2XErhBitcWXqyl/5DVZVPT//FJmZ47hstsPiABx3TSlfZno7gXeR
         eouQ==
Received: by 10.42.61.134 with SMTP id u6mr387944ich.11.1340960148074;
        Fri, 29 Jun 2012 01:55:48 -0700 (PDT)
Received: from burratino (c-24-1-56-9.hsd1.il.comcast.net. [24.1.56.9])
        by mx.google.com with ESMTPS id if4sm1448797igc.10.2012.06.29.01.55.47
        (version=SSLv3 cipher=OTHER);
        Fri, 29 Jun 2012 01:55:47 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <4FED6250.7010103@viscovery.net>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/200811>

Johannes Sixt wrote:

> Signed-off-by: Johannes Sixt <j6t@kdbg.org>

Yes, not sure how I missed that. :(

Acked-by: Jonathan Nieder <jrnieder@gmail.com>
