From: Sverre Rabbelier <srabbelier@gmail.com>
Subject: Re: Is ./git/branches used for anything?
Date: Tue, 2 Feb 2010 09:11:26 +0100
Message-ID: <fabb9a1e1002020011p4819b918yc9c2379bf68b4b6b@mail.gmail.com>
References: <ron1-35461E.00013102022010@news.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Ron Garret <ron1@flownet.com>
X-From: git-owner@vger.kernel.org Tue Feb 02 09:11:53 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NcDrU-0005jC-D0
	for gcvg-git-2@lo.gmane.org; Tue, 02 Feb 2010 09:11:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752550Ab0BBILr convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 2 Feb 2010 03:11:47 -0500
Received: from mail-px0-f182.google.com ([209.85.216.182]:61524 "EHLO
	mail-px0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751300Ab0BBILq convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 2 Feb 2010 03:11:46 -0500
Received: by pxi12 with SMTP id 12so5485079pxi.33
        for <git@vger.kernel.org>; Tue, 02 Feb 2010 00:11:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :from:date:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=5yUHEr7ql90eboC0yreCYEdVqTgjdSnTdXn6OOJ/I3w=;
        b=CorMGyVqTGtLaWXgHga8AedyrgHPzrP4ZNCF+GtOOXuuIubIdkhaBr+KUL9HhzAam5
         Wp+PlYQcaoXP+ow6iRdQGY+50DQd21UPOPxGTA8TVEywJhPWgDVpMFVZYbvjlxYwk4TS
         zCnhCNShwIp+zM5klhU2eqHQI/WfjAm0jeSTM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=uytoERfvwCyImVuZojPquWRRspTp5oW/z1jWlUKwbbWz3pnQ89NrmOzSURFWjzILoT
         ptLnTZDz5i7EZWtkXb5kOM9coIFRhZZwtwyYV5s1IAO1KPRLT8TBjtW2vB9jKTnij2gi
         8zz13xl7Yv3Q/S0ToWRkLFLAERTUcuNjLUA8A=
Received: by 10.142.55.15 with SMTP id d15mr2186582wfa.166.1265098306140; Tue, 
	02 Feb 2010 00:11:46 -0800 (PST)
In-Reply-To: <ron1-35461E.00013102022010@news.gmane.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/138696>

Heya,

On Tue, Feb 2, 2010 at 09:01, Ron Garret <ron1@flownet.com> wrote:
> If so, what? =A0.git/refs/heads seems to contain all the branch info,=
 so
> what is the branches directory for?

It's a leftover from the good ole' days. I think Cogito used it.

--=20
Cheers,

Sverre Rabbelier
