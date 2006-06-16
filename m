From: David Kowis <dkowis@shlrm.org>
Subject: Re: git-rebase nukes multiline comments
Date: Fri, 16 Jun 2006 12:55:43 -0500
Message-ID: <4492F09F.9080906@shlrm.org>
References: <20060616171251.GA29820@suse.de> <4492E8F9.4000106@shlrm.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, mhopf@suse.de
X-From: git-owner@vger.kernel.org Fri Jun 16 19:55:48 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FrIXq-0006Sd-KT
	for gcvg-git@gmane.org; Fri, 16 Jun 2006 19:55:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751060AbWFPRzn (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 16 Jun 2006 13:55:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750954AbWFPRzn
	(ORCPT <rfc822;git-outgoing>); Fri, 16 Jun 2006 13:55:43 -0400
Received: from adsl-66-143-246-231.dsl.snantx.swbell.net ([66.143.246.231]:21932
	"EHLO mail.shlrm.org") by vger.kernel.org with ESMTP
	id S1750839AbWFPRzn (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 16 Jun 2006 13:55:43 -0400
Received: from [192.168.2.111] (rrcs-24-173-63-133.sw.biz.rr.com [24.173.63.133])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.shlrm.org (Postfix) with ESMTP id 73D732816BBC;
	Fri, 16 Jun 2006 12:55:42 -0500 (CDT)
User-Agent: Thunderbird 1.5.0.4 (Windows/20060516)
To: David Kowis <dkowis@shlrm.org>
In-Reply-To: <4492E8F9.4000106@shlrm.org>
X-Enigmail-Version: 0.94.0.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/21953>

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA512

David Kowis wrote:
<snip>
> 
> I'm new to git, but I tried what you said.
> my git log:
> commit c846bea8c61bec7cf0f7688c48abc42577b9ac7f
> Author: David Kowis <dkowis@kain.org>
> Date:   Fri Jun 16 12:20:08 2006 -0500
> 
>     this is a multi
> 
>     line comment
>     with three lines
> 
> 
> I'm using git 1.4.0. It added a blank line in there...

I'm going to note that the xorg ML cc doesn't work for anyone not
subscribed... You may miss out on replies.

- --
David Kowis

ISO Team Lead - www.sourcemage.org
Source Mage GNU/Linux

Progress isn't made by early risers. It's made by lazy men trying to
find easier ways to do something.
  - Robert Heinlein
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (MingW32)

iQGVAwUBRJLwn8nf+vRw63ObAQqhmwv7BXLqVSJa2FV6RVhLnmARqh+MHBAX+XLu
zgg/kcYd97pXz9bUEFEmY9tp3afzghA6EQlrV/zRHe/R/e1ZFjvTE27mUe3CvtHu
dUPgx6b85vMLkT2k6jbZ5BoA9KtbNITQlZnQJcEAMBv7aUrclRFykABnXwfh3YxM
jVOGbqoNaKzeB5/Sccb27xnzU91UjztB5X7yNgJYosO6tTz164bQQQbIMGWGztPw
wTwQOPK2+v4oUqfvYbKlX/Fd/Fve6PPWOAj5cUjxPHf47oiF/HY3ir/V/k04qO34
KFKAr10ss/sVm7kbURyj7AWJ/putgy9zzYzSWjqh+4ahTwIFb2ciPsU64o1MsO1K
Mnwz0IowmUUZO57qV0gkYdZyPvudOpV2v52aqMEhMyq8GU56Fvsy0KJma235Sv0r
D0ucIrrorCG0FyY7wKpEM83GJDBaTzxb/Mv8bjCD9/av1uQMjmMvqcPFWsZL+nRx
igTF8LiWzBBEG5b+PPjKlS8uofj8cW5g
=90TM
-----END PGP SIGNATURE-----
