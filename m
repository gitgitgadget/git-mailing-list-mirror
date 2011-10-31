From: netroby <hufeng1987@gmail.com>
Subject: New Feature wanted: Is it possible to let git clone continue last
 break point?
Date: Mon, 31 Oct 2011 10:28:04 +0800
Message-ID: <CAEZo+gcj5q2UYnak1+1UG7pPzoeaUr=QLsiCiNXbC_n+JQbKQQ@mail.gmail.com>
References: <CAEZo+gfKVY-YgMjd=bEYzRV4-460kqDik-yVcQ9Xs=DoCZOMDg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: Git Mail List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Oct 31 03:28:36 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RKhc3-0002t9-M2
	for gcvg-git-2@lo.gmane.org; Mon, 31 Oct 2011 03:28:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753560Ab1JaC20 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 30 Oct 2011 22:28:26 -0400
Received: from mail-iy0-f174.google.com ([209.85.210.174]:61041 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753486Ab1JaC2Z convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 30 Oct 2011 22:28:25 -0400
Received: by iaby12 with SMTP id y12so6654444iab.19
        for <git@vger.kernel.org>; Sun, 30 Oct 2011 19:28:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :content-type:content-transfer-encoding;
        bh=Q20hsSqIK9N1fsrrtzR2ZDrK5Eduy9XRJzTCPunfP7M=;
        b=vt/GcZFggdwzSoCGmZAxYLyCMypzhPg/ahV/+M9VmuK1Qjp8hrYJSyUBdcWSNtV5G+
         6nywGWPP9mUdfu1W5w+OhXLejTjNer+nHwyVw1x7Pa8Y+TiCXc5xtTcD83nZf7znu9qz
         atHxAGDUrEdWIaTyz5px0vqA96jeztgtcJSqQ=
Received: by 10.231.73.139 with SMTP id q11mr4365588ibj.97.1320028105086; Sun,
 30 Oct 2011 19:28:25 -0700 (PDT)
Received: by 10.231.33.139 with HTTP; Sun, 30 Oct 2011 19:28:04 -0700 (PDT)
In-Reply-To: <CAEZo+gfKVY-YgMjd=bEYzRV4-460kqDik-yVcQ9Xs=DoCZOMDg@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/184490>

Is it possible to let git clone continue last break point.
when we git clone very large project from the web,=C2=A0 we may face so=
me
interupt, then we must clone it from zero .

it is bad feeling for low=C2=A0 connection=C2=A0 speed users.

please help us out.

we need git clone continue last break point

netroby
----------------------------------
http://www.netroby.com
