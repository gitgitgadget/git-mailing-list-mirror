From: "Nguyen Thai Ngoc Duy" <pclouds@gmail.com>
Subject: Re: User-wide ignore list
Date: Thu, 15 Feb 2007 18:00:23 +0700
Message-ID: <fcaeb9bf0702150300g2781cb98u160f28086cd69ecb@mail.gmail.com>
References: <vpq4ppnvi1j.fsf@olympe.imag.fr>
	 <Pine.LNX.4.63.0702151152320.22628@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: "Matthieu Moy" <Matthieu.Moy@imag.fr>, git <git@vger.kernel.org>
To: "Johannes Schindelin" <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Thu Feb 15 12:00:36 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HHeLk-0004HR-Cc
	for gcvg-git@gmane.org; Thu, 15 Feb 2007 12:00:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965622AbXBOLAY (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 15 Feb 2007 06:00:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965625AbXBOLAY
	(ORCPT <rfc822;git-outgoing>); Thu, 15 Feb 2007 06:00:24 -0500
Received: from nz-out-0506.google.com ([64.233.162.226]:39170 "EHLO
	nz-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965622AbXBOLAY (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 15 Feb 2007 06:00:24 -0500
Received: by nz-out-0506.google.com with SMTP id s1so503666nze
        for <git@vger.kernel.org>; Thu, 15 Feb 2007 03:00:23 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=ENhbqN6bpdEtt78yXeA3RvLw5jIqkumhRR5ibWpYpobKapBBfqpf22cPwBQTpca01pDMDcWVDKPnKPgyx5NvPb4amxJCqf5Gldsf1f7NnBgmaqwhh8kmI63tSw8YpNoRrqDMCyEDGW+/mbEZuKHWSDDNqemescB0aKhcc6ute68=
Received: by 10.114.58.1 with SMTP id g1mr888178waa.1171537223178;
        Thu, 15 Feb 2007 03:00:23 -0800 (PST)
Received: by 10.114.111.4 with HTTP; Thu, 15 Feb 2007 03:00:23 -0800 (PST)
In-Reply-To: <Pine.LNX.4.63.0702151152320.22628@wbgn013.biozentrum.uni-wuerzburg.de>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/39815>

On 2/15/07, Johannes Schindelin <Johannes.Schindelin@gmx.de> wrote:
> Hi,
>
> On Thu, 15 Feb 2007, Matthieu Moy wrote:
>
> > Is there a way to have a per-user ignore list in git?
>
> It's not really per user, but how about doing it with templates?

Templates have no effect on previously created git repositories, does it?
-- 
Duy
