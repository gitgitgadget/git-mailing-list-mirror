From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: Git User's Survey 2007 partial summary
Date: Mon, 27 Aug 2007 13:15:07 +0200
Message-ID: <200708271315.07919.jnareb@gmail.com>
References: <200708190128.43515.jnareb@gmail.com> <200708270251.05762.jnareb@gmail.com> <20070827014034.GD18160@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Mon Aug 27 13:15:23 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IPcZ1-0003G2-1R
	for gcvg-git@gmane.org; Mon, 27 Aug 2007 13:15:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754531AbXH0LPQ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 27 Aug 2007 07:15:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754497AbXH0LPQ
	(ORCPT <rfc822;git-outgoing>); Mon, 27 Aug 2007 07:15:16 -0400
Received: from nf-out-0910.google.com ([64.233.182.186]:43257 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753913AbXH0LPO (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 27 Aug 2007 07:15:14 -0400
Received: by nf-out-0910.google.com with SMTP id g13so1112292nfb
        for <git@vger.kernel.org>; Mon, 27 Aug 2007 04:15:13 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=kMwd+MbRZLXA3WxVm4SeoUuCIqlErjAf8521vOA5tVASN+IpVGzVJETK1cJET5u0UdB8ylu2zfkRw9wDi5l0orIob/BkieHNkWTOQ2mrRRc3blgj39LAuEPG86nBb2conVSkRTLbXssgBwPPoiAaByDIYCMuM6nalq96JUEA3To=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=ar+pO/CVZ/4h2FB7PFYSGljR36xtfqyuESSozJZCBsvUkawp46eHrFuhmTm2Feb6ijkrGEehdWk/NTv/gH4AZcyLclMtn9+b++5/VWN3nTJrPNnA+jWKJFvX9bfacI4yGvWNf2bJ/h7+yfZr3HqgEBEufbxCtGdxm9f4g4g2Clk=
Received: by 10.86.82.16 with SMTP id f16mr4830455fgb.1188213313171;
        Mon, 27 Aug 2007 04:15:13 -0700 (PDT)
Received: from host-89-229-8-65.torun.mm.pl ( [89.229.8.65])
        by mx.google.com with ESMTPS id 31sm3940910fkt.2007.08.27.04.15.10
        (version=SSLv3 cipher=OTHER);
        Mon, 27 Aug 2007 04:15:11 -0700 (PDT)
User-Agent: KMail/1.9.3
In-Reply-To: <20070827014034.GD18160@spearce.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/56814>

Shawn O. Pearce wrote:
> Jakub Narebski <jnareb@gmail.com> wrote:

>> 04. Which programming languages are you proficient with?
>> 
>> It look like there is only 3/4 people proficient in Perl as compared to 
>> Python; it looks like Python is more popular.

I meant here that Perl to Python is around 3 to 4; more people are
proficient in Python than in Perl.

>>                                              C is most popular, with  
>> only a few (if everything is all right with the results page) people 
>> proficient in Tcl/Tk. I'm sorry, git-gui and gitk guys; it looks like
>> not many developers...
> 
> Rather sad given their user base.  gitk seems to have at least 30%
> of the respondants while git-gui is somewhere between 10-14%,
> depending upon the question asked.  Odd.  qgit has a smaller
> respondant base (~7.7%) but is probably the tool that more Git
> users would be comfortable hacking on since it is developed in C++.

It is not *that* bad, as there are 14 people proficient in Tcl/Tk,
while there are 5 people who had made 5 or more commits to either
gitk or git-gui. But it is not encouraging.

I wonder if PyGTK is as portable as Tcl/Tk...
-- 
Jakub Narebski
Poland
