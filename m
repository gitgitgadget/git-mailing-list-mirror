From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: Can git pull from a mercurial repository?
Date: Wed, 17 Oct 2012 15:29:30 +0200
Message-ID: <CAMP44s1F63K3k_Z-nyFx9-q7YYiOfFjadmaJGOYa4sLsGbmP8w@mail.gmail.com>
References: <k39lir$gpm$1@ger.gmane.org>
	<50585F10.3080307@op5.se>
	<000a01cd959a$d8cd0730$8a671590$@schmitz-digital.de>
	<37D17798-4BDC-433D-A9B4-49F4352754D9@quendi.de>
	<CAMP44s2DtMfeDQqgQfBamC3ZpbssnRrzveqP5nQ6Sehaw4+oVQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Joachim Schmitz <jojo@schmitz-digital.de>,
	Andreas Ericsson <ae@op5.se>, git@vger.kernel.org
To: Max Horn <postbox@quendi.de>
X-From: git-owner@vger.kernel.org Wed Oct 17 15:29:50 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TOTgt-0004X1-Cu
	for gcvg-git-2@plane.gmane.org; Wed, 17 Oct 2012 15:29:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756763Ab2JQN3c (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 17 Oct 2012 09:29:32 -0400
Received: from mail-oa0-f46.google.com ([209.85.219.46]:36184 "EHLO
	mail-oa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755134Ab2JQN3b (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 17 Oct 2012 09:29:31 -0400
Received: by mail-oa0-f46.google.com with SMTP id h16so7386223oag.19
        for <git@vger.kernel.org>; Wed, 17 Oct 2012 06:29:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=e+GFZonwvt31Sh1BB04SWYoHbBjbc+xDi7S67zA5v2w=;
        b=eZc+XRX9zJgqU/mcuMjDHUt/drO1+hSOaXNF5XkR96+E6dtXAjIIMkKH7kR2sMnUMR
         GnE76UaebqU7nRRLS/CzL3ULb7Bh8e/YOPUH1lw4RwXouACTeNaMiyzNHz5V1Mmpki+J
         dUqhkOifZvs8ButwQyOttUQmJwYxzyKbGN72/AVUf7StdFNsP1MbW4jp6OPBCn7/Fi7A
         4oVAMz66awdzR3FIwDcs8rBH6VqWQcPNYg3Vau9Hd07hCe/qNzNgP47/t+sXUZXWZYCP
         sdauRkpT0HItB760f/vfrd8DELFOZC5TFgEpn7hjx2cCGVFYrzqO5THFyH0asGbauU9h
         lB0Q==
Received: by 10.60.31.241 with SMTP id d17mr6144464oei.107.1350480570712; Wed,
 17 Oct 2012 06:29:30 -0700 (PDT)
Received: by 10.60.58.137 with HTTP; Wed, 17 Oct 2012 06:29:30 -0700 (PDT)
In-Reply-To: <CAMP44s2DtMfeDQqgQfBamC3ZpbssnRrzveqP5nQ6Sehaw4+oVQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/207917>

On Wed, Oct 17, 2012 at 2:44 PM, Felipe Contreras
<felipe.contreras@gmail.com> wrote:
> On Tue, Sep 25, 2012 at 4:15 PM, Max Horn <postbox@quendi.de> wrote:

> And here's a new one:
> https://github.com/felipec/git/blob/fc-remote-hd/contrib/remote-hd/git-remote-hg

Er:
https://github.com/felipec/git/blob/fc-remote-hg/contrib/remote-hg/git-remote-hg

-- 
Felipe Contreras
