From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: Some questions about GSoC
Date: Mon, 29 Mar 2010 16:58:22 -0500
Message-ID: <20100329215822.GA27793@progeny.tock>
References: <201003272305.14827.igor@gplsoft.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Igor Murzov <igor@gplsoft.org>
X-From: git-owner@vger.kernel.org Mon Mar 29 23:58:32 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NwMyY-0004qm-Tb
	for gcvg-git-2@lo.gmane.org; Mon, 29 Mar 2010 23:58:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753230Ab0C2V6U convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 29 Mar 2010 17:58:20 -0400
Received: from mail-yw0-f172.google.com ([209.85.211.172]:38838 "EHLO
	mail-yw0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752673Ab0C2V6T (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 29 Mar 2010 17:58:19 -0400
Received: by ywh2 with SMTP id 2so5295692ywh.33
        for <git@vger.kernel.org>; Mon, 29 Mar 2010 14:58:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=wCdDtBQpaKBtNAPUZfFqZVQ24/rNcYT2mpiBd97YfCo=;
        b=hdS9XibqAKI+k4ybbysnOaxwVmwh7W1lE+YtFCVRatoBKKlGjhym1YiHsFWwD+pZhS
         gPhdgWCV3hdhYwVgGLZ0SJq/ry1bG8ZfQNUic382i9+zWqKzBbcBcEVrdMyQxCodUxf8
         zknb18T9KthHCWYshdB7tUOIqopM25GYwWicU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        b=q1oCynTn7v79VkR8z1TMHOX/VFBNEofg5Oj+iMpar+DdAgiksmJ6OkthpzZP0T5jwi
         i4723jcMk/I4ZRJ+6B89qIO6USBfDvJBqKC7QT1LzrMYgowg7RaUxTqGyleGYFgGiG6E
         vwfmN2iux011S5boeambRcIQ8iV5SZrMImMjw=
Received: by 10.100.22.31 with SMTP id 31mr1535217anv.39.1269899898480;
        Mon, 29 Mar 2010 14:58:18 -0700 (PDT)
Received: from progeny.tock (c-98-212-3-231.hsd1.il.comcast.net [98.212.3.231])
        by mx.google.com with ESMTPS id 6sm1209075ywc.11.2010.03.29.14.58.17
        (version=SSLv3 cipher=RC4-MD5);
        Mon, 29 Mar 2010 14:58:17 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <201003272305.14827.igor@gplsoft.org>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/143521>

Hi,

Igor Murzov wrote:

> I would like to work on "Unify Pathspec=20
> Semantics" or "Git Submodules Enhancements" or "Complete libgit2"

Some people are very excited about all three of these happening --- not
necessarily this summer but ASAP. ;-)

> Is chosen task make any impact on my=20
> possibility to be taken for the gsoc?

Yes.  If you do not seem like you would do a good job at your chosen
task, that would really hurt your chances.

To help your chances, it is best to show some initiative.  For example:

 - Maybe write a patch or two now.  This would demonstrate that you=E2=80=
=99ve
   cloned the git.git repository and understand how our development
   process works, and it would give us some sense of your working style=
=2E

   That may seem daunting if you are not up to speed with git sources
   yet.  Not to worry: in that case, you would be in an ideal situation
   to collaborate on writing documentation.

 - Choose a task that scratches an itch you have, so you can write a
   good proposal.  Write a proposal and get some feedback.  A good
   proposal will probably require a few revisions.

Good luck.

Jonathan
