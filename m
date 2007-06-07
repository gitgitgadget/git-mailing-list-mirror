From: "Lars Hjemli" <hjemli@gmail.com>
Subject: Re: git-stash
Date: Fri, 8 Jun 2007 00:52:07 +0200
Message-ID: <8c5c35580706071552v3a099fdci1baec9101a40242b@mail.gmail.com>
References: <Pine.LNX.4.64.0706072328000.4046@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Johannes Schindelin" <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Fri Jun 08 00:52:17 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HwQq0-0000mu-N4
	for gcvg-git@gmane.org; Fri, 08 Jun 2007 00:52:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760569AbXFGWwJ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 7 Jun 2007 18:52:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S936640AbXFGWwJ
	(ORCPT <rfc822;git-outgoing>); Thu, 7 Jun 2007 18:52:09 -0400
Received: from nz-out-0506.google.com ([64.233.162.229]:19624 "EHLO
	nz-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760569AbXFGWwI (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 7 Jun 2007 18:52:08 -0400
Received: by nz-out-0506.google.com with SMTP id n1so656669nzf
        for <git@vger.kernel.org>; Thu, 07 Jun 2007 15:52:07 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=juA6AgRkevGDDIogLmuV0LSgGfGu0HP7HQF224OOj9fgIFrIOnvbgftpVlFAtXgPFZSSwTyJiad2QQEwOKspkQ5bFN6CwK+SWnSz9RHCjjrbpdtM7whBqXlZK7fqm5qdQNLcKfe8r5bR+azdjtlEyO08iBLx5jjQR40w1Q+MnNg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=mrrFR0LAAnJBJrNWTTm9IHVjf+/13Gt76C/SREn8ebxf+zmRP/ZwhMI78qyEVNutvfy8rkrv85oAN8vv8u2i6zQGLS+PAJ0ZjWEjx4RddGxHIZallEr41pI7RQnpen7kWXYXBKJWvXu7ws4E+BqzsyKIAveedHGhN96MIRpbNSw=
Received: by 10.115.88.1 with SMTP id q1mr1970615wal.1181256727393;
        Thu, 07 Jun 2007 15:52:07 -0700 (PDT)
Received: by 10.115.73.2 with HTTP; Thu, 7 Jun 2007 15:52:07 -0700 (PDT)
In-Reply-To: <Pine.LNX.4.64.0706072328000.4046@racer.site>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/49400>

On 6/8/07, Johannes Schindelin <Johannes.Schindelin@gmx.de> wrote:
> git-commit-tree $tree

I added -p HEAD here, and it's even nicer ;-)

Thanks!

--
larsh
