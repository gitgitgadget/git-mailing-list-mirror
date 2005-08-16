From: Martin Langhoff <martin.langhoff@gmail.com>
Subject: Re: [RFC] Patches exchange is bad?
Date: Wed, 17 Aug 2005 09:31:17 +1200
Message-ID: <46a038f9050816143153e4104b@mail.gmail.com>
References: <20050816200132.88287.qmail@web26304.mail.ukl.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Aug 16 23:32:10 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1E591n-0006zK-Nx
	for gcvg-git@gmane.org; Tue, 16 Aug 2005 23:31:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932734AbVHPVbS (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 16 Aug 2005 17:31:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932736AbVHPVbS
	(ORCPT <rfc822;git-outgoing>); Tue, 16 Aug 2005 17:31:18 -0400
Received: from rproxy.gmail.com ([64.233.170.193]:39304 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932734AbVHPVbR convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 16 Aug 2005 17:31:17 -0400
Received: by rproxy.gmail.com with SMTP id i8so28483rne
        for <git@vger.kernel.org>; Tue, 16 Aug 2005 14:31:17 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=dR1NUNloH3neqfGFtZtsShUjLEQx59wvvGIVOu9PNjOBBF1TMAHvd62RKeMZEKfNgN8mO86MzT01JWTVCulssVa9uNbzAkshVoAuavdsZyg68ruxnWbLHtwIENZGg6M4Sz04Iu9mHNhCEmX7UOBG46PgCvlj97zrAlPeUx02i/0=
Received: by 10.38.78.22 with SMTP id a22mr2494555rnb;
        Tue, 16 Aug 2005 14:31:17 -0700 (PDT)
Received: by 10.38.101.8 with HTTP; Tue, 16 Aug 2005 14:31:17 -0700 (PDT)
To: Marco Costalba <mcostalba@yahoo.it>
In-Reply-To: <20050816200132.88287.qmail@web26304.mail.ukl.yahoo.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

On 8/17/05, Marco Costalba <mcostalba@yahoo.it> wrote:
> What do you think?

>From what I understand, you'll want the StGIT infrastructure. If you
use git/cogito, there is an underlying  assumption that you'll want
all the patches merged across, and a simple cg-update will bring in
all the pending stuff.

cheers,


martin
