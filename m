From: "Marco Costalba" <mcostalba@gmail.com>
Subject: Re: [QGit] Some suggestion
Date: Thu, 25 Sep 2008 17:34:19 +0100
Message-ID: <e5bfff550809250934l47c48440m332764491ff5391@mail.gmail.com>
References: <gbak2u$v9b$1@ger.gmane.org>
	 <7FD1F85C96D70C4A89DA1DF7667EAE96079EDF@zch01exm23.fsl.freescale.net>
	 <e5bfff550809250451q578b8e10r75c043d307a63f28@mail.gmail.com>
	 <7FD1F85C96D70C4A89DA1DF7667EAE96079FBB@zch01exm23.fsl.freescale.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Li Frank-B20596" <Frank.Li@freescale.com>
X-From: git-owner@vger.kernel.org Thu Sep 25 18:35:34 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KitoS-0006oU-7K
	for gcvg-git-2@gmane.org; Thu, 25 Sep 2008 18:35:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752806AbYIYQeW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 25 Sep 2008 12:34:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752763AbYIYQeW
	(ORCPT <rfc822;git-outgoing>); Thu, 25 Sep 2008 12:34:22 -0400
Received: from fg-out-1718.google.com ([72.14.220.158]:19492 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752747AbYIYQeV (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 25 Sep 2008 12:34:21 -0400
Received: by fg-out-1718.google.com with SMTP id 19so352390fgg.17
        for <git@vger.kernel.org>; Thu, 25 Sep 2008 09:34:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=rI/D5MI2n+3o7fLflFlDuP1mQfngEwBAUrfCl3uKnP8=;
        b=Kcry1SbxEwfIPRiAu01Ygcm/3b3Bx4JM/VULP5Dr2bKQiq5Eryl5CCpbX4iSKA0Lao
         XwK01CslQPmWXQM1tTVXtqIuxLcYKmh/0Gy+zbknBFD2AfUF4lSW3uwlEZ1ypMngiqph
         E0+bq7hjYqUfAkGs+bNoOBeHNntMW3+/opsQk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=cCWnyZZX7TvVQECTnIm37OmOWssNmGUnOVHI3DYumOEddnUKrDqyftbpYcoErU8KaL
         v8d/9F/kO3tZvPbujuIaJxkHj3aVZv3KtfZixaNlkivFooUXvu+FhhyKMUWPmyeXoy+X
         eev3EXhp9VtDb7S8gG27bSo3xc6i4t1+h2FMY=
Received: by 10.181.36.9 with SMTP id o9mr854615bkj.89.1222360459606;
        Thu, 25 Sep 2008 09:34:19 -0700 (PDT)
Received: by 10.180.220.15 with HTTP; Thu, 25 Sep 2008 09:34:19 -0700 (PDT)
In-Reply-To: <7FD1F85C96D70C4A89DA1DF7667EAE96079FBB@zch01exm23.fsl.freescale.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/96782>

On Thu, Sep 25, 2008 at 4:20 PM, Li Frank-B20596 <Frank.Li@freescale.com> wrote:
> Marco:
>
>        Ctrl +/- change font size, but how to change source code view
> font size.
>

Edit->Settings->Fixed width font

You can choose size, font family, bolding, etc...

File view and diff view are optimized for source code viewing so use
fixed pitch fonts, not system default one that normally it is not
fixed pitch.
