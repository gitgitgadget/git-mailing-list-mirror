From: Steven Walter <stevenrwalter@gmail.com>
Subject: Re: [RFC/PATCH] t9157-*.sh: Add an svn version check
Date: Fri, 7 Jan 2011 12:44:55 -0500
Message-ID: <AANLkTi=VpHtQ+x5hyfCei-=X=ry4X=+TSGg7EKa7zs4j@mail.gmail.com>
References: <4D260A03.90903@ramsay1.demon.co.uk>
	<20110107173114.GA31376@dcvr.yhbt.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Ramsay Jones <ramsay@ramsay1.demon.co.uk>,
	GIT Mailing-list <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>
To: Eric Wong <normalperson@yhbt.net>
X-From: git-owner@vger.kernel.org Fri Jan 07 18:45:06 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PbGN5-00024r-Ci
	for gcvg-git-2@lo.gmane.org; Fri, 07 Jan 2011 18:45:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754654Ab1AGRo6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 7 Jan 2011 12:44:58 -0500
Received: from mail-bw0-f46.google.com ([209.85.214.46]:33688 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754603Ab1AGRo5 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 7 Jan 2011 12:44:57 -0500
Received: by bwz15 with SMTP id 15so17506685bwz.19
        for <git@vger.kernel.org>; Fri, 07 Jan 2011 09:44:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type;
        bh=ZTCXu5RWr5UDEjc25al65fSXsYDaiBvRuTiQ20cKqAA=;
        b=nSGHBqQXeHxtkMlQAWhk2oo0qepD4GbJE2xWPd0x+GGjjYeaNk94bb6ruaQ8Ker2MQ
         +R+65lVy+4ag+cqOTgAAjbYQjMkysfm/4xdrWuSFa7z/A8wQXvVbfJ365w3aIR8oiw59
         GYkYxdqaDZc4W87cdDgrQpk+nur++Uu/REIl4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=sGV7FCuuv8uEIHrAN/4qIb1xofT0d/YPFpXV8fVzJdQDfGlKbbPF/cIYoT5RaVxq5r
         OisqhWAiQQcbFnmrromo0SviJbOgTQ5hHntWyzn0zKOA9z9jfM/4Hk9IgNYo4h58ib6J
         72YovQ6di44KsZxK2qDZkPHrGr4tYH8rtrZBE=
Received: by 10.204.138.142 with SMTP id a14mr1374623bku.197.1294422295370;
 Fri, 07 Jan 2011 09:44:55 -0800 (PST)
Received: by 10.204.152.212 with HTTP; Fri, 7 Jan 2011 09:44:55 -0800 (PST)
In-Reply-To: <20110107173114.GA31376@dcvr.yhbt.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/164726>

On Fri, Jan 7, 2011 at 12:31 PM, Eric Wong <normalperson@yhbt.net> wrote:
> Ramsay Jones <ramsay@ramsay1.demon.co.uk> wrote:
>> Signed-off-by: Ramsay Jones <ramsay@ramsay1.demon.co.uk> ---
>
> Consider this
> Acked-by: Eric Wong <normalperson@yhbt.net>

Acked-by: Steven Walter <stevenrwalter@gmail.com>
-- 
-Steven Walter <stevenrwalter@gmail.com>
