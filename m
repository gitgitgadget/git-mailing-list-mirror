From: Adrien Beau <adrienbeau@gmail.com>
Subject: Re: Get rid of .git/branches/ and .git/remotes/?
Date: Tue, 22 Nov 2005 21:13:01 +0100
Message-ID: <94fc236b0511221213s588c4b11k4ee6d5450f3009c9@mail.gmail.com>
References: <20051122041843.9436.qmail@science.horizon.com>
	 <4382DFDA.6040306@op5.se> <20051122191234.GA9040@puritan.petwork>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-From: git-owner@vger.kernel.org Tue Nov 22 21:15:41 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EeeVo-0004MX-LD
	for gcvg-git@gmane.org; Tue, 22 Nov 2005 21:13:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965004AbVKVUNE (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 22 Nov 2005 15:13:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965164AbVKVUNE
	(ORCPT <rfc822;git-outgoing>); Tue, 22 Nov 2005 15:13:04 -0500
Received: from zproxy.gmail.com ([64.233.162.198]:57374 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S965004AbVKVUNC convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 22 Nov 2005 15:13:02 -0500
Received: by zproxy.gmail.com with SMTP id 13so1172468nzn
        for <git@vger.kernel.org>; Tue, 22 Nov 2005 12:13:02 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=BJJRmMmel4Am6Xsgqw10soSmaU2qWPdG5ibywoo8pMZ8hEmVO6jZrfndumorsTqJmvDYp4Z/9xREgU+BT2snHpmydTHQdy5nTxddTirRIVAOhHOOadqE1KR+kX80vFOFlR78I4cyC2RRZWI/Q6Fmkn+Ifx1ugMtb2XOeKmAzoek=
Received: by 10.36.250.70 with SMTP id x70mr2662712nzh;
        Tue, 22 Nov 2005 12:13:01 -0800 (PST)
Received: by 10.36.250.69 with HTTP; Tue, 22 Nov 2005 12:13:01 -0800 (PST)
To: git@vger.kernel.org
In-Reply-To: <20051122191234.GA9040@puritan.petwork>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/12572>

On 11/22/05, Nikolai Weibull <mailing-lists.git@rawuncut.elitemail.org> wrote:
>
> who is the target audience of git?  I get the
> feeling that most users will be programmers, so that's kind of a
> non-argument (even though I agree with your standpoint).

If Git is successful, then there will also be a lot of bleeding-edge
users, people who want to be able to:

* Get the latest and greatest (and build it and run it)
* Browse the repository (with gitk or gitweb)
* Maybe (very occasionnally) create a simple patch

This is already the case with CVS, plenty of people know (or are
instructed to do) cvs checkout, cvs update, and nothing more. That's
not much, but they're CVS users, nevertheless.
