From: "Gary V. Vaughan" <gary@gnu.org>
Subject: Re: [SCM] GNU Libtool annotated tag, v2.2.7b, created. v2.2.7b
Date: Fri, 21 May 2010 12:52:12 +0700
Message-ID: <A3F5E117-5E3D-4C9B-97A9-5C75D0ACF8E2@gnu.org>
References: <E1OFFfN-0003gH-6w@vcs-noshell.in.savannah.gnu.org>
Mime-Version: 1.0 (Apple Message framework v1078)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Cc: libtool-commit@gnu.org, git@vger.kernel.org
To: "Gary V. Vaughan" <gary@gnu.org>
X-From: git-owner@vger.kernel.org Fri May 21 07:53:12 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OFLAV-0008LG-5B
	for gcvg-git-2@lo.gmane.org; Fri, 21 May 2010 07:53:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754809Ab0EUFxF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 21 May 2010 01:53:05 -0400
Received: from hapkido.dreamhost.com ([66.33.216.122]:34306 "EHLO
	hapkido.dreamhost.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754702Ab0EUFxE (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 21 May 2010 01:53:04 -0400
Received: from homiemail-a22.g.dreamhost.com (mailbigip.dreamhost.com [208.97.132.5])
	by hapkido.dreamhost.com (Postfix) with ESMTP id 6EA8027403B
	for <git@vger.kernel.org>; Thu, 20 May 2010 22:53:02 -0700 (PDT)
Received: from [192.168.1.3] (unknown [110.164.248.181])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	(Authenticated sender: gary@vaughan.pe)
	by homiemail-a22.g.dreamhost.com (Postfix) with ESMTPSA id 5461F1A8063;
	Thu, 20 May 2010 22:52:20 -0700 (PDT)
In-Reply-To: <E1OFFfN-0003gH-6w@vcs-noshell.in.savannah.gnu.org>
X-Mailer: Apple Mail (2.1078)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/147441>

Git bug?  Or am I misunderstanding something?

On 21 May 2010, at 07:00, Gary V. Vaughan wrote:
> This is an automated email from the git hooks/post-receive script. It was
> generated because a ref change was pushed to the repository containing
> the project "GNU Libtool".
> 
> The annotated tag, v2.2.7b has been created
>        at  13412c2e2dfe7a720483c8d1dc98ca21c13c0483 (tag)
>   tagging  99da5501fcca20d7cab7f328e223c7520c1a6701 (commit)
>  replaces  v2.2.6
   ^^^^^^^
> tagged by  Gary V. Vaughan
>        on  Fri May 21 06:26:53 2010 +0700

This implies v2.2.6 tag was removed, and v2.2.7b was created in its place.
And yet in a freshly cloned tree I still see the v2.2.6 tag at commit
c7f97f395615fb62c96de30c6925484ecd0cee2e.  I'm running git version 1.6.6.1.

Cheers,
Gary
-- 
Gary V. Vaughan <gary@gnu.org>
