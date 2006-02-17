From: Martin Langhoff <martin.langhoff@gmail.com>
Subject: Re: contrib/ area
Date: Sat, 18 Feb 2006 01:24:55 +1300
Message-ID: <46a038f90602170424u59f84ac8l1311d80cd7251394@mail.gmail.com>
References: <7vmzgq451m.fsf@assigned-by-dhcp.cox.net>
	 <873biikx6k.fsf@wine.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Feb 17 13:25:00 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FA4fU-0000uV-18
	for gcvg-git@gmane.org; Fri, 17 Feb 2006 13:25:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751405AbWBQMY5 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 17 Feb 2006 07:24:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751406AbWBQMY5
	(ORCPT <rfc822;git-outgoing>); Fri, 17 Feb 2006 07:24:57 -0500
Received: from wproxy.gmail.com ([64.233.184.203]:28640 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751405AbWBQMY4 convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 17 Feb 2006 07:24:56 -0500
Received: by wproxy.gmail.com with SMTP id i20so120099wra
        for <git@vger.kernel.org>; Fri, 17 Feb 2006 04:24:55 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=Y8m+oWnlFS9SdUh35tOS8hVOXIkWXH1RtIOqGCSh4fihAqXHclugkK3PhhhYgBLE2agT77Hj8aJ+UetKULrlA//M/DRltu0FhmArBM4QnBPZP+CGJzCWnwJOGN89D+wVTZ17WdduV2IY9ovRahy0h7Yz1rz71IlkZVPOntZxW1o=
Received: by 10.54.152.14 with SMTP id z14mr1055379wrd;
        Fri, 17 Feb 2006 04:24:55 -0800 (PST)
Received: by 10.54.127.12 with HTTP; Fri, 17 Feb 2006 04:24:55 -0800 (PST)
To: Alexandre Julliard <julliard@winehq.org>
In-Reply-To: <873biikx6k.fsf@wine.dyndns.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/16341>

On 2/18/06, Alexandre Julliard <julliard@winehq.org> wrote:
> Is there interest in an emacs interface for git?  I posted a first
> version (http://marc.theaimsgroup.com/?l=git&m=113313040724346&w=2)
> some time ago, I'd be happy to send you a patch with my latest version
> if you want to include it.

Yes, please. I'd really like to see it help handle conflicts, and
provide multi-pane views during merges. We are in love with emacs diff
mode for conflict resolution when you end up with .rej files, but it
doesn't kick in properly with the inline conflict markers :-(

cheers,


m
