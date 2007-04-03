From: Srijak Rijal <srijak@gmail.com>
Subject: Re: Gittorent .. avahi ?
Date: Tue, 03 Apr 2007 15:44:38 -0400
Message-ID: <4612AEA6.3040706@gmail.com>
References: <9d916d5b0704011059g31394159kfdd5e01ba81915c2@mail.gmail.com> <2c6b72b30704031125o4335aeefg88ccee163fa27142@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Jonas Fonseca <jonas.fonseca@gmail.com>
X-From: git-owner@vger.kernel.org Tue Apr 03 21:45:39 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HYowf-0001zu-Pn
	for gcvg-git@gmane.org; Tue, 03 Apr 2007 21:45:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S966188AbXDCTpb (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 3 Apr 2007 15:45:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S966211AbXDCTpb
	(ORCPT <rfc822;git-outgoing>); Tue, 3 Apr 2007 15:45:31 -0400
Received: from wx-out-0506.google.com ([66.249.82.228]:6221 "EHLO
	wx-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S966188AbXDCTpa (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 Apr 2007 15:45:30 -0400
Received: by wx-out-0506.google.com with SMTP id h31so1916702wxd
        for <git@vger.kernel.org>; Tue, 03 Apr 2007 12:45:28 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:user-agent:mime-version:to:cc:subject:references:in-reply-to:x-enigmail-version:content-type:content-transfer-encoding;
        b=Qp8d33z/4J9ZOPZ3FovY6kv3QXqXRzQEMxhoRYrFsAm/WxhvgsGglZXjqXPyxuDpbXsrCTnSZZh2TH+YGeYCcpthAiZdLzsWCGD37drvJfScwbDR4GaC6JDWua4RXWAYdrxE6P7JnueFgodd2F9bIbY4bcK7tOMHJHuHNGthuBE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:user-agent:mime-version:to:cc:subject:references:in-reply-to:x-enigmail-version:content-type:content-transfer-encoding;
        b=Wev88t6BBUW9wvdoFp9hGSdwfUrRX6JBfeyegM9lY3d4lUpUqnZS40EOyWZVUZeGKKmpLRF2XaE1CgavcXWpcj3UBrGWRpXnQyUB4N7srkffIzMkVA90KWILzvp0TSCgZk0YgDyFIMLUno2FDGjFXSC5qBPr6fuLz4QipKbqoTo=
Received: by 10.70.11.1 with SMTP id 1mr379728wxk.1175629527425;
        Tue, 03 Apr 2007 12:45:27 -0700 (PDT)
Received: from ?128.173.146.235? ( [128.173.146.235])
        by mx.google.com with ESMTP id i12sm8506207wxd.2007.04.03.12.45.25;
        Tue, 03 Apr 2007 12:45:25 -0700 (PDT)
User-Agent: Thunderbird 1.5.0.9 (Windows/20061207)
In-Reply-To: <2c6b72b30704031125o4335aeefg88ccee163fa27142@mail.gmail.com>
X-Enigmail-Version: 0.94.3.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/43644>

Hi Jonas,
>
> While the tracker is a very interesting part of GitTorrent, because it
> has a lot of responsibility for 'advertising' new changes, I think the
> client, in itself, would be a hard and big enough project. And as Sam
> said the tracker can be reduced to a simple static file that is
> regularly updated by a cron job or something like that.

Yup. For now,  I plan to adhere closely to the spec and get the initial 
version out :).
I agree with Shawn in that letting the tool organically evolve to
include new features and bug fixes as required is the best way to go.
The avahi idea is a product of me having time to think about the
project, but not being able to code :).

> I made a report about GitTorrent from which you might be able to
> get some info from or at least some overall motivations and
> considerations. However, it is for the much simpler and stupid
> 'initial' proposal, before Sam stepped in and made especially the
> core of the peer wire protocol more scalable. So 'caveat emptor'
> (this especially goes for the more Git related parts).
>
> You can find it at:
>
>  http://jonas.nitro.dk/tmp/foo/gittorrent.html/node38.html
>
> and the whole report at
>
>  http://jonas.nitro.dk/tmp/foo/gittorrent.pdf
>
Great :). Thanks for the link. I think the report will be helpful.  I
intend to look it over as soon as I get time. School in kinda hectic ATM.

> I really hope your project gets approved.
Thanks, me too :),




Srijak.
