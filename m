From: "Sverre Rabbelier" <srabbelier@gmail.com>
Subject: Re: Newbie Query
Date: Tue, 20 Jan 2009 21:16:11 +0100
Message-ID: <bd6139dc0901201216k45ec4da9k73ad37a22a8062a4@mail.gmail.com>
References: <20090120191952.GA25322@uts.thewillards.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Git List" <git@vger.kernel.org>
To: "Chris Willard" <chris@thewillards.co.uk>
X-From: git-owner@vger.kernel.org Tue Jan 20 21:17:58 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LPN2a-0002Ev-C2
	for gcvg-git-2@gmane.org; Tue, 20 Jan 2009 21:17:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756225AbZATUQN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 20 Jan 2009 15:16:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755194AbZATUQN
	(ORCPT <rfc822;git-outgoing>); Tue, 20 Jan 2009 15:16:13 -0500
Received: from mail-gx0-f21.google.com ([209.85.217.21]:49198 "EHLO
	mail-gx0-f21.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754025AbZATUQM (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 20 Jan 2009 15:16:12 -0500
Received: by gxk14 with SMTP id 14so3165166gxk.13
        for <git@vger.kernel.org>; Tue, 20 Jan 2009 12:16:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:sender
         :to:subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references
         :x-google-sender-auth;
        bh=D4N6LI9TJVMW9HY//L+ZzfQcnr5lV5u6bmkIlDINFwI=;
        b=yICjzxm2snsavZ5EcQi7k91LKWkntS64M9DzpMuGQKXqyV0S/19HMHoyirgF+z3iLG
         DBTndvnaA2kB5taBzR4I1u+JWeaCB4OpWppG6xrEO0g4B8Cruz3BC1x4/nz6akzLtry0
         aNr3skUY2Z5wB6ArxjHU1QluSXcijine1a2kU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:sender:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references:x-google-sender-auth;
        b=BD3Zdu05fsX/vorLHtS50ADYzLzl9Q5V4P4Mocx7A8Ft9inwdlhU3e+40aEMen5K/x
         U/mZ974CpQpAk4pdm31/FGntXeRpM268nr6zgIk9j12vbBIC5Fkt6DKQ734jHIP1QoFv
         nmBvUmDg3AJmQVOK/MhsGDC9Di6WWnz0a1usQ=
Received: by 10.151.46.17 with SMTP id y17mr9219670ybj.183.1232482571444;
        Tue, 20 Jan 2009 12:16:11 -0800 (PST)
Received: by 10.150.121.4 with HTTP; Tue, 20 Jan 2009 12:16:11 -0800 (PST)
In-Reply-To: <20090120191952.GA25322@uts.thewillards.local>
Content-Disposition: inline
X-Google-Sender-Auth: 172e5f4efbd3f249
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/106517>

Heya,

On Tue, Jan 20, 2009 at 20:19, Chris Willard <chris@thewillards.co.uk> wrote:
> I then modified the files, added them, commited the changes and then
> used git push to put them on the PC - still no problems.
>
> Both systems show the commits but the PC does not have the latest
> version of the files. Git status on the PC shows the file as changed
> but commiting give an error when pushing from the laptop.

Please read http://git.or.cz/gitwiki/GitFaq#head-b96f48bc9c925074be9f95c0fce69bcece5f6e73
and let us know if you have any other problems.


-- 
Cheers,

Sverre Rabbelier
