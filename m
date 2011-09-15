From: Joshua Stoutenburg <jehoshua02@gmail.com>
Subject: Re: Anybody home?
Date: Thu, 15 Sep 2011 02:01:06 -0700
Message-ID: <CAOZxsTqGt=gYr3t7e5Ma4z6W9wt_JxrgsNSGFGVbtk2rc3LZ9w@mail.gmail.com>
References: <CAOZxsTq1crC0zeMpFGMafG8HXu168gkK2-KDnpwLoamRLJshjg@mail.gmail.com>
	<4E71A5FF.5040807@viscovery.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Git List <git@vger.kernel.org>
To: Johannes Sixt <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Thu Sep 15 11:01:18 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R47oo-0003Aj-JS
	for gcvg-git-2@lo.gmane.org; Thu, 15 Sep 2011 11:01:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755502Ab1IOJBJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 15 Sep 2011 05:01:09 -0400
Received: from mail-ew0-f43.google.com ([209.85.215.43]:43435 "EHLO
	mail-ew0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755428Ab1IOJBI (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 15 Sep 2011 05:01:08 -0400
Received: by ewy20 with SMTP id 20so1616573ewy.2
        for <git@vger.kernel.org>; Thu, 15 Sep 2011 02:01:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=chnwD8X5wbB1NnsFM31bSsHsVKiAvAIBbsmSh2C5Sx4=;
        b=OgQu2/OC8ewBtw3zAe0mXHPcXzE34E6sX+CqyR81OngBkw6PlGJpL8f/9/WADv2sx7
         N0XG74AeC5iMNOCOjrD2RO4B3yMwpwcId6Ltl+QRsqwf2L2wixskoMSlPoiXP1P6YuEQ
         tLKqULuqDTojAFwbK8oFUxQ6QW14+5y7G0AVY=
Received: by 10.213.21.194 with SMTP id k2mr328468ebb.53.1316077266574; Thu,
 15 Sep 2011 02:01:06 -0700 (PDT)
Received: by 10.213.16.195 with HTTP; Thu, 15 Sep 2011 02:01:06 -0700 (PDT)
In-Reply-To: <4E71A5FF.5040807@viscovery.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/181449>

> Reading your exchanges elsewhere in this thread, I think you missed that
> you don't need a git server at all just to *use* git.
>
> Even when you want to exchange your commits between two or three machines,
> all you need is ssh access. There is no *git server* necessary. git is not
> svn. ;-)
>
> I thought I'd just mention this to help you streamline your search.
>
> -- Hannes
>

I read the first four and a half chapters from the Pro Git book pdf.
So I think I understood that much.

But in my situation, I do need a server so that other developers can
access anytime over the internet.

I should have mentioned that.
