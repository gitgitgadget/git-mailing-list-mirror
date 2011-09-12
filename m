From: Sverre Rabbelier <srabbelier@gmail.com>
Subject: Re: What's cooking in git.git (Sep 2011, #03; Sun, 11)
Date: Mon, 12 Sep 2011 10:16:11 +0200
Message-ID: <CAGdFq_jDrVeO99K4oujs4-7tRL9TbNS26_=wknNcGEecc505Tg@mail.gmail.com>
References: <7vwrde9t6h.fsf@alter.siamese.dyndns.org> <vpqehzm6wrt.fsf@bauges.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Mon Sep 12 10:17:06 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R31hR-0008T5-H3
	for gcvg-git-2@lo.gmane.org; Mon, 12 Sep 2011 10:17:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752263Ab1ILIQx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 12 Sep 2011 04:16:53 -0400
Received: from mail-yw0-f46.google.com ([209.85.213.46]:60329 "EHLO
	mail-yw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751987Ab1ILIQw (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 Sep 2011 04:16:52 -0400
Received: by ywb5 with SMTP id 5so558458ywb.19
        for <git@vger.kernel.org>; Mon, 12 Sep 2011 01:16:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=cNTQj5gdi+klI1wnKPK2AhRrfUPQ4wOhe+MBG95BYao=;
        b=FbJakVVY/RutaWegu+o6OshZrLR2euBywzaOvOJMTeR/qgAjLNzPmTVrntr6JoAufV
         okZkhKdeoxn+lng7VL4wviBBsQuv7NcgemKzesS9aoYXeeb7MmI2+U5HcYIvd/IXOvMI
         YG8aJNMXnfpHS4oxf3CBm37vxZCiRqDq24ceY=
Received: by 10.68.14.163 with SMTP id q3mr1159969pbc.98.1315815411076; Mon,
 12 Sep 2011 01:16:51 -0700 (PDT)
Received: by 10.68.59.39 with HTTP; Mon, 12 Sep 2011 01:16:11 -0700 (PDT)
In-Reply-To: <vpqehzm6wrt.fsf@bauges.imag.fr>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/181214>

Heya,

On Mon, Sep 12, 2011 at 09:32, Matthieu Moy
<Matthieu.Moy@grenoble-inp.fr> wrote:
> I agree it's not urgent, but this serie doesn't touch the code itself,
> so it should be pretty harmless. It fixes some relatively important
> documentation issues, and a nice side effect of putting them in a
> release soon would be to update the doc available at
> http://www.kernel.org/pub/software/scm/git/docs/git-remote-helpers.html
> (when kernel.org is not down).

Agreed. Do we have a different policy for documentation cooking than
code though?

-- 
Cheers,

Sverre Rabbelier
