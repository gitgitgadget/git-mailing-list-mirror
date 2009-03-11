From: saurabh gupta <saurabhgupta1403@gmail.com>
Subject: Re: Google Summer of Code 2009: GIT
Date: Wed, 11 Mar 2009 14:32:34 +0530
Message-ID: <ab9fa62a0903110202y743767c6v372bedf9e1b9a11@mail.gmail.com>
References: <49B74373.3090609@gmail.com>
	 <ee77f5c20903110159l1cda4c3dnc9588c1352905932@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: David Symonds <dsymonds@gmail.com>
X-From: git-owner@vger.kernel.org Wed Mar 11 10:04:19 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LhKMG-0003rh-J4
	for gcvg-git-2@gmane.org; Wed, 11 Mar 2009 10:04:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752527AbZCKJCi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 11 Mar 2009 05:02:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752513AbZCKJCh
	(ORCPT <rfc822;git-outgoing>); Wed, 11 Mar 2009 05:02:37 -0400
Received: from mail-gx0-f167.google.com ([209.85.217.167]:48916 "EHLO
	mail-gx0-f167.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752322AbZCKJCh (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 Mar 2009 05:02:37 -0400
Received: by gxk11 with SMTP id 11so1814710gxk.13
        for <git@vger.kernel.org>; Wed, 11 Mar 2009 02:02:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=tg5V6s7Sz/x98av6FqQtfKgJN8ye7oaCO+gPLO21zng=;
        b=OyUSvPNbsWxrR7WHq4fL1rg6Fi4BvVsvfhlRGq6opQUfwbJyB8Y6ZDee7SPPrNCnFE
         IQIQL1y+Is16XmqyaZKyQnY/snqT0aydwkkfow+sfvZtjrrbR1h4DqlkwAFIph/4qWIP
         u0R8uDW99o9GYz0hmzXfRkA//Qhgvr7W49fIA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=kHa1WQoBB+BTodw/AF+AsKIBbIP289RbnXfpwmZrF3Y7RxyIbewQFVABrCN98NDI95
         dJms36FVibQL33oAkG1fzQVKjpNe/Bh7m2l0FmzS8fOPM99Js8SpKG18bD1tH4hyPSJl
         fCKb9n0K24qhieMLmTT7Aveyh9ojC8XvW4l8Q=
Received: by 10.231.10.140 with SMTP id p12mr1937440ibp.50.1236762154646; Wed, 
	11 Mar 2009 02:02:34 -0700 (PDT)
In-Reply-To: <ee77f5c20903110159l1cda4c3dnc9588c1352905932@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/112895>

On Wed, Mar 11, 2009 at 2:29 PM, David Symonds <dsymonds@gmail.com> wrote:
>
> On Wed, Mar 11, 2009 at 3:52 PM, Saurabh Gupta
> <saurabhgupta1403@gmail.com> wrote:
>
> > *1) Domain specific merge helpers*
> > Intelligence in the merger can be put which modifies the source file
> > according the format. Different file formats can be put in the merger
> > to support.
>
> I don't think that's Git specific, though it still might be reasonable
> to be done as a Git GSoC project. I'm sure other VCSs would find that
> useful, and even folk who aren't using VCSs might benefit from it.

All right.
Can you suggest me another idea or any aim which GIT will mostly be
interested in. I am also looking over other ideas and areas where more
improvement can be put.

Thanks...


>
> Dave.



--
Saurabh Gupta
Senior,
Electronics and Communication Engg.
NSIT,New Delhi, India
