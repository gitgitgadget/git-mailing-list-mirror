From: "Dana How" <danahow@gmail.com>
Subject: Re: GIT vs Other: Need argument
Date: Wed, 25 Apr 2007 01:58:05 -0700
Message-ID: <56b7f5510704250158v5d80feb7gb82db0da2349eb8f@mail.gmail.com>
References: <aa69c80b0704170202r3f35acc7ydb81708e747c69ff@mail.gmail.com>
	 <46a038f90704170333t38992792m77ddb3d927b21842@mail.gmail.com>
	 <81b0412b0704170739te4c35f0m8e4a3cd5bad440cd@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: "Martin Langhoff" <martin.langhoff@gmail.com>,
	"Pietro Mascagni" <pietromas@gmail.com>, git@vger.kernel.org,
	danahow@gmail.com
To: "Alex Riesen" <raa.lkml@gmail.com>
X-From: git-owner@vger.kernel.org Wed Apr 25 10:58:28 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HgdKU-0007eO-P8
	for gcvg-git@gmane.org; Wed, 25 Apr 2007 10:58:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423324AbXDYI6L (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 25 Apr 2007 04:58:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423330AbXDYI6K
	(ORCPT <rfc822;git-outgoing>); Wed, 25 Apr 2007 04:58:10 -0400
Received: from nz-out-0506.google.com ([64.233.162.237]:3635 "EHLO
	nz-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1423324AbXDYI6I (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 25 Apr 2007 04:58:08 -0400
Received: by nz-out-0506.google.com with SMTP id o1so199963nzf
        for <git@vger.kernel.org>; Wed, 25 Apr 2007 01:58:06 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=iYJqHUI2yRXX+6IZyMpowha2lUTnmmeAlHzEKe7XJyBvPxL+5W4Q2/9prYSExs4+bZmb0UDCRqai5rJbOK0Afhac3Yf+pgG5JC8raXsqOZjqtU6FEsTjG8u7P79XEI4ReSMOJHWZYBfRB4vEovxue0HsRCGuMn3k2GgPhH7/l4U=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=g1ilYkbWfaIu5KohVTSCr18EsYrbfOxIwL3WFz9aZ+0K7+0WlyF8KoOQmWscXUfUyMeR4RyYdbD93dIcgcfLthPBN1YLbruz211bp8fXlWj9Zs3MKN38TTnKQSw4eEzS991MA+RGQeh+JIbFu5hIFZxoUJu0GGazvXivkemK2+I=
Received: by 10.114.77.1 with SMTP id z1mr141486waa.1177491485650;
        Wed, 25 Apr 2007 01:58:05 -0700 (PDT)
Received: by 10.115.58.20 with HTTP; Wed, 25 Apr 2007 01:58:05 -0700 (PDT)
In-Reply-To: <81b0412b0704170739te4c35f0m8e4a3cd5bad440cd@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/45514>

On 4/17/07, Alex Riesen <raa.lkml@gmail.com> wrote:
> On 4/17/07, Martin Langhoff <martin.langhoff@gmail.com> wrote:
> >  - Old school SCMs allow you to branch, but are unable to keep track
> > of merges in any meaningful way. Every time you merge, history is
> > lost. GIT (and other DSCMs) have excellent branching _and_ merging
> > facilities.
> This one was a bad argument too. Curiously, and I cannot explain why,
> ability to branch is considered a weakness of GIT ("because it confuses
> the integrators", them being old mean men). The Perforce is said to
> be "vastly superior to everything" on these grounds: "it also has
> branching support, but luckily(!) it is hard enough for simple
> developers. Was not their (Perforce's) fault, they just included it
> to keep up with the market". Almost exact wording (I had to translate it).

You are also trying to gain traction in a Perforce environment?
I'd be interested in any more details you might have;
I'm just starting.  Email me directly if you like.

Thanks,
-- 
Dana L. How  danahow@gmail.com  +1 650 804 5991 cell
