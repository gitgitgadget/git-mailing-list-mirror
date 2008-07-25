From: "Scott Chacon" <schacon@gmail.com>
Subject: Re: git-scm.com
Date: Fri, 25 Jul 2008 14:49:37 -0700
Message-ID: <d411cc4a0807251449le917db2u12977045cdd19b93@mail.gmail.com>
References: <d411cc4a0807251035i7aed2ec9wef7e8f1b3ae4c585@mail.gmail.com>
	 <200807252336.13555.johan@herland.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Johan Herland" <johan@herland.net>
X-From: git-owner@vger.kernel.org Fri Jul 25 23:50:39 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KMVBO-0001Zy-FW
	for gcvg-git-2@gmane.org; Fri, 25 Jul 2008 23:50:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751815AbYGYVtj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 25 Jul 2008 17:49:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751668AbYGYVtj
	(ORCPT <rfc822;git-outgoing>); Fri, 25 Jul 2008 17:49:39 -0400
Received: from rv-out-0506.google.com ([209.85.198.229]:4865 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751407AbYGYVti (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 25 Jul 2008 17:49:38 -0400
Received: by rv-out-0506.google.com with SMTP id k40so3628201rvb.1
        for <git@vger.kernel.org>; Fri, 25 Jul 2008 14:49:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=c0aSBXwnJJYAqeCnuw9Z7LVkWfCI4i0oyvnO2dzpLCU=;
        b=ucRF8yPSOeFzFNAtBOvlMcG+7A6zVnwRJ5608ZibLmXmmXfkz1ZG6dDWjxtSp2BGDy
         j+j8B+TR7sqtLABMVMrbaBkm1C3wXP3ZkYz8AEXnuE7p4yG9+gQDQiysIk79tTZ6cblC
         0+FoThUrqc/TG8YKD5ZUwH28cD4MKr671Azps=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=g5RmCAg45jdPxj9NX+bW11XEGti5uJjGSFZgKzTWEo2HlnIDkJZM5EhzsFGvauNtat
         ZXD7APZZ4GkCJFpYEoSYDHZzAiCxo4boPLbcc2FHrMtO7T7QnU3JZYLdPiirB9qiHLCZ
         qe6n0x2MSkbBpmHOzYIEUDnoW80LKwoVDsPOI=
Received: by 10.114.182.15 with SMTP id e15mr2642909waf.84.1217022577326;
        Fri, 25 Jul 2008 14:49:37 -0700 (PDT)
Received: by 10.115.22.20 with HTTP; Fri, 25 Jul 2008 14:49:37 -0700 (PDT)
In-Reply-To: <200807252336.13555.johan@herland.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/90124>

Actually, that's directly from git.or.cz - I thought about removing
the Cygwin one, but perhaps swapping the order would be better.  Any
thoughts?

Scott

On Fri, Jul 25, 2008 at 2:36 PM, Johan Herland <johan@herland.net> wrote:
> On Friday 25 July 2008, Scott Chacon wrote:
>> Hey all,
>
> Thanks for the update. Looks good.
>
> Minor niggle: On the download page, in the Binaries table, Cygwin is listed
> before msysGit. I'm under the impression that msysGit is what we really
> want to be pushing on Windows (it's faster, smaller, and less strange to
> Windows-people (i.e. less Unix-y)), so you might want to switch the order
> around.
>
>
> Have fun!
>
> ...Johan
>
> --
> Johan Herland, <johan@herland.net>
> www.herland.net
>
