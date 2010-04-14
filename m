From: Sverre Rabbelier <srabbelier@gmail.com>
Subject: Re: git log of remote repositories.
Date: Wed, 14 Apr 2010 22:11:22 +0200
Message-ID: <r2rfabb9a1e1004141311sa27dedf2h8bfff789a6ef1200@mail.gmail.com>
References: <u2n3abd05a91004131625k500e79bbsc8ffa6455a85332d@mail.gmail.com> 
	<slrnhsba0k.h9q.heipei@dualtron.heipei.net> <x2q3abd05a91004141208x6e154385l8b7ce6488d65f21b@mail.gmail.com> 
	<20100414194552.GA5178@dualtron.lan> <w2s3abd05a91004141305h28d69d44g2fcb69abe578dbcc@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Johannes Gilger <heipei@hackvalue.de>, git@vger.kernel.org
To: Aghiles <aghilesk@gmail.com>
X-From: git-owner@vger.kernel.org Wed Apr 14 22:11:54 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O28wA-0004lg-Lb
	for gcvg-git-2@lo.gmane.org; Wed, 14 Apr 2010 22:11:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756375Ab0DNULp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 14 Apr 2010 16:11:45 -0400
Received: from qw-out-2122.google.com ([74.125.92.24]:24683 "EHLO
	qw-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755795Ab0DNULo (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 Apr 2010 16:11:44 -0400
Received: by qw-out-2122.google.com with SMTP id 8so180229qwh.37
        for <git@vger.kernel.org>; Wed, 14 Apr 2010 13:11:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :from:date:received:message-id:subject:to:cc:content-type;
        bh=uPj7GP0dAyRoDK6xiiQ2EF+ZxkwSVFxqy+W/dMp4+b4=;
        b=j0mscOgP3v92QMOzpAZeshWOweNX3qP+FsIexmR7QW8E6x0pnp69AyRD4/eqVMcsC6
         utE5zway+XC5J6cHKFBQpf9hNhNJ8t6x+wTV+q8vWtZ54EthRcEykCVDfLTFMgsWiKWV
         JbrbEaBhcW2C0MOozHh3n8XrGI3sITbmEp0DM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        b=R6hPoG2L2D3IQQgLYd5KKvcyKeDWrjDsP06aSVWgCsXn7hhvrIyHyYPI6VzYazSBkq
         /NsieiKZWaH97yagoE5Ytd5+YxnWVIhWOyTV7Vq8i8IQgkXUWs/tUWxY7noYBNhKe0LS
         lKRWjpSEbXZUeeXISFgVa3FWHvNoXlrCgB86k=
Received: by 10.224.74.3 with HTTP; Wed, 14 Apr 2010 13:11:22 -0700 (PDT)
In-Reply-To: <w2s3abd05a91004141305h28d69d44g2fcb69abe578dbcc@mail.gmail.com>
Received: by 10.224.44.11 with SMTP id y11mr2801110qae.40.1271275902212; Wed, 
	14 Apr 2010 13:11:42 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/144901>

Heya,

On Wed, Apr 14, 2010 at 22:05, Aghiles <aghilesk@gmail.com> wrote:
> Having a sneak peek on what's going upstream seems like a natural
> thing to do, no ?

This can be done as said before, by fetching (which does not touch
your working copy, it only adds some objects to your store). Can you
explain what your hesitation to doing the fetch is? Are the objects
stored on the server (potentially) very large?

-- 
Cheers,

Sverre Rabbelier
