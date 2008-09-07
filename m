From: "Thomas Adam" <thomas.adam22@gmail.com>
Subject: Re: Extremely simple Vim interface for Git
Date: Sun, 7 Sep 2008 15:11:43 +0100
Message-ID: <18071eea0809070711m2d98e762uc33b90ad1af79368@mail.gmail.com>
References: <20080906193744.GA3122@mithlond.arda.local>
	 <18071eea0809070623v4a54cbb8j2face0724651ef56@mail.gmail.com>
	 <20080907135952.GD3387@mithlond.arda.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Teemu Likonen" <tlikonen@iki.fi>
X-From: git-owner@vger.kernel.org Sun Sep 07 16:13:25 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KcL0u-00076s-0r
	for gcvg-git-2@gmane.org; Sun, 07 Sep 2008 16:13:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753764AbYIGOLp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 7 Sep 2008 10:11:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753796AbYIGOLp
	(ORCPT <rfc822;git-outgoing>); Sun, 7 Sep 2008 10:11:45 -0400
Received: from nf-out-0910.google.com ([64.233.182.188]:31499 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753761AbYIGOLo (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 7 Sep 2008 10:11:44 -0400
Received: by nf-out-0910.google.com with SMTP id d3so214497nfc.21
        for <git@vger.kernel.org>; Sun, 07 Sep 2008 07:11:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=oRQvTPxzKM2n8VJWRUk9HxUD0nnOi1lHz6Al2m3jAus=;
        b=vPTICOZxouF2lSQSEMORuSYUcAWy9WIC2HfwQeIdNshYSZhXyjfhXGfCOGJBD1DbW/
         nwnLbOGiPOZq8xJkDdu3aPoCQ72FphiWHxTxYfM128Dv+FUyRXY7jQzHz7XN2ALIZHJ3
         fBt00BKnAVjxVVre1mlRh7NYfxillCpADMVU4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=KEn81/ieaE+pOEppm7wr5GU2JvTqZasecw6HjGnb56pKxCqyDqd6aib24ZmpyphHrT
         +ZAucVYPMdXNP+c0s1v3ykavZdTrfwnkZbY+ZV6zLxMkT5grZA5ZvAlyEyiYoiLxdJCM
         2iRQW6AKVUqWPYGpIJn+rLz0UXzkB3XvxKsco=
Received: by 10.103.114.14 with SMTP id r14mr9396601mum.120.1220796703069;
        Sun, 07 Sep 2008 07:11:43 -0700 (PDT)
Received: by 10.103.182.8 with HTTP; Sun, 7 Sep 2008 07:11:43 -0700 (PDT)
In-Reply-To: <20080907135952.GD3387@mithlond.arda.local>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/95142>

Hello --

2008/9/7 Teemu Likonen <tlikonen@iki.fi>:
> I'd like to add a hint that Vim command line expands % to current file
> name. Examples:
>
>    :Git add %
>    :Git blame -C %

I will certainly try this plugin of yours when I am at work next since
it does look cool.  Thanks.

-- Thomas Adam
