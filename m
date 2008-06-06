From: "Imran M Yousuf" <imyousuf@gmail.com>
Subject: Re: [JGIT PATCH] Change the POM file to take all the sources from the original location
Date: Fri, 6 Jun 2008 18:45:04 +0600
Message-ID: <7bfdc29a0806060545x5b0475cal3325f802aded505d@mail.gmail.com>
References: <1212731380-13221-1-git-send-email-imyousuf@gmail.com>
	 <200806061420.52194.robin.rosenberg.lists@dewire.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, imran.yousuf@smartitengineering.com,
	"Imran M Yousuf" <imyousuf@smartitengineering.com>
To: "Robin Rosenberg" <robin.rosenberg.lists@dewire.com>
X-From: git-owner@vger.kernel.org Fri Jun 06 14:46:10 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K4bKW-0007LB-H6
	for gcvg-git-2@gmane.org; Fri, 06 Jun 2008 14:46:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753299AbYFFMpM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 6 Jun 2008 08:45:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750884AbYFFMpL
	(ORCPT <rfc822;git-outgoing>); Fri, 6 Jun 2008 08:45:11 -0400
Received: from yw-out-2324.google.com ([74.125.46.30]:27545 "EHLO
	yw-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750744AbYFFMpK (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 6 Jun 2008 08:45:10 -0400
Received: by yw-out-2324.google.com with SMTP id 9so707619ywe.1
        for <git@vger.kernel.org>; Fri, 06 Jun 2008 05:45:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=bdscBBcfvxITkhJqfIwgoaWX/aDuaFvFusjgrTlS/BY=;
        b=sgg7lWjtpzo1erIhoE6W4m1NDax8fO+F5opdZ1HhzGP8AZJJQbteaEuU4dAm+HsMfh
         Dww0xj/rzrBhmq5Q0I8QfpyAMF+7gGKfdGOKfd3/9zATgkeSdATuipw5ythF+49e3oGV
         lyCg2NSv+APrw9kyrcjyE5VcvC4Uh2xYXaiS8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=hTAG6JwZZ2S5HYcNlR+Xv28L3Jax6+f/FUrrGDLokzIsRmD//IH6s5aLFWbgwagoZr
         j9EZNcvJKyiF0/Kk3lDwTOODrcBMLniE+kPayD3Z+sfv7W8X0zdYcWh7jzFavyTonAjm
         jJb1d4IhPGeGExdEnsJYr1+jcgESJqy45mBhM=
Received: by 10.151.102.16 with SMTP id e16mr146767ybm.188.1212756304987;
        Fri, 06 Jun 2008 05:45:04 -0700 (PDT)
Received: by 10.150.54.11 with HTTP; Fri, 6 Jun 2008 05:45:04 -0700 (PDT)
In-Reply-To: <200806061420.52194.robin.rosenberg.lists@dewire.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/84063>

On Fri, Jun 6, 2008 at 6:20 PM, Robin Rosenberg
<robin.rosenberg.lists@dewire.com> wrote:
> fredagen den 6 juni 2008 07.49.40 skrev imyousuf@gmail.com:
>> From: Imran M Yousuf <imyousuf@smartitengineering.com>
>>
> You could make the patches more readble using -C -C. That would tell people you
> are copying a whole directory. Maybe someone else could tell my why double -C
> is needed. It's a 100% failtful copy of those files. Even the base names are the same.

Is the -C -C option for the binary files?

>
> I posted another comment in the original maven thread.

Replied to that :).

Thanks,

Imran

>
> -- robin
>



-- 
Imran M Yousuf
Entrepreneur & Software Engineer
Smart IT Engineering
Dhaka, Bangladesh
Email: imran@smartitengineering.com
Blog: http://imyousuf-tech.blogs.smartitengineering.com/
Mobile: +880-1711402557
