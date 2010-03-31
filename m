From: Jay Soffian <jaysoffian@gmail.com>
Subject: Re: git branch -a prefixes origin/ branches with remotes/
Date: Wed, 31 Mar 2010 18:09:51 -0400
Message-ID: <q2y76718491003311509z9c2f83c2t4a217f7c68b4ff4f@mail.gmail.com>
References: <18137.1270056387@relay.known.net>
	 <k2r76718491003311459u4bbaeb4ax5b2e550acdd14c88@mail.gmail.com>
	 <m2iq8c2ln9.fsf@igel.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: layer <layer@known.net>, git@vger.kernel.org
To: Andreas Schwab <schwab@linux-m68k.org>
X-From: git-owner@vger.kernel.org Thu Apr 01 00:10:01 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Nx66n-0005fC-VK
	for gcvg-git-2@lo.gmane.org; Thu, 01 Apr 2010 00:09:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932481Ab0CaWJw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 31 Mar 2010 18:09:52 -0400
Received: from mail-iw0-f202.google.com ([209.85.223.202]:44475 "EHLO
	mail-iw0-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932188Ab0CaWJw (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 31 Mar 2010 18:09:52 -0400
Received: by iwn40 with SMTP id 40so493202iwn.1
        for <git@vger.kernel.org>; Wed, 31 Mar 2010 15:09:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:received:message-id:subject:from:to:cc:content-type;
        bh=gz0ceQ4GGsNW7KVxz7xJOr4CBiQmGtLmxhs536i9I6I=;
        b=EQD3Sa2sVmhJCiMgewDCcF/hAYfAeLIUxP74u4E2893ZdIv0iJUzEOUuJXrIWGL0yW
         mlE/VPtzKgsTdS3fqb33PPmfAIl16XGPQSVU1gZiaWXz2G1a6PnEW2eRx4ndgfOPGgxw
         SFvKHxkfgRr0toihjFdnVrpkaXVnegFj4HC8w=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=nUk/um59dgIjE9Vk/egHslKQWAdNmmMOj50bvX7S77e5VjCZwiSCYom2jCt6KybyBj
         9zKThVXR53qwzC0kbrrEiolTPyJfcRBaufH2pLuyxiZITlamavEl3eI9gmmLgaHMJGBv
         uwD6c7eILxy1Lz09sQfA+hd/X/xrlFmIKEpew=
Received: by 10.231.19.131 with HTTP; Wed, 31 Mar 2010 15:09:51 -0700 (PDT)
In-Reply-To: <m2iq8c2ln9.fsf@igel.home>
Received: by 10.231.159.207 with SMTP id k15mr4338292ibx.75.1270073391418; 
	Wed, 31 Mar 2010 15:09:51 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/143698>

On Wed, Mar 31, 2010 at 6:04 PM, Andreas Schwab <schwab@linux-m68k.org> wrote:
> Jay Soffian <jaysoffian@gmail.com> writes:
>
>> (Note to git list: there should be a man page that has a single-line
>> summary of each command and states whether the command is plumbing or
>> porcelain. Maybe there is and I just don't know it.)
>
> git(1)

Yes, I'm an idiot. Anyone else wanna pile on? :-)

j.
