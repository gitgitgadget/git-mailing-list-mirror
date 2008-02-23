From: "J.C. Pizarro" <jcpiza@gmail.com>
Subject: Re: Question about your git habits
Date: Sat, 23 Feb 2008 03:46:19 +0100
Message-ID: <998d0e4a0802221846u795160b2r3acb0839ced74d29@mail.gmail.com>
References: <200802221837.37680.chase.venters@clientec.com>
	 <998d0e4a0802221736q4e4c3a28l101522912f7d3caf@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Feb 23 03:47:00 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JSkPk-0006J0-9p
	for gcvg-git-2@gmane.org; Sat, 23 Feb 2008 03:47:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755633AbYBWCqX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 22 Feb 2008 21:46:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755522AbYBWCqX
	(ORCPT <rfc822;git-outgoing>); Fri, 22 Feb 2008 21:46:23 -0500
Received: from wr-out-0506.google.com ([64.233.184.232]:5594 "EHLO
	wr-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755387AbYBWCqW (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 22 Feb 2008 21:46:22 -0500
Received: by wr-out-0506.google.com with SMTP id c48so978465wra.23
        for <git@vger.kernel.org>; Fri, 22 Feb 2008 18:46:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=rs0pNHcUVOVMliteTi7qF5z19QptlD8g5srmqKrdEa8=;
        b=qwZYNQEbLHMqzopVp9hZQ89bp5vmh2ekzie86gdLwmw7D2kcmnu1EYOFgzWc6zc1b5tC4dMUEGvIx0kYWfRvfg4nX9vlTKiK6eqg9RckNOAXFV9NlUpYXtAukVhywiUla+74oXd8F7+ZhsoROmSLLELICppGhqqjlcOQKF26X/8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=hT8MtKbcZN9FjjNY3Fn9Q38IOwl0jRDitgVAaKBisKHnG0A0hSSzJHcnyLzETpFOKnS94Lp34DFI3oJgcg/fpo/7BDz+q/QqjEHDMlb4fjf4EqauuhdG+YoPYQ42C9MVtUGSr5GGMJu8p3hfnvZfPTxeM/Iga/nL8ULzO4A3gMM=
Received: by 10.142.229.4 with SMTP id b4mr664285wfh.125.1203734780089;
        Fri, 22 Feb 2008 18:46:20 -0800 (PST)
Received: by 10.70.40.12 with HTTP; Fri, 22 Feb 2008 18:46:19 -0800 (PST)
In-Reply-To: <998d0e4a0802221736q4e4c3a28l101522912f7d3caf@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/74790>

2008/2/23, Chase Venters <chase.venters@clientec.com> wrote:
 >
 > ... blablabla
 >
 >  My question is: If you're working on multiple things at once, do you tend to
 >  clone the entire repository repeatedly into a series of separate working
 >  directories and do your work there, then pull that work (possibly comprising
 >  a series of "temporary" commits) back into a separate local master
 >  respository with --squash, either into "master" or into a branch containing
 >  the new feature?
 >
 > ... blablabla
 >
 >  I'm using git to manage my project and I'm trying to determine the most
 >  optimal workflow I can. I figure that I'm going to have an "official" master
 >  repository for the project, and I want to keep the revision history clean in
 >  that repository (ie, no messy intermediate commits that don't
compile or only
 >  implement a feature half way).


I recomend you to use these complementary tools

   1. google: gitk screenshots  ( e.g. http://lwn.net/Articles/140350/ )

   2. google: "git-gui" screenshots
         ( e.g. http://www.spearce.org/2007/01/git-gui-screenshots.html )

   3. google: gitweb color meld

   ;)
