From: Paolo Ciarrocchi <paolo.ciarrocchi@gmail.com>
Subject: Re: [RFC] On watchman support
Date: Wed, 19 Nov 2014 16:26:19 +0100
Message-ID: <CAHVLzcnb6_rYPqKNFvnqrnwuToCeRp8NPY31Y-cbOEyY=wYvvg@mail.gmail.com>
References: <20141111124901.GA6011@lanh> <1416270336.13653.23.camel@leckie>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Duy Nguyen <pclouds@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: David Turner <dturner@twopensource.com>
X-From: git-owner@vger.kernel.org Wed Nov 19 16:26:49 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Xr79b-0000KK-00
	for gcvg-git-2@plane.gmane.org; Wed, 19 Nov 2014 16:26:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753718AbaKSP0n (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 19 Nov 2014 10:26:43 -0500
Received: from mail-la0-f46.google.com ([209.85.215.46]:42238 "EHLO
	mail-la0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750759AbaKSP0m (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 19 Nov 2014 10:26:42 -0500
Received: by mail-la0-f46.google.com with SMTP id gd6so705372lab.33
        for <git@vger.kernel.org>; Wed, 19 Nov 2014 07:26:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=CgnZQKOFJXnsONUkBLu70cKlPQgduG2EwDtkS1As89Y=;
        b=CTEtyyfhU6k93yDBlMEu4NQq+RYurAehOBOP8fty6FUnzYaMFvQz/p/jeWax3x6Vho
         9vFTciVfgtJzaeeAIOVn1hUArUPyja7R6FH4Ys6+g7VBL3sfK0RSbW48wcWbQyAm5bkR
         fXX5uwA3PMrz32pyXjjuOXp6hbOjrn+V7eiRAiizyaA+8JrbXtRzvHozie+IcacICbcU
         4pRlvlDOmSzheIpiLD8R/WNB/CgJ/t2FcHLPKubSdDJozPHPh0wBtA9mv/D16jsFf7PZ
         8/PaZG8DWIDJeZ0SDY6OdqH7KnEgykSPg7vgxBaNnmY8HeM+yNYr8w9CSJwY69htaciX
         /RxQ==
X-Received: by 10.152.88.8 with SMTP id bc8mr6009081lab.64.1416410800659; Wed,
 19 Nov 2014 07:26:40 -0800 (PST)
Received: by 10.25.132.215 with HTTP; Wed, 19 Nov 2014 07:26:19 -0800 (PST)
In-Reply-To: <1416270336.13653.23.camel@leckie>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Nov 18, 2014 at 1:25 AM, David Turner <dturner@twopensource.com> wrote:
>
> My patches are not the world's most beautiful, but they do work.

Out of curiosity: do you run the patches at twitter?

Thanks.

-- Paolo


-- 
Paolo
