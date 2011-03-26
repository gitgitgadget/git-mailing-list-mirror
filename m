From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: Bug Tracker
Date: Sat, 26 Mar 2011 12:42:36 +0700
Message-ID: <AANLkTimWQ0vBr1u2iny9FJxrEK39C0ab_6phYFda8s6Q@mail.gmail.com>
References: <4D8D2E29.6090008@googlemail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org
To: "Stanley F." <wurfk3ks@googlemail.com>
X-From: git-owner@vger.kernel.org Sat Mar 26 06:43:29 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q3MHY-0006YW-Ve
	for gcvg-git-2@lo.gmane.org; Sat, 26 Mar 2011 06:43:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753738Ab1CZFnK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 26 Mar 2011 01:43:10 -0400
Received: from mail-ww0-f44.google.com ([74.125.82.44]:50458 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753781Ab1CZFnJ (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 26 Mar 2011 01:43:09 -0400
Received: by wwa36 with SMTP id 36so2049101wwa.1
        for <git@vger.kernel.org>; Fri, 25 Mar 2011 22:43:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-type;
        bh=wUUTx9cunbwrTtnn2AJb9sGZfrPbBWCztULaoUCqCxQ=;
        b=WcyU1mtmoJM7KdPKdddZGzj/7VZntzTfiygFyQYx3uYxOlQDd3nKZK5582JaMbP3DK
         24FeJQh+8pCRYvoZ/AcZXcMxrqUBGENpkL2yWEnssMJTiQ3c8Z6zRFKbRK6CpygN4uZY
         SHecKkQ5wRi0jD0ly6zElGdlk1vzkcUwHKu1s=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        b=i9EuE81NXcsgvWm+F0yvLyY1iKagVV3Zru/F3+pLUPCoXQbQZcB1G4cz8OuA7cFKeo
         fE/U9ifzfJalGDmI6XtpmPwG6pw+abHb635I6M5CD9H8A2s0cdALwCAOq5qJhLwKdma3
         on+/xxphgjIhq9XRWfQBNN3gBVLZQXD7H0LkE=
Received: by 10.217.2.73 with SMTP id o51mr527936wes.66.1301118186134; Fri, 25
 Mar 2011 22:43:06 -0700 (PDT)
Received: by 10.216.163.202 with HTTP; Fri, 25 Mar 2011 22:42:36 -0700 (PDT)
In-Reply-To: <4D8D2E29.6090008@googlemail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/170039>

On Sat, Mar 26, 2011 at 7:07 AM, Stanley F. <wurfk3ks@googlemail.com> wrote:
> Good evening,
>
> I'm interested in working for git during this year's GSoC program.
> So I want to get familiar with the git code by implementing some
> patches. But I can't find a bug tracker or something where are some
> TODOs to prepare for GSOC.
> Where can I find some small tasks, I can start with to get a reference
> for my proposal?

Git list is the bug tracker (well, not exactly a bug tracker). I wish
we have a todo list too. In the mean time you can look for "low
hanging fruit" in the list archive. I found this one:

http://marc.info/?l=git&m=129986810306332
-- 
Duy
