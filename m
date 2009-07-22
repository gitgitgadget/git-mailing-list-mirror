From: Sverre Rabbelier <srabbelier@gmail.com>
Subject: Re: Why is it important to learn git?
Date: Wed, 22 Jul 2009 18:15:10 +0000
Message-ID: <fabb9a1e0907221115x212c4b52q47cac29cf0336fc@mail.gmail.com>
References: <e1a5e9a00907212208t10a071d0oe59a39b357a1111a@mail.gmail.com> 
	<200907220952.27385.trast@student.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Tim Harper <timcharper@gmail.com>, git@vger.kernel.org
To: Thomas Rast <trast@student.ethz.ch>
X-From: git-owner@vger.kernel.org Wed Jul 22 20:15:43 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MTgLs-0002P6-W8
	for gcvg-git-2@gmane.org; Wed, 22 Jul 2009 20:15:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752648AbZGVSPc convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 22 Jul 2009 14:15:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751476AbZGVSPc
	(ORCPT <rfc822;git-outgoing>); Wed, 22 Jul 2009 14:15:32 -0400
Received: from mail-ew0-f226.google.com ([209.85.219.226]:62707 "EHLO
	mail-ew0-f226.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751157AbZGVSPc convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 22 Jul 2009 14:15:32 -0400
Received: by ewy26 with SMTP id 26so428163ewy.37
        for <git@vger.kernel.org>; Wed, 22 Jul 2009 11:15:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :from:date:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=G4U6R9Zzv1NvLeFqkjGeT6D3sftjQEvhCw2rHIApy7s=;
        b=lYSDXTK0ALrn6gZQx0G3MuTHxSG5xHTkBgdIhJ1adv0+RuLuLmfzaV3JbOAvYanSrH
         i/F3m9golzXSVVsfvum8ItNLe3KS9Qi88t++jBAyVQQBjGBOmnE5cJxSbzwC0Ylv9tjz
         2TLnged5Fmg+c81VwAhO86XODPJrXkXJhYMBI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=TZCtxr1upJTagsaw3+GvvkNrPXXuZtvobHBd72E41fhaS/vWqKhzB3PVEvyG42aHCc
         aKYD4tP+eaipBEAk1RS3aInERo89SFtQyqCiVf09YQIPtQWkTxJODY8ipv4FHFU9TTc8
         yUy1mhEjUyBYFQBvaZDiJhTi1relgOSSYn4vg=
Received: by 10.216.45.65 with SMTP id o43mr331026web.4.1248286530132; Wed, 22 
	Jul 2009 11:15:30 -0700 (PDT)
In-Reply-To: <200907220952.27385.trast@student.ethz.ch>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/123765>

Heya,

On Wed, Jul 22, 2009 at 07:52, Thomas Rast<trast@student.ethz.ch> wrote=
:
> =A0Learning to make nice, reviewable, working, one-change-per-revisio=
n
> =A0commits.

I very much agree with those values, but also

  Commit early, commit often

It's very convenient to be able to go back to/diff with a previous
version later on, running 'git commit -am "got x half-working"' takes
only a few seconds, but can save hours later on when you got x
totally-not-working-at-all-anymore.

--=20
Cheers,

Sverre Rabbelier
