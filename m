From: Avery Pennarun <apenwarr@gmail.com>
Subject: Re: RFD: best way to automatically rewrite a git DAG as a linear 
	history?
Date: Fri, 19 Feb 2010 22:05:46 -0500
Message-ID: <32541b131002191905u59a90866he0a38dfc661d45d2@mail.gmail.com>
References: <2cfc40321002171835j107d2cdcr5f7667d769bf391e@mail.gmail.com> 
	<20100218051129.GD10970@coredump.intra.peff.net> <2cfc40321002181704i73eb87demd03faaddf9bb108@mail.gmail.com> 
	<32541b131002181913t24989addr84b612787a2f8c48@mail.gmail.com> 
	<2cfc40321002182329q7b8c5b90nbd77a4e0678cd9c8@mail.gmail.com> 
	<32541b131002191220q5a0eae6dk304173418f818ff3@mail.gmail.com> 
	<2cfc40321002191825i605e5045w6f52f9f044a5d369@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Git Mailing List <git@vger.kernel.org>
To: Jon Seymour <jon.seymour@gmail.com>
X-From: git-owner@vger.kernel.org Sat Feb 20 04:06:16 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Niffc-0008SD-Eu
	for gcvg-git-2@lo.gmane.org; Sat, 20 Feb 2010 04:06:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755768Ab0BTDGM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 19 Feb 2010 22:06:12 -0500
Received: from mail-gx0-f217.google.com ([209.85.217.217]:44019 "EHLO
	mail-gx0-f217.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754594Ab0BTDGK (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 19 Feb 2010 22:06:10 -0500
Received: by gxk9 with SMTP id 9so876200gxk.8
        for <git@vger.kernel.org>; Fri, 19 Feb 2010 19:06:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :from:date:message-id:subject:to:cc:content-type;
        bh=22WmMczJQeYbDDtL1znu32DXRO7uUehx3CjrBWs5wmQ=;
        b=wz591IVELgt7LP0Yjll1S4dc1pU7r/93j8BqZ3tpmzZVIlfL5YhXzcyGO+RUitLpld
         KjL2lEh3HLwuQrjkdAU2AcePZehzU68oVfVsk+AXrZsBn262OZn4672x2kGVUU9j5Jny
         +OuIcQ8eo7nJ2rWdyajqSollVtiyLucjD8dP4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        b=odvHmhwonzL4n5Ghfs6BXzRnnsFXVYoz65vNLHjOeD8kqyiQ6qKjugNsWlDyExzPeJ
         dSpY4XJ3PLUkJ+xxXAgXlcYJ5Y8xerw+Y+XIJyNM/8VhJXdgqe5hEx9A2Sc19p94Ac80
         WysIXo/idIimiTx5umAjIFOI4eYKQnipob8ws=
Received: by 10.150.25.22 with SMTP id 22mr2349501yby.106.1266635166241; Fri, 
	19 Feb 2010 19:06:06 -0800 (PST)
In-Reply-To: <2cfc40321002191825i605e5045w6f52f9f044a5d369@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/140511>

On Fri, Feb 19, 2010 at 9:25 PM, Jon Seymour <jon.seymour@gmail.com> wrote:
> (A hammer is, of course, a reasonably good tool for making things flat
> although it does tend to break things along the way).

Nice analogy.  Well, thanks for the clarification and best of luck in
your slightly crazy project :)

Have fun,

Avery
