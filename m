From: "Sverre Rabbelier" <alturin@gmail.com>
Subject: Re: Pull request for sub-tree merge into /contrib/gitstats
Date: Thu, 30 Oct 2008 01:38:50 +0100
Message-ID: <bd6139dc0810291738i592aae81y9f10da5477ffe998@mail.gmail.com>
References: <bd6139dc0810291606o2efe4254me378335b76861340@mail.gmail.com>
Reply-To: sverre@rabbelier.nl
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: "Junio C Hamano" <gitster@pobox.com>,
	"Git Mailinglist" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Oct 30 01:40:08 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KvLa3-0005Wk-FU
	for gcvg-git-2@gmane.org; Thu, 30 Oct 2008 01:40:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753803AbYJ3Aiy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 29 Oct 2008 20:38:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751271AbYJ3Aiy
	(ORCPT <rfc822;git-outgoing>); Wed, 29 Oct 2008 20:38:54 -0400
Received: from fk-out-0910.google.com ([209.85.128.190]:41475 "EHLO
	fk-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751119AbYJ3Aiy (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 29 Oct 2008 20:38:54 -0400
Received: by fk-out-0910.google.com with SMTP id 18so44433fkq.5
        for <git@vger.kernel.org>; Wed, 29 Oct 2008 17:38:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:reply-to
         :to:subject:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=E6OFmbr6v7kZo3HIa8/otb/jJF+zayFLPxiFMjd3pKo=;
        b=cO/RnHCf1pQiQGxevMUFyY9oqS70XU7Q6kPJRvOOSd61T+K6Flh9KHYDRhxqO4Sv4e
         q+xqq2BqvEuyffOr22SvrzQIrsWbjhXVwMAFkT57nUmbY8W8WxK9MYmR6S2W+6omy1WK
         8qhDazPwlOzTsnOZGDxYxQ0bkjC6TG68Jb8sY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:reply-to:to:subject:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=szeFM1R/4fzT+RzXD1fR74rJUBfW/MYZ4P3YKIISH7+cfbOghJuDVZ0Uqns/miFnTr
         YuNXoLzcKSxV2JcUtGgTv7Bv3vGhhsZAFJyPsga3nbH48oMGvrQ8BaRXaR6rU4hzPXW4
         6eNOHQdKlNsUO5Zfj7elZGZGvLXV3XH9LzgcU=
Received: by 10.187.226.5 with SMTP id d5mr928892far.102.1225327130815;
        Wed, 29 Oct 2008 17:38:50 -0700 (PDT)
Received: by 10.187.213.8 with HTTP; Wed, 29 Oct 2008 17:38:50 -0700 (PDT)
In-Reply-To: <bd6139dc0810291606o2efe4254me378335b76861340@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/99441>

On Thu, Oct 30, 2008 at 00:06, Sverre Rabbelier <alturin@gmail.com> wrote:
> My work is available in the git repository at:

Please use instead:

>  git://repo.or.cz/git-stats.git for-junio

Which has the "gitstats:" prefix to all commit messages, and does not
have the changelog file.

-- 
Cheers,

Sverre Rabbelier
