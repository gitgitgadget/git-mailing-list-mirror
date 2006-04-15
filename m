From: "Marco Costalba" <mcostalba@gmail.com>
Subject: Re: [WISH] prepend diffstat in front of the patch
Date: Sat, 15 Apr 2006 11:23:56 +0200
Message-ID: <e5bfff550604150223i1ceaee5am9d3ec30f34166c01@mail.gmail.com>
References: <e5bfff550604150207h6fdb0042x3a9bbfa63269a8c8@mail.gmail.com>
	 <7vejzzi4ft.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Apr 15 11:24:06 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FUh0d-0000DR-7L
	for gcvg-git@gmane.org; Sat, 15 Apr 2006 11:24:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751613AbWDOJX6 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 15 Apr 2006 05:23:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932354AbWDOJX6
	(ORCPT <rfc822;git-outgoing>); Sat, 15 Apr 2006 05:23:58 -0400
Received: from wproxy.gmail.com ([64.233.184.227]:17928 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751612AbWDOJX6 convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 15 Apr 2006 05:23:58 -0400
Received: by wproxy.gmail.com with SMTP id i6so369404wra
        for <git@vger.kernel.org>; Sat, 15 Apr 2006 02:23:57 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=Rn+TtKszwrpRZwd+xbq7iwEdrapuOlijxd7vI5rCWJkVQe/iH2meyQPP3woKAzwDeqLEv5xNHvYMvgX9rGU4zReFR1A9tixdqTjijvZmyKCc7mYQtkhJEf3uZyTuTgTr3vXXCm5jlABMCmjPv9rlJqdnG9WbB/Z2pf55d5PU0QU=
Received: by 10.64.250.10 with SMTP id x10mr1254521qbh;
        Sat, 15 Apr 2006 02:23:56 -0700 (PDT)
Received: by 10.64.131.14 with HTTP; Sat, 15 Apr 2006 02:23:56 -0700 (PDT)
To: "Junio C Hamano" <junkio@cox.net>
In-Reply-To: <7vejzzi4ft.fsf@assigned-by-dhcp.cox.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/18735>

On 4/15/06, Junio C Hamano <junkio@cox.net> wrote:
> "Marco Costalba" <mcostalba@gmail.com> writes:
>
> > Perhaps I missed something, but I would like to see --stat and -p as
> > _cumulative_ options .
>
> Yes, you missed my write-up on "Recent unresolved issues",
> especially this entry:
>
>     * Message-ID: <7vek02ynif.fsf@assigned-by-dhcp.cox.net>
>       diff --with-raw, --with-stat? (me)
>
> and the thread that introduced the --stat option.
>
> It is also what I want, but there is only 24 hours in a day and
> there is this thing called day-job.
>

Sorry, I  didn't mean to force anything, just asking.

Day-job thing is not unknown to me too.

Marco
