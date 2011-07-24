From: Ori Avtalion <ori@avtalion.name>
Subject: Re: TFS brigde
Date: Sun, 24 Jul 2011 11:25:42 +0300
Message-ID: <CALgdb5JyqDwTiRrioaFEhzdZH8chxjuWKaBpjwNv7q1WR79XiQ@mail.gmail.com>
References: <20110511113338.GA24644@nibiru.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: weigelt@metux.de, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jul 24 10:28:23 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Qku2u-0003At-7Z
	for gcvg-git-2@lo.gmane.org; Sun, 24 Jul 2011 10:28:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752128Ab1GXIZp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 24 Jul 2011 04:25:45 -0400
Received: from mail-iy0-f174.google.com ([209.85.210.174]:36821 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751374Ab1GXIZn (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 24 Jul 2011 04:25:43 -0400
Received: by iyb12 with SMTP id 12so3390909iyb.19
        for <git@vger.kernel.org>; Sun, 24 Jul 2011 01:25:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:sender:in-reply-to:references:date
         :x-google-sender-auth:message-id:subject:from:to:content-type;
        bh=NBE7+Drs9zCBhnMuYjwn8GnFj+NZllOkaMyMkdqWKrs=;
        b=Pir6g/u3ZlEdQL5dsxDWWXgJ8ISOaaf3jhT0O+VNas58WZdjWBw5Zr3Ecj98sQsHhd
         vJWeuYwsjYXjV/4BKkZ98tfVDZgRWNC0UkDmXhKY5ODPwGHD9Gq6rvLoBRXAH5NH+URH
         PAYy5jTaSBCvMjlQUeOxRmCuqRGhoQX0aCU8U=
Received: by 10.231.47.136 with SMTP id n8mr3499969ibf.19.1311495942884; Sun,
 24 Jul 2011 01:25:42 -0700 (PDT)
Received: by 10.231.202.78 with HTTP; Sun, 24 Jul 2011 01:25:42 -0700 (PDT)
In-Reply-To: <20110511113338.GA24644@nibiru.local>
X-Google-Sender-Auth: ScKkEhfxPaal63HIUxKmKPAibxA
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/177733>

> did anybody manage to pull changes from TFS into git ?
>

Check out https://github.com/spraints/git-tfs/

It's not exactly git-svn (yet?), but it may suit your needs.
