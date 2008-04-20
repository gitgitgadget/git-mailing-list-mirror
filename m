From: "Thomas Adam" <thomas.adam22@gmail.com>
Subject: Re: Which content is not indexed?
Date: Mon, 21 Apr 2008 00:43:00 +0100
Message-ID: <18071eea0804201643w55cb2d8fjcc713df61f4442df@mail.gmail.com>
References: <11b141710804201636s7a35db7aydcbcafafabf7a4ee@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Paulo J. Matos" <pocm@soton.ac.uk>
X-From: git-owner@vger.kernel.org Mon Apr 21 01:43:53 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JnjCK-0008Bl-Jc
	for gcvg-git-2@gmane.org; Mon, 21 Apr 2008 01:43:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751828AbYDTXnG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 20 Apr 2008 19:43:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751768AbYDTXnF
	(ORCPT <rfc822;git-outgoing>); Sun, 20 Apr 2008 19:43:05 -0400
Received: from fk-out-0910.google.com ([209.85.128.187]:14803 "EHLO
	fk-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751399AbYDTXnD (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 20 Apr 2008 19:43:03 -0400
Received: by fk-out-0910.google.com with SMTP id 19so2080082fkr.5
        for <git@vger.kernel.org>; Sun, 20 Apr 2008 16:43:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=QG8ueVCrJcBJO6xkGW54WfbAbEoegICO3BY4kUMAmyA=;
        b=aFVgMstnZvizzrQL2fxKFNZSxiESnuq170Okg9D05CGxYbLBBv0MeEzXMijYxfLAFQeUr+Ps6GYwJ6nK7GVLTdo43Y0LJuSIqAS+BjmhUtygZZFBUXRdvXyC3k2eSO0BrcE4w0v/X6Edj516XCojtq4PigD+gc7tbc4xGCyRyRY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=kKYAt+tc3+g1lckbA9bnGXzh8ONSoSeWG4T0qZuNSh+J95jE5D6wWZI9AflfGeaT7m99QNyS5+DOWHi9yRmu2jpAkjbEAL6ScH/0IIn/RwgYiEfKAvWHcEPx/5evWX7dTjnU4/oelmAe5XRWfABIdrNKnQBNJssYHA7ijyNb8OU=
Received: by 10.82.111.1 with SMTP id j1mr1851002buc.51.1208734980231;
        Sun, 20 Apr 2008 16:43:00 -0700 (PDT)
Received: by 10.82.170.5 with HTTP; Sun, 20 Apr 2008 16:43:00 -0700 (PDT)
In-Reply-To: <11b141710804201636s7a35db7aydcbcafafabf7a4ee@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/80003>

On 21/04/2008, Paulo J. Matos <pocm@soton.ac.uk> wrote:
> Hello all,
>
>  I just started using git on a new project. I have added some files to
>  git, commit.
>  Now I created some more files, added more content. How can I check
>  which files [content] are not in git yet?

You must mean:  git status

-- Thomas Adam
