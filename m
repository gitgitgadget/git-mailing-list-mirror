From: "Thomas Adam" <thomas.adam22@gmail.com>
Subject: Re: Git Community Book
Date: Fri, 5 Sep 2008 20:15:55 +0100
Message-ID: <18071eea0809051215n6a8e1468gfd28876d7d5b0488@mail.gmail.com>
References: <d411cc4a0809051208k2a15c4a7te09a6979929e52f7@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "git list" <git@vger.kernel.org>
To: "Scott Chacon" <schacon@gmail.com>
X-From: git-owner@vger.kernel.org Fri Sep 05 21:17:19 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Kbgo2-0007dZ-Vd
	for gcvg-git-2@gmane.org; Fri, 05 Sep 2008 21:17:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752035AbYIETQB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 5 Sep 2008 15:16:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751516AbYIETQA
	(ORCPT <rfc822;git-outgoing>); Fri, 5 Sep 2008 15:16:00 -0400
Received: from ug-out-1314.google.com ([66.249.92.173]:13775 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751944AbYIETP7 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 5 Sep 2008 15:15:59 -0400
Received: by ug-out-1314.google.com with SMTP id c2so227739ugf.37
        for <git@vger.kernel.org>; Fri, 05 Sep 2008 12:15:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=b+H+/pWNAnpeN5Zku6Sv6e9rf6qSIgmRkUeC8hHU4Y0=;
        b=HluBbjNYTvwrfdIilv1INVFMKD706KGcl0ArtAsAz+cPYD5BIDorbntz8PLRmWNGTl
         hZK8f1jZ8i2CMy7vrRJ+gI4yu7bcq17HYZtaVCuEmMeJ53d9+UuPILjVH2gwNndXJlPR
         GeIVJuIJVaYN7OvS7HrOnJka9lfCRDwinWpvI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=L6l+stUfcFGc5lHWbFVgoNth4XZMycol5UO29JFqYfzP+g8b3pA4mTnEk+QPH3v0pZ
         i7QQHlpaBVlGRmO4P7nLagzvJJQyVdovrZm8Bo44bAMhV/K+lxQ1IViYnQ6soX24IDpG
         wmnn8CVEah5AnKj6GakHAgrxo+QLm+yZBcTRc=
Received: by 10.103.249.7 with SMTP id b7mr8194333mus.51.1220642155445;
        Fri, 05 Sep 2008 12:15:55 -0700 (PDT)
Received: by 10.103.182.8 with HTTP; Fri, 5 Sep 2008 12:15:55 -0700 (PDT)
In-Reply-To: <d411cc4a0809051208k2a15c4a7te09a6979929e52f7@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/95033>

2008/9/5 Scott Chacon <schacon@gmail.com>:
> Hey all,
>
> I just wanted to let those of you who are interested know that I've
> been making a lot of progress on the Git Community Book
> (http://book.git-scm.com)  I was wondering if anyone was interested in

I'm going to bite and ask the obvious questions:

1.  How does what you're producing differ from the current Git Users' Manual?
2.  Is this project of yours aiming to obsolete the Git Users' Manual
with "official" sanctioning from people involved with Git?
3.  Assuming 2 is a "no", patches to the Users' Guide would be nice.  :)

-- Thomas Adam
