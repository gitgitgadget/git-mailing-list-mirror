From: Yann Simon <yann.simon.fr@gmail.com>
Subject: Re: [PATCH JGIT] In the commit dialog, deal with Signed-off-by not on 
	the last line
Date: Fri, 20 Feb 2009 08:48:08 +0100
Message-ID: <551f769b0902192348k7b1a2444n4c882cc198c79723@mail.gmail.com>
References: <499D2478.6080501@gmail.com>
	 <bd6139dc0902190953m195a56ey47aa9bf535c4d77c@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Robin Rosenberg <robin.rosenberg.lists@dewire.com>,
	"Shawn O. Pearce" <spearce@spearce.org>, git <git@vger.kernel.org>
To: Sverre Rabbelier <srabbelier@gmail.com>
X-From: git-owner@vger.kernel.org Fri Feb 20 08:49:43 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LaQ8h-0001yy-Fo
	for gcvg-git-2@gmane.org; Fri, 20 Feb 2009 08:49:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753301AbZBTHsM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 20 Feb 2009 02:48:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752945AbZBTHsL
	(ORCPT <rfc822;git-outgoing>); Fri, 20 Feb 2009 02:48:11 -0500
Received: from fk-out-0910.google.com ([209.85.128.189]:3154 "EHLO
	fk-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752198AbZBTHsK (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 20 Feb 2009 02:48:10 -0500
Received: by fk-out-0910.google.com with SMTP id f33so698083fkf.5
        for <git@vger.kernel.org>; Thu, 19 Feb 2009 23:48:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=O/aW+zUTz8WQHjpkEXc7pEk0CRjjjDFghn4e+1A32H0=;
        b=HyKJZqsfrnm4xGBEc0BMwl9FjJyjkvAvgYDxyCJgQO4salXFon2InVtbGJxRUE6xLN
         Ifsf+zqyvjWw73EY3JXgzx0FrgisW+1H7ssltHRv+eeRIRZfnRuPONhPVqLm6KPKTJrn
         1g3rnC6X5C93FeiXkd1GlhMMn6GJxfdNOOj6s=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=nXsfd3pOcga0x9Ws7fLxV2YPJ+01bF5RtkXQCNLxfZ0gNHDqNgKLikbxtvm0C5H1LZ
         ivnU6FoOC6XoH3BDcvi59LJoKg5hCeTmibw+RiDrISSieTpHd0FSbeG+nPkNiAeOjMbi
         ixH8CWpXa82hjUYKpmBFhjKsEJA4Z9qfwWk5I=
Received: by 10.181.28.15 with SMTP id f15mr176269bkj.187.1235116088036; Thu, 
	19 Feb 2009 23:48:08 -0800 (PST)
In-Reply-To: <bd6139dc0902190953m195a56ey47aa9bf535c4d77c@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/110810>

2009/2/19 Sverre Rabbelier <srabbelier@gmail.com>:
> On Thu, Feb 19, 2009 at 10:20, Yann Simon <yann.simon.fr@gmail.com> wrote:
>> I hope this send will not be whitespace damaged.
>
> You could of course send your patch inlined, but attach the patch as
> well if you fear your MUA will damage the patch. That way the patch
> can still be easily reviewed, and can be applied just as well.
>
> --
> Cheers,
>
> Sverre Rabbelier
>

I switched from STMP to IMAP.
Maybe it is the problem.
I will revert to SMTP and re-test the send.

Sorry for the trouble

Yann
