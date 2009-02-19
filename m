From: Jay Soffian <jaysoffian@gmail.com>
Subject: Re: git rebase -i
Date: Thu, 19 Feb 2009 16:07:32 -0500
Message-ID: <76718490902191307h39e4dd02nafb8ef02d670dc57@mail.gmail.com>
References: <43d8ce650902190121v2e18aac1rfaa64a4ce6e799a3@mail.gmail.com>
	 <76718490902191255w24b30bd8jacaed8aa919d6526@mail.gmail.com>
	 <alpine.DEB.1.00.0902192203280.6223@intel-tinevez-2-302>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: John Tapsell <johnflux@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Thu Feb 19 22:09:04 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LaG8k-0003MS-M2
	for gcvg-git-2@gmane.org; Thu, 19 Feb 2009 22:09:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754110AbZBSVHe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 19 Feb 2009 16:07:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753565AbZBSVHe
	(ORCPT <rfc822;git-outgoing>); Thu, 19 Feb 2009 16:07:34 -0500
Received: from rv-out-0506.google.com ([209.85.198.233]:15467 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751752AbZBSVHd (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 19 Feb 2009 16:07:33 -0500
Received: by rv-out-0506.google.com with SMTP id g37so586916rvb.1
        for <git@vger.kernel.org>; Thu, 19 Feb 2009 13:07:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=9/7u8/8mU1EorLSqAcq+phxPWP+/8BhHx93fFyms/qw=;
        b=PwJAwEhyev6gT0nGcAfYJjX5YetUXapEp6RGrEZoL2cCBEC3kHqPWvhQ2EqLIEmCIL
         jQF+iWTi/maXGt5j8asWQC2RXADy8nhmSwXxE2RLgWnMAOd7Fo8EuH9reNjCpKdySxRV
         1y6ur1tFLdfW0LuDGq6Q2BgVy/HAuA8jXM3L0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=RdSl3gjyv0Tgd2fZPMCkmYiVwshYoVKHTSg3MoMFkP4t3c9K8rsxcKv8p5R44hc1LJ
         qkJmBgYUPKguUkrKTrcnIJmQeAllWZxDWLKDI+zouUomrZgnZlQPsrSVtblmOWYywFSU
         LYwDQRjjGjQv0vHWYbq1AGFGIStLsD0NJjWWU=
Received: by 10.141.133.14 with SMTP id k14mr2634rvn.98.1235077652689; Thu, 19 
	Feb 2009 13:07:32 -0800 (PST)
In-Reply-To: <alpine.DEB.1.00.0902192203280.6223@intel-tinevez-2-302>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/110752>

On Thu, Feb 19, 2009 at 4:04 PM, Johannes Schindelin
<Johannes.Schindelin@gmx.de> wrote:
> You think -10 would be the same as HEAD~10?

I think it would mean the same thing to rebase as it does to format-patch.

I will now admit I haven't thought about what it means to format-patch
if there are merges. :-)

j.
