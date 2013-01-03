From: Martin Langhoff <martin.langhoff@gmail.com>
Subject: Re: cvsps, parsecvs, svn2git and the CVS exporter mess
Date: Thu, 3 Jan 2013 10:51:02 -0500
Message-ID: <CACPiFCLpZT6v7tS+D9=hZwpj3kOewndcyFYfUBso62Ry_Y-Eow@mail.gmail.com>
References: <20121222173649.04C5B44119@snark.thyrsus.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Yann Dirson <ydirson@free.fr>,
	Michael Haggerty <mhagger@alum.mit.edu>,
	Heiko Voigt <hvoigt@hvoigt.net>,
	Antoine Pelisse <apelisse@gmail.com>,
	Bart Massey <bart@cs.pdx.edu>,
	Keith Packard <keithp@keithp.com>,
	David Mansfield <david@cobite.com>,
	Git Mailing List <git@vger.kernel.org>
To: "Eric S. Raymond" <esr@thyrsus.com>
X-From: git-owner@vger.kernel.org Thu Jan 03 16:51:48 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Tqn58-0006ae-Ot
	for gcvg-git-2@plane.gmane.org; Thu, 03 Jan 2013 16:51:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753475Ab3ACPvY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 3 Jan 2013 10:51:24 -0500
Received: from mail-pb0-f51.google.com ([209.85.160.51]:53964 "EHLO
	mail-pb0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753412Ab3ACPvX (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 3 Jan 2013 10:51:23 -0500
Received: by mail-pb0-f51.google.com with SMTP id ro12so8615787pbb.10
        for <git@vger.kernel.org>; Thu, 03 Jan 2013 07:51:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=30q7ExrDOUny3ert2ZBieVebkvZSFs5MjEi+bPk9Roc=;
        b=Ugoj6Gc6i8o/4wdW3zR54P7IpWQI9mvKmyGE49d4jecOz0wivHzoLwuCm71CUY7qUQ
         RN9lodTTPIoFog4hrLoCpLJRUlN6/iPsZusWwxBAcK949CfRR+fwwI9lmhwJJOpiuzka
         OiyIJtH7JwV+6gmeCTjW0NJYp3liR3O2LjMCIcSkJUgbhlA3M9zubTiE/vG327rZ6DIX
         fdyOkLU7Do+ktua8bb+++kA2NE5GwKEajaEcSuk6SossEq0wFon8e8ffZwiUuKzG2NSR
         nKbH/1jshZGWAIiZw6HSrCq9yuGLfR9u1+0uPyTEx1ZdyYxrdXHuFjiMAfsmrmjgyVop
         XgpA==
Received: by 10.68.132.34 with SMTP id or2mr155380612pbb.133.1357228282834;
 Thu, 03 Jan 2013 07:51:22 -0800 (PST)
Received: by 10.66.21.231 with HTTP; Thu, 3 Jan 2013 07:51:02 -0800 (PST)
In-Reply-To: <20121222173649.04C5B44119@snark.thyrsus.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/212593>

On Sat, Dec 22, 2012 at 12:36 PM, Eric S. Raymond <esr@thyrsus.com> wrote:
> It is pure accident that I now maintain two of these.

Maintainership is always temporary.

> Having three different tools for this job seems to me duplicative and
> pointless; two of them should probably be let die an honorable death.

Perhaps just maintain the code that serves your goals. That way, you
don't need long trolly emails nor approval from anyone.




m
--
 martin.langhoff@gmail.com
 martin@laptop.org -- Software Architect - OLPC
 - ask interesting questions
 - don't get distracted with shiny stuff  - working code first
 - http://wiki.laptop.org/go/User:Martinlanghoff
