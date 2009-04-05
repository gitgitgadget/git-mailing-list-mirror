From: Sverre Rabbelier <srabbelier@gmail.com>
Subject: Re: Running 'git pull' from an unnamed branch
Date: Sun, 5 Apr 2009 23:37:39 +0200
Message-ID: <fabb9a1e0904051437i75ea0aeci33759a464a412a17@mail.gmail.com>
References: <3f4fd2640904051433u199587c3wc9bf080d138944e7@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git List <git@vger.kernel.org>
To: Reece Dunn <msclrhd@googlemail.com>
X-From: git-owner@vger.kernel.org Sun Apr 05 23:39:33 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lqa3s-0005jG-PP
	for gcvg-git-2@gmane.org; Sun, 05 Apr 2009 23:39:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754005AbZDEVh5 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 5 Apr 2009 17:37:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754003AbZDEVh5
	(ORCPT <rfc822;git-outgoing>); Sun, 5 Apr 2009 17:37:57 -0400
Received: from mail-fx0-f158.google.com ([209.85.220.158]:37394 "EHLO
	mail-fx0-f158.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753644AbZDEVh4 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 5 Apr 2009 17:37:56 -0400
Received: by fxm2 with SMTP id 2so1645004fxm.37
        for <git@vger.kernel.org>; Sun, 05 Apr 2009 14:37:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:date
         :received:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=8qj1WRGxzwbs+pX/urITlPmqVLr/8Z8STfI/uaCRnTw=;
        b=KBwPH/3IgZYEgCClQrAy5v3I8WjFsNPh0ipHn9pstlqKdEojHAZsqb+hdi7HpR9eVF
         ECL3X9gtwfahaPH7YfzozkjEvmbdEtNjjgMtTQkjmytbXjwH5+0J776PgAHkkB1POMEL
         rNSblW6kAIMWbNKoKOyiF3uPParRkNBGBBe4g=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=KH6VQVNvrE2zWSIOeypRaLKy6pMXjymG2kJ1uPcVdkkqLHRPKLkd72vEzq9MiKMElc
         UItYbGBbw5wWoG7n+OmI4HIRNiJ6gKHmq5KeWmHLdODPCJJI2cfg4z7WtOeDi1ZU4sp7
         hhCOKPtnL4loUPVOp4qkUIqiM+uwRfcZDVfvM=
In-Reply-To: <3f4fd2640904051433u199587c3wc9bf080d138944e7@mail.gmail.com>
Received: by 10.103.192.2 with SMTP id u2mr1652649mup.2.1238967474175; Sun, 05 
	Apr 2009 14:37:54 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/115718>

Heya,

On Sun, Apr 5, 2009 at 23:33, Reece Dunn <msclrhd@googlemail.com> wrote=
:
> + =A0 =A0 =A0 echo "You may not be on a branch. In this case, you nee=
d to move"
> + =A0 =A0 =A0 echo "onto the branch you want to pull to (usually mast=
er):"
> + =A0 =A0 =A0 echo " =A0 =A0git checkout <branch>"
> + =A0 =A0 =A0 echo

Please, there's already 17 lines of spam each time I type 'git pull',
let's not embed the entire user manual!

--=20
Cheers,

Sverre Rabbelier
