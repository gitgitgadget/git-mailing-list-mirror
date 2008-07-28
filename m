From: "Jon Smirl" <jonsmirl@gmail.com>
Subject: Re: short log and email address
Date: Mon, 28 Jul 2008 14:25:23 -0400
Message-ID: <9e4733910807281125m7e555377l89cb57dff0f57ee2@mail.gmail.com>
References: <9e4733910807281106y56f8b67ao86f78822c4b4ad58@mail.gmail.com>
	 <20080728181101.GA9148@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Git Mailing List" <git@vger.kernel.org>
To: "Mark Brown" <broonie@sirena.org.uk>
X-From: git-owner@vger.kernel.org Mon Jul 28 20:26:41 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KNXQV-0000Xa-S2
	for gcvg-git-2@gmane.org; Mon, 28 Jul 2008 20:26:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756054AbYG1SZ0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 28 Jul 2008 14:25:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755797AbYG1SZZ
	(ORCPT <rfc822;git-outgoing>); Mon, 28 Jul 2008 14:25:25 -0400
Received: from qw-out-2122.google.com ([74.125.92.24]:60419 "EHLO
	qw-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755657AbYG1SZY (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 Jul 2008 14:25:24 -0400
Received: by qw-out-2122.google.com with SMTP id 3so272208qwe.37
        for <git@vger.kernel.org>; Mon, 28 Jul 2008 11:25:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=+E0GlLi+V6IJu2ohN6FGJo37Ua/+N8WHf/ca2AytXeg=;
        b=lNJHVtKAsOcIipz2uM/B6FdA8uVViFJEeanFfHjwa2fZ3Dc3n1/deN1WP+XWIBnwe0
         gKAoPpbYUi1w1j2aTjP5hcwfIvtlckCcSOaFF6XjLaV5zcwNc1zYOpFEiktiTxrlz0OL
         i5Fs/+qSew3aE2LE47euytWnaM9BXohwQ1EzE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=SHI/7PUk6YvKsMAkDYxbXg26tLM353O7JsuYtHQ/jJxBBAlbsml/5XQnruekQlxllm
         WL0eOqrBrJ1MJMwZxa001g3xrYkXt0CfAclJThh9DPrOYahm1u6oP3OlZtYIyQa2Z7N+
         HcPpgRj91FJUIr3onojNiM9A9qOTnyGik2EoA=
Received: by 10.215.14.10 with SMTP id r10mr166573qai.48.1217269523297;
        Mon, 28 Jul 2008 11:25:23 -0700 (PDT)
Received: by 10.150.205.1 with HTTP; Mon, 28 Jul 2008 11:25:23 -0700 (PDT)
In-Reply-To: <20080728181101.GA9148@sirena.org.uk>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/90483>

On 7/28/08, Mark Brown <broonie@sirena.org.uk> wrote:
> On Mon, Jul 28, 2008 at 02:06:06PM -0400, Jon Smirl wrote:
>  > Using the -e option in shortlog changes the results by spitting things
>  > out by email address instead of leaving them combined  by name. That's
>  > probably not what you want. Instead you want everything combined by
>  > name and then display the most recent email address used.
>
> Apart from anything else you're assuming that people's names are
>  globally unique - they aren't.  I'm aware of several Mark Browns active
>  in the free software world, for example.

There is a conflicting problem, multiple people with the same name and
people using multiple email addresses. The only solution I can see is
for the Mark Brown developers to get together and come up with a way
to differentiate their signatures (initial, nickname, etc), otherwise
I can't tell them apart from someone using multiple email addresses.

Mark Brown <broonie@opensource.wolfsonmicro.com>
Mark Brown <broonie@sirena.org.uk>

Same or two different people? These two names have committed to the kernel.

-- 
Jon Smirl
jonsmirl@gmail.com
