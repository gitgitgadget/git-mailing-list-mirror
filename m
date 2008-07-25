From: "Scott Chacon" <schacon@gmail.com>
Subject: Re: git-scm.com
Date: Fri, 25 Jul 2008 15:15:18 -0700
Message-ID: <d411cc4a0807251515q7801a8dfl1798a1976ee1bed8@mail.gmail.com>
References: <d411cc4a0807251035i7aed2ec9wef7e8f1b3ae4c585@mail.gmail.com>
	 <20080725220217.GE13539@leksak.fem-net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Stephan Beyer" <s-beyer@gmx.net>
X-From: git-owner@vger.kernel.org Sat Jul 26 00:16:20 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KMVaF-0000zA-Ob
	for gcvg-git-2@gmane.org; Sat, 26 Jul 2008 00:16:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752026AbYGYWPU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 25 Jul 2008 18:15:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751937AbYGYWPU
	(ORCPT <rfc822;git-outgoing>); Fri, 25 Jul 2008 18:15:20 -0400
Received: from rv-out-0506.google.com ([209.85.198.233]:4972 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751990AbYGYWPT (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 25 Jul 2008 18:15:19 -0400
Received: by rv-out-0506.google.com with SMTP id k40so3637544rvb.1
        for <git@vger.kernel.org>; Fri, 25 Jul 2008 15:15:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=4xd+W9iUMctg14B9Nc3VCxFrFP2HjDfm8lV5g0lz9dU=;
        b=wT2u4jei+y6OqHoBbgYoU4wUdo5jX9y1EKrxczL/ANMP9rGRXagwB6ApwqsamSBma+
         XTRG+hJvLUKulfOgMGRIYCU5ZmWsF0zr+kvlOM1XFs02rkEm37Mex78uELZqyYga+qr4
         B28x1HpYHDXDU433XrWybL+uN76s0vIMczFK8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=mRG3e/Iewo65+b3dEBXfXBdCkvMD3gp4hW1Ih1OyO4Ob3z0cztLknBFuX/gwr6izsm
         x5LbXvT6FdtbIlIk1iXZtA/WGdLefGgT7fmhjWso4SnsycjOnkNy5ddUSkN+ngTQHVKn
         +EJ7OjZPR+ltc3RJPPEt4FcwzwRakzdPQ3JVY=
Received: by 10.114.46.11 with SMTP id t11mr2637737wat.211.1217024118857;
        Fri, 25 Jul 2008 15:15:18 -0700 (PDT)
Received: by 10.115.22.20 with HTTP; Fri, 25 Jul 2008 15:15:18 -0700 (PDT)
In-Reply-To: <20080725220217.GE13539@leksak.fem-net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/90132>

Thanks - we're working on validating the pages now.  This should be
fixed shortly.

Scott

On Fri, Jul 25, 2008 at 3:02 PM, Stephan Beyer <s-beyer@gmx.net> wrote:
> Hi,
>
> Just a very short note: I like it ;-)
> Amusing picture.
>
> You perhaps should switch the page encoding to utf-8, since many
> names of contributors are broken without.
> I've just taken a view at the XHTML. You have:
>        <?xml version="1.0" encoding="iso-8859-1" ?>
> But:
>        <meta http-equiv="content-type" content="text/html; charset=UTF-8" />
>
> And the HTTP server does not set an encoding, as it seems, which is ok.
> So please change the first line to
>        <?xml version="1.0" encoding="UTF-8"?>
>
> Thanks,
>  Stephan
>
> --
> Stephan Beyer <s-beyer@gmx.net>, PGP 0x6EDDD207FCC5040F
>
