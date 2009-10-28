From: bill lam <cbill.lam@gmail.com>
Subject: Re: how to split a hunk
Date: Wed, 28 Oct 2009 23:26:51 +0800
Message-ID: <20091028152651.GC3956@debian.b2j>
References: <20091028022105.GE3938@debian.b2j>
 <21963906-785A-4D98-8AD8-A89ED914920C@adacore.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Cc: git <git@vger.kernel.org>
To: Geert Bosch <bosch@adacore.com>
X-From: git-owner@vger.kernel.org Wed Oct 28 16:27:06 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N3AQT-0000le-G7
	for gcvg-git-2@lo.gmane.org; Wed, 28 Oct 2009 16:27:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754142AbZJ1P0z (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 28 Oct 2009 11:26:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753849AbZJ1P0z
	(ORCPT <rfc822;git-outgoing>); Wed, 28 Oct 2009 11:26:55 -0400
Received: from mail-ew0-f208.google.com ([209.85.219.208]:36584 "EHLO
	mail-ew0-f208.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752324AbZJ1P0y (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 28 Oct 2009 11:26:54 -0400
Received: by ewy4 with SMTP id 4so851948ewy.37
        for <git@vger.kernel.org>; Wed, 28 Oct 2009 08:26:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=ESFnVFky6xd3FcWBE7X1C60nm1qBX37c9dXeFxoYPwo=;
        b=Ds3oYOT/mMF6I+EAaDc3gzu8YnzDjZtlFALYjqcFKWCVkW9EL90I09Z9ZCwhi4uBHM
         dxR0X4P6pdztCWtrhXBG0evRmguZxNbiBdczS61BVsBwOmIuXzFFd/KGAK2KX3A+IQLe
         Rejwy6LIoNbJZPqN2IpySW0Tgk3Vn4WY9HAwc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=SWbbH3LGVahsLtz5YvtP8DqkOvXZ6v9h+56uxkXAgS8yuFNSKQJwCK698J5pdBEc6I
         g1GgAqoDGAfImp1q/j3oO0YAqv1qMjr8lZayxHentRfAkIGpok9WZuWNE8VZ0p4sxkF3
         Wp33Ax7qKsqdoDfxpjGsPaFJ1pSDir1pwF2EI=
Received: by 10.216.89.149 with SMTP id c21mr1615832wef.224.1256743618393;
        Wed, 28 Oct 2009 08:26:58 -0700 (PDT)
Received: from localhost (n218103227169.netvigator.com [218.103.227.169])
        by mx.google.com with ESMTPS id i6sm3774176gve.2.2009.10.28.08.26.55
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 28 Oct 2009 08:26:57 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <21963906-785A-4D98-8AD8-A89ED914920C@adacore.com>
User-Agent: Mutt/1.5.20 (2009-08-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/131472>

On Tue, 27 Oct 2009, Geert Bosch wrote:
> I like to use "git gui" for this. This allows you to pick individual
> lines to commit. I really like the "git gui" interface for staging/unstaging
> changes and making a series of commits.

Thank you suggestion. However I did not use git-gui/gitk or have tcl
installed.

-- 
regards,
====================================================
GPG key 1024D/4434BAB3 2008-08-24
gpg --keyserver subkeys.pgp.net --recv-keys 4434BAB3
