From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: Git User's Survey 2007 partial summary
Date: Tue, 28 Aug 2007 01:48:29 +0200
Message-ID: <200708280148.29702.jnareb@gmail.com>
References: <200708190128.43515.jnareb@gmail.com> <200708270251.05762.jnareb@gmail.com> <61e816970708262024m1cbbfd4dxfeb10b56397670b8@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Andreas Ericsson <ae@op5.se>
To: "Dan Chokola" <dan@chokola.com>
X-From: git-owner@vger.kernel.org Wed Aug 29 16:12:45 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IPoK5-0007cV-VM
	for gcvg-git@gmane.org; Tue, 28 Aug 2007 01:48:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753733AbXH0Xse (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 27 Aug 2007 19:48:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753512AbXH0Xse
	(ORCPT <rfc822;git-outgoing>); Mon, 27 Aug 2007 19:48:34 -0400
Received: from nf-out-0910.google.com ([64.233.182.186]:13791 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753274AbXH0Xsd (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 27 Aug 2007 19:48:33 -0400
Received: by nf-out-0910.google.com with SMTP id g13so1315464nfb
        for <git@vger.kernel.org>; Mon, 27 Aug 2007 16:48:31 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=RGCga0kvTeDpmMs2S03NRs350w/emmbmBekIv0Euss2nMj1EZxFLNy9WqwEjEOmf/dvWeskTxQCPW4JQglT1GtgRdXkQlXqQRWhdjFE6wIz1Osl+JcIhXRWO6DtwXiAy/jxvreWvAiYj+ycz80I3MZjnho9YEgRvT8gDMWaTCOU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=DZ/lRxLMeVSWypjr4X9A7Iud875+xrq5UWrr9CO3C89PKN8AxR571BemqwAiTmt4/jAAtrmC0f74JsK9CubthbBh0ARzR29lGBvIqccThh+ZLG8YHnirdmK2gbt561dQ2CFRCTD4ogBGzuUArpMwCFgRu/5rPdeUUw6BD0rVDCM=
Received: by 10.86.26.11 with SMTP id 11mr5284751fgz.1188258511588;
        Mon, 27 Aug 2007 16:48:31 -0700 (PDT)
Received: from host-89-229-8-65.torun.mm.pl ( [89.229.8.65])
        by mx.google.com with ESMTPS id f31sm7443485fkf.2007.08.27.16.48.28
        (version=SSLv3 cipher=OTHER);
        Mon, 27 Aug 2007 16:48:29 -0700 (PDT)
User-Agent: KMail/1.9.3
In-Reply-To: <61e816970708262024m1cbbfd4dxfeb10b56397670b8@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/56898>

On Mon, Aug 27, 2007, Dan Chokola wrote:
> On 8/26/07, Jakub Narebski <jnareb@gmail.com> wrote:

>> 55. Would commerical (paid) support from a support vendor be of interest
>> to you/your organization?
>>
>> Only 44 answers yes, 217 no, 126 not applicable (which was menat to
>> encompass people who do not use git for work).
> 
> Are questions like this at all indicative of where Git is looking
> towards going? 

This question was actually requested on git mailing list to be in
the survey...

This question is to get to know if there is sufficient demand for
commercial git support for it to be viable. There are two possible
outcomes:

If there is enough demand, then company selling git support can make
a living. Company selling support for git means more git user's (because
some corp needs to have commercial/external support to be present) and
possibly more developers. It is possible that some revenue falls to main
git developers, be it by paying somebody to hack on git, or paying for
some feature or for fixing a bug fast.

If there is not enough demand, better to know it from onset that to have
company which tries to provide git support bancrupt. No failed support
company means no bad publicity on git; it _might_ mean that community
support is enogh for git...


Note that commercial (paid) support does not clash
with GPL. One does not need change in license to have commercial
git support. GPL allows paid support.

-- 
Jakub Narebski
Poland
