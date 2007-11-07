From: "Jon Smirl" <jonsmirl@gmail.com>
Subject: Re: Inconsistencies with git log
Date: Wed, 7 Nov 2007 18:16:42 -0500
Message-ID: <9e4733910711071516ic414c28ua272e13db8823fbf@mail.gmail.com>
References: <9e4733910711071415i1729e277u6be19b72cd682a85@mail.gmail.com>
	 <Pine.LNX.4.64.0711072242230.4362@racer.site>
	 <9e4733910711071445p7cfb6cffx83adb1d84d6bf9d8@mail.gmail.com>
	 <Pine.LNX.4.64.0711072255420.4362@racer.site>
	 <9e4733910711071503va92a653s25fd978989d5917d@mail.gmail.com>
	 <Pine.LNX.4.64.0711072309380.4362@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Git Mailing List" <git@vger.kernel.org>
To: "Johannes Schindelin" <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Thu Nov 08 00:17:09 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ipu8r-00052c-5z
	for gcvg-git-2@gmane.org; Thu, 08 Nov 2007 00:17:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755196AbXKGXQq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 7 Nov 2007 18:16:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754841AbXKGXQp
	(ORCPT <rfc822;git-outgoing>); Wed, 7 Nov 2007 18:16:45 -0500
Received: from nz-out-0506.google.com ([64.233.162.229]:25922 "EHLO
	nz-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754658AbXKGXQo (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 7 Nov 2007 18:16:44 -0500
Received: by nz-out-0506.google.com with SMTP id s18so1862874nze
        for <git@vger.kernel.org>; Wed, 07 Nov 2007 15:16:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=sjUkjTVv/1NF+5S4WjIRSLowYYVAjxOSSdJhfS8bLso=;
        b=RE9j4CnqyHWi/XxGGk8NvFkAojGzLGoY4D4z2R4cKvmu3lSHy3K9tCz9TjmeqMEbZOnYx39gDY73jHBmN32Dk8fpKbYu7C0wu+IKdvrwQy3siXCINzARtgETeM7FT4awS+n1KwNPyuxQE3dzCAh1/w9S5uX3t1/wetZo+0A8NLk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=QtB8RlRkegxUfsBYCPOjPkUhlaBj1i1ysbzsyJUfVcVp1BZwv+I7Whi5YzKv7Oy85yEMLe6Hql5yzbIU484onePziPFqUDidILJAonCVAokkQPIlNS5yQ60fsfOAk90dMeKD2yyKtWlpaYkPpm2zwM21hsusMEf1Uw834+K/HZs=
Received: by 10.114.167.2 with SMTP id p2mr189658wae.1194477402734;
        Wed, 07 Nov 2007 15:16:42 -0800 (PST)
Received: by 10.115.54.19 with HTTP; Wed, 7 Nov 2007 15:16:42 -0800 (PST)
In-Reply-To: <Pine.LNX.4.64.0711072309380.4362@racer.site>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/63892>

On 11/7/07, Johannes Schindelin <Johannes.Schindelin@gmx.de> wrote:
> Besides, adding a space and a dot is not what qualifies for "harder to
> use" with this developer.

It requires teaching people new to git to add the space dot.

-- 
Jon Smirl
jonsmirl@gmail.com
