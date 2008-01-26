From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [ANNOUNCE] Pyrite project.
Date: Sat, 26 Jan 2008 03:17:24 -0800 (PST)
Message-ID: <m3bq78ala9.fsf@localhost.localdomain>
References: <5d46db230801260127pf6f7a2fwfc8f35884a6322e@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Git Mailing List" <git@vger.kernel.org>
To: "Govind Salinas" <blix@sophiasuchtig.com>
X-From: git-owner@vger.kernel.org Sat Jan 26 12:18:12 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JIj35-0008HD-HG
	for gcvg-git-2@gmane.org; Sat, 26 Jan 2008 12:18:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751129AbYAZLR2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 26 Jan 2008 06:17:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751203AbYAZLR2
	(ORCPT <rfc822;git-outgoing>); Sat, 26 Jan 2008 06:17:28 -0500
Received: from ug-out-1314.google.com ([66.249.92.170]:30508 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751049AbYAZLR1 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 26 Jan 2008 06:17:27 -0500
Received: by ug-out-1314.google.com with SMTP id z38so660953ugc.16
        for <git@vger.kernel.org>; Sat, 26 Jan 2008 03:17:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:received:x-authentication-warning:to:cc:subject:references:in-reply-to:message-id:lines:user-agent:mime-version:content-type:from:date;
        bh=TE88iZuYBVVdZ1lxe36nyHzTUljnTKPcXPl3pVF3qZo=;
        b=I6WtzUhml6599TINbJy1wqkZzQxBZ88E5tkSNtnMPpwliXeFGxFBbZ7NDZkFsavQdfSVxR6jgTtkcckVhdL9HnahGWaaws65BGEwh6WzprjyiXAS2da2usHZ1RSJMiKa9uaA3pQSkXpr/AmCjMB4C+uUpjYvC8eXMGFlhVhEVPE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:in-reply-to:message-id:lines:user-agent:mime-version:content-type:from:date;
        b=jm9HFdMWkh+LyB0yd16hBt4/Oz/Vtu5RfzrEpB4Zn+K80ywaeDoKltUXrVn5mf9UKsfbJOKFghQxxKuDTupD6eXZPhRcpoTwM7175DKIyiQR4ot8ACUQ9qfFAS4aPtij8nL/j8mxn7Ds0nPhNkpLRC+a7SNElrcXTy5EHYOP1w0=
Received: by 10.66.220.17 with SMTP id s17mr906743ugg.20.1201346245393;
        Sat, 26 Jan 2008 03:17:25 -0800 (PST)
Received: from localhost.localdomain ( [83.8.247.37])
        by mx.google.com with ESMTPS id h1sm3597529ugf.11.2008.01.26.03.17.23
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sat, 26 Jan 2008 03:17:24 -0800 (PST)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id m0QBHJDW016199;
	Sat, 26 Jan 2008 12:17:19 +0100
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id m0QBHIuB016195;
	Sat, 26 Jan 2008 12:17:18 +0100
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@fuw.edu.pl using -f
In-Reply-To: <5d46db230801260127pf6f7a2fwfc8f35884a6322e@mail.gmail.com>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/71776>

"Govind Salinas" <blix@sophiasuchtig.com> writes:

> I am starting a project that I hope some of you will be interested in.
> I have been looking at DSCM tools for a few months now and I have
> come away liking different aspects of different systems.  The project,
> called Pyrite, aims to combine the best features of git and Mercurial.
> 
> Please stop by http://pyrite.sophiasuchtig.com/ to see the
> announcement.  Links to the public repo in there.

>From the description there it looks like Pyrite is (will be) something
in between porcelain (SCM layer) like (now deprecated) Cogito, StGit,
Guilt, and plumbings / reimplementation of Git, like jGit/eGit in Java
and (planned?) Widgit in C#, rather than new SCM, isn't it?

-- 
Jakub Narebski
Poland
ShadeHawk on #git
