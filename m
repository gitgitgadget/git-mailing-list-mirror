From: Sverre Rabbelier <srabbelier@gmail.com>
Subject: Re: obnoxious CLI complaints
Date: Thu, 10 Sep 2009 20:52:08 +0200
Message-ID: <fabb9a1e0909101152n4d55b344p60da1529fa58eb01@mail.gmail.com>
References: <ef38762f0909091427m5b8f3am72c88fd4dbfebc59@mail.gmail.com> 
	<m3fxavvl5k.fsf@localhost.localdomain> <ef38762f0909091709t7336d86dkd2f175e5b3a6a3f@mail.gmail.com> 
	<200909101116.55098.jnareb@gmail.com> <34f8975d0909101118x7c95be1ehda085bea1611b70c@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: git@vger.kernel.org
To: Eric Schaefer <eric.schaefer@ericschaefer.org>
X-From: git-owner@vger.kernel.org Thu Sep 10 20:52:38 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Mlol2-0006Dj-3V
	for gcvg-git-2@lo.gmane.org; Thu, 10 Sep 2009 20:52:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753254AbZIJSw0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 10 Sep 2009 14:52:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753246AbZIJSw0
	(ORCPT <rfc822;git-outgoing>); Thu, 10 Sep 2009 14:52:26 -0400
Received: from mail-ew0-f206.google.com ([209.85.219.206]:34418 "EHLO
	mail-ew0-f206.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753245AbZIJSw0 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 10 Sep 2009 14:52:26 -0400
Received: by ewy2 with SMTP id 2so416144ewy.17
        for <git@vger.kernel.org>; Thu, 10 Sep 2009 11:52:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :from:date:message-id:subject:to:cc:content-type;
        bh=MK6vx6+1PQv1pyjWjIJ2N+9d0/Ao5zTQbohS7Y2haQY=;
        b=k/TyqWzKSdKrfiUsXY1uOhiRXoAddlz8wZpgWfnWuKvu/LuWqaSgh2AIje1Gzx+O80
         VwVMY0yGj6RKaWUmfLK3OyaYJd5jtHYlZ6IQCpeiXGQbb3bpb2e+S/AiEDWtHoDXggVq
         K41oKD2QH3WfdNhN3GTL26e3Hqm8E5aFaL2S4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        b=ORPILcD+XcrAe7Rsng23SRktlYkk118W3EkYSiyi0gmdSxhwaELyWU8yG6lqMUmMp6
         JJnphUNA6xd8XMBoMsr6WZsT2fH9H7Fv2IVMCR9GGrzhSiJJApyoyqmktZsu3gvTDmk+
         RxJb5sgLM29yWOhM4BKpMxwK0zaYuZ4fM/xv0=
Received: by 10.216.88.71 with SMTP id z49mr485686wee.90.1252608748210; Thu, 
	10 Sep 2009 11:52:28 -0700 (PDT)
In-Reply-To: <34f8975d0909101118x7c95be1ehda085bea1611b70c@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/128133>

Heya,

On Thu, Sep 10, 2009 at 20:18, Eric Schaefer
<eric.schaefer@ericschaefer.org> wrote:
> "Unimportant bug reports"? Interesting concept... ;-)

Sure, if there's a bug in feature foo, but it only happens when
invoking it with some rarely used argument, and only on Solaris
platforms, it is probably not worth spending time on it if the
original reporter does not even have the time to stick around and aid
in resolving the issue. It's probably better to spend that precious
time on other bug fixes, or features instead.

-- 
Cheers,

Sverre Rabbelier
