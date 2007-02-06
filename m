From: "Alex Riesen" <raa.lkml@gmail.com>
Subject: Re: [RFC/PATCH] enable rerere by default
Date: Tue, 6 Feb 2007 14:56:32 +0100
Message-ID: <81b0412b0702060556r3e366defwe4b7afabdf5ffb7c@mail.gmail.com>
References: <Pine.LNX.4.63.0702061103070.22628@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, junkio@cox.net
To: "Johannes Schindelin" <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Tue Feb 06 14:56:46 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HEQoL-00078Z-Kz
	for gcvg-git@gmane.org; Tue, 06 Feb 2007 14:56:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752110AbXBFN4f (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 6 Feb 2007 08:56:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752119AbXBFN4f
	(ORCPT <rfc822;git-outgoing>); Tue, 6 Feb 2007 08:56:35 -0500
Received: from ug-out-1314.google.com ([66.249.92.170]:29940 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752110AbXBFN4e (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 6 Feb 2007 08:56:34 -0500
Received: by ug-out-1314.google.com with SMTP id 44so1609844uga
        for <git@vger.kernel.org>; Tue, 06 Feb 2007 05:56:33 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=Ywo+0/qXqEPDcbnJKyozyYotxAje7mSskfSmsAe2WX3AQH6SfyDIGB0j7D3cUS+pNrg7iEiHDXp8b4WAX0i4v6Nz78X53OOEBAfGfiDStjvXgVzU1+T49zCgdXx2Tee9ZgWvrgQ5w6HiS3eXlTG4dLin0Vo1dG8CrowPyRYHSkU=
Received: by 10.78.200.3 with SMTP id x3mr1674233huf.1170770192923;
        Tue, 06 Feb 2007 05:56:32 -0800 (PST)
Received: by 10.78.139.9 with HTTP; Tue, 6 Feb 2007 05:56:32 -0800 (PST)
In-Reply-To: <Pine.LNX.4.63.0702061103070.22628@wbgn013.biozentrum.uni-wuerzburg.de>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/38841>

On 2/6/07, Johannes Schindelin <Johannes.Schindelin@gmx.de> wrote:
>
> Since the theme of the upcoming release is the (true) Wow factor, we
> should enable this feature by default. New users are not likely to learn
> of that feature otherwise.
>
> Signed-off-by: Johannes Schindelin <Johannes.Schindelin@gmx.de>
> ---
>
>         I know it is quite late in the game for 1.5.0, but since the theme
>         is usability and user-friendliness, I cannot think of a better
>         release to enable rerere by default, if that should ever happen.
>
>         Comments?

How do I disable rerere by default?
