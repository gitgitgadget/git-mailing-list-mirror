From: "Martin Langhoff" <martin.langhoff@gmail.com>
Subject: Re: [PATCH] Remove useless uses of cat, and replace with filename arguments or redirection
Date: Wed, 6 Jun 2007 18:38:09 +1200
Message-ID: <46a038f90706052338x775b18e1h2bdf0d8d120dd799@mail.gmail.com>
References: <46660F43.4060402@freedesktop.org>
	 <20070606133915.d72e4afe.git@ozlabs.org>
	 <87sl957naf.fsf@graviton.dyn.troilus.org>
	 <46a038f90706052058h1c823278o78ce0d8edce3caab@mail.gmail.com>
	 <20070606145436.b8907cf0.git@ozlabs.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: "Michael Poole" <mdpoole@troilus.org>,
	"Josh Triplett" <josh@freedesktop.org>, git@vger.kernel.org
To: "Stephen Rothwell" <git@ozlabs.org>
X-From: git-owner@vger.kernel.org Wed Jun 06 08:38:22 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hvp9w-0006ZC-SG
	for gcvg-git@gmane.org; Wed, 06 Jun 2007 08:38:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758958AbXFFGiL (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 6 Jun 2007 02:38:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757434AbXFFGiL
	(ORCPT <rfc822;git-outgoing>); Wed, 6 Jun 2007 02:38:11 -0400
Received: from wx-out-0506.google.com ([66.249.82.226]:31354 "EHLO
	wx-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758958AbXFFGiK (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 6 Jun 2007 02:38:10 -0400
Received: by wx-out-0506.google.com with SMTP id t15so44281wxc
        for <git@vger.kernel.org>; Tue, 05 Jun 2007 23:38:09 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=A2IZTg7i9KKzNA/1pbB8eU4Njw/hIIOCwOVq0cPvluRPnJ3veFA8lPU/6hHSgLi6hCq0lwtEp/M93TI4VEd2jugm5cp4e7SR2IoaPU6sYdax0wPmhivhuFKrA7CxacajsA8yFgjBKUia87+AKBGsL/eaj7/j86r5cEf3MOzQAMw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=lwV6xZ3oBfUNqSNUefwAJ+CWma2DMsM+cNutvs30fS7rOA547+pXgD/xuk4aAXz7KogGseMh5yPfxwN86JzKWihQ7Y6ALWZu7OibD7g7tj2Sc2a9rIMeZXUUFxavcNU2w+YljwymfKOUmJn+919e/dPDfKf00GWAVAMueA1fpj8=
Received: by 10.90.89.5 with SMTP id m5mr105277agb.1181111889695;
        Tue, 05 Jun 2007 23:38:09 -0700 (PDT)
Received: by 10.90.35.4 with HTTP; Tue, 5 Jun 2007 23:38:09 -0700 (PDT)
In-Reply-To: <20070606145436.b8907cf0.git@ozlabs.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/49248>

On 6/6/07, Stephen Rothwell <git@ozlabs.org> wrote:
> On Wed, 6 Jun 2007 15:58:09 +1200 "Martin Langhoff" <martin.langhoff@gmail.com> wrote:
> >
> > Josh is right. The output *is* different because it contains the
>   ^^^^
> My name is Stephen  :-) and that is indeed what I meant.

Sorry! Cross-eyed over the email thread, but not over posix behaviour ;-)

...cleans those glasses now


martin
