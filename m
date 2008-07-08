From: "Joshua Roys" <roysjosh@gmail.com>
Subject: Re: [GSoC] What is status of Git's Google Summer of Code 2008 projects?
Date: Tue, 8 Jul 2008 12:31:45 -0400
Message-ID: <19b271a20807080931w75430148u8c9778117c9fb6cc@mail.gmail.com>
References: <200807080227.43515.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, "Sam Vilain" <sam@vilain.net>,
	"Sverre Rabbelier" <alturin@gmail.com>,
	"Sverre Rabbelier" <sverre@rabbelier.nl>,
	"David Symonds" <dsymonds@gmail.com>,
	"Lea Wiemann" <LeWiemann@gmail.com>,
	"John Hawley" <warthog19@eaglescrag.net>,
	"Marek Zawirski" <marek.zawirski@gmail.com>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	"Miklos Vajna" <vmiklos@frugalware.org>,
	"Johannes Schindelin" <Johannes.Schindelin@gmx.de>,
	"Stephan Beyer" <s-beyer@gmx.net>,
	"Christian Couder" <chriscool@tuxfamily.org>,
	"Daniel Barkalow" <barkalow@iabervon.org>
To: "Jakub Narebski" <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jul 08 18:32:54 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KGG7S-0001yE-8e
	for gcvg-git-2@gmane.org; Tue, 08 Jul 2008 18:32:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753845AbYGHQbr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 8 Jul 2008 12:31:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753799AbYGHQbr
	(ORCPT <rfc822;git-outgoing>); Tue, 8 Jul 2008 12:31:47 -0400
Received: from rv-out-0506.google.com ([209.85.198.232]:52568 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753492AbYGHQbq (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 8 Jul 2008 12:31:46 -0400
Received: by rv-out-0506.google.com with SMTP id k40so3214887rvb.1
        for <git@vger.kernel.org>; Tue, 08 Jul 2008 09:31:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=tztOD+COHKI54Pv0v+SjqqwJw7H24ao3LLd2q8/ORaw=;
        b=D/3t+A/PqQzv1BKkdY40UfCNZ/jwi2Dvd0qajwIZ1UqzOn6ZjvqnBr+t83Ld8WpiyN
         g3euumx3RHjO7BvmRDaKRHHqPLLgkKXxVa21TQTaXdQtrE98k+lqj2Rit9OjosIDnlqK
         LPuuGMkBmiq8X2ebtSMh8Sw04hlaNjDsoofQw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=aW21D12BAbXhJB64fD9rCHnU+IdYCFgxmhPmTYrKyzaM6z7ZWB6q3izKdBRbvbGINy
         Ym+bx3m7Sqq0j+gP8LmtAI1Hcb8/hLlaWEHDbAiEVhF0DhHJwdoy4RSVmRGPz+pvpRvz
         Xrsp5PgI2urPA1FqoYb6cBN40rgfs1f3iy7zY=
Received: by 10.141.15.19 with SMTP id s19mr3319047rvi.205.1215534705625;
        Tue, 08 Jul 2008 09:31:45 -0700 (PDT)
Received: by 10.141.12.16 with HTTP; Tue, 8 Jul 2008 09:31:45 -0700 (PDT)
In-Reply-To: <200807080227.43515.jnareb@gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/87769>

Hello,

On Mon, Jul 7, 2008 at 8:27 PM, Jakub Narebski <jnareb@gmail.com> wrote:
> 1. GitTorrent (???)
>
> Student: Joshua Roys
> Mentor: Sam Vilain
>
> There was short thread of me asking about project
>  http://thread.gmane.org/gmane.comp.version-control.git/83611
> where I got gittorrent mailing list (no activity at least according to
> list archive http://lists.utsl.gen.nz/pipermail/gittorrent/) and URL
> for project repo / gitweb... which is currently down, so I cannot check
> if there is anything here.
>
> What is the status of this project, please?
>
> http://www.codinghorror.com/blog/archives/001134.html ("Don't Got Dark")
>

It's going slower than I would like, in part due to a two-week period
when I was out of the country.  Other than that, it's going well, I
think.  Sam had a lot of the framework stuff done at the start, and
I've just been working my way through it.  My schedule has cleared up
for the remaining time, so things should move a little faster now.

The gitweb randomly gives 500/internal server errors, not sure why.

Joshua Roys
