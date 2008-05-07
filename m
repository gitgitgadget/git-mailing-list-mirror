From: "Steve Hoelzer" <shoelzer@gmail.com>
Subject: Re: How can I specify multiple refs on one line in the config file?
Date: Wed, 7 May 2008 17:19:30 -0500
Message-ID: <588192970805071519i76c23367ue497e37445fa7c74@mail.gmail.com>
References: <588192970805071415wb7b502ch2047ac5e4865c296@mail.gmail.com>
	 <18071eea0805071433j5bde8868w305d9a80c00bd2bd@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "git mailing list" <git@vger.kernel.org>
To: "Thomas Adam" <thomas.adam22@gmail.com>
X-From: git-owner@vger.kernel.org Thu May 08 00:20:52 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jts0I-00073L-4M
	for gcvg-git-2@gmane.org; Thu, 08 May 2008 00:20:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1763908AbYEGWTh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 7 May 2008 18:19:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1763184AbYEGWTg
	(ORCPT <rfc822;git-outgoing>); Wed, 7 May 2008 18:19:36 -0400
Received: from mu-out-0910.google.com ([209.85.134.190]:17614 "EHLO
	mu-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932196AbYEGWTd (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 7 May 2008 18:19:33 -0400
Received: by mu-out-0910.google.com with SMTP id w8so396617mue.1
        for <git@vger.kernel.org>; Wed, 07 May 2008 15:19:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=HBGgzdXfUOwyjiMWqHz1qVzzV+4AcF8zbQazzVNEzxo=;
        b=xmcEWh8ZzpPesaJ+QNu6AnCLIruF5ddoRl79VwdHrKpQQTkvS2BN0vtSGgZIdB/jEGMTZVrrtlW13QvuARpiXC0tk13gb2KeSPJTtsA8qidwC0/ZMDIiYrEsvMLDU7sBvy04C3cssPCWr4j5upQUK8iJV1RAIF1AadSILw004Ww=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=XitKPzVprHmSXv7vZ8553lUEzwWPhqeFsdcm0qSoNX7xdp/AO4aBeUKAg9SihSXjGfBxcjP7raV3fROFHOfDb0ijNL2ANrt1NSuWk7bTWeDFhOdm9hP1aobVsevcOVEUbEh6EBriQYI0INH5MiTLd7Jz72azp9fx0PjC13KThMs=
Received: by 10.86.78.4 with SMTP id a4mr4830591fgb.17.1210198770868;
        Wed, 07 May 2008 15:19:30 -0700 (PDT)
Received: by 10.86.62.15 with HTTP; Wed, 7 May 2008 15:19:30 -0700 (PDT)
In-Reply-To: <18071eea0805071433j5bde8868w305d9a80c00bd2bd@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/81484>

On Wed, May 7, 2008 at 4:33 PM, Thomas Adam <thomas.adam22@gmail.com> wrote:
> I might be misunderstanding you, but to push tags, there's:
>
> git push --tags

True, but I only want to type "git push". No, it's not _really_
necessary, but I'd like to set it up that way so I don't have to
depend on my coworkers (new git users) remembering "--tags".

Steve
