From: "Marco Costalba" <mcostalba@gmail.com>
Subject: Re: [PATCH 1/3] Wrap the log text in some nice HTML to highlight the commit message
Date: Sun, 18 Feb 2007 08:25:14 +0100
Message-ID: <e5bfff550702172325w32f980b3x58b05face97ec7d2@mail.gmail.com>
References: <200702172200.13461.andyparkins@gmail.com>
	 <200702172202.25730.andyparkins@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Andy Parkins" <andyparkins@gmail.com>
X-From: git-owner@vger.kernel.org Sun Feb 18 08:25:21 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HIgQD-0005Xq-BY
	for gcvg-git@gmane.org; Sun, 18 Feb 2007 08:25:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030396AbXBRHZS (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 18 Feb 2007 02:25:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161086AbXBRHZS
	(ORCPT <rfc822;git-outgoing>); Sun, 18 Feb 2007 02:25:18 -0500
Received: from nz-out-0506.google.com ([64.233.162.231]:32585 "EHLO
	nz-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1030396AbXBRHZQ (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 18 Feb 2007 02:25:16 -0500
Received: by nz-out-0506.google.com with SMTP id s1so1360553nze
        for <git@vger.kernel.org>; Sat, 17 Feb 2007 23:25:16 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=tN5CuQZyXeAmE3a1c3ksTRuroPvhgWRkJz+W0joNA0bL6slu60DQY0Z9DTaPEzxuIYZtD7+0gQaOyzEltfg9g3ZaoOMkcf2LtFDSB9NY4Cv6TxN3Vnlxn2GPGRZuRcOY+YCyhp2iwWIkJQaXpIKjCwAGyYfI+57AeGDi6Mhf+NU=
Received: by 10.114.254.1 with SMTP id b1mr2502605wai.1171783514971;
        Sat, 17 Feb 2007 23:25:14 -0800 (PST)
Received: by 10.114.60.16 with HTTP; Sat, 17 Feb 2007 23:25:14 -0800 (PST)
In-Reply-To: <200702172202.25730.andyparkins@gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/40060>

On 2/17/07, Andy Parkins <andyparkins@gmail.com> wrote:
> On Saturday 2007, February 17, Andy Parkins wrote:
> > Signed-off-by: Andy Parkins <andyparkins@gmail.com>
> > ---
> > Hey Marco; I've finally got around to rebasing.  The problem I had
> > was an error in my .git/config was making git-fetch just return
> > without fetching so I wasn't getting your new master head.
>
> Apologies all: this and following patches should have been marked qgit4;
> not mainline git.
>

Hi Andy,

thanks for your patches, but I can see only this email and the '[PATCH
2/3] Improve default column widths by changing resize modes', I miss
body of [PATCH 1/3]  and  [PATCH 3/3].

Please take a look at http://marc.theaimsgroup.com/?l=git&r=1&b=200702&w=2
to see what's landed on git list.

Marco

P.S: I will be on travel next week, so I won't be able to connect regularly.
