From: "Marco Costalba" <mcostalba@gmail.com>
Subject: Re: [ANNOUNCE] qgit 1.1.1
Date: Sun, 19 Mar 2006 23:04:57 +0100
Message-ID: <e5bfff550603191404l7511e76awe980fad51ffde98d@mail.gmail.com>
References: <e5bfff550603190853m2db7bb38gecc94934c4dfb89e@mail.gmail.com>
	 <20060319214907.GA7294@elte.hu>
	 <e5bfff550603191401h2c206950w1a0e04cd50fc5370@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org, proski@gnu.org
X-From: git-owner@vger.kernel.org Sun Mar 19 23:05:06 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FL61G-0006OB-7w
	for gcvg-git@gmane.org; Sun, 19 Mar 2006 23:05:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751123AbWCSWE7 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 19 Mar 2006 17:04:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751125AbWCSWE7
	(ORCPT <rfc822;git-outgoing>); Sun, 19 Mar 2006 17:04:59 -0500
Received: from pproxy.gmail.com ([64.233.166.177]:48791 "EHLO pproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751123AbWCSWE6 convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 19 Mar 2006 17:04:58 -0500
Received: by pproxy.gmail.com with SMTP id b36so1684574pyb
        for <git@vger.kernel.org>; Sun, 19 Mar 2006 14:04:57 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=gttnjhyENhspWCByhm7cdfkK5C5Nc/SXGjqniGr7xKMCwimZC7qg+/7Fs8l1HL9rpZ8j9vslSs923RAD9q9j3+OgipM14FM6GvymkaDvR81DIWnyK7QkbkuDg5ekxngl8ORQxwY0qmvP73SjZNK2C/mTkL/oBw24TQFC7Rf63ec=
Received: by 10.65.44.5 with SMTP id w5mr335159qbj;
        Sun, 19 Mar 2006 14:04:57 -0800 (PST)
Received: by 10.64.131.10 with HTTP; Sun, 19 Mar 2006 14:04:57 -0800 (PST)
To: "Ingo Molnar" <mingo@elte.hu>
In-Reply-To: <e5bfff550603191401h2c206950w1a0e04cd50fc5370@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/17731>

On 3/19/06, Marco Costalba <mcostalba@gmail.com> wrote:
> On 3/19/06, Ingo Molnar <mingo@elte.hu> wrote:
> >
> > * Marco Costalba <mcostalba@gmail.com> wrote:
> >
> > > This is a maintenance release, mainly performance tweaks and small bug
> > > fixes.
> >
> > looks good here. One small bug: when in 'patch view' mode (e.g. after
> > having double-clicked on a commit), clicking on a merge commit produces
> > an "Error - Qgit" window.
> >
>
> Put in this way it seems a very major bug! really not a small one!
>
> I cannot reproduce it. Please can you give me some more info as repository
> (linux tree?) and commit sha.
>

And please also the error message that appears in qgit window so to know
what git command failed.

Thanks
Marco
