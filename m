From: Dmitry Potapov <dpotapov@gmail.com>
Subject: Re: RFC: Website redesign
Date: Tue, 15 Apr 2008 01:33:39 +0400
Message-ID: <20080414213339.GB10300@dpotapov.dyndns.org>
References: <3175605f-ff32-4fd6-bed3-7ae596ecbcde@q1g2000prf.googlegroups.com> <2c6b72b30804140656g14c24d8cwae016d62fe12f4a7@mail.gmail.com> <56e37551-4b8f-4164-a71d-79dba8635b7d@l28g2000prd.googlegroups.com> <96F7571C-1D9D-4F0A-99F1-A2307DAB0374@wincent.com> <bd6139dc0804141129h25c829e2i320f227594763d71@mail.gmail.com> <pan.2008.04.14.20.39.10@progsoc.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Anand Kumria <wildfire@progsoc.org>
X-From: git-owner@vger.kernel.org Mon Apr 14 23:34:55 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JlWK2-0001K8-E5
	for gcvg-git-2@gmane.org; Mon, 14 Apr 2008 23:34:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751791AbYDNVdr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 14 Apr 2008 17:33:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752115AbYDNVdr
	(ORCPT <rfc822;git-outgoing>); Mon, 14 Apr 2008 17:33:47 -0400
Received: from nf-out-0910.google.com ([64.233.182.191]:60542 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750945AbYDNVdq (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 14 Apr 2008 17:33:46 -0400
Received: by nf-out-0910.google.com with SMTP id g13so458551nfb.21
        for <git@vger.kernel.org>; Mon, 14 Apr 2008 14:33:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject:message-id:references:mime-version:content-type:content-disposition:in-reply-to:user-agent;
        bh=eJCDtDSAaNluky2h/hHl1rRe/KkUZTXG2U6pEoGbFc8=;
        b=tRo+iEB06aGxDNvwy8ildAyr00l23kxBq/frfQpBxHFFkLsVvfNbupgL8biyNyBp+AlgIWwKVETkIwUQoVK5+pnLfIGbp4B9lYDPtUMLV/8lPjfBaGLYPKhLnwg6o9ZR7L/KJUYHFvL6TsWmwVW9ycOVTX8Qe8jUkbClk5wLJkk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version:content-type:content-disposition:in-reply-to:user-agent;
        b=tZidG5dsEqVPBvvbsr6aIOnfph/1F00jFPdZvGMTdVGbWNSWfkCiIRZqh9V/qSx/vVg0RuPNd1TpP+yLH/k8bLvFmbc+3QoZX9lvyGp4Z5IGaSdaUkZtagl4OdRDnzl4rrzdmwpzjlpgPt5Fmw8t18pDcjPBCC4MxR3InIEKylo=
Received: by 10.78.204.1 with SMTP id b1mr4990505hug.42.1208208823702;
        Mon, 14 Apr 2008 14:33:43 -0700 (PDT)
Received: from localhost ( [83.237.185.245])
        by mx.google.com with ESMTPS id 31sm1704768nfu.24.2008.04.14.14.33.41
        (version=TLSv1/SSLv3 cipher=OTHER);
        Mon, 14 Apr 2008 14:33:42 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <pan.2008.04.14.20.39.10@progsoc.org>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/79535>

On Mon, Apr 14, 2008 at 08:39:00PM +0000, Anand Kumria wrote:
> 
> That is basically the current "Web 2.0 style".
> 
> <http://www.webdesignfromscratch.com/current-style.cfm>
> 
> One of the "hotties" is a software project, and Free Software at that.
> 
> I think the designs are a good first starting point. 

And here is what validator.w3.org says about this page:

This page is not Valid XHTML 1.0 Strict!
Result:  	 Failed validation, 83 Errors 

BTW, validator.w3.org does not catch every problem. In particular, it
does not detect problems with CSS. So, it is likely to be much more...

Dmitry
