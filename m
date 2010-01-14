From: Martin Langhoff <martin.langhoff@gmail.com>
Subject: Re: [PATCH] git push --track
Date: Thu, 14 Jan 2010 15:35:11 +0100
Message-ID: <46a038f91001140635t38328ddbq3fc0bbced013e25b@mail.gmail.com>
References: <op.u6g8jnixg402ra@nb-04> <871vht7cs2.fsf@catnip.gol.com>
	 <46a038f91001140544u64dd7eefn94625cdc40881cd6@mail.gmail.com>
	 <alpine.DEB.1.00.1001141509230.3029@intel-tinevez-2-302>
	 <vpqiqb4lq4q.fsf@bauges.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Miles Bader <miles@gnu.org>,
	Rudolf Polzer <divVerent@alientrap.org>, git@vger.kernel.org
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Thu Jan 14 15:35:33 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NVQnM-0003GO-CS
	for gcvg-git-2@lo.gmane.org; Thu, 14 Jan 2010 15:35:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754274Ab0ANOfW convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 14 Jan 2010 09:35:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754230Ab0ANOfV
	(ORCPT <rfc822;git-outgoing>); Thu, 14 Jan 2010 09:35:21 -0500
Received: from mail-ew0-f209.google.com ([209.85.219.209]:63075 "EHLO
	mail-ew0-f209.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754242Ab0ANOfQ convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 14 Jan 2010 09:35:16 -0500
Received: by ewy1 with SMTP id 1so49676ewy.28
        for <git@vger.kernel.org>; Thu, 14 Jan 2010 06:35:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=Sg6Qf99AXbMANKKgg1YsbmiNrWH/YmpB17cefR5V7dk=;
        b=o7hc8MmHBnwBe++VBkLJCeLVOqT7lCRbXN1wbE8zPs/UxuzowKs88O3tuijwjIlA5d
         OrhvlZe+X772lHoONFK2xNzl1mfy1MqKfAAPGsuHIcNbxzfHHsYVAj8faUOEHEjPbkDc
         ZMB7gkb7NShJDa0aHaOs+6byJ+bPV7gejzO+U=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=XIK8GdwELNJaOR3RB/OyGPnUKVN/scaM9hVUft8EyWqq6ymADL1kv4GXPx21XZzfaN
         Psl+/U6gY+P0mbNXIqx31gB3CzrziCqlRvWN/JyunHnX391ZOc4eqHgIS+VzUWxSTwnn
         rocEux3zWFBC1HglaiNl6ksHd3KPozeUfeGCQ=
Received: by 10.213.99.210 with SMTP id v18mr556141ebn.48.1263479711990; Thu, 
	14 Jan 2010 06:35:11 -0800 (PST)
In-Reply-To: <vpqiqb4lq4q.fsf@bauges.imag.fr>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/136996>

On Thu, Jan 14, 2010 at 3:25 PM, Matthieu Moy
<Matthieu.Moy@grenoble-inp.fr> wrote:
> I think he meant
>
> =A0git --git-dir=3Dgit+ssh://foo.bar/var/git/mynewthing.git init

exacto. And push --track, all in one cmd.

Zooper easy for users.



m
--=20
 martin.langhoff@gmail.com
 martin@laptop.org -- School Server Architect
 - ask interesting questions
 - don't get distracted with shiny stuff  - working code first
 - http://wiki.laptop.org/go/User:Martinlanghoff
