From: Tay Ray Chuan <rctay89@gmail.com>
Subject: Re: [PATCH] Support "git remote --quiet update"
Date: Fri, 16 Apr 2010 10:59:31 +0800
Message-ID: <o2xbe6fef0d1004151959h6dd0405bhc669fe6284a66044@mail.gmail.com>
References: <E1O2XT7-00011E-RT@lake.fysh.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: git@vger.kernel.org
To: Zefram <zefram@fysh.org>
X-From: git-owner@vger.kernel.org Fri Apr 16 04:59:45 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O2bmN-0002PC-AI
	for gcvg-git-2@lo.gmane.org; Fri, 16 Apr 2010 04:59:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757409Ab0DPC7d (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 15 Apr 2010 22:59:33 -0400
Received: from mail-yx0-f199.google.com ([209.85.210.199]:43323 "EHLO
	mail-yx0-f199.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757282Ab0DPC7c (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 15 Apr 2010 22:59:32 -0400
Received: by yxe37 with SMTP id 37so1196468yxe.21
        for <git@vger.kernel.org>; Thu, 15 Apr 2010 19:59:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:received:message-id:subject:from:to:cc:content-type;
        bh=jvNugaI3tl5aCktATPniRe5tBL3zSC5ob0TeZEIOnb4=;
        b=kMHvhtfXsoqPp/gG9nPQ0suLaBSQDydhK0yzn24392wFt+md8bcVbOS8yS2ycWkCGc
         gGWuOuWgvn9UGAfl973rlApAklhEwK6aU3Z7yue2Bct/OD3Zv4hHpv5VZb8Z//C9z42u
         CX1Vl56WReJ4Wy0XJbF+uQDSSqF2UPXNTT6RA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=TNVg4CJxbZOrfK5+9nGZB3K5VTocTo+U6fp2fS45h+c/wl+Q2Dlmk386cKGSIayBey
         fgkQHS5McdUPJrOWedSZPgyUhh0IM/IuvHbuOYQ0dVBlNW/4uUMJfjXfe4K7edx36DA5
         b55eks2ZrS54jt4sZ92INXX4Ii0jAZ+a911fA=
Received: by 10.231.10.65 with HTTP; Thu, 15 Apr 2010 19:59:31 -0700 (PDT)
In-Reply-To: <E1O2XT7-00011E-RT@lake.fysh.org>
Received: by 10.150.119.25 with SMTP id r25mr1093565ybc.267.1271386771840; 
	Thu, 15 Apr 2010 19:59:31 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/145048>

Hi,

On Fri, Apr 16, 2010 at 6:11 AM, Zefram <zefram@fysh.org> wrote:
> Add --quiet option for git-remote, which it will pass on to git-fetch.

Signed-off-by?

  http://github.com/git/git/blob/master/Documentation/SubmittingPatches

-- 
Cheers,
Ray Chuan
