From: Sverre Rabbelier <srabbelier@gmail.com>
Subject: Re: [PATCH] ls-remote: a lone "-h" is asking for help
Date: Fri, 16 Sep 2011 21:44:59 +0200
Message-ID: <CAGdFq_hug3zNwvDZ3c8iG-F8jJSuxsuFghMWtWTmUTdfTrWiqg@mail.gmail.com>
References: <7vobykfj7g.fsf@alter.siamese.dyndns.org> <CAGdFq_h474OrLzP+CHj_eSdSp53n8x7jz1ORT16dOhvRdQMP+g@mail.gmail.com>
 <7vehzgfffw.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Sep 16 21:45:47 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R4eM6-0006PB-Qq
	for gcvg-git-2@lo.gmane.org; Fri, 16 Sep 2011 21:45:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754448Ab1IPTpl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 16 Sep 2011 15:45:41 -0400
Received: from mail-gx0-f174.google.com ([209.85.161.174]:39505 "EHLO
	mail-gx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752896Ab1IPTpk (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 16 Sep 2011 15:45:40 -0400
Received: by gxk6 with SMTP id 6so2544690gxk.19
        for <git@vger.kernel.org>; Fri, 16 Sep 2011 12:45:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=uAk/B2V4nDX4vROm4lDmJzMIl1jSEpUPRheiqR43cZ8=;
        b=MoMud0HSUthN4DfBpIoeo/r2v43gSI4/LIfjg5lyf+XC4ogdYt4oljJvtw1C50+TRy
         cv+WDGDZQfFacOt/8bAMPhoPMafTMaIPtuq+k+IarbYU7k85ywinJEDNBdVIDoWQxh+1
         ITPHpvwHGlRiBRMOQ7jE/gqtKTTa+kNBgGx+k=
Received: by 10.68.46.98 with SMTP id u2mr24658pbm.31.1316202339093; Fri, 16
 Sep 2011 12:45:39 -0700 (PDT)
Received: by 10.68.59.39 with HTTP; Fri, 16 Sep 2011 12:44:59 -0700 (PDT)
In-Reply-To: <7vehzgfffw.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/181547>

Heya,

On Fri, Sep 16, 2011 at 21:35, Junio C Hamano <gitster@pobox.com> wrote:
> Sverre Rabbelier <srabbelier@gmail.com> writes:
>> Should we really have "-h" as a short for anything other than "--help"
>> in the first place?
>
> You have been here long enough to know the answer to that question, no?

Yeah, you're right :).

> The answer would be different if you are starting a new project from
> scratch and if you are talking about a project with existing userbase.

Does git 2.0 count?

-- 
Cheers,

Sverre Rabbelier
