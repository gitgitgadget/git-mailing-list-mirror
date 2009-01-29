From: James Pickens <jepicken@gmail.com>
Subject: Re: do you recommend "git" (over svn) for a 1-person team???
Date: Wed, 28 Jan 2009 19:15:32 -0700
Message-ID: <885649360901281815q42199468v8658d864386efe2d@mail.gmail.com>
References: <d30068860901281718x363348caya2dc94e798cc8091@mail.gmail.com>
	 <d30068860901281725t14d19c1vc0557182bca3eb8d@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Greg Hauptmann <greg.hauptmann.ruby@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jan 29 03:17:00 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LSMSh-0007zk-8f
	for gcvg-git-2@gmane.org; Thu, 29 Jan 2009 03:16:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752790AbZA2CPf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 28 Jan 2009 21:15:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752002AbZA2CPe
	(ORCPT <rfc822;git-outgoing>); Wed, 28 Jan 2009 21:15:34 -0500
Received: from wa-out-1112.google.com ([209.85.146.177]:23535 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751356AbZA2CPd (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 28 Jan 2009 21:15:33 -0500
Received: by wa-out-1112.google.com with SMTP id v33so1190103wah.21
        for <git@vger.kernel.org>; Wed, 28 Jan 2009 18:15:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=U/dxlGMjrndXngiq0wF3NAlbyjbrbzGYPg7g9Yqny3A=;
        b=mRI1/eNy1BWL9KwYgJJ4WRVsHbsD0XU3ln3dESckrhDUTyhGs8kRfVdj0QiUbAVt3p
         jbKqW4LfSuaEg3ZjD2K0loMXFoa86OLQD1nlD8nvMjNed8YbegLcUsa6K1KeV1oElb4j
         VAl3waOar8eceedj+L6KeZHd9PSwJ/lhR3NbI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=DPyINvpLpiTf9LgUvgY7RO4NFbQv2fT3dOk69dGoVzfuzAzsRa3d+tXZZZJxHJYr5n
         6/2QiZGRjHuSYMQiUkt/8UJFwxdU9OjvY2p5IDbZQ5ZnVbRZL5AgWYDMSPhnlqC65+zf
         odAKbLL8fcFSUCA7uBIT3wAwObP96F4ZcY3DI=
Received: by 10.114.89.1 with SMTP id m1mr779137wab.188.1233195332191; Wed, 28 
	Jan 2009 18:15:32 -0800 (PST)
In-Reply-To: <d30068860901281725t14d19c1vc0557182bca3eb8d@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/107615>

Greg Hauptmann <greg.hauptmann.ruby@gmail.com> wrote:
> Do you recommend "git" (over svn) for a 1-person team???

Yes, emphatically.  I do it myself all the time.

James
