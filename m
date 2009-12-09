From: Jay Soffian <jaysoffian@gmail.com>
Subject: Re: [PATCH] mergetool--lib: add diffmerge as a pre-configured 
	mergetool option
Date: Wed, 9 Dec 2009 15:14:23 -0800
Message-ID: <76718490912091514l16f6dd71g3f644ccf4ef5835c@mail.gmail.com>
References: <1260302477-49412-1-git-send-email-jaysoffian@gmail.com>
	 <20091209223409.GA32744@hashpling.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org, David Aguilar <davvid@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
To: Charles Bailey <charles@hashpling.org>
X-From: git-owner@vger.kernel.org Thu Dec 10 00:14:33 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NIVjr-00023B-S4
	for gcvg-git-2@lo.gmane.org; Thu, 10 Dec 2009 00:14:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758661AbZLIXOR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 9 Dec 2009 18:14:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758637AbZLIXOR
	(ORCPT <rfc822;git-outgoing>); Wed, 9 Dec 2009 18:14:17 -0500
Received: from mail-iw0-f171.google.com ([209.85.223.171]:55769 "EHLO
	mail-iw0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758561AbZLIXOQ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 9 Dec 2009 18:14:16 -0500
Received: by iwn1 with SMTP id 1so4963098iwn.33
        for <git@vger.kernel.org>; Wed, 09 Dec 2009 15:14:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type;
        bh=kIb6cqc2O7r0H6Y8srkZ7lo9M2LKt3zf5YPmaT5afjU=;
        b=mj9unFa4oM/fQi3UDbHJp2BuAGwpgQJ/6CgEaDAbXIfeKRWPcxVmerw9HQIQCVJBVC
         6zaBpSPAoj6nzrybNmbV28JuaE+FlVFP0cN+POP8X1acCnFFnF07DWTJOR2ECl7wUAWL
         mxG4TjLFcwaGTnMLKVBAuNqss+MaSY1Q9z4Is=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=VyplRFgIQvQFTL/6wPscSa88RM/XM/GpGwudJaY8GHxCOMK5cdW56uYsjFoecFK+is
         4RK9mUXWyTvdWfcDIX1uQScL/otrt75JHcinht7BUA0uJdDXHWFVLl8d7zCGZa2lrCTg
         NuK0W63QCFDM0/hghP3dGTF8ck5mmOanUQvr0=
Received: by 10.231.125.28 with SMTP id w28mr936975ibr.50.1260400463077; Wed, 
	09 Dec 2009 15:14:23 -0800 (PST)
In-Reply-To: <20091209223409.GA32744@hashpling.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/135005>

On Wed, Dec 9, 2009 at 2:34 PM, Charles Bailey <charles@hashpling.org> wrote:
> Is diffmerge free but not Free?

Correct, it's free as in beer, not as in speech. It is multi-platform
though (Linux, Windows, OS X). I've tested only on MacOS X. If someone
else wants to give it a test on Linux, that would be good. Looks like
there's both a deb and an rpm:

http://www.sourcegear.com/diffmerge/downloads.html

> Any reason for holding back on sign-off?

Oversight:

Signed-off-by: Jay Soffian <jaysoffian@gmail.com>

j.
