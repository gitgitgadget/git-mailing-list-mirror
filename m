From: Sverre Rabbelier <srabbelier@gmail.com>
Subject: Re: Converting to Git using svn-fe (Was: Speeding up the initial
 git-svn fetch)
Date: Sat, 16 Oct 2010 21:25:21 -0500
Message-ID: <AANLkTinbaBs=xWwRVU42h91ox-qXzuhDcgP-13wn+QSp@mail.gmail.com>
References: <AANLkTim6w54CPhw0GzaDxT9e0t19XQ7-rMEe5aSBevS+@mail.gmail.com> <26761091.515858.1287188219315.JavaMail.root@mail.hq.genarts.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Matt Stump <mstump@goatyak.com>, git@vger.kernel.org,
	David Barr <david.barr@cordelta.com>,
	Tomas Carnecky <tom@dbservice.com>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Jonathan Nieder <jrnieder@gmail.com>
To: Stephen Bash <bash@genarts.com>
X-From: git-owner@vger.kernel.org Sun Oct 17 04:25:58 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P7Iwg-0003PT-63
	for gcvg-git-2@lo.gmane.org; Sun, 17 Oct 2010 04:25:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757269Ab0JQCZw convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 16 Oct 2010 22:25:52 -0400
Received: from mail-gx0-f174.google.com ([209.85.161.174]:48110 "EHLO
	mail-gx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757228Ab0JQCZm convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 16 Oct 2010 22:25:42 -0400
Received: by gxk6 with SMTP id 6so909830gxk.19
        for <git@vger.kernel.org>; Sat, 16 Oct 2010 19:25:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:mime-version:received:in-reply-to
         :references:from:date:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=qGZ2rLXsIwGnxry5B+p2TnojY7kfKzXRWR4lxhffcx8=;
        b=jUzVqMJw4VXo2ao3H73evcc3rhgNpXqMqA7CiHrpNPXvt68E+K+lRC8uAHav7YQvWy
         ZAI9ogvZtcNvw+iM86BZAFZ7sFlmqAjokCdQ4ZxO21fxt7gnd7QTbadu1jWBkYA8fWtd
         uCVveGisGCtftaQaPbR504HHseDVknpCeiZ2M=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=ZZ4EfkQObJq+Nb201UKZRLfnT1yvc6ewQC5wj7OPVJDcJ0C/GvuUaFvkgw4+CGLnFS
         ZRTFyzxEJm8yPq5Yc5YkWs6oFCUXNuJX1Yc/hZLFCuJd7sJ+wnFZNb1dqkG3OaMsSBXZ
         MB7ryxhN58/TIgbeqGSV2Hx8JMTdNyGXquZ2A=
Received: by 10.151.41.17 with SMTP id t17mr4249167ybj.443.1287282341439; Sat,
 16 Oct 2010 19:25:41 -0700 (PDT)
Received: by 10.151.15.8 with HTTP; Sat, 16 Oct 2010 19:25:21 -0700 (PDT)
In-Reply-To: <26761091.515858.1287188219315.JavaMail.root@mail.hq.genarts.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/159187>

Heya,

On Fri, Oct 15, 2010 at 19:16, Stephen Bash <bash@genarts.com> wrote:
> That idea along with a bunch of others are now brewing a 2.0 in
> my head since I started revisiting this proces. =C2=A0We'll see if I =
have a
> productive weekend or not...

Looking forward to seeing what you come up with :).

--=20
Cheers,

Sverre Rabbelier
