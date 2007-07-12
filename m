From: "pradeep singh" <pradeep.rautela@gmail.com>
Subject: Re: git-update-server-info may be required,cannot clone and pull from a remote repository
Date: Thu, 12 Jul 2007 10:57:46 +0530
Message-ID: <a901b49a0707112227m2ea746ectd367031fdc8d3537@mail.gmail.com>
References: <a901b49a0707110708o7c883bb0s707d9791f344f1f6@mail.gmail.com>
	 <81b0412b0707110731n4ffa25afoea5395a856869325@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Alex Riesen" <raa.lkml@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jul 12 07:27:56 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I8rDT-0006c2-FS
	for gcvg-git@gmane.org; Thu, 12 Jul 2007 07:27:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751369AbXGLF1r (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 12 Jul 2007 01:27:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751048AbXGLF1r
	(ORCPT <rfc822;git-outgoing>); Thu, 12 Jul 2007 01:27:47 -0400
Received: from py-out-1112.google.com ([64.233.166.183]:41017 "EHLO
	py-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750742AbXGLF1q (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 12 Jul 2007 01:27:46 -0400
Received: by py-out-1112.google.com with SMTP id d32so72317pye
        for <git@vger.kernel.org>; Wed, 11 Jul 2007 22:27:46 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=gxR9+tyq3N4U2kPhqEtY/WZ6yZcyUtAet4sZW/LVwBw+/gNDQ4pdhbE0UrXjUU63dy1wXSdDjmc5FsLiSmEmqkE0fRdrm8AxDMSvUpNVNFa9SPRX82ajc+3+Jm4RGPxal2Y5FF34EorUP9mmhFr7XZKrHIN3guZ8NQDqjwC8OtI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=ZjEK6RH6gD1JlyDdsj7hvLIfUnxVP5wXPyh3gmYaZnGF7ivvjW5MWQlRu4PnhrTXu8+mapthp8erJ5K6q1xfFRqRW1iqQqytBhHcoMASvpwOqOKQNQKuYptlVlJZFVYvMkhHQFjfjRYZnowQBX3RbW5ygk9z2GAnuaT15LAus1I=
Received: by 10.35.125.20 with SMTP id c20mr478808pyn.1184218066215;
        Wed, 11 Jul 2007 22:27:46 -0700 (PDT)
Received: by 10.35.72.8 with HTTP; Wed, 11 Jul 2007 22:27:46 -0700 (PDT)
In-Reply-To: <81b0412b0707110731n4ffa25afoea5395a856869325@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/52245>

On 7/11/07, Alex Riesen <raa.lkml@gmail.com> wrote:
> On 7/11/07, pradeep singh <pradeep.rautela@gmail.com> wrote:
[snip]
>
[...]
ok, i got the repo up. Thanks for the suggestion Alex.
Anyway i could not get gitweb running after running git-instaweb.

Any thoughts on how to setup a gitweb interface ?

Thanks
-- 
Pradeep
