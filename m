From: "Sverre Rabbelier" <alturin@gmail.com>
Subject: Re: git-scm.com
Date: Fri, 25 Jul 2008 23:20:02 +0200
Message-ID: <bd6139dc0807251420x32e65e73o8db5d77c8b841947@mail.gmail.com>
References: <d411cc4a0807251035i7aed2ec9wef7e8f1b3ae4c585@mail.gmail.com>
Reply-To: sverre@rabbelier.nl
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Scott Chacon" <schacon@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jul 25 23:21:05 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KMUim-0001dN-VN
	for gcvg-git-2@gmane.org; Fri, 25 Jul 2008 23:21:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751689AbYGYVUE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 25 Jul 2008 17:20:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751714AbYGYVUE
	(ORCPT <rfc822;git-outgoing>); Fri, 25 Jul 2008 17:20:04 -0400
Received: from wf-out-1314.google.com ([209.85.200.171]:2695 "EHLO
	wf-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751689AbYGYVUC (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 25 Jul 2008 17:20:02 -0400
Received: by wf-out-1314.google.com with SMTP id 27so4342190wfd.4
        for <git@vger.kernel.org>; Fri, 25 Jul 2008 14:20:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:reply-to
         :to:subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=s/4/dyYv2mYYe//dmVhzUDJ53cfR3ec/nceGCr+5hU8=;
        b=GWUqQx094dbEMsE8wFdmO7nd6mETfFY4QtFTwPmYot+ujCwTg2suOzscYmOo1ZTuTC
         e/eqEB3duoQZw1d92jSlevaMo3IyVNdnhKZ7iPvewYqJfw+s7dmtVFKcMOgtyPNm9gI/
         8bjrv896tZocp8+kGRmGm01Dz95dIQM3VxxXI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:reply-to:to:subject:cc:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:references;
        b=IS3SCQ7ardNTw05rSHW9VKC60s1nYzvP33SYS/0NWCfmgI/4gc4TAa74m4pTnvBrCe
         dyLm0lTgvnPkeyNuJKUQL4s67/LAkG2qe6FTE97qWfkFNSQV96Z0wy73w9h8++cJX8Fm
         4KUXei3sq9xNlIjN1F6vAQzXCt34/ADTGzaRw=
Received: by 10.142.140.15 with SMTP id n15mr700806wfd.84.1217020802112;
        Fri, 25 Jul 2008 14:20:02 -0700 (PDT)
Received: by 10.143.38.17 with HTTP; Fri, 25 Jul 2008 14:20:02 -0700 (PDT)
In-Reply-To: <d411cc4a0807251035i7aed2ec9wef7e8f1b3ae4c585@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/90116>

On Fri, Jul 25, 2008 at 19:35, Scott Chacon <schacon@gmail.com> wrote:
> A followup on the post I did a few days ago about Git documentation.
> I forked Petr's git.or.cz site and put up a version that I think is a
> bit more accessible and newbie-friendly at git-scm.com.  I had meant
> to discuss this with Petr before posting it to you all, but I
> published a blog post that got a bit more attention than I expected,
> and I didn't want you all to think I didn't care about your opinion,
> as some have already accused me of.

I had a looksie at the site and I think the documentation section [0]
could use some TLC. It might be because it's getting late, but there's
not really any 'eye catchers', no "CLICK ME!" link for someone
browsing around looking for Documentation. In order to find what you
want you have to read -a lot- of the page, which I think is a sign
that the page would do well with some TLC ;).
Now I'll admit that the git.or.cz version [1] is a lot worse, but with
this being an attempt to make it a lot more newbie friendly...

[0] http://git-scm.com/documentation
[1] http://git.or.cz/gitwiki/GitDocumentation

PS: I think you forgot the </shameless plug> when you did put up your
own e-book in the books section but did not put "Git Magic" there ;).

-- 
Cheers,

Sverre Rabbelier
