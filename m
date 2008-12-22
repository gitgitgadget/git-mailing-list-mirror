From: "Tim Visher" <tim.visher@gmail.com>
Subject: Re: 'Theirs' merge between branches on a binary file.
Date: Mon, 22 Dec 2008 17:58:39 -0500
Message-ID: <c115fd3c0812221458q3444cbcai7ab1716b9195ad08@mail.gmail.com>
References: <c115fd3c0812221256l494bb824ga8e1640efb07b20c@mail.gmail.com>
	 <7vr63zhq4k.fsf@gitster.siamese.dyndns.org>
	 <c115fd3c0812221316y24ce0c7q29807cd349a99e83@mail.gmail.com>
	 <7vd4fjhlf8.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Junio C Hamano" <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Dec 23 00:00:23 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LEtky-00056B-Js
	for gcvg-git-2@gmane.org; Tue, 23 Dec 2008 00:00:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755032AbYLVW6m (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 22 Dec 2008 17:58:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755650AbYLVW6l
	(ORCPT <rfc822;git-outgoing>); Mon, 22 Dec 2008 17:58:41 -0500
Received: from mail-gx0-f27.google.com ([209.85.217.27]:59853 "EHLO
	mail-gx0-f27.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754643AbYLVW6k (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 22 Dec 2008 17:58:40 -0500
Received: by gxk8 with SMTP id 8so1917161gxk.13
        for <git@vger.kernel.org>; Mon, 22 Dec 2008 14:58:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=ALxWGtZMa7nSSpaE/mQ4oRrIiMvk/vFlzf+AiFuyM30=;
        b=eYLA3D207kgeDuuMmlLv2OnGoZhy2enQF2rDVmzgXNflvnyl2gWaJOg80NBT/IeGwY
         lEJeWth/1BdbOo4XWv1KFE/yXBMh81iG6trIQWQPiX9QzG5bEDTE/cWBTVI6+PpCRpPC
         WBG5YIjrhzs9wKARScoOe9epVBHeIr+6tpACk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=ftjiORFeKVzEwmnmG+G4o7TcR3T+iDWcxIqrpzqmZUcLOaRnHuKiGk4GVWoDZ0Cv44
         kNft9uDVSN9qFGtQDQLtdZjaAPUNKS0KxJYFHHcl48PNx0NfQ4Pbhl9zCDUglZ4oDUCV
         qzliWxZaNQ5O4hTyvJOpMYDUgBAhT8u/1+W/M=
Received: by 10.100.173.18 with SMTP id v18mr4192736ane.17.1229986719452;
        Mon, 22 Dec 2008 14:58:39 -0800 (PST)
Received: by 10.100.198.2 with HTTP; Mon, 22 Dec 2008 14:58:39 -0800 (PST)
In-Reply-To: <7vd4fjhlf8.fsf@gitster.siamese.dyndns.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/103778>

On Mon, Dec 22, 2008 at 5:52 PM, Junio C Hamano <gitster@pobox.com> wrote:

> That sounds like "git checkout --theirs"...

I'm sorry, Junio.  I don't mean to be dense but I can't find that in
the docs and when I execute it it comes back as an unknown command.
Perhaps you could just point me to the relevant man page?  This seems
like such a fundamental operation, I just don't understand why there
isn't something like a `git resolve`.

Thanks for your help!

-- 

In Christ,

Timmy V.

http://burningones.com/
http://five.sentenc.es/ - Spend less time on e-mail
