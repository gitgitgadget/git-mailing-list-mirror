From: Scott Chacon <schacon@gmail.com>
Subject: Re: Google Summer of Code 2012... and git wiki
Date: Thu, 1 Mar 2012 15:33:56 -0800
Message-ID: <CAP2yMaKw8dx+fsy2Kbh2XUORu+b7CiA+qzZDcK05zsv3m5-bww@mail.gmail.com>
References: <201203020027.41016.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Fri Mar 02 00:34:22 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S3FVt-0003zo-TS
	for gcvg-git-2@plane.gmane.org; Fri, 02 Mar 2012 00:34:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752576Ab2CAXeR convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 1 Mar 2012 18:34:17 -0500
Received: from mail-pz0-f46.google.com ([209.85.210.46]:49460 "EHLO
	mail-pz0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751283Ab2CAXeQ convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 1 Mar 2012 18:34:16 -0500
Received: by dajr28 with SMTP id r28so1297694daj.19
        for <git@vger.kernel.org>; Thu, 01 Mar 2012 15:34:16 -0800 (PST)
Received-SPF: pass (google.com: domain of schacon@gmail.com designates 10.68.194.65 as permitted sender) client-ip=10.68.194.65;
Authentication-Results: mr.google.com; spf=pass (google.com: domain of schacon@gmail.com designates 10.68.194.65 as permitted sender) smtp.mail=schacon@gmail.com; dkim=pass header.i=schacon@gmail.com
Received: from mr.google.com ([10.68.194.65])
        by 10.68.194.65 with SMTP id hu1mr8814872pbc.75.1330644856250 (num_hops = 1);
        Thu, 01 Mar 2012 15:34:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=KY6dmDwXB01R9dms5XJ60sEfHC3s5vb50PVWdrkwTj8=;
        b=sUp1Ku1bYs3kxlQEzcqZ1e9Sef1aJe7lLJtGHFBlqZZkMBzeVC2aaT1O6z6V+BFlQM
         gTk0ynxLZFM9To359ord2qBGmUwLK4gdpNflvXSgJ+1IgyrjCoY5ByO/qIYaRiOxMG0W
         4H72C+OsRcEmoRqW6UQSkNv0bGpxNUeZvSpcyt5mfZ1Bw2iIpVF+OP0ofVQLq1USwvyg
         u8eOu0JMxWCTBOmsH7+N7PyKN1rbdtuCz9aiyFuvBXr+BFNTCWuraE1KI2YY6CC16L8N
         uzFqER09wm2nvgkGR7b0jAnZSt1VsxQClA/ogiDjHNDJrlHZvR3CMhNbhNYr4A3CTT9k
         Y3ew==
Received: by 10.68.194.65 with SMTP id hu1mr7288220pbc.75.1330644856165; Thu,
 01 Mar 2012 15:34:16 -0800 (PST)
Received: by 10.68.5.72 with HTTP; Thu, 1 Mar 2012 15:33:56 -0800 (PST)
In-Reply-To: <201203020027.41016.jnareb@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/191987>

Hey,

2012/3/1 Jakub Narebski <jnareb@gmail.com>:
> Google Summer of Code 2012 has started. =C2=A0The Git Development Com=
munity
> has time till March 9 to submit organization application.
>
> The problem (beside finding volunteer for the position of GSoC
> administrator) is that both GSoC application and ideas for GSoC
> projects were hosted on Git Wiki... but Git Wiki is still only parial=
ly
> functional, available only as static pages under changed URLs.
>
> I guess we can get by without having fully functional wiki for creati=
ng
> application (if we decide to apply), but it would need a forum to sen=
d
> ideas for GSoC projects and some place to publish them. =C2=A0Editabl=
e wiki
> can work as both, though git mailing list and some static page (perha=
ps
> home pages for git project on GitHub?) could also work.
>
>
> I don't know what are ETA on bringing Git Wiki fully up, but I doubt =
it
> would be possible at http://git.wiki.kernel.org -- it is more than tw=
o
> months since the event and wiki is not functional yet. =C2=A0Perhaps =
it
> could be hosted at git-scm.com somewhere - =C2=A0but it really should=
 be
> true wiki, editable without need to use git.
>

I can probably set something up there, but I'm not sure if I can
import everything.  In the longer term (a month or two) I will have a
full wiki import running on that domain, but in the next few weeks we
might want to just setup a temp wiki somewhere to pull together the
ideas and I can link to it from git-scm.com

Scott
