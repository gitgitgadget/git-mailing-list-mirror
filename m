From: Catalin Marinas <catalin.marinas@gmail.com>
Subject: Re: [StGIT PATCH] contrib/vim: Add vim syntax highlighting for StGit
 commit messages
Date: Wed, 24 Nov 2010 10:16:27 +0000
Message-ID: <AANLkTinBT9Hd2EA9Wqu4FjRDmc=DNCRsrqopb_n3KOkm@mail.gmail.com>
References: <20101123154538.12513.39180.stgit@zaneb-dl.ws.alliedtelesyn.co.nz>
	<AANLkTinS7LrG9ROy+3BLchWEi3=-7E0FFy+9_eJiaswW@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Zane Bitter <zane.bitter@alliedtelesis.co.nz>, git@vger.kernel.org
To: Chris Packham <judge.packham@gmail.com>
X-From: git-owner@vger.kernel.org Wed Nov 24 11:16:35 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PLCOw-0001Zk-19
	for gcvg-git-2@lo.gmane.org; Wed, 24 Nov 2010 11:16:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753121Ab0KXKQ3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 24 Nov 2010 05:16:29 -0500
Received: from mail-gw0-f46.google.com ([74.125.83.46]:44491 "EHLO
	mail-gw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753109Ab0KXKQ3 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 24 Nov 2010 05:16:29 -0500
Received: by gwj20 with SMTP id 20so657968gwj.19
        for <git@vger.kernel.org>; Wed, 24 Nov 2010 02:16:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type;
        bh=l5dTA18EUy1hiIrMwyHJkBUh2rD4BqGXCMA3eZswXxE=;
        b=tl/n5s/U2fcAjmYVGazTbI4s3j+U1wGnNw51qESRkJQhlRv5S5bjPCTHSwLCkVNcgy
         2EMnvd+nV2cDIM52+/MX6gXgVc+DrhJRCVaOa5wm8Lgz1zCb0BAXkLSio4GTFsXTzMpm
         N3VUaTvX9GBC8Ji88zSOY95jN++aKEwgeAsCY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=G4PSGxOUfp4ya6tTBd/XwzcKajnplb7ZLESX8PCIEcEkEoMcBG5IX6u7sAnT+MBPk7
         71zoiNPznV/0+jpJRIxgem3Cw2qNo97cjeynENsQNFVHsuCNZ8LUDydZWfV3y5k9fJsC
         S4+/UGfPLrU62FEqN+V6VfKvHULKEiDZYQ9Ac=
Received: by 10.90.21.21 with SMTP id 21mr560747agu.104.1290593787914; Wed, 24
 Nov 2010 02:16:27 -0800 (PST)
Received: by 10.231.148.72 with HTTP; Wed, 24 Nov 2010 02:16:27 -0800 (PST)
In-Reply-To: <AANLkTinS7LrG9ROy+3BLchWEi3=-7E0FFy+9_eJiaswW@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/162058>

On 24 November 2010 00:38, Chris Packham <judge.packham@gmail.com> wrote:
> On Wed, Nov 24, 2010 at 4:46 AM, Zane Bitter
> <zane.bitter@alliedtelesis.co.nz> wrote:
>>
>
> I'm not sure about how Catalin runs stgit, but in for git having a
> Signed-off-by: line is mandatory and usually indicates that the patch
> considered ready for inclusion and acts as the "developers certificate
> of authenticity" (i.e. it is the developers own work or the developer
> has based it on other compatibly licensed code).
>
> A commit message would also be nice but in this case I think it just
> does what it says on the tin.

That would be nice but I'm not usually rejecting patches on this basis.

> For the reviewers I can add that I've been using Zane's patch for a
> while now and it works well for me (although I'm not exactly a vim
> guru).

I can add a Tested-by then :)

-- 
Catalin
