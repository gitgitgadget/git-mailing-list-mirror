From: "Bob Hiestand" <bob.hiestand@gmail.com>
Subject: Re: Yet another Git tutorial
Date: Mon, 28 Apr 2008 14:45:44 -0500
Message-ID: <cc29171c0804281245n7715c2fta2b5c8f3155bfa40@mail.gmail.com>
References: <2D3D2E55-74C7-4373-BC22-9CF4C26C197D@newartisans.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "John Wiegley" <johnw@newartisans.com>
X-From: git-owner@vger.kernel.org Mon Apr 28 21:47:07 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JqZJY-00089k-2e
	for gcvg-git-2@gmane.org; Mon, 28 Apr 2008 21:47:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932340AbYD1Tpu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 28 Apr 2008 15:45:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932318AbYD1Tpu
	(ORCPT <rfc822;git-outgoing>); Mon, 28 Apr 2008 15:45:50 -0400
Received: from rn-out-0910.google.com ([64.233.170.191]:28356 "EHLO
	rn-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932155AbYD1Tpt (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 Apr 2008 15:45:49 -0400
Received: by rn-out-0910.google.com with SMTP id e11so2015912rng.17
        for <git@vger.kernel.org>; Mon, 28 Apr 2008 12:45:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=YhrJSUyHRCERttmJl4eDzs4vLU9Z2aCeIcMnXY3cjk0=;
        b=R7LqS02aW7sNUXl7f6PeOjZ4PpzfIp57eKh/Gcfg9HGyS1/30mhVmoDBG35AJnEotxugweDIMVxVdQKploraDfrpCSdEwL6+kYTyOz7gdTEztwwvBvS95vcGY0eZStZTAKu6Bsu7RqAgBsnNaxWhqbsrea2+0Hme2dpR+ihmVDk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=iBCeNfwSlbGQg08enaJ83zNQDDhahap3wRGAb+VxXgatml/4ev9EtftOhNiMqhThTdMDuVbgzvozRNlz9fgXv07vaY7NAgE7XqM4GDrVVQWgRVd2wLS9hi+MlgYd8psP9ivctJ2YRmyjLyky9PWSMqqYgkvYKh2+aTs5+tlGTn8=
Received: by 10.142.212.19 with SMTP id k19mr968929wfg.86.1209411944371;
        Mon, 28 Apr 2008 12:45:44 -0700 (PDT)
Received: by 10.142.13.12 with HTTP; Mon, 28 Apr 2008 12:45:44 -0700 (PDT)
In-Reply-To: <2D3D2E55-74C7-4373-BC22-9CF4C26C197D@newartisans.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/80598>

On Mon, Apr 28, 2008 at 1:39 AM, John Wiegley <johnw@newartisans.com> wrote:

>   http://www.newartisans.com/blog_files/git.from.bottom.up.php

  Under the section "Doing a mixed reset" you mention that "It doesn't
change the working tree, and it doesn't change any of
the repository's references."  However, doing a --mixed reset does
change your references, just not your working tree.

Thank you,

bob
