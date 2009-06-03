From: Sverre Rabbelier <srabbelier@gmail.com>
Subject: Re: state of libgit2?
Date: Wed, 3 Jun 2009 10:21:51 +0200
Message-ID: <fabb9a1e0906030121v1aaa8315paeda9e9ef3062399@mail.gmail.com>
References: <200906030822.15516.thomas@koch.ro>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: thomas@koch.ro
X-From: git-owner@vger.kernel.org Wed Jun 03 10:29:34 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MBlqk-0000sO-CI
	for gcvg-git-2@gmane.org; Wed, 03 Jun 2009 10:29:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753915AbZFCI3T (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 3 Jun 2009 04:29:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753668AbZFCI3S
	(ORCPT <rfc822;git-outgoing>); Wed, 3 Jun 2009 04:29:18 -0400
Received: from mail-ew0-f162.google.com ([209.85.219.162]:62445 "EHLO
	mail-ew0-f162.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753301AbZFCI3R (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Jun 2009 04:29:17 -0400
X-Greylist: delayed 426 seconds by postgrey-1.27 at vger.kernel.org; Wed, 03 Jun 2009 04:29:16 EDT
Received: by ewy6 with SMTP id 6so25457ewy.37
        for <git@vger.kernel.org>; Wed, 03 Jun 2009 01:29:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :from:date:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=3kGRF0LLxw1mSXsqAhZ68pI8VsQlXgrB/o/qqCMx7Fw=;
        b=HnMFuMF/ap2pYnK07ldCpuPXj0XGgncNgVOM5+6243EjUrs8wd6yotIadWoZ2aEvxr
         D9sNUcyTuZvFXlAOdy/jAELnJuc8S+PciUIReeFwhHO96BoBkS9On/iRItrAQEJ6JB8s
         SSf4KOn6Xs60zVqh6dVajB/ttwEEuefmrBRLs=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=x5OOp0fAPPRk6xHD8WAdulx0tRH1U/qJKW19NXwZ5v549+fcmwsr6q1kJJ+bTZGEv4
         8pNMF6Zj8eN0Dd39HZk1yWBcY5zPBPXVzLS9K0vY5Gg01xcrG4eVRTJyPIxLckLG9unq
         NWfxacswTGL04OdlXgOGv200XI7NHD/Xjei2k=
Received: by 10.216.53.196 with SMTP id g46mr226221wec.63.1244017331126; Wed, 
	03 Jun 2009 01:22:11 -0700 (PDT)
In-Reply-To: <200906030822.15516.thomas@koch.ro>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/120592>

Heya,

On Wed, Jun 3, 2009 at 08:22, Thomas Koch <thomas@koch.ro> wrote:
> Just want to show, that there is interest in the state and roadmap for
> libgit2. If I understand right, libgit2 is necessary to get GIT bindings in
> scripting languages like PHP, Python, etc.

As you can see from [0] the development on libgit2 is stalled, I'm
assuming due to lack of developer time.

[0] http://repo.or.cz/w/libgit2.git

-- 
Cheers,

Sverre Rabbelier
