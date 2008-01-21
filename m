From: "Imran M Yousuf" <imyousuf@gmail.com>
Subject: Re: What's not in 'master', and likely not to be until 1.5.4
Date: Mon, 21 Jan 2008 11:55:19 +0600
Message-ID: <7bfdc29a0801202155o471db5c7v38e1a587115abf36@mail.gmail.com>
References: <1200022189-2400-1-git-send-email-mlevedahl@gmail.com>
	 <7vbq7qssd7.fsf@gitster.siamese.dyndns.org>
	 <47893E1A.5020702@gmail.com>
	 <7v4pdislrf.fsf@gitster.siamese.dyndns.org>
	 <alpine.LSU.1.00.0801132224540.8333@wbgn129.biozentrum.uni-wuerzburg.de>
	 <7vir1xmazm.fsf@gitster.siamese.dyndns.org>
	 <7v63xrh3mw.fsf_-_@gitster.siamese.dyndns.org>
	 <7vfxwvfmd8.fsf_-_@gitster.siamese.dyndns.org>
	 <m3tzlbl6he.fsf@roke.D-201>
	 <7vk5m6by9f.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Jakub Narebski" <jnareb@gmail.com>, git@vger.kernel.org
To: "Junio C Hamano" <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Jan 21 06:55:52 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JGpdP-0005oO-CG
	for gcvg-git-2@gmane.org; Mon, 21 Jan 2008 06:55:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752192AbYAUFzV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 21 Jan 2008 00:55:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752176AbYAUFzV
	(ORCPT <rfc822;git-outgoing>); Mon, 21 Jan 2008 00:55:21 -0500
Received: from nf-out-0910.google.com ([64.233.182.190]:12756 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752133AbYAUFzU (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 21 Jan 2008 00:55:20 -0500
Received: by nf-out-0910.google.com with SMTP id g13so220532nfb.21
        for <git@vger.kernel.org>; Sun, 20 Jan 2008 21:55:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=o9FsZO8vw83QvwgwvoAyxz/ApAHUMB6pVLQfYdU/Ywg=;
        b=eiy1z40QPn/t2N1FRIQ52WxidQPKLdqmrvdFy3FVmdu0guTAYN9E+Wp+4PvTC1Ch7tvt8pvGnKbQPlB4KQ5RK4C2Q7nzuYcl33XHtKHuxcQ58vXVQsdKyPlHT+FwSJ7geOaf+Jq70a0rauiddr3PAp2LYchSJthyjJUFlI4v4fI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=btsirO8mizMUpQ/l1TG5svYB87cn8tSCfYXpHRjnNtjpQvyBuQhxlK2Mwqj4t4A+kzRal/O8l2imod78/q6x6n7aIClmeWSL+aJl9E7NEEajuN61KxorDar11QBMOwEnJk+lKrxj9kKghcA9CZt4aZIv7k55low43nRnXWhOfcM=
Received: by 10.78.188.10 with SMTP id l10mr8412644huf.14.1200894919102;
        Sun, 20 Jan 2008 21:55:19 -0800 (PST)
Received: by 10.78.50.5 with HTTP; Sun, 20 Jan 2008 21:55:19 -0800 (PST)
In-Reply-To: <7vk5m6by9f.fsf@gitster.siamese.dyndns.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/71223>

On Jan 19, 2008 3:49 AM, Junio C Hamano <gitster@pobox.com> wrote:
> Jakub Narebski <jnareb@gmail.com> writes:
>
> > Junio C Hamano <gitster@pobox.com> writes:
> >
> >> Here is an update to the list I sent earlier.  Topics that I
> >> thought may deserve attention, discussion and eventual inclusion
> >> but are not 1.5.4 material.
> >>
> >> I think some of them actually have a slight chance of being
> >> 1.5.4 material, if interested parties present good enough
> >> arguments that they are actually good and safe bugfixes.
> >
> >>  * submodule subcommand parser fix for "git submodule add init
> >>    update" (Imran M Yousuf and me)
> >
> > Isn't it a bugfix, and shouldn't it for this reason be in 1.5.4?
>
> Yeah, I tend to agree.  I was waiting for an Ack or failure
> report from Imran, as I turned the table around.

Sorry I forgot to mention it earlier, your patches worked fine :),
thank you once again for the help.

>



-- 
Imran M Yousuf
