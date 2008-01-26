From: "Govind Salinas" <blix@sophiasuchtig.com>
Subject: Re: [ANNOUNCE] Pyrite project.
Date: Sat, 26 Jan 2008 10:16:26 -0600
Message-ID: <5d46db230801260816r350140d0k3f0e3b664ea8b41e@mail.gmail.com>
References: <5d46db230801260127pf6f7a2fwfc8f35884a6322e@mail.gmail.com>
	 <m3bq78ala9.fsf@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Git Mailing List" <git@vger.kernel.org>
To: "Jakub Narebski" <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Sat Jan 26 17:17:05 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JIniK-0005rz-BX
	for gcvg-git-2@gmane.org; Sat, 26 Jan 2008 17:17:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752342AbYAZQQa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 26 Jan 2008 11:16:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752298AbYAZQQ3
	(ORCPT <rfc822;git-outgoing>); Sat, 26 Jan 2008 11:16:29 -0500
Received: from hs-out-0708.google.com ([64.233.178.241]:53963 "EHLO
	hs-out-2122.google.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751814AbYAZQQ2 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 26 Jan 2008 11:16:28 -0500
Received: by hs-out-2122.google.com with SMTP id 54so940047hsz.5
        for <git@vger.kernel.org>; Sat, 26 Jan 2008 08:16:27 -0800 (PST)
Received: by 10.150.157.11 with SMTP id f11mr1376074ybe.108.1201364186809;
        Sat, 26 Jan 2008 08:16:26 -0800 (PST)
Received: by 10.150.156.18 with HTTP; Sat, 26 Jan 2008 08:16:26 -0800 (PST)
In-Reply-To: <m3bq78ala9.fsf@localhost.localdomain>
Content-Disposition: inline
X-Google-Sender-Auth: a377ed5ecd2ad2f4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/71782>

On 1/26/08, Jakub Narebski <jnareb@gmail.com> wrote:
> "Govind Salinas" <blix@sophiasuchtig.com> writes:
>
> > I am starting a project that I hope some of you will be interested in.
> > I have been looking at DSCM tools for a few months now and I have
> > come away liking different aspects of different systems.  The project,
> > called Pyrite, aims to combine the best features of git and Mercurial.
> >
> > Please stop by http://pyrite.sophiasuchtig.com/ to see the
> > announcement.  Links to the public repo in there.
>
> From the description there it looks like Pyrite is (will be) something
> in between porcelain (SCM layer) like (now deprecated) Cogito, StGit,
> Guilt, and plumbings / reimplementation of Git, like jGit/eGit in Java
> and (planned?) Widgit in C#, rather than new SCM, isn't it?
>
Yes, I guess it's going a bit far to say that it's a new SCM since I
will be re-using the git internals.  Mostly I said that because I hope
to re-implement large parts of it.  It is more than a porcelain layer
though.  I prefer to think of it as a system based on both tools.

-Govind
