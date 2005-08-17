From: Martin Langhoff <martin.langhoff@gmail.com>
Subject: Re: [RFC] Patches exchange is bad?
Date: Wed, 17 Aug 2005 21:07:19 +1200
Message-ID: <46a038f90508170207578b1c0@mail.gmail.com>
References: <20050817082709.28135.qmail@web26301.mail.ukl.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Daniel Barkalow <barkalow@iabervon.org>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Aug 17 11:08:31 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1E5JtL-000862-8z
	for gcvg-git@gmane.org; Wed, 17 Aug 2005 11:07:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751012AbVHQJHU (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 17 Aug 2005 05:07:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751013AbVHQJHU
	(ORCPT <rfc822;git-outgoing>); Wed, 17 Aug 2005 05:07:20 -0400
Received: from rproxy.gmail.com ([64.233.170.202]:20803 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751011AbVHQJHU convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 17 Aug 2005 05:07:20 -0400
Received: by rproxy.gmail.com with SMTP id i8so100594rne
        for <git@vger.kernel.org>; Wed, 17 Aug 2005 02:07:19 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=JvdaL4BDpZbEc4Ku10zA9kgbzqB4+Wz+qr6LyFLxCUoJB8EVAaWZIVLl5xRJmK01ENZsptypb8NFXiBGKsCv5VPBSG929gcL5nGEaf41sV60CnBnaQRO63nHDXe01Mom9pzAdDKO+VnVRsIwcdXUNMnSv5S0ENEm6KBMKdlXszU=
Received: by 10.38.209.36 with SMTP id h36mr98720rng;
        Wed, 17 Aug 2005 02:07:19 -0700 (PDT)
Received: by 10.38.101.8 with HTTP; Wed, 17 Aug 2005 02:07:19 -0700 (PDT)
To: Marco Costalba <mcostalba@yahoo.it>
In-Reply-To: <20050817082709.28135.qmail@web26301.mail.ukl.yahoo.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

On 8/17/05, Marco Costalba <mcostalba@yahoo.it> wrote:
> Of course I can feed proper subject and description to git-commit but I would like
> to find something less intrusive

I don't know if it helps, but I think that StGIT is what you are
looking for, not only because you have more tools to deal with
patches, but also because patches that are in the 'stack' are actually
really malleable. You can edit and reedit the patch w its commit msg
and all, commit it to the stack, and reedit it again later. It only
becomes immutable when you commit to the underlying git repo.

cheers,


martin
