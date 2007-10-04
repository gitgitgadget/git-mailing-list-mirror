From: "Jon Smirl" <jonsmirl@gmail.com>
Subject: Re: stgit: editing description of patch
Date: Wed, 3 Oct 2007 22:14:20 -0400
Message-ID: <9e4733910710031914r766efa88pad9f55f9495d127e@mail.gmail.com>
References: <9e4733910710031626kff59666y77ba9001c0fef907@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: "Git Mailing List" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Oct 04 04:14:38 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IdGET-00054a-9I
	for gcvg-git-2@gmane.org; Thu, 04 Oct 2007 04:14:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756109AbXJDCOW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 3 Oct 2007 22:14:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755702AbXJDCOW
	(ORCPT <rfc822;git-outgoing>); Wed, 3 Oct 2007 22:14:22 -0400
Received: from nz-out-0506.google.com ([64.233.162.232]:17459 "EHLO
	nz-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755145AbXJDCOV (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Oct 2007 22:14:21 -0400
Received: by nz-out-0506.google.com with SMTP id s18so18580nze
        for <git@vger.kernel.org>; Wed, 03 Oct 2007 19:14:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=ryH6DYqhqWDIQyZH2BS6KDck6Bs+IrG0hy881jkFJIw=;
        b=oWWlKnkLq2wR7GEXqF5/cKBUpHyuGU5Y87Ip4jQEK/HI8ydAKhyGp4pvU9msY45FsKT/jE5gCRmiQXTdnOGZYdtee/k1jOxOHBU1UYK9r/QCdG4TKdk/iKofv1wGyruFrav/9J1jrdHL59iJYiCuDx20+Xp54vFzujS9Pd7nd64=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=q6UmE+5VTyxK/P0NkWvMrzWmAfCOVFkzi1PKBoLndB2HbDf2LH/3MG+3cCU0yt3Rd4o8Ja/pfOvCSDegUyR4WpLZI4sGdyM8d/qeEuKVoNwQgE+omTLIj+LF4b+iKACbZd+WtlH0owHX63iJkwyeX2QbnPdTcWh2vMiX4MVCcvg=
Received: by 10.114.58.1 with SMTP id g1mr1832358waa.1191464060134;
        Wed, 03 Oct 2007 19:14:20 -0700 (PDT)
Received: by 10.114.195.11 with HTTP; Wed, 3 Oct 2007 19:14:20 -0700 (PDT)
In-Reply-To: <9e4733910710031626kff59666y77ba9001c0fef907@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/59917>

On 10/3/07, Jon Smirl <jonsmirl@gmail.com> wrote:
> What is the right procedure for editing the various attributes of a
> stgit patch? patch name, description, etc....  I just emailed a series
> to myself and the titles/comments are all messed up.

Editing these is done with the stg refresh command.

>
> On my box all of the patches have names -- stg series shows them. But
> when I emailed them half of the patch didn't have the right subjects.

this is controled in the template files

>
> --
> Jon Smirl
> jonsmirl@gmail.com
>


-- 
Jon Smirl
jonsmirl@gmail.com
