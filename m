From: "Jeff Whiteside" <jeff.m.whiteside@gmail.com>
Subject: Re: for newbs = little exercise / tutorial / warmup for windows and other non-sophisticated new Git users :-) [Scanned]
Date: Tue, 30 Dec 2008 18:35:55 -0800
Message-ID: <3ab397d0812301835oc2978e2q4eedc618ad54a47f@mail.gmail.com>
References: <BB5F02FD3789B54E8964D38D6775E718242D35@ALTMORE-SVR.altmore.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Daniel Barkalow" <barkalow@iabervon.org>,
	"Boyd Stephen Smith Jr." <bss@iguanasuicide.net>,
	git@vger.kernel.org
To: "Conor Rafferty" <conor.rafferty@altmore.co.uk>
X-From: git-owner@vger.kernel.org Wed Dec 31 03:37:21 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LHqxT-0007r3-Iq
	for gcvg-git-2@gmane.org; Wed, 31 Dec 2008 03:37:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754487AbYLaCf6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 30 Dec 2008 21:35:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754484AbYLaCf5
	(ORCPT <rfc822;git-outgoing>); Tue, 30 Dec 2008 21:35:57 -0500
Received: from qw-out-2122.google.com ([74.125.92.26]:65098 "EHLO
	qw-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754479AbYLaCf4 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 30 Dec 2008 21:35:56 -0500
Received: by qw-out-2122.google.com with SMTP id 3so4434582qwe.37
        for <git@vger.kernel.org>; Tue, 30 Dec 2008 18:35:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=8GvhLzBtwHXofTWR77/htsfTP7R+A7aeSDQRBWIweHg=;
        b=vmzBHU6rzScTM2RQ+h8438iPBRROBMbMezlfV+RGbGp6sYHj/UMLNO+PPNrOthuyja
         9IPLbQYW+4twh3poLQTOLI5j3kSr4AcCj3p8NYL9eGu/i+OTfTY8sN4aKgGngsyWWnN9
         RjD2q/pTNocqGOvaDpHoqW7vkCDPZwOwAun48=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=HJaJgTVcOZdzW9RvMkKP9DH/c3QU8rAutwBs66g7cvMdQy4N4bmjmNnxGDsPsZSULi
         8ElQrM3YaUXOjwsniSgbmLyhwulGhvgYIup+wHnHYX4tP0VBL0A/NdPIzbFn+0FbAWlr
         hZmvaTh1r8N7vryWIfSIx+fg95/CYyZA0VMxk=
Received: by 10.214.116.3 with SMTP id o3mr13302720qac.241.1230690955255;
        Tue, 30 Dec 2008 18:35:55 -0800 (PST)
Received: by 10.215.41.3 with HTTP; Tue, 30 Dec 2008 18:35:55 -0800 (PST)
In-Reply-To: <BB5F02FD3789B54E8964D38D6775E718242D35@ALTMORE-SVR.altmore.local>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/104241>

sir, i believe you're not reading what is typed.

> wtf is wrong with
>
> git checkout <something>
>
> ??
>
> ** It doesn't reliably put the files that were in that revision into the
> working directory - a fairly major flaw, for what I'm using SCM for (and
> 80% of the market IMHO)

yes it does.  your example uses "git checkout versionB .", which is
NOT "git checkout <something>"
we are suggesting you do "git checkout versionB" which is different
(HINT: there is NO dot), and which i'm 99% positive will work.

if you still disagree, then i'm sure mercurial will be sufficient for
your needs, and all your dcvs book-lernin' over christmas will be
transferrable.

good luck with whatever option you choose.
