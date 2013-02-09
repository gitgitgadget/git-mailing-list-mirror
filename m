From: Javier Tia <javier.tia@gmail.com>
Subject: Re: [PATCH] user-manual: Rewrite git-gc section for automatic packing
Date: Fri, 8 Feb 2013 19:13:44 -0600
Message-ID: <CAEzRmfVOou_pN=4gkbDz46ivqpu-NbV1DG4h6-d5ygX5iCPd6A@mail.gmail.com>
References: <7ac63ea832711ad4bee636163e277a408cbddda4.1360341577.git.wking@tremily.us>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
To: "W. Trevor King" <wking@tremily.us>
X-From: git-owner@vger.kernel.org Sat Feb 09 02:14:10 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U3z17-0003Y1-MY
	for gcvg-git-2@plane.gmane.org; Sat, 09 Feb 2013 02:14:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932356Ab3BIBNq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 8 Feb 2013 20:13:46 -0500
Received: from mail-wg0-f48.google.com ([74.125.82.48]:32908 "EHLO
	mail-wg0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932308Ab3BIBNp (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 8 Feb 2013 20:13:45 -0500
Received: by mail-wg0-f48.google.com with SMTP id 16so3391450wgi.27
        for <git@vger.kernel.org>; Fri, 08 Feb 2013 17:13:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:x-received:in-reply-to:references:date:message-id
         :subject:from:to:cc:content-type;
        bh=WmfjmRMg9sCC1ohEo717i31QvzUM4P4ZgyE0GhyEfjc=;
        b=G/wlfMVMLI0NAVZVEsZHSODpFocrpSL+G8veuz3gVcgg6bnU4p3QCU341iKFaZ/0C6
         AdQHlvEzCOsYCEPMgNz0DzxCkaDdbJKFBPAiWPC0qfSy7xHQsAQjuVRZKwvtSIYEzbgJ
         GEAKjgOQE7xCU4RrJg7UfFSsmq71lcOUJ0QIGzP5IVbrd619l28Rbv+PPWcXvYgHB1p4
         hJK/bWHw7lsvxsQQXdt19N5DPOE5lfC+TqBGMYtXZ9xr2I35gEvReoSiko8f/reFZFfv
         mAiz5dvdiitE8dZuBvvEmfKo40OsGdHxkoabknUNge7eKo1dux/VgeNiavK2rqC86h5S
         Mecw==
X-Received: by 10.180.84.165 with SMTP id a5mr5646829wiz.6.1360372424411; Fri,
 08 Feb 2013 17:13:44 -0800 (PST)
Received: by 10.216.43.137 with HTTP; Fri, 8 Feb 2013 17:13:44 -0800 (PST)
In-Reply-To: <7ac63ea832711ad4bee636163e277a408cbddda4.1360341577.git.wking@tremily.us>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/215841>

> +information from taking up too much space on disk or in memory.  Some
> +git commands may automatically run linkgit:git-gc[1], so you don't
> +have to worry about running it manually.  However, compressing large
> +repositories may take some time, so you might want to disable
> +automatic comression and run it explicitly when you are not doing
                       ^^^^^^^^

You might want to make a little correction by 'compression'.


Regards,

-- 
Javier
