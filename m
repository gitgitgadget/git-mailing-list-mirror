From: Luben Tuikov <ltuikov@yahoo.com>
Subject: Re: manual merge/fixup question
Date: Sat, 7 Jan 2006 09:01:32 -0800 (PST)
Message-ID: <20060107170132.66682.qmail@web31803.mail.mud.yahoo.com>
References: <20060107165506.67640.qmail@web31812.mail.mud.yahoo.com>
Reply-To: ltuikov@yahoo.com
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-From: git-owner@vger.kernel.org Sat Jan 07 18:01:44 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EvHRn-0002Nb-RB
	for gcvg-git@gmane.org; Sat, 07 Jan 2006 18:01:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030510AbWAGRBe (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 7 Jan 2006 12:01:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030511AbWAGRBe
	(ORCPT <rfc822;git-outgoing>); Sat, 7 Jan 2006 12:01:34 -0500
Received: from web31803.mail.mud.yahoo.com ([68.142.207.66]:44186 "HELO
	web31803.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S1030510AbWAGRBd (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 7 Jan 2006 12:01:33 -0500
Received: (qmail 66684 invoked by uid 60001); 7 Jan 2006 17:01:32 -0000
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  h=Message-ID:Received:Date:From:Reply-To:Subject:To:In-Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding;
  b=In7UbbZqF6h7IQSQHLg9Y87RYx86qg54ctxWUJH5412YITBjpCw2EHQt/FCsu+w+YsCJY9IzMILWeT0LTLC3FXDvbFaGQ3XNZnX+r0CmN0jeSo0IZORu2+bGW/s/a1Ra6WAyAr+7/jO9cLhRdWkiGqpUmt//Vp00yj2KzhSR380=  ;
Received: from [68.221.7.47] by web31803.mail.mud.yahoo.com via HTTP; Sat, 07 Jan 2006 09:01:32 PST
To: git@vger.kernel.org
In-Reply-To: <20060107165506.67640.qmail@web31812.mail.mud.yahoo.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/14262>

Ok, I think it does all of them...
    Luben

--- Luben Tuikov <ltuikov@yahoo.com> wrote:

> git resolve or git merge fails, complaining
> about file(s) having conflicts. I go ahead and fix up
> those files and then update the index.
> 
> Can I assume now that I can go ahead and do git commit,
> or is there any more/other files which need fixing?
> 
> I.e. does git resolve/merge fail on the first file
> which needs fixing or would it go through all of them,
> and then report the ones which need fixing?
> 
> Thanks,
>    Luben
> 
> -
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
