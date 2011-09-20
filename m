From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH/RFCv4 1/4] Documentation: Preparation for gitweb manpages
Date: Tue, 20 Sep 2011 22:33:58 +0200
Message-ID: <201109202233.58923.jnareb@gmail.com>
References: <1316352884-26193-1-git-send-email-jnareb@gmail.com> <201109202211.06899.jnareb@gmail.com> <20110920201953.GA11464@elie>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Drew Northup <drew.northup@maine.edu>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Tue Sep 20 22:34:37 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R671Z-0007Ig-5B
	for gcvg-git-2@lo.gmane.org; Tue, 20 Sep 2011 22:34:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750874Ab1ITUec (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 20 Sep 2011 16:34:32 -0400
Received: from mail-fx0-f46.google.com ([209.85.161.46]:40377 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750823Ab1ITUec (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 20 Sep 2011 16:34:32 -0400
Received: by fxe4 with SMTP id 4so866406fxe.19
        for <git@vger.kernel.org>; Tue, 20 Sep 2011 13:34:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        bh=swfkKMg1FVaKo0xAtZZST4deCb0syViUXBG+65KGuKE=;
        b=j5+8U64r1MR6bPvD7GXInpAtt9m9obPSh/cAxDN6tP2SvW3VOfVOTkQK1YPujWroaJ
         m2POyXYsv5ktKLjvR7i7FuakLzMGteQpv5BlvOCaiBP4hUmk9++IxRs8mNFhcqE7rM4U
         CDS1Qt8l41vy9876iG+F/1+XxafRrUbgX0yww=
Received: by 10.223.9.133 with SMTP id l5mr1963457fal.13.1316550846641;
        Tue, 20 Sep 2011 13:34:06 -0700 (PDT)
Received: from [192.168.1.13] (abvd239.neoplus.adsl.tpnet.pl. [83.8.201.239])
        by mx.google.com with ESMTPS id y24sm2333766fan.24.2011.09.20.13.34.04
        (version=TLSv1/SSLv3 cipher=OTHER);
        Tue, 20 Sep 2011 13:34:05 -0700 (PDT)
User-Agent: KMail/1.9.3
In-Reply-To: <20110920201953.GA11464@elie>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/181794>

Jonathan Nieder wrote:
> Jakub Narebski wrote:
> 
> > I hope that this version is more clear:
> 
> Yep, it doesn't leave me confused any more.  Thanks, this looks good
> (and sorry for my carelessness in reading the patch before).

No, your concern was valid.

It's better to be more explicit. 

-- 
Jakub Narebski
Poland
