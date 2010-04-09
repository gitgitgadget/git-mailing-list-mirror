From: Sverre Rabbelier <srabbelier@gmail.com>
Subject: Re: [PATCH v2] Makefile: Simplify handling of python scripts
Date: Fri, 9 Apr 2010 18:05:43 +0200
Message-ID: <n2qfabb9a1e1004090905u7a28136bzc1bf556f1d6149e0@mail.gmail.com>
References: <i2ifabb9a1e1004090839hd55a81bfid820180815c8d94d@mail.gmail.com> 
	<1270828665-29373-1-git-send-email-brian@gernhardtsoftware.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git List <git@vger.kernel.org>
To: Brian Gernhardt <brian@gernhardtsoftware.com>
X-From: git-owner@vger.kernel.org Fri Apr 09 18:06:15 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O0Gik-0001aJ-Ve
	for gcvg-git-2@lo.gmane.org; Fri, 09 Apr 2010 18:06:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753682Ab0DIQGI convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 9 Apr 2010 12:06:08 -0400
Received: from qw-out-2122.google.com ([74.125.92.25]:58136 "EHLO
	qw-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752783Ab0DIQGF convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 9 Apr 2010 12:06:05 -0400
Received: by qw-out-2122.google.com with SMTP id 8so1247070qwh.37
        for <git@vger.kernel.org>; Fri, 09 Apr 2010 09:06:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :from:date:received:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=WfqfWtL4pYaZmI5Ug+p7L3XYtVxG065Y3/CQmGDWylU=;
        b=D7Ao+CPi25NdyrDtjVoumK+97Wx71e9q9+dthxDoO+aFsqeRpEr3/m4O2KEVgv42Aw
         ypm40yPfbCa9jBVHvl7E8jl8qp92RM+qaFcbV5/bU8clegDgMbtqX1cZpw63LBwBhE1S
         9LmsKvapZsAnN0GC2QzlaejmEW2U2Xh7VqUsc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=i/nJh14Ibu/H/pHDZyUsEl8yGWIMdQF0+EZqIS6vzXEYUIvTRX897m7IW8iM9gb1vy
         /uLAOoYydFEfUv5wKQcSSMrisa8/tzsShGs+5Kdfrax4m83nkssujLDLS8enD0Xt7LRm
         3Lvag5BKQ/dIoSvVmWE4NtJ1i0a3U4mZ36iuQ=
Received: by 10.224.74.3 with HTTP; Fri, 9 Apr 2010 09:05:43 -0700 (PDT)
In-Reply-To: <1270828665-29373-1-git-send-email-brian@gernhardtsoftware.com>
Received: by 10.224.70.129 with SMTP id d1mr77544qaj.357.1270829163165; Fri, 
	09 Apr 2010 09:06:03 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/144448>

 Heya,

On Fri, Apr 9, 2010 at 17:57, Brian Gernhardt
<brian@gernhardtsoftware.com> wrote:
> =C2=A0Certainly. =C2=A0(And the commit message is the only change fro=
m v1.)

Thanks, very clear!

Acked-by: Sverre Rabbelier <srabbelier@gmail.com>

--=20
Cheers,

Sverre Rabbelier
