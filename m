From: "Paulo J. Matos" <pocm@soton.ac.uk>
Subject: Re: Which content is not indexed?
Date: Mon, 21 Apr 2008 00:49:15 +0100
Message-ID: <11b141710804201649g6211c13emb6111c1fdf998c4b@mail.gmail.com>
References: <11b141710804201636s7a35db7aydcbcafafabf7a4ee@mail.gmail.com>
	 <18071eea0804201643w55cb2d8fjcc713df61f4442df@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Thomas Adam" <thomas.adam22@gmail.com>
X-From: git-owner@vger.kernel.org Mon Apr 21 01:50:23 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JnjIc-0001Wf-5y
	for gcvg-git-2@gmane.org; Mon, 21 Apr 2008 01:50:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752434AbYDTXtd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 20 Apr 2008 19:49:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752195AbYDTXtd
	(ORCPT <rfc822;git-outgoing>); Sun, 20 Apr 2008 19:49:33 -0400
Received: from yw-out-2324.google.com ([74.125.46.30]:40726 "EHLO
	yw-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752114AbYDTXtd (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 20 Apr 2008 19:49:33 -0400
Received: by yw-out-2324.google.com with SMTP id 5so875990ywb.1
        for <git@vger.kernel.org>; Sun, 20 Apr 2008 16:49:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:sender:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references:x-google-sender-auth;
        bh=hP1juPIbDTr2O0Sc3SDd2kET4+C78g80m6pbXObahG0=;
        b=an113PzcTLb7XgLO++wJPbJwA17eBdRbNNP6e+sjy8G88pi/loj0QE9bMoIGJBvW4gUi8HKLbqa5loId4qEh09VopqiVvDhe3aVD5wygBj6BX9mBg2zQnIKXHFgmZHdML/YNrI0MEloU2VikF/kqXJE9DLT63UHqdHaA8cGRLEk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:sender:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references:x-google-sender-auth;
        b=TgJSjevwS6GeVF7RRs4ncaudGvgQNOvm2ZmkuHxK7RV4ogBqdjSrx8lcmMuL9W99p2tB9jTfR29MGpvcZB6dTkrkw0Qkn6J6fgeJd/SAt0KqcQJRcKctgt1csF2SLAqqwyHXpcL2EowIW3qqRc7dHyyIFJp5Srhqu3k2qDty3iE=
Received: by 10.150.196.20 with SMTP id t20mr500622ybf.8.1208735355967;
        Sun, 20 Apr 2008 16:49:15 -0700 (PDT)
Received: by 10.150.225.2 with HTTP; Sun, 20 Apr 2008 16:49:15 -0700 (PDT)
In-Reply-To: <18071eea0804201643w55cb2d8fjcc713df61f4442df@mail.gmail.com>
Content-Disposition: inline
X-Google-Sender-Auth: a251cca0f9436fcd
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/80004>

On Mon, Apr 21, 2008 at 12:43 AM, Thomas Adam <thomas.adam22@gmail.com> wrote:
> On 21/04/2008, Paulo J. Matos <pocm@soton.ac.uk> wrote:
>  > Hello all,
>  >
>  >  I just started using git on a new project. I have added some files to
>  >  git, commit.
>  >  Now I created some more files, added more content. How can I check
>  >  which files [content] are not in git yet?
>
>  You must mean:  git status
>

Geee, for someone also using svn, not trying the git status command
was quite stupid of me.

Thanks!!!

-- 
Paulo Jorge Matos - pocm at soton.ac.uk
http://www.personal.soton.ac.uk/pocm
PhD Student @ ECS
University of Southampton, UK
Sponsor ECS runners - Action against Hunger:
http://www.justgiving.com/ecsrunslikethewind
