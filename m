From: "Daniel Berlin" <dberlin@dberlin.org>
Subject: Re: Git and GCC
Date: Wed, 5 Dec 2007 23:32:52 -0500
Message-ID: <4aca3dc20712052032n521c344cla07a5df1f2c26cb8@mail.gmail.com>
References: <4aca3dc20712051841o71ab773ft6dd0714ebc355dd5@mail.gmail.com>
	 <20071205.185203.262588544.davem@davemloft.net>
	 <4aca3dc20712051947t5fbbb383ua1727c652eb25d7e@mail.gmail.com>
	 <20071205.202047.58135920.davem@davemloft.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: ismail@pardus.org.tr, gcc@gcc.gnu.org, git@vger.kernel.org
To: "David Miller" <davem@davemloft.net>
X-From: git-owner@vger.kernel.org Thu Dec 06 05:33:16 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J08QD-00058D-P7
	for gcvg-git-2@gmane.org; Thu, 06 Dec 2007 05:33:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752177AbXLFEcy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 5 Dec 2007 23:32:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752161AbXLFEcy
	(ORCPT <rfc822;git-outgoing>); Wed, 5 Dec 2007 23:32:54 -0500
Received: from wa-out-1112.google.com ([209.85.146.178]:25011 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752030AbXLFEcx (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 5 Dec 2007 23:32:53 -0500
Received: by wa-out-1112.google.com with SMTP id v27so181880wah
        for <git@vger.kernel.org>; Wed, 05 Dec 2007 20:32:53 -0800 (PST)
Received: by 10.142.50.15 with SMTP id x15mr461891wfx.1196915572553;
        Wed, 05 Dec 2007 20:32:52 -0800 (PST)
Received: by 10.142.217.1 with HTTP; Wed, 5 Dec 2007 20:32:52 -0800 (PST)
In-Reply-To: <20071205.202047.58135920.davem@davemloft.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/67231>

On 12/5/07, David Miller <davem@davemloft.net> wrote:
> From: "Daniel Berlin" <dberlin@dberlin.org>
> Date: Wed, 5 Dec 2007 22:47:01 -0500
>
> > The size is clearly not just svn data, it's in the git pack itself.
>
> And other users have shown much smaller metadata from a GIT import,
> and yes those are including all of the repository history and branches
> not just the trunk.
I followed the instructions in the tutorials.
I followed the instructions given to by people who created these.
I came up with a 1.5 gig pack file.
You want to help, or you want to argue with me.
Right now it sounds like you are trying to blame me or make it look
like i did something wrong.

You are of course, welcome to try it yourself.
I can give you the absolute exactly commands I gave, and with git
1.5.3.7, it will give you a 1.5 gig pack file.
