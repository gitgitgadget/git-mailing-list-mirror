From: "Imran M Yousuf" <imyousuf@gmail.com>
Subject: Re: [PATCH] git-submodule: New subcommand 'summary'
Date: Wed, 9 Jan 2008 08:25:56 +0600
Message-ID: <7bfdc29a0801081825ue3b51f1p29c8199287aad66b@mail.gmail.com>
References: <1199122505-27478-1-git-send-email-pkufranky@gmail.com>
	 <46dff0320801080420v6295939aw86a6cba3ceb8c076@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Ping Yin" <pkufranky@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jan 09 03:26:33 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JCQeF-0001zX-Tb
	for gcvg-git-2@gmane.org; Wed, 09 Jan 2008 03:26:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752450AbYAICZ7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 8 Jan 2008 21:25:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754153AbYAICZ7
	(ORCPT <rfc822;git-outgoing>); Tue, 8 Jan 2008 21:25:59 -0500
Received: from fg-out-1718.google.com ([72.14.220.154]:32505 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752204AbYAICZ6 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 8 Jan 2008 21:25:58 -0500
Received: by fg-out-1718.google.com with SMTP id e21so69111fga.17
        for <git@vger.kernel.org>; Tue, 08 Jan 2008 18:25:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=wBBGP28hvTorORI2gaSkGtDE2Wpw0Za7dkZRx7nox5w=;
        b=fjMYlGyfzA02BOAglrumrEyLvf6MfSjJ4x+tA44ItJZYiCG9JBwQsgdxTRHFDD9lYpjrK1L8+bUZ8T/NGzicXXxxC7FfbHmFLP/2sxhIe8bqDjGo/kpPve2FmWqfuueqi3EJUrImd+PeAry/waw3HRQQ2sKS2gh+EjI6WSy+snA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=dKS1t1i8FrGx6qyhHPc68wuZfyaORf46X8SJ3Zg26QoZmO0URJraG+C2sUd+peugOPfRmMyhArJudnUCj+BxfHWuRsklbRDyXI84oJlDLjNulu8oVlWu40jtAFW/GC24RPVpCiSkWt8mpdKfHHcFc93aJx+BpINOuUkp9cWWLJc=
Received: by 10.78.131.8 with SMTP id e8mr75891hud.1.1199845556270;
        Tue, 08 Jan 2008 18:25:56 -0800 (PST)
Received: by 10.78.50.5 with HTTP; Tue, 8 Jan 2008 18:25:56 -0800 (PST)
In-Reply-To: <46dff0320801080420v6295939aw86a6cba3ceb8c076@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/69943>

Hi Ping,

Though I am not a expert on this myself but from my recent experience
from patches I would request you to have a look at
Documentation/Submitting patches.
http://repo.or.cz/w/git.git?a=blob;f=Documentation/SubmittingPatches;hb=HEAD

Best regards,

Imran

On Jan 8, 2008 6:20 PM, Ping Yin <pkufranky@gmail.com> wrote:
> Any comment to my patch?
>
> Following this i will give patches to introduce submodule summary
> function into git-commit
>
>
> On Jan 1, 2008 1:35 AM, Ping Yin <pkufranky@gmail.com> wrote:
> > The patch series ( 3 in total) teach git-submodule a new subcommand 'summary'.
> >
> > PATCH 1 introduces the code framework.
> >
> > PATCH 2 does the real work for summary.
> >
> > PATCH 3 teaches a new option '--summary-limit|-n'.
> >
> > -
> > To unsubscribe from this list: send the line "unsubscribe git" in
> > the body of a message to majordomo@vger.kernel.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> >
>
>
>
> --
> Ping Yin
>
> -
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>



-- 
Imran M Yousuf
Entrepreneur & Software Engineer
Smart IT Engineering
Dhaka, Bangladesh
Email: imran@smartitengineering.com
Mobile: +880-1711402557
