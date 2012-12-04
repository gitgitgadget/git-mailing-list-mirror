From: Martin Langhoff <martin.langhoff@gmail.com>
Subject: Re: Python extension commands in git - request for policy change
Date: Tue, 4 Dec 2012 10:51:19 -0500
Message-ID: <CACPiFCK5rg626iHSdb7qhnvoDHJu+xs2Dp3SXqdHq81SXBMJYA@mail.gmail.com>
References: <20121125024451.1ADD14065F@snark.thyrsus.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Git Mailing List <git@vger.kernel.org>
To: "Eric S. Raymond" <esr@thyrsus.com>
X-From: git-owner@vger.kernel.org Tue Dec 04 16:51:58 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Tfumr-00055x-59
	for gcvg-git-2@plane.gmane.org; Tue, 04 Dec 2012 16:51:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752669Ab2LDPvk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 4 Dec 2012 10:51:40 -0500
Received: from mail-pb0-f46.google.com ([209.85.160.46]:33431 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752263Ab2LDPvj (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 4 Dec 2012 10:51:39 -0500
Received: by mail-pb0-f46.google.com with SMTP id wy7so2921678pbc.19
        for <git@vger.kernel.org>; Tue, 04 Dec 2012 07:51:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=MAMMAs268LlZDRtlciZfTQLdQB/l7Ldkf9ldAZnH/ow=;
        b=bKfHYWs7XqA/lWCTof0KQSxkFeDjgGpH3jkLCajCp7x1u1QEsbChpDb0T85vBbUFYQ
         XJzaRS1NZtFLSZAgdrn39mPNDmJiV6nxZyZK0XG57dd3xthiEGS7LkdzK+afbfw3wU8X
         xYTqCmU82odI62klePkYLBT2U9rmm2CMayUWwyPSGmv4JzJO4Sdo6E3cuB4BLVfgYdSP
         0ji2d0gvDLsn3QUrgYNmg3e8Rdl0ADnMFGAKHMelLAbcZ6NA8QYbW7I5zRC74QEz+fBB
         8CzsbP2niQZiP5Iyw7FTnDbycA05KEVEexGVAV9PJf8+hza8Cq0U0znyI7upbT5aFwiA
         pY1A==
Received: by 10.66.74.2 with SMTP id p2mr36167307pav.55.1354636299298; Tue, 04
 Dec 2012 07:51:39 -0800 (PST)
Received: by 10.66.21.231 with HTTP; Tue, 4 Dec 2012 07:51:19 -0800 (PST)
In-Reply-To: <20121125024451.1ADD14065F@snark.thyrsus.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/211086>

On Sat, Nov 24, 2012 at 9:44 PM, Eric S. Raymond <esr@thyrsus.com> wrote:
> git presently contains one Python extension command, Pete Wycoff's p4
> importer.  If my git-weave code is merged it will acquire another.

Write a really compelling tool. Don't argue languages. Make it
wonderful. The git maintainers, tool maintainers (you!) and overall
development community have shown flexibility and smarts in the past.

cheers,


m
--
 martin.langhoff@gmail.com
 martin@laptop.org -- Software Architect - OLPC
 - ask interesting questions
 - don't get distracted with shiny stuff  - working code first
 - http://wiki.laptop.org/go/User:Martinlanghoff
