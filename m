From: "Martin Langhoff" <martin.langhoff@gmail.com>
Subject: Re: irc usage..
Date: Tue, 23 May 2006 11:29:32 +1200
Message-ID: <46a038f90605221629w4e5b3654o5bb494843cb1d38a@mail.gmail.com>
References: <Pine.LNX.4.64.0605211209080.3649@g5.osdl.org>
	 <46a038f90605220042v369e9ff5o3dc7841472171d02@mail.gmail.com>
	 <Pine.LNX.4.64.0605220203200.3697@g5.osdl.org>
	 <46a038f90605220554y569c11b9p24027772bd2ee79a@mail.gmail.com>
	 <44720C66.6040304@gentoo.org>
	 <46a038f90605221241x58ffa2a4o26159d38d86a8092@mail.gmail.com>
	 <Pine.LNX.4.64.0605221256090.3697@g5.osdl.org>
	 <20060522214128.GE16677@kiste.smurf.noris.de>
	 <Pine.LNX.4.64.0605221516500.3697@g5.osdl.org>
	 <46a038f90605221623g25325e71hf3faf0a6a6ca628a@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
	format=flowed
Content-Transfer-Encoding: 7BIT
Cc: "Matthias Urlichs" <smurf@smurf.noris.de>,
	"Donnie Berkholz" <spyderous@gentoo.org>,
	"Yann Dirson" <ydirson@altern.org>,
	"Git Mailing List" <git@vger.kernel.org>,
	"Johannes Schindelin" <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Tue May 23 01:29:39 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FiJqE-0004GS-K0
	for gcvg-git@gmane.org; Tue, 23 May 2006 01:29:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751017AbWEVX3f (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 22 May 2006 19:29:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751304AbWEVX3f
	(ORCPT <rfc822;git-outgoing>); Mon, 22 May 2006 19:29:35 -0400
Received: from wr-out-0506.google.com ([64.233.184.229]:6481 "EHLO
	wr-out-0506.google.com") by vger.kernel.org with ESMTP
	id S1751017AbWEVX3e convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 22 May 2006 19:29:34 -0400
Received: by wr-out-0506.google.com with SMTP id 50so731788wri
        for <git@vger.kernel.org>; Mon, 22 May 2006 16:29:34 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=eWX31ElEBTWPaLm5YdPSmnMaAP7GhHTbKCvmi4zOqIO32fn4ZvKVMq+6ivmx4UQrTaP95NbSBA54jx92+jV07FZKqRq3uq6MXZtmsPAFRUIDRrTWC81me4DChl/eWP8xnQ1gLeQ2MLOC+Irjlcw85XZpOh/A0NtqflT7s6YAIjQ=
Received: by 10.54.153.18 with SMTP id a18mr5356671wre;
        Mon, 22 May 2006 16:29:32 -0700 (PDT)
Received: by 10.54.127.17 with HTTP; Mon, 22 May 2006 16:29:32 -0700 (PDT)
To: "Linus Torvalds" <torvalds@osdl.org>
In-Reply-To: <46a038f90605221623g25325e71hf3faf0a6a6ca628a@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/20553>

On 5/23/06, Martin Langhoff <martin.langhoff@gmail.com> wrote:
> The problem is that they lead to slightly different trees.

Sorry! s/trees/histories/ there. The trees are (or should!) be the
same, and tree differences should be addressed as bugs. Differences in
how history is parsed are unavoidable right now.

martin
