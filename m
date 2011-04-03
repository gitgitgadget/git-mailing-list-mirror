From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: GSOC 11: Minimal git based client based on libgit2
Date: Sun, 3 Apr 2011 21:05:18 +0530
Message-ID: <20110403153515.GB1480@kytes>
References: <AANLkTima7ezW+jFJKTKFmOvbibTkayaopF-NifKRQbp5@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: libgit2@librelist.org, git@vger.kernel.org, peff@peff.net,
	Jonathan Nieder <jrnieder@gmail.com>
To: Sarath Lakshman <sarathlakshman@slynux.com>
X-From: git-owner@vger.kernel.org Sun Apr 03 17:36:44 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q6PM3-0003Ko-Vb
	for gcvg-git-2@lo.gmane.org; Sun, 03 Apr 2011 17:36:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752457Ab1DCPgd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 3 Apr 2011 11:36:33 -0400
Received: from mail-iw0-f174.google.com ([209.85.214.174]:61374 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751048Ab1DCPgc (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 3 Apr 2011 11:36:32 -0400
Received: by iwn34 with SMTP id 34so5017969iwn.19
        for <git@vger.kernel.org>; Sun, 03 Apr 2011 08:36:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        bh=j0KbQTHgajud43Gr8svjKxEfJGe4YcdKUdkhKVbArrA=;
        b=ZnV0onMrmeP8i/xijZr+jD6qOkZT8WbO8PCqUmoxN00zsUl72MbkVBF0QT3UARg+Cu
         fWR+dYzqUyDgUcbbOPeuL2nqYxfrTSbpT/+6FMyqEjk5BluxSNc+E7jAl/IvXYIMH56L
         npf4y04YdNWFEYpwm5LRF8IHDeWHc0x6kZvXM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=SnQN7HIKNaM3t0+mJ2ZBADVy5MNbk/Q3YFMAru033fhZh7fF89vEMrlTl/A9wm1cKY
         XtRRVQh9T5TkI7R3SKwX708dPzkriOAOevEezViylGssPg4vtt96/MXAbrGwENvbgj23
         tvs9r1BJ0eBFU78ez0dY+hJLKM9UU0HBzFIxs=
Received: by 10.231.39.135 with SMTP id g7mr6036306ibe.173.1301844991779;
        Sun, 03 Apr 2011 08:36:31 -0700 (PDT)
Received: from kytes ([203.110.240.41])
        by mx.google.com with ESMTPS id hc41sm3051995ibb.64.2011.04.03.08.36.27
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sun, 03 Apr 2011 08:36:30 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <AANLkTima7ezW+jFJKTKFmOvbibTkayaopF-NifKRQbp5@mail.gmail.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/170699>

Hi Sarath,

Sarath Lakshman writes:
> I am an undergraduate student from India who wants to contribute to
> libgit2 during GSOC. I have worked with Fedora and Pardus during GSOC
> 2008, 2009 and 2010.

Thanks for writing.  Sorry about the late response.

> I am interested to work on libgit2 based minimal git client. I have
> built the libgit2 from source and tried to write basic git tasks. I
> have written a lot of python code in the past and now I look for
> writing good C code. Definitely, writing a git client based on libgit2
> seems interesting.

A lot of students are interested in this project.  Please browse
through the mailing list archives to see what the others have said --
Jonathan's response will probably be helpful [1].  Additionally,
please consider submitting more than one proposal to maximize your
changes.

Next steps: Post a concrete proposal to the list for feedback/
discussion.  You can make your application stronger by showing us some
code.

[1]: http://article.gmane.org/gmane.comp.version-control.git/170094

-- Ram
