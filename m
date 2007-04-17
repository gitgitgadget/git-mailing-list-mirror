From: "Alex Riesen" <raa.lkml@gmail.com>
Subject: Re: GIT vs Other: Need argument
Date: Tue, 17 Apr 2007 16:39:41 +0200
Message-ID: <81b0412b0704170739te4c35f0m8e4a3cd5bad440cd@mail.gmail.com>
References: <aa69c80b0704170202r3f35acc7ydb81708e747c69ff@mail.gmail.com>
	 <46a038f90704170333t38992792m77ddb3d927b21842@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: "Pietro Mascagni" <pietromas@gmail.com>, git@vger.kernel.org
To: "Martin Langhoff" <martin.langhoff@gmail.com>
X-From: git-owner@vger.kernel.org Tue Apr 17 16:39:47 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HdoqQ-0007n0-A6
	for gcvg-git@gmane.org; Tue, 17 Apr 2007 16:39:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754425AbXDQOjm (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 17 Apr 2007 10:39:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754429AbXDQOjm
	(ORCPT <rfc822;git-outgoing>); Tue, 17 Apr 2007 10:39:42 -0400
Received: from an-out-0708.google.com ([209.85.132.244]:6735 "EHLO
	an-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754425AbXDQOjl (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 Apr 2007 10:39:41 -0400
Received: by an-out-0708.google.com with SMTP id b33so2238968ana
        for <git@vger.kernel.org>; Tue, 17 Apr 2007 07:39:41 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=ATmC5j669pSHigRwKkubVaTtg/VxLJizGjB8T5IKAB8mzHAfjGsbSLZBJEx+dUJUUrYXRSzFySywuE38NwWusHptZQ6UxfSCkFGtV1Fyq2SQFUX1NFX1yHwxsIALWBFiiPLbyes4L0/nliv+z7LROr+bU0Qvj743bjm5sM5apmo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=TAQZJWV2g43ilfcrFBoVlQAyBDtdz/wHoQ8s690n6xT3hanl/PBqURqfMw+/jqMRf5PcS2StMuZ7+eLqdnE1vEefQut0H2B9OoosaEr9/WEqlukCHwa+yibiDVTLCE7slrb3PCJ501BSQh5eRnFzDB7EnkmAgtdLg5zlaFwYBY8=
Received: by 10.100.144.11 with SMTP id r11mr5488526and.1176820781348;
        Tue, 17 Apr 2007 07:39:41 -0700 (PDT)
Received: by 10.100.86.19 with HTTP; Tue, 17 Apr 2007 07:39:41 -0700 (PDT)
In-Reply-To: <46a038f90704170333t38992792m77ddb3d927b21842@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/44774>

On 4/17/07, Martin Langhoff <martin.langhoff@gmail.com> wrote:
>
>  - Old school SCMs allow you to branch, but are unable to keep track
> of merges in any meaningful way. Every time you merge, history is
> lost. GIT (and other DSCMs) have excellent branching _and_ merging
> facilities.
>

This one was a bad argument too. Curiously, and I cannot explain why,
ability to branch is considered a weakness of GIT ("because it confuses
the integrators", them being old mean men). The Perforce is said to
be "vastly superior to everything" on these grounds: "it also has
branching support, but luckily(!) it is hard enough for simple
developers. Was not their (Perforce's) fault, they just included it
to keep up with the market". Almost exact wording (I had to translate it).
