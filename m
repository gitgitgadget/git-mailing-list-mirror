From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: [PATCH v2 0/3] Towards a useable git-branch
Date: Sat, 25 May 2013 05:51:48 +0700
Message-ID: <CACsJy8AEkmiWP46tOBkXRkWDGO+k5YW+GJB-ak8HfTpghQP5eQ@mail.gmail.com>
References: <1369405177-7855-1-git-send-email-artagnon@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Sat May 25 00:52:36 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ug0qh-0005Dl-3P
	for gcvg-git-2@plane.gmane.org; Sat, 25 May 2013 00:52:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756154Ab3EXWwU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 24 May 2013 18:52:20 -0400
Received: from mail-oa0-f42.google.com ([209.85.219.42]:48712 "EHLO
	mail-oa0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755156Ab3EXWwT (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 24 May 2013 18:52:19 -0400
Received: by mail-oa0-f42.google.com with SMTP id i10so6932165oag.29
        for <git@vger.kernel.org>; Fri, 24 May 2013 15:52:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=ETMOlWzvFAzg+hk21i0WAppNMIGgYs/pFrFQWkTC9T4=;
        b=yATDVX4KekFohLpt+wm3I2TNM81xdIhOeBd181P81p0HdbACeDGgaalS1UDL5A/T5Z
         NjSGqys3jSv4xOnG+kUflOYLA+xGs9OJdyrT0unyP5YD/uS90N8z8aa5cahGY/KKUnP6
         WdRWi1Z2MJRahHcvL1pm/dvSHt0sw7J32CkHO1zYpxs/K45imw/C1SA5X/LlOyKeRHZs
         2IpOuxhuSOjS7+DG5+3bOTllnIGUiF1R33f5VB6pZegWVNCGCaBSjbD1iMjqkN5ZosZY
         48sEodDq/XEZ23Y4WlvLVdvbz44DgAK9nHLjqaTevupvZOp1TZB/5F/uhEg8tXuvGJ9k
         lM1Q==
X-Received: by 10.182.118.226 with SMTP id kp2mr12970980obb.48.1369435939070;
 Fri, 24 May 2013 15:52:19 -0700 (PDT)
Received: by 10.76.141.232 with HTTP; Fri, 24 May 2013 15:51:48 -0700 (PDT)
In-Reply-To: <1369405177-7855-1-git-send-email-artagnon@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/225403>

On Fri, May 24, 2013 at 9:19 PM, Ramkumar Ramachandra
<artagnon@gmail.com> wrote:
> So, while investigating alignment operators in pretty-formats, I found
> out that it's way too much effort and totally not worth it (atleast
> not immediately; we can add it later if we want).

I just had an idea that might bring pretty stuff to for-each-ref with
probably reasonable effort, making for-each-ref format a superset of
pretty. But I need to clean up my backlog first. Give me a few days, I
will show you something (or give up ;)
--
Duy
