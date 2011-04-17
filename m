From: David Chanters <david.chanters@googlemail.com>
Subject: Re: Generating GNU-style Changelog from git commits
Date: Sun, 17 Apr 2011 16:14:35 +0100
Message-ID: <BANLkTi=bGnT6n9WqGz309ZPgzL9KRAkMzQ@mail.gmail.com>
References: <BANLkTi=j_Ge9h8+r8R-a5Fppan_2dtu5LA@mail.gmail.com>
	<4DAA3A0D.6070904@gmail.com>
	<BANLkTikQvOkoFSXXC3oUKQfASo8==qdgxA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Chris Packham <judge.packham@gmail.com>, git@vger.kernel.org
To: "Marcus D. Hanwell" <marcus.hanwell@kitware.com>
X-From: git-owner@vger.kernel.org Sun Apr 17 17:14:41 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QBTgO-0004IT-B7
	for gcvg-git-2@lo.gmane.org; Sun, 17 Apr 2011 17:14:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753885Ab1DQPOh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 17 Apr 2011 11:14:37 -0400
Received: from mail-iy0-f174.google.com ([209.85.210.174]:54151 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752439Ab1DQPOf (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 17 Apr 2011 11:14:35 -0400
Received: by iyb14 with SMTP id 14so3283954iyb.19
        for <git@vger.kernel.org>; Sun, 17 Apr 2011 08:14:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=XgK7Y/6bt0emUtqXiXMfqRTynjn9ZUaHbqDvtzwF+w8=;
        b=t0wyBcyoRAaZ8UpMQ4r7/gna1nVLw6AYAAYppeJHjIqNNYUwZM72LtCPOnq6AeziHz
         Gy/yA9Ag1Rgl00cUu3q5x+FSRxJDMg6P6wIvHq39q8w7aQ6tOEXh8inkszCBulGm0c5D
         IbnUTrq+t+Qg62IgJXn5pmD2JyIaauBX0L7co=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=SkFs7tuWM7lmqfamdCBM3+YWMjhwrnUN1424tcD86LVP9qgcYOadcKI0cfnS7omX7l
         ME+Kn8VkhIN76AHOstd83shT8eGq2wphKuF7AhbxvaGB5XboW+BhV3IOpBV7pkOcakNi
         VpRxZgLPCSAKTc0TEKhFSYqOnLTDeHP0ulJg0=
Received: by 10.43.68.204 with SMTP id xz12mr3117791icb.354.1303053275156;
 Sun, 17 Apr 2011 08:14:35 -0700 (PDT)
Received: by 10.42.178.3 with HTTP; Sun, 17 Apr 2011 08:14:35 -0700 (PDT)
In-Reply-To: <BANLkTikQvOkoFSXXC3oUKQfASo8==qdgxA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/171723>

On 17 April 2011 02:47, Marcus D. Hanwell <marcus.hanwell@kitware.com> wrote:
> https://github.com/cryos/avogadro/blob/master/scripts/gitlog2changelog.py
>
> If there are better ways of doing this I would certainly be
> interested, but have not spent much time on this since writing the
> initial script. We had a similar desire, but didn't want to end up
> resolving conflicts around a file in version control.

Thanks, all.  I shall look into it.   :)

David
