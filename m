From: Lin Mac <mkl0301@gmail.com>
Subject: Re: git commands
Date: Sun, 22 Aug 2010 18:41:35 +0800
Message-ID: <AANLkTimRpwLZHve_cAY0JxLGKC4202i-V_Soq=m1_JsY@mail.gmail.com>
References: <1282288658094-5443370.post@n2.nabble.com>
	<5F6739C3-B537-4694-BC63-F3F74962A47C@gmail.com>
	<vpq39u97m3l.fsf@bauges.imag.fr>
	<1282294163263-5443609.post@n2.nabble.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: git@vger.kernel.org
To: sandy2010 <sandeeptt@yahoo.com>
X-From: git-owner@vger.kernel.org Sun Aug 22 12:41:43 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1On7zj-0004E8-8S
	for gcvg-git-2@lo.gmane.org; Sun, 22 Aug 2010 12:41:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752102Ab0HVKli (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 22 Aug 2010 06:41:38 -0400
Received: from mail-ww0-f42.google.com ([74.125.82.42]:44548 "EHLO
	mail-ww0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751698Ab0HVKlg (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 22 Aug 2010 06:41:36 -0400
Received: by wwf26 with SMTP id 26so2935413wwf.1
        for <git@vger.kernel.org>; Sun, 22 Aug 2010 03:41:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type;
        bh=vCW9BG6zGM8aLiR6Nuc6aAP2tji8tYitXtbSUOEjwJk=;
        b=UbbC/z8jEb+Xi+vYvyHhNt7//fHZN7wqVLUPQbriPHzcbIYJdYIF3ht9bZRXuysogC
         zVKgNdrIT2B8gPhufXedKP45wtEcvg1bgk3y3yFy/GP7hDElrYVRU55u8k/3K7KC4WI4
         LiFDyYsmjfyndR/ce5icPo9MJ/dGIPp+QzYx0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=APIAszX8QfPxQCOMaefZuX5/yhTF+qIGkZF4TclX7BZs3p/1PqWRRvDX7FHFmno49c
         7LuOUDuhBkv7qyQDY1M4iP2zuDLfi01mRJeU1zF1gEeYnHdP+9GvadUPkj8HfwtHmM3C
         8jZXip7bO9l5tcG10FtM9kFMNdoNVx8fnQy1E=
Received: by 10.216.1.17 with SMTP id 17mr1325798wec.99.1282473695611; Sun, 22
 Aug 2010 03:41:35 -0700 (PDT)
Received: by 10.216.36.15 with HTTP; Sun, 22 Aug 2010 03:41:35 -0700 (PDT)
In-Reply-To: <1282294163263-5443609.post@n2.nabble.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/154179>

Hi,

2010/8/20 sandy2010 <sandeeptt@yahoo.com>:
> Yeah.. Actually, we were using git-15.6 and the command we used was
> 'git-clone'. Later, I upgraded to git-1.7.1 and I found that in the
> installation directory, there was only 4 binaries including git. I was
> wondering were are the rest commands like git-clone, etc? Hence, I asked
> this question.
I have the same question regarding the installation here. I'm trying
to upgrade from v1.5.x to the newest. But found that there are only a
few files installed. Where are the rest? Should I uninstall the old
version before I install? And is there any issues for the newer
version works in respository made by v1.5.x, like git-svn?

Best Regards,
Mac Lin.
