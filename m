From: "Thomas Adam" <thomas.adam22@gmail.com>
Subject: Re: Feature Request: Branch Annotations
Date: Wed, 8 Oct 2008 11:55:37 +0100
Message-ID: <18071eea0810080355g743c7bbfq9d7d39c9a76eb59d@mail.gmail.com>
References: <d2115f4f0810080341m27c4ca9bv9b1e9b66704ef3fa@mail.gmail.com>
	 <d2115f4f0810080348t62e18b14x1dfe798974332b05@mail.gmail.com>
	 <d2115f4f0810080349o30b6bc2labc2745b8d981e0d@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Rotem Yaari" <vmalloc@gmail.com>
X-From: git-owner@vger.kernel.org Wed Oct 08 12:56:51 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KnWio-0001MK-MR
	for gcvg-git-2@gmane.org; Wed, 08 Oct 2008 12:56:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754383AbYJHKzj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 8 Oct 2008 06:55:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754024AbYJHKzj
	(ORCPT <rfc822;git-outgoing>); Wed, 8 Oct 2008 06:55:39 -0400
Received: from nf-out-0910.google.com ([64.233.182.190]:31796 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753935AbYJHKzj (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 8 Oct 2008 06:55:39 -0400
Received: by nf-out-0910.google.com with SMTP id d3so1528089nfc.21
        for <git@vger.kernel.org>; Wed, 08 Oct 2008 03:55:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=gQ9/w/aJRc5aAMJ4Zyu7x2c+e1NVmGQlahdQP4BaR4U=;
        b=A7bjYdojpxAoCMaKY88YLCCoZ6RlO51H7QFykMMUBPTWY7actnv9SWeW8Xd9n4yeyg
         oCOJEEByn4oYkUr4XrC4Pa2fbN0UhUwE48PfRP77AsCO3HLWQkoT6RBkCVYNna4ndOVo
         OXb8FwKIWp0phtrItHAYtxCg/XHt4HYPBtNPQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=LKj5tOyTI3jcMDqwb3T9vC7Zs5e71818GvERzKRJ+AjIiPoNR4tkqOvXpctaF3YRYf
         e6+wE8MCbC+88QJWUMJD0WSP2cSafIRF6bgsx+MhxxQOos6SXT+DhB6JB63WCW86VbYN
         tpEgmVIL5JvOfz26unsVcyEBNBnwfPDC1xWqg=
Received: by 10.103.176.20 with SMTP id d20mr4306645mup.136.1223463337066;
        Wed, 08 Oct 2008 03:55:37 -0700 (PDT)
Received: by 10.103.182.8 with HTTP; Wed, 8 Oct 2008 03:55:37 -0700 (PDT)
In-Reply-To: <d2115f4f0810080349o30b6bc2labc2745b8d981e0d@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/97794>

2008/10/8 Rotem Yaari <vmalloc@gmail.com>:
> Hi,
>
> I usually work with many branches in git, each of which represents a
> different state of development/stability, but also development tasks
> assigned to me.
> Sometimes, besides the name of the branch, it could be useful to have
> a short description of a branch which quickly reminds me what that
> branch is intended for.
>
> Currently I see no way in git to achieve this (there's a description
> for a repository, but not for individual branches).
>
> Any opinions on this?

Wasn't this discussed here before, with a prototype?  ISTR it was, but
dropped due to lack of interest?  Have a look through the archives.

-- Thomas Adam
