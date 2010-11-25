From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: vcs for hefty video and graphics files
Date: Wed, 24 Nov 2010 20:21:06 -0600
Message-ID: <20101125022106.GB13274@burratino>
References: <877hg55iyd.fsf@newsguy.com>
 <icg5ia$5an$1@dough.gmane.org>
 <20101123204149.GA2373@burratino>
 <m3r5ea4a5y.fsf@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Philippe Lhoste <PhiLho@GMX.net>, git@vger.kernel.org,
	Harry Putnam <reader@newsguy.com>, Joey Hess <joey@kitenet.net>
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Thu Nov 25 03:22:09 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PLRTI-0002eu-Il
	for gcvg-git-2@lo.gmane.org; Thu, 25 Nov 2010 03:22:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755594Ab0KYCVQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 24 Nov 2010 21:21:16 -0500
Received: from mail-gw0-f46.google.com ([74.125.83.46]:42729 "EHLO
	mail-gw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755382Ab0KYCVP (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 24 Nov 2010 21:21:15 -0500
Received: by gwj20 with SMTP id 20so227880gwj.19
        for <git@vger.kernel.org>; Wed, 24 Nov 2010 18:21:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=SH9Zc1QHLL6LQvHbl45dSuhH70UZgYV4Y/sQKSIEbqo=;
        b=LbDCpI/wyk3l6fnsefXZ9WoqJEuxExN30vilRRgTnUyIAJMtM4X4Gx+lZ/2d9Irr5I
         habna2sn3R5lEp1RQ8p/d60MnTe43V91Lfu9xdXOy7EK3o/uCZzsBnbPpeop7t/9fz20
         9DEAfwW/mJaQnEf2yT8OGqNtPbVNvm9hlwq68=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=n12/pxTUKNtVWLjHSxoU9TSVZFLqiApWlguTBLyn99IkEN+/jId6ItElfjBhhrfMvu
         R6TAJoBC0OGJk8dBZPYnwBnH/6trvtDNLPd7ogNJNgRWWUlOGQlZHyyIh9Rfdih8gJki
         PSZi7N1Y8+pSJwQvJIJSJwkR9Gk+yVMZSa9ME=
Received: by 10.91.19.13 with SMTP id w13mr1803424agi.151.1290651674476;
        Wed, 24 Nov 2010 18:21:14 -0800 (PST)
Received: from burratino (adsl-68-255-106-176.dsl.chcgil.ameritech.net [68.255.106.176])
        by mx.google.com with ESMTPS id 43sm131938yhl.37.2010.11.24.18.21.11
        (version=SSLv3 cipher=RC4-MD5);
        Wed, 24 Nov 2010 18:21:13 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <m3r5ea4a5y.fsf@localhost.localdomain>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/162098>

Jakub Narebski wrote:

> Jonathan, could you add git-annex to "Interfaces, frontends, and tools"
> page on git wiki:
>   https://git.wiki.kernel.org/index.php/InterfacesFrontendsAndTools

Ok, done.  Please feel free to improve the description.

> Does git-annex use git-replace?

No, just plain symlinks.  See http://git-annex.branchable.com/walkthrough/
to get a feel for it.

Regards,
Jonathan
