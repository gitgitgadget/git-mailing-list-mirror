From: Avery Pennarun <apenwarr@gmail.com>
Subject: Re: [Announce] bup 0.09: git-based backup system for really huge 
	datasets
Date: Wed, 10 Feb 2010 15:01:08 -0500
Message-ID: <32541b131002101201n2d626152xe1aecd6697260b7f@mail.gmail.com>
References: <32541b131002091448o6f809322x1d86d2d7f74a80ed@mail.gmail.com> 
	<m3sk998lhq.fsf@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Wed Feb 10 21:01:40 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NfIki-00085C-E2
	for gcvg-git-2@lo.gmane.org; Wed, 10 Feb 2010 21:01:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753010Ab0BJUBc convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 10 Feb 2010 15:01:32 -0500
Received: from mail-yx0-f204.google.com ([209.85.210.204]:63269 "EHLO
	mail-yx0-f204.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751322Ab0BJUBa convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 10 Feb 2010 15:01:30 -0500
Received: by yxe42 with SMTP id 42so412998yxe.22
        for <git@vger.kernel.org>; Wed, 10 Feb 2010 12:01:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :from:date:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=kb5Viba7kLEpJeZRJwc4fDlLysMMoqqxvNtaol0L0Bo=;
        b=u+KRwxEdXkvcbuj+X66syCgZjpHluwIdGAh2OZK47dJPRCTMe7yFRPaY0AUNJOFHoX
         2i5V3YNBEJhPq1w8auAgrinysmA/KefqJtiGvaARjyMbIM7SDcYE37piRpH89JhhDQnp
         qiRA2WAWj4tuMz8q8sXUhIPQZMf0gw61DiksU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=JL4i2OwDc7gbNibS5XvxClVtcMJrknMz+5LXp04xJOaz59Pa/pYWGP6bg61UEgnqga
         zl9mL+OhaAtH49z/HpE6/vdglaW/xRIKY96b4FgJjn+2828JetkS49kXff7xI2Mhn23Q
         d+J0B+cls2xIdnoqHbGeJ+L4fkj0vyp21gNSg=
Received: by 10.150.128.42 with SMTP id a42mr3086837ybd.328.1265832088129; 
	Wed, 10 Feb 2010 12:01:28 -0800 (PST)
In-Reply-To: <m3sk998lhq.fsf@localhost.localdomain>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/139542>

On Wed, Feb 10, 2010 at 4:54 AM, Jakub Narebski <jnareb@gmail.com> wrot=
e:
> Avery Pennarun <apenwarr@gmail.com> writes:
>> bup is a file backup tool based on the git packfile format.
> [...]
>> bup is still pretty experimental, but it's already a useful tool for
>> backing up your files, even if those files include millions of files
>> and hundreds of gigs of VM images.
>>
>> You can find the source code (and README) at github:
>>
>> =A0 =A0 http://github.com/apenwarr/bup
>>
>> To subscribe to the bup mailing list, send an email to:
>>
>> =A0 =A0 bup-list+subscribe@googlegroups.com
>>
>> Looking forward to everyone's feedback.
>
> Would you be adding short info about your project to
> http://git.wiki.kernel.org/index.php/InterfacesFrontendsAndTools

Done.  Thanks for the reminder!

Have fun,

Avery
