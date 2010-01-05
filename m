From: Dongas <dongas86@gmail.com>
Subject: Re: A question about changing remote repo name
Date: Tue, 5 Jan 2010 09:53:41 +0800
Message-ID: <60ce8d251001041753y5fe37b9do8d4cffc477e58198@mail.gmail.com>
References: <60ce8d251001032245n4e0267b1o1ecc796f324f8179@mail.gmail.com>
	 <20100104200908.GS29803@genesis.frugalware.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: git@vger.kernel.org
To: Miklos Vajna <vmiklos@frugalware.org>
X-From: git-owner@vger.kernel.org Tue Jan 05 02:53:56 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NRycN-0002rQ-0V
	for gcvg-git-2@lo.gmane.org; Tue, 05 Jan 2010 02:53:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753820Ab0AEBxp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 4 Jan 2010 20:53:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753642Ab0AEBxo
	(ORCPT <rfc822;git-outgoing>); Mon, 4 Jan 2010 20:53:44 -0500
Received: from mail-yw0-f176.google.com ([209.85.211.176]:48821 "EHLO
	mail-yw0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753484Ab0AEBxn (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 4 Jan 2010 20:53:43 -0500
Received: by ywh6 with SMTP id 6so15952848ywh.4
        for <git@vger.kernel.org>; Mon, 04 Jan 2010 17:53:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type;
        bh=ctTvqxGTHcAYOFXDjRz00we+h7bvcdpzjkIZFN+JfT4=;
        b=DRrtQ4iWyOgVYi2QkXKLX6cFMrmAZ6OCRA2pxYr3pC12QcKmBFbLKRYAabggxjKUPf
         NYhQxzHJxqYsE8ntTnVIeYc8oqgrMSQNaL2Srva26o0QV5DgRr9D+1I7UX32dWw4hXHM
         znmYAAKFxwg4d54wAGBfYph6UfjdQPV5Nuyz0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=KqCktkvpXKM1/7Q9kqCquJE6g3IvZ3BhcUUC4UJxPjHIyeX7+rBl3xiY9e0VplfIGw
         TTTu/cIaphHrWFyhiMMMQ0HGgOI5dh2NCG6X+23NF+ktjrJOkm89Sz5M5RJ2b06dgdjM
         lq2xWtZjxTvAxxkNacfVJQM+mq7PhMjwihvs8=
Received: by 10.90.219.9 with SMTP id r9mr1664960agg.85.1262656421604; Mon, 04 
	Jan 2010 17:53:41 -0800 (PST)
In-Reply-To: <20100104200908.GS29803@genesis.frugalware.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/136150>

2010/1/5 Miklos Vajna <vmiklos@frugalware.org>:
> On Mon, Jan 04, 2010 at 02:45:09PM +0800, Dongas <dongas86@gmail.com> wrote:
>> I'm running ubuntu 9.04 and the git coming along with it doesn't
>> support git remote rename command.
>
> It first appeared in v1.6.1, about a year ago. What does 'git version'
> say?

Thanks a lot for your reply.

# git --version
git version 1.6.0.4

It seems the ubuntu9.04 doesn't have the repo source to update to a
higher git version than 1.6.0.4,
i'd like to know if there's a manual way to rename the git remote name
with this version.

Regards
Dongas
