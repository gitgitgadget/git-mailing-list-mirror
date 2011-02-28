From: Sverre Rabbelier <srabbelier@gmail.com>
Subject: Re: Git bugtraq for all users who clone my repos?
Date: Mon, 28 Feb 2011 14:14:04 +0100
Message-ID: <AANLkTin9ZPcTDDQgwWyCd6h7MBJYe8m0VquoMCFZO6o1@mail.gmail.com>
References: <4D6B8F7E.4070804@fischer.name>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org
To: Markus Fischer <markus@fischer.name>
X-From: git-owner@vger.kernel.org Mon Feb 28 14:14:51 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Pu2w6-0002jd-KC
	for gcvg-git-2@lo.gmane.org; Mon, 28 Feb 2011 14:14:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754032Ab1B1NOq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 28 Feb 2011 08:14:46 -0500
Received: from mail-gx0-f174.google.com ([209.85.161.174]:35566 "EHLO
	mail-gx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753937Ab1B1NOp (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 Feb 2011 08:14:45 -0500
Received: by gxk8 with SMTP id 8so1504629gxk.19
        for <git@vger.kernel.org>; Mon, 28 Feb 2011 05:14:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-type;
        bh=0LTTPhQbexhwJ5UPi8oXtXhFkwtBNS8lb4obc7nalVM=;
        b=I/LwbnGohpz/1Ye5c2gs8NiuMV44zdAuw8Ql0mZ0aGFUyn7MPBeGdfUUf5d0D3JyfP
         OyeWAEJYYeatmvBda5/OBWEcK7IhpjTjoubII3HCUCJseQz2disgX7hGLCXGmtkP8x+e
         eht0uUnCB1mRbt/g+wSV5GPXETwYHwZD/2Lg4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        b=jeFVzXiJJICwonDkCjUf6TpT6xMQg9kWnKF4XuXK+fj0xC9mpFQQYVuuehkBh2XsPF
         9r6bz5l+QgMA0raLh6ZP1tMXL76i5rnwus8q/Xak1tz7hohtOlJrFjchsgf5Zw+eptP9
         uofPDKlEDDMJO8cKHp3D3ifS/WJBFbpy29TLk=
Received: by 10.150.66.10 with SMTP id o10mr5460870yba.235.1298898885078; Mon,
 28 Feb 2011 05:14:45 -0800 (PST)
Received: by 10.151.11.12 with HTTP; Mon, 28 Feb 2011 05:14:04 -0800 (PST)
In-Reply-To: <4D6B8F7E.4070804@fischer.name>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/168110>

Heya,

On Mon, Feb 28, 2011 at 13:05, Markus Fischer <markus@fischer.name> wrote:
> Do I need to educate every developer to configure their checkouts (also
> unsatisfying for myself when I move somewhere else have to do clone my
> repository again) or it possible to feed it when the repository is being
> cloned?

Perhaps 'git notes' is what you're looking for?

-- 
Cheers,

Sverre Rabbelier
