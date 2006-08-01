From: "Martin Langhoff" <martin.langhoff@gmail.com>
Subject: Re: Why I love GIT but use Subversion
Date: Tue, 1 Aug 2006 17:39:48 +1200
Message-ID: <46a038f90607312239y50fbd2afl1dbd56b721fb8c19@mail.gmail.com>
References: <4d8e3fd30607230123m459aa1cle2ab8c1c1dd0fcd2@mail.gmail.com>
	 <4d8e3fd30607300248m36b4038dv1fcd1f3716503905@mail.gmail.com>
	 <1prv3rw6ldo9s$.dlg@jwmittag.my-fqdn.de>
	 <7virld2hjt.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: "=?ISO-8859-1?Q?J=F6rg_W_Mittag?=" <Joerg.Mittag@web.de>,
	git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Aug 01 07:39:55 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1G7myv-0007yy-Eu
	for gcvg-git@gmane.org; Tue, 01 Aug 2006 07:39:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161080AbWHAFju (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 1 Aug 2006 01:39:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161081AbWHAFju
	(ORCPT <rfc822;git-outgoing>); Tue, 1 Aug 2006 01:39:50 -0400
Received: from nf-out-0910.google.com ([64.233.182.184]:37043 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S1161080AbWHAFjt (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 1 Aug 2006 01:39:49 -0400
Received: by nf-out-0910.google.com with SMTP id o25so152809nfa
        for <git@vger.kernel.org>; Mon, 31 Jul 2006 22:39:48 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=GJ0mK9/TDnWo9mMq1bdlOqKxAzZ3Brj/jIEI8JnHkFstYg2qpV0ocm6K5/NSly19EL6LOzVC98MfdOVmWSIzR4hbB/dmA7Ts2ePWOf5LumZtb13FuhTndJQSKOM4SVCX26GizzazD2emsX26P+e+ShIfQmRR/WzERs42eItS6FY=
Received: by 10.78.140.17 with SMTP id n17mr140774hud;
        Mon, 31 Jul 2006 22:39:48 -0700 (PDT)
Received: by 10.78.120.17 with HTTP; Mon, 31 Jul 2006 22:39:47 -0700 (PDT)
To: "Junio C Hamano" <junkio@cox.net>
In-Reply-To: <7virld2hjt.fsf@assigned-by-dhcp.cox.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/24577>

On 8/1/06, Junio C Hamano <junkio@cox.net> wrote:
> So please step forward, enlist MS comrades, and start hacking,

I don't know how mature the libification of git is, in terms of
working correctly on Windows without a full cygwin environemnt (but
perhaps with the cygwin dll). If it builds and works reasonably well
just linking to the dll, perhaps we should enlist the
TortoiseCVS/TortoiseSVN hackers to replace the SVN bindings with GIT
bindings.

Of course, that'd give us a simplified UI, but it'd get the ball rolling.

cheers,


martin
