From: "Marco Costalba" <mcostalba@gmail.com>
Subject: Re: qgit idea: marking refs (heads and tags)
Date: Thu, 6 Jul 2006 20:39:35 +0200
Message-ID: <e5bfff550607061139y3ccbab37xb83e654d24a19964@mail.gmail.com>
References: <e8d3i6$ne9$1@sea.gmane.org>
	 <e5bfff550607040503x75b1abdavbbeb80b41a454e7d@mail.gmail.com>
	 <e8dnst$pvh$1@sea.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jul 06 20:40:32 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FyYlm-0000Xi-S0
	for gcvg-git@gmane.org; Thu, 06 Jul 2006 20:40:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750762AbWGFSjh (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 6 Jul 2006 14:39:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750749AbWGFSjh
	(ORCPT <rfc822;git-outgoing>); Thu, 6 Jul 2006 14:39:37 -0400
Received: from py-out-1112.google.com ([64.233.166.177]:49161 "EHLO
	py-out-1112.google.com") by vger.kernel.org with ESMTP
	id S1750754AbWGFSjg (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 6 Jul 2006 14:39:36 -0400
Received: by py-out-1112.google.com with SMTP id 57so332346pya
        for <git@vger.kernel.org>; Thu, 06 Jul 2006 11:39:35 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=BpZoZ/hze7oIKrgkY4slBz9/ASwdY2eMQoLgCiSUP+mEQ758yVzokyWVEcK59SKVsSQr8eWU0WxFXiVZajs93n8scCqAffE8L+J7D6UaN8tFlq8jbf00svAAYfO2GQwWE0BpaTydKnD1EYcE6b+KhcwFUpysxwYzqGpiKPpVglg=
Received: by 10.35.41.14 with SMTP id t14mr1236925pyj;
        Thu, 06 Jul 2006 11:39:35 -0700 (PDT)
Received: by 10.35.52.17 with HTTP; Thu, 6 Jul 2006 11:39:35 -0700 (PDT)
To: "Jakub Narebski" <jnareb@gmail.com>
In-Reply-To: <e8dnst$pvh$1@sea.gmane.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/23401>

On 7/4/06, Jakub Narebski <jnareb@gmail.com> wrote:
>
> >> And also somewhat (but to much lesser extent) showing explicitely sha1-ids
> >> for commit, parents, tree, referenced object (in tag), to copy'n'paste to
> >> shell.
> >
> > Something as a typical browser "copy selected link" context menu entry?
>
> Yes, "copy sha1 of selected link" would be nice.
>

Patch pushed to public repo (git.kernel.org/pub/scm/qgit/qgit.git)

   Marco
