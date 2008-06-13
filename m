From: "Denis Bueno" <dbueno@gmail.com>
Subject: Re: git-instaweb portability issue (maybe?)
Date: Fri, 13 Jun 2008 09:59:12 -0400
Message-ID: <6dbd4d000806130659r2a8bc57ev6db4ef058ee97440@mail.gmail.com>
References: <6dbd4d000806130626pfdb06f2qbfea6f1909710b7b@mail.gmail.com>
	 <6dbd4d000806130638k4461a41eo8ce6fe803505fa88@mail.gmail.com>
	 <alpine.DEB.1.10.0806130946060.8043@alchemy.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Git Mailing List" <git@vger.kernel.org>
To: "Asheesh Laroia" <asheesh@asheesh.org>
X-From: git-owner@vger.kernel.org Fri Jun 13 16:00:53 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K79p5-0003dv-NW
	for gcvg-git-2@gmane.org; Fri, 13 Jun 2008 16:00:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756051AbYFMN7R (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 13 Jun 2008 09:59:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756013AbYFMN7Q
	(ORCPT <rfc822;git-outgoing>); Fri, 13 Jun 2008 09:59:16 -0400
Received: from fg-out-1718.google.com ([72.14.220.156]:30884 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754478AbYFMN7Q (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 13 Jun 2008 09:59:16 -0400
Received: by fg-out-1718.google.com with SMTP id 19so2768211fgg.17
        for <git@vger.kernel.org>; Fri, 13 Jun 2008 06:59:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=0XDizauWYq7754hQQY5zcJIvK7VMhStEol+9bziwb3c=;
        b=kIDfcdPknSdP/iocvrHmyPPUIV+whVPRaOsz0i9qf5pDqYBLiVHqX0e+rtb+cV3eDv
         QH/wndYVMEdc0+f1ME6gO4xSnn9b1aZVwwBqiUighbaBMvxg3a2Lhjzn5Nb1TNpb8Dir
         jlUfBNrFrzD8+YssKKeNPGex1mxdva7htZ890=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=s7Qb7Du3NlutuX2zFAw0Rgu0USNiCstJugCHSZF1DvJRsjpAkdclfVxMpnA52yIAiv
         u7xaqeeJNfTwN7G98yUj6S4F52HY7g3jda1moT7TvabuOf530dyrbL00dI5JN3lpcHh6
         ciQkUrQDFZZM5PNP/PVxB8n4BMdJRjtzhXhMw=
Received: by 10.86.58.3 with SMTP id g3mr4040818fga.21.1213365552610;
        Fri, 13 Jun 2008 06:59:12 -0700 (PDT)
Received: by 10.86.59.7 with HTTP; Fri, 13 Jun 2008 06:59:12 -0700 (PDT)
In-Reply-To: <alpine.DEB.1.10.0806130946060.8043@alchemy.localdomain>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/84877>

On Fri, Jun 13, 2008 at 09:46, Asheesh Laroia <asheesh@asheesh.org> wrote:
> Does OS X ship /usr/bin/env?
>
> If you type "/usr/bin/env perl" in a Terminal window, do you get Perl?

Sorry, I should have made that clear earlier: yes.

funsat[122] > /usr/bin/env perl --version

This is perl, v5.8.8 built for darwin-2level


-- 
 Denis
