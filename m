From: demerphq <demerphq@gmail.com>
Subject: Re: [PATCH RFC 6/6] send-email: Remove horrible mix of tabs and 
	spaces
Date: Tue, 7 Apr 2009 23:35:07 +0200
Message-ID: <9b18b3110904071435p320e5d1dh16061d04a3a8ab57@mail.gmail.com>
References: <1239139522-24118-1-git-send-email-mfwitten@gmail.com>
	 <1239139522-24118-2-git-send-email-mfwitten@gmail.com>
	 <1239139522-24118-3-git-send-email-mfwitten@gmail.com>
	 <1239139522-24118-4-git-send-email-mfwitten@gmail.com>
	 <1239139522-24118-5-git-send-email-mfwitten@gmail.com>
	 <1239139522-24118-6-git-send-email-mfwitten@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Michael Witten <mfwitten@gmail.com>
X-From: git-owner@vger.kernel.org Tue Apr 07 23:37:08 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LrIyU-0005oQ-0O
	for gcvg-git-2@gmane.org; Tue, 07 Apr 2009 23:36:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932112AbZDGVfN convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 7 Apr 2009 17:35:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760881AbZDGVfL
	(ORCPT <rfc822;git-outgoing>); Tue, 7 Apr 2009 17:35:11 -0400
Received: from mail-qy0-f118.google.com ([209.85.221.118]:56451 "EHLO
	mail-qy0-f118.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760773AbZDGVfJ convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 7 Apr 2009 17:35:09 -0400
Received: by qyk16 with SMTP id 16so5305716qyk.33
        for <git@vger.kernel.org>; Tue, 07 Apr 2009 14:35:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=l17pIOcTuwcpF93bAH1UwN8MKQ58T09FULKvypSqOrQ=;
        b=rLoxIcNdp2lnV+/A2LVs/Xj5qmNims+gVvA7TpwauNIgkq3o/Z1gKzxVScfpt6e3F1
         ZSO4vWgwyJwrgmJ6KQpub8ig9/OyPEZ/zBc9qgVgWliv5TRfGCuKZLXRkuwcVNkD9fKA
         Ljl3icA6GoX6QQkooZYDAXgTnVQNfxMix0sBY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=Wez/+IwLabVn3MkRIqwvxGblqzkyWFasv18DbPL4tFPz2v28ZxBBElJf6K1wQVO+a+
         Hdw8VIOd0dN7GwbI4MV3t9KwEbUL3eoajqWJ7if6UpAfc/jTrNyr8F10AkmSHmVXXxDs
         GiWMUi8e5AA6dfISfvLEVuJdvUQdqofDWO7io=
Received: by 10.231.15.202 with SMTP id l10mr199916iba.35.1239140107441; Tue, 
	07 Apr 2009 14:35:07 -0700 (PDT)
In-Reply-To: <1239139522-24118-6-git-send-email-mfwitten@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/115994>

2009/4/7 Michael Witten <mfwitten@gmail.com>:
> +## WARNING! ACHTUNG! ATTENTION! ADVERTENCIA!
> +## =A0 Currently, this file uses tabs (like the rest of git source) =
to
> +## =A0 delineate code structure. Do NOT under any circumstances mix =
tabs
> +## =A0 and spaces across lines that share a relationship in terms of=
 layout.
> +## =A0 In fact, it would currently be best to use only tabs, so plea=
se set
> +## =A0 your editor(s) accordingly. This code is already trashy enoug=
h. Please
> +## =A0 don't make it worse.

Perltidy the file?

Yves


--=20
perl -Mre=3Ddebug -e "/just|another|perl|hacker/"
