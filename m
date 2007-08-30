From: "Giuseppe Bilotta" <giuseppe.bilotta@gmail.com>
Subject: Re: [PATCH] git-filter-branch: more detailed USAGE
Date: Thu, 30 Aug 2007 19:11:11 +0200
Message-ID: <cb7bb73a0708301011s3aa3dffaxa75d8fcee320d143@mail.gmail.com>
References: <11884893671845-git-send-email-giuseppe.bilotta@gmail.com>
	 <46D6EE65.3040503@telecom.at>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Johannes Sixt" <j.sixt@telecom.at>
X-From: git-owner@vger.kernel.org Thu Aug 30 19:11:28 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IQnY8-0008Oj-2Y
	for gcvg-git@gmane.org; Thu, 30 Aug 2007 19:11:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756074AbXH3RLO (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 30 Aug 2007 13:11:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755862AbXH3RLN
	(ORCPT <rfc822;git-outgoing>); Thu, 30 Aug 2007 13:11:13 -0400
Received: from wx-out-0506.google.com ([66.249.82.237]:25459 "EHLO
	wx-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754198AbXH3RLM (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 30 Aug 2007 13:11:12 -0400
Received: by wx-out-0506.google.com with SMTP id h31so546276wxd
        for <git@vger.kernel.org>; Thu, 30 Aug 2007 10:11:11 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=fGq5d0wxml0vd3ydSg/w1IzNRIxJNwTqeczxMGbwSBooylgQTM47nNE9+s8waSVuWFyaNX4WRlN7rbD8n/e2C07S1U8icjXYDskbDiIcwmxsEj/u9CA25xZpeWl6s6PF5O0POp/pBOzBvvfOe9EzLux46NDka1mVeRMT/cf408k=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=qlU0wdUMwRGis/4680HYukIHyWlnPuJYLrn4iEPQpcKMabiT/X3s4CKUGczqLyFh0uxeen0IrWImtoU4PsNSCYJNJRhPbPLXeuMGvNI2NnH4ljgpJ2HXK0EIcoriUQbGC0DG68X9BS0j0hJ6xTtIQW12jpf6dQseO5S7c160h7Y=
Received: by 10.90.120.13 with SMTP id s13mr835577agc.1188493871606;
        Thu, 30 Aug 2007 10:11:11 -0700 (PDT)
Received: by 10.35.43.11 with HTTP; Thu, 30 Aug 2007 10:11:11 -0700 (PDT)
In-Reply-To: <46D6EE65.3040503@telecom.at>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/57054>

On 8/30/07, Johannes Sixt <j.sixt@telecom.at> wrote:
> Giuseppe Bilotta schrieb:
> > +[--subdirectory-filter <command>] \
>
> +[--subdirectory-filter <directory>] \

Doh. I'll resend.

-- 
Giuseppe "Oblomov" Bilotta
