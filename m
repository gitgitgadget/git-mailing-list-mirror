From: "Martin Langhoff" <martin.langhoff@gmail.com>
Subject: Re: irc usage..
Date: Wed, 31 May 2006 10:31:35 +1200
Message-ID: <46a038f90605301531g4f8b37c7qab9a717833c64ebc@mail.gmail.com>
References: <Pine.LNX.4.64.0605201016090.10823@g5.osdl.org>
	 <46a038f90605220554y569c11b9p24027772bd2ee79a@mail.gmail.com>
	 <44720C66.6040304@gentoo.org>
	 <Pine.LNX.4.64.0605221234430.3697@g5.osdl.org>
	 <447215D4.5020403@gentoo.org>
	 <Pine.LNX.4.64.0605221312380.3697@g5.osdl.org>
	 <447231C4.2030508@gentoo.org> <447B6D85.4050601@gentoo.org>
	 <46a038f90605291521q37f34209wd923608bdebb9084@mail.gmail.com>
	 <447B7669.8050805@gentoo.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: "Linus Torvalds" <torvalds@osdl.org>,
	"Yann Dirson" <ydirson@altern.org>,
	"Git Mailing List" <git@vger.kernel.org>,
	"Matthias Urlichs" <smurf@smurf.noris.de>,
	"Johannes Schindelin" <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Wed May 31 00:32:20 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FlCka-00057m-Fj
	for gcvg-git@gmane.org; Wed, 31 May 2006 00:31:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932528AbWE3Wbj (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 30 May 2006 18:31:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964775AbWE3Wbi
	(ORCPT <rfc822;git-outgoing>); Tue, 30 May 2006 18:31:38 -0400
Received: from wr-out-0506.google.com ([64.233.184.224]:54205 "EHLO
	wr-out-0506.google.com") by vger.kernel.org with ESMTP
	id S932528AbWE3Wbg (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 30 May 2006 18:31:36 -0400
Received: by wr-out-0506.google.com with SMTP id 37so96189wra
        for <git@vger.kernel.org>; Tue, 30 May 2006 15:31:36 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=MlhCpydU8lRrYSMPD7s7HDmGXeegA+6YTuL7qmddFV/pjyGBDxLB4kiQg1WIC3R7BsKCjRPHwGypA/BPciGehuRQWVkwMVhdQYX0f8LGIa529v79gic0gnEpEd4qsfNdfz0uGD4DZm0C0wCG+n8L7+64d75ZCIPIO/LDi4IgGCw=
Received: by 10.54.77.13 with SMTP id z13mr3675835wra;
        Tue, 30 May 2006 15:31:35 -0700 (PDT)
Received: by 10.54.127.12 with HTTP; Tue, 30 May 2006 15:31:35 -0700 (PDT)
To: "Donnie Berkholz" <spyderous@gentoo.org>
In-Reply-To: <447B7669.8050805@gentoo.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/21047>

On 5/30/06, Donnie Berkholz <spyderous@gentoo.org> wrote:
> Martin Langhoff wrote:
> > On 5/30/06, Donnie Berkholz <spyderous@gentoo.org> wrote:
> >> Finally hit an OOM sometime in the past day (yep, a week later) =\. Not
> >> sure whether it was cvsimport or cvs. Anyone else had more luck?

With the latest cvsimport in Junio's repo, a lot of RAM and a bit of patience...

  gitview
  http://git.catalyst.net.nz/gitweb?p=gentoo.git;a=summary

  fetchable
  http://git.catalyst.net.nz/git/gentoo.git#cvshead

Still pushing it, will be there in a minute or so. The packed repo
weights about 660MB. Not too bad given the size of the project and the
number of commits.


martin
