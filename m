From: "Lars Hjemli" <hjemli@gmail.com>
Subject: Re: [PATCH] Documentation/gitmodules: fix asciidoc
Date: Fri, 15 Jun 2007 09:11:06 +0200
Message-ID: <8c5c35580706150011g2189e45dvb1dc1567f12c7f8c@mail.gmail.com>
References: <11818789512948-git-send-email-sam.vilain@catalyst.net.nz>
	 <20070615034915.GE18491@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: "Sam Vilain" <sam.vilain@catalyst.net.nz>,
	"Junio C Hamano" <gitster@pobox.com>, git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Fri Jun 15 09:11:13 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hz5xg-0001GQ-CT
	for gcvg-git@gmane.org; Fri, 15 Jun 2007 09:11:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752659AbXFOHLJ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 15 Jun 2007 03:11:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752555AbXFOHLI
	(ORCPT <rfc822;git-outgoing>); Fri, 15 Jun 2007 03:11:08 -0400
Received: from wa-out-1112.google.com ([209.85.146.182]:11726 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751559AbXFOHLG (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 15 Jun 2007 03:11:06 -0400
Received: by wa-out-1112.google.com with SMTP id v27so1006524wah
        for <git@vger.kernel.org>; Fri, 15 Jun 2007 00:11:06 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=dW/nUO7tZEllkd28C5ZBkyf6uyA8ZUCJR/u9RoaWIIMI8ciPrtZcVOyXnALO5gTGTAJ7tt3WI9dCcP3kjTEfRa73yd+b0/sd+h57ItMu7IdMjdCKIAZxa+K6mimgHKI1hWxD6rx/1t1baJytkP+P0je1aF4kvCxgLwPRLnjWgsQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=mC3Jr4bj5oJoUms0HJYI+CTR09/S6NAhPg0nU51+2XoNCRuYeF1js0fwJYi+0B9BIvjlSWkTd6nmUZN1PkYRaNxLcvWcSsHONl2mass23ftN4O7NpDjBOABNezf5VxzFGyp+I4FVR/7ks+8FgJuvwhnqYT8ptLRWwmPktWC5fXw=
Received: by 10.115.111.1 with SMTP id o1mr2706616wam.1181891466037;
        Fri, 15 Jun 2007 00:11:06 -0700 (PDT)
Received: by 10.115.73.2 with HTTP; Fri, 15 Jun 2007 00:11:06 -0700 (PDT)
In-Reply-To: <20070615034915.GE18491@spearce.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/50249>

On 6/15/07, Shawn O. Pearce <spearce@spearce.org> wrote:
> Sam Vilain <sam.vilain@catalyst.net.nz> wrote:
> > ---
> >   I was getting documentation build errors without this
>
> Yea, I got doc build errors today too from `next`

This is my bad, sorry about that.

Have you tested the patch in
<11817720703159-git-send-email-hjemli@gmail.com> /
http://article.gmane.org/gmane.comp.version-control.git/50135 ?

--
larsh
