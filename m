From: Dmitry Potapov <dpotapov@gmail.com>
Subject: Re: fatal: unable to run 'git-svn'
Date: Fri, 17 Apr 2009 20:36:26 +0400
Message-ID: <37fcd2780904170936w10dc2f41odd9d71a03ba9125a@mail.gmail.com>
References: <loom.20090417T075701-666@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Jean-Marie Gaillourdet <jmg@gaillourdet.net>
X-From: git-owner@vger.kernel.org Fri Apr 17 18:40:25 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lur4v-0007tC-2f
	for gcvg-git-2@gmane.org; Fri, 17 Apr 2009 18:38:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756944AbZDQQgb convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 17 Apr 2009 12:36:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753158AbZDQQgb
	(ORCPT <rfc822;git-outgoing>); Fri, 17 Apr 2009 12:36:31 -0400
Received: from mail-fx0-f158.google.com ([209.85.220.158]:47201 "EHLO
	mail-fx0-f158.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755857AbZDQQga convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 17 Apr 2009 12:36:30 -0400
Received: by fxm2 with SMTP id 2so987722fxm.37
        for <git@vger.kernel.org>; Fri, 17 Apr 2009 09:36:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=CRK9aG8mZ0VMT5XQTAcMKAaEw/tk8t9oMA/h8PTvmHk=;
        b=HXjlAzaqVRVKnUZeUa31YgGIMW2R43bW32pkOBeLqwr32U7omm/SdFTwhU7zVQavas
         yZglnuMPvjMA+KgwHS0TB8bpOKCjB/qyRMsP0ttN/IyL5jIUaoC2sXGw/t0wOpLGUzHd
         H9ERGZdVfjMwCOvBQbMNkrpVRFCcKCoBG5N4o=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=dXVvxvZ6aGS+f6feZFgZ+iFAL3bOs3g6X4RnJmb2bNNEsV2rFOxKg7Chd8qZ8akk3l
         uqg3cD9GZirZm8kiFEk1iP35mbifzMOaEk8j/pSFcH6apwP8+2JAXFO/OvDVvIuvQ25b
         8rcOceJR0IduMMKpioEBV28WsaynxCW2KyOyE=
Received: by 10.86.63.5 with SMTP id l5mr2091784fga.63.1239986186520; Fri, 17 
	Apr 2009 09:36:26 -0700 (PDT)
In-Reply-To: <loom.20090417T075701-666@post.gmane.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/116758>

On Fri, Apr 17, 2009 at 12:08 PM, Jean-Marie Gaillourdet
<jmg@gaillourdet.net> wrote:
>
> several hundered revisions are imported
> ...
> r896 =3D 6a91d0d15864c174fe8d001e03c579d1968ab926 (git-svn)
> =A0 =A0 =A0 =A0A =A0 =A0 =A0 Uebungen/uebung08/README
> r897 =3D c2d0e0f317b54575598c8d3067f26a558b202745 (git-svn)
> fatal: unable to run 'git-svn'

Sounds similar to

http://thread.gmane.org/gmane.comp.version-control.git/114925/focus=3D1=
14957

but it is all what I know about it...

Dmitry
