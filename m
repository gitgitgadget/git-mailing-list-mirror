From: "Tom Clarke" <tom@u2i.com>
Subject: Re: Add --rebase option to git-pull?
Date: Thu, 30 Aug 2007 17:26:37 +0200
Message-ID: <550f9510708300826w50b45caesfa88678be1e75115@mail.gmail.com>
References: <550f9510708300540u13c77201oe7cbe599c6773364@mail.gmail.com>
	 <Pine.LNX.4.64.0708301415150.28586@racer.site>
	 <550f9510708300810y1ca84e8dt4d0bab8fc99deb3c@mail.gmail.com>
	 <Pine.LNX.4.64.0708301622240.28586@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Johannes Schindelin" <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Thu Aug 30 17:26:45 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IQlut-0002UJ-6O
	for gcvg-git@gmane.org; Thu, 30 Aug 2007 17:26:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757276AbXH3P0j (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 30 Aug 2007 11:26:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756827AbXH3P0j
	(ORCPT <rfc822;git-outgoing>); Thu, 30 Aug 2007 11:26:39 -0400
Received: from wx-out-0506.google.com ([66.249.82.235]:28380 "EHLO
	wx-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756714AbXH3P0i (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 30 Aug 2007 11:26:38 -0400
Received: by wx-out-0506.google.com with SMTP id h31so520712wxd
        for <git@vger.kernel.org>; Thu, 30 Aug 2007 08:26:38 -0700 (PDT)
Received: by 10.90.53.16 with SMTP id b16mr652001aga.1188487597469;
        Thu, 30 Aug 2007 08:26:37 -0700 (PDT)
Received: by 10.35.86.2 with HTTP; Thu, 30 Aug 2007 08:26:37 -0700 (PDT)
In-Reply-To: <Pine.LNX.4.64.0708301622240.28586@racer.site>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/57047>

On 8/30/07, Johannes Schindelin <Johannes.Schindelin@gmx.de> wrote:
> Looks good to me except for:
>
> > +git update-index --refresh 2>/dev/null
>
> Maybe a test case would be in order, too...

Will do.  Thanks,

-Tom
