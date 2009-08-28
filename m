From: Avery Pennarun <apenwarr@gmail.com>
Subject: Re: [PATCH] Fix overridable written with an extra 'e'
Date: Fri, 28 Aug 2009 15:15:29 +0000
Message-ID: <32541b130908280815y78f95140re679c336fbd17443@mail.gmail.com>
References: <20090828121849.6117@nanako3.lavabit.com> <20090828034305.GQ4297@inocybe.localdomain> 
	<7v63c8a69a.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Todd Zullinger <tmz@pobox.com>,
	Nanako Shiraishi <nanako3@lavabit.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Aug 28 17:16:20 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Mh3Ba-0007Ce-LJ
	for gcvg-git-2@lo.gmane.org; Fri, 28 Aug 2009 17:16:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752100AbZH1PPs convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 28 Aug 2009 11:15:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752425AbZH1PPs
	(ORCPT <rfc822;git-outgoing>); Fri, 28 Aug 2009 11:15:48 -0400
Received: from mail-gx0-f205.google.com ([209.85.217.205]:48688 "EHLO
	mail-gx0-f205.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752415AbZH1PPr convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 28 Aug 2009 11:15:47 -0400
Received: by gxk1 with SMTP id 1so2499628gxk.17
        for <git@vger.kernel.org>; Fri, 28 Aug 2009 08:15:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :from:date:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=Qr6mqrQQKV9ui4PRCpZ+3KvAJ4NwhGAQsPaTMB9eGFY=;
        b=pxwb4AwBOip4ZgQWbCi/3fzNfT1TpkvDMTcfof9mnyjrQubPnKhZp0plrYq5mJ4YWQ
         IYbNuYQQHsOBJn+g4EI6CIbZ8zRagXiGNqNN+j1Ag8nm9rYCvEs6q+vh6WHl8louCeuT
         FlvL8RBYXa4gJMFB8CmN/1eg4Knlqk85fREk4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=vDrdOcf0pgkeyweW1bl+T7JGTcxU2l1s4Nx3hHwz5DzKzDP2pkwnAnvoRu8REQXTEs
         VUcekZyNJMTeSw/rWX1Nvwcvg+rTahjBOqmqKa5N6frL0eAg4X+MHtKijwnPCKTLHmgg
         KWp+2dQ5mHxx0FykeTSSwEuKmPooErERKQCfY=
Received: by 10.150.8.14 with SMTP id 14mr2416369ybh.52.1251472549058; Fri, 28 
	Aug 2009 08:15:49 -0700 (PDT)
In-Reply-To: <7v63c8a69a.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/127302>

On Fri, Aug 28, 2009 at 4:53 AM, Junio C Hamano<gitster@pobox.com> wrot=
e:
> Hmph, I don't know. =A0Googling "overrideable" suggests "Did you mean
> overridable?" which is enough clue for me.

Using a similar system, the Google hit count:

overrideable: 26,900
overridable: 339,000
overridden: 2,280,000

Which agrees with my intuition that you can get away with overridable,
but it's much more common to just use overridden.

"override" of course comes from "ride" (181,000,000).  A horse can be
ridden (10,500,000) if it's ridable (82,500).

The bad news: rideable (201,000).

http://www.merriam-webster.com/dictionary/ridable shows rideable as
the preferred spelling, but accepts both.

Have fun,

Avery
