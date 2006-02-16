From: Aneesh Kumar <aneesh.kumar@gmail.com>
Subject: Re: [ANNOUNCE] git-svn - bidirection operations between svn and git
Date: Thu, 16 Feb 2006 16:50:01 +0530
Message-ID: <cc723f590602160320p7d551c58q96f6882c97e8422b@mail.gmail.com>
References: <20060216073826.GA12055@hand.yhbt.net>
	 <7v4q2zg2an.fsf@assigned-by-dhcp.cox.net>
	 <cc723f590602160008v5fcc0e35h6d9296bd0572fac2@mail.gmail.com>
	 <7vr763emwx.fsf@assigned-by-dhcp.cox.net>
	 <cc723f590602160030n498b18edla328f7c64d44c04a@mail.gmail.com>
	 <7vmzgrbqy0.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Feb 16 12:20:57 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1F9hBb-0007RB-8j
	for gcvg-git@gmane.org; Thu, 16 Feb 2006 12:20:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932143AbWBPLUF (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 16 Feb 2006 06:20:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751359AbWBPLUF
	(ORCPT <rfc822;git-outgoing>); Thu, 16 Feb 2006 06:20:05 -0500
Received: from uproxy.gmail.com ([66.249.92.203]:51227 "EHLO uproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751356AbWBPLUD convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 16 Feb 2006 06:20:03 -0500
Received: by uproxy.gmail.com with SMTP id y2so109477uge
        for <git@vger.kernel.org>; Thu, 16 Feb 2006 03:20:02 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=UZmxVqXMf9DTnMIM5Um6LHg+iJRaGSlnTEuhnzz4Qx93hbXr+xsWV79W8nu80Q931suLtkr7O4vGtcdrWbQMlmJdrc9N+/cOYsU3OT2i98Sg6oeCS/JFdjHe2uBxG21P/xtstv6jY+aIpgdGzieBMkgRcCrOYIzQOIfZAgHincE=
Received: by 10.66.220.13 with SMTP id s13mr605858ugg;
        Thu, 16 Feb 2006 03:20:01 -0800 (PST)
Received: by 10.66.254.7 with HTTP; Thu, 16 Feb 2006 03:20:01 -0800 (PST)
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7vmzgrbqy0.fsf@assigned-by-dhcp.cox.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/16295>

On 2/16/06, Junio C Hamano <junkio@cox.net> wrote:
> Aneesh Kumar <aneesh.kumar@gmail.com> writes:
>
> > It would be fine with me if you just  drop the script to
> > contrib/gitview directory.
>
> OK.  One final question.  Actually, two.  Is the original author
> Scott James Remnant OK with adding the script to a GPLv2
> project?  Also do you want your HP affiliation appear in the
> author field or your gmail address?
>
>
>

Scott James code was motivation to start the project. But if you
compare the two code lot of changes are done. Infact only thing that
remain now is how i draw using the cairo which is also modified a bit.

This is the COPYING file that scott had in bzrk project.

http://people.ubuntu.com/~scott/bzr/bzrk/COPYING

But gitview is quiet different from bzrk. I just wanted to add it to
the code that i started with bzrk code.

Regarding HP affiliation i guess it should remain. In short you can
add the file as I send you

-aneesh
