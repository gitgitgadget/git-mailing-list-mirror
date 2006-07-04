From: "Marco Costalba" <mcostalba@gmail.com>
Subject: Re: qgit idea: marking refs (heads and tags)
Date: Tue, 4 Jul 2006 14:03:23 +0200
Message-ID: <e5bfff550607040503x75b1abdavbbeb80b41a454e7d@mail.gmail.com>
References: <e8d3i6$ne9$1@sea.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jul 04 14:03:38 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Fxjco-0001cU-PV
	for gcvg-git@gmane.org; Tue, 04 Jul 2006 14:03:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932232AbWGDMDZ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 4 Jul 2006 08:03:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932233AbWGDMDZ
	(ORCPT <rfc822;git-outgoing>); Tue, 4 Jul 2006 08:03:25 -0400
Received: from py-out-1112.google.com ([64.233.166.179]:37136 "EHLO
	py-out-1112.google.com") by vger.kernel.org with ESMTP
	id S932232AbWGDMDY (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 4 Jul 2006 08:03:24 -0400
Received: by py-out-1112.google.com with SMTP id t32so1810858pyc
        for <git@vger.kernel.org>; Tue, 04 Jul 2006 05:03:23 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=M78St4GyqzDdHPrqe3YHyPbJEaSPH1kPL6OL4pDWarYHKouTmWlgc7+cQzhZZQLm+yzddS2g6CPhW2gMkSOmCmMVK5tvOQoZtBOExgSnMGIkJNrL1sTky0oMI7Te2E0q3UQTUmlYMG9MPrVQ4dfIfigWnDmsbpz+DaR57ydlxxg=
Received: by 10.35.70.17 with SMTP id x17mr3914520pyk;
        Tue, 04 Jul 2006 05:03:23 -0700 (PDT)
Received: by 10.35.52.17 with HTTP; Tue, 4 Jul 2006 05:03:23 -0700 (PDT)
To: "Jakub Narebski" <jnareb@gmail.com>
In-Reply-To: <e8d3i6$ne9$1@sea.gmane.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/23293>

On 7/4/06, Jakub Narebski <jnareb@gmail.com> wrote:
> One thing I sorely lack in qgit as compared to gitk (and even gitweb[*1*])
> is marking commits with refs (heads and tags, marked with different colors
> or different shape marker). gitk currently uses markers in short log line
> before text of commit summary, gitweb uses markers after (at the end) of
> commit log summary. In qgit head commits are marked as such, but not to
> which branche they belong[*2*].

Currently you have to select the head and the status bar will show
related information: branch, tag message, etc.

>
> And also somewhat (but to much lesser extent) showing explicitely sha1-ids
> for commit, parents, tree, referenced object (in tag), to copy'n'paste to
> shell.
>

Something as a typical browser "copy selected link" context menu entry?

  Marco
