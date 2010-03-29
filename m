From: Sverre Rabbelier <srabbelier@gmail.com>
Subject: Re: [RFC PATCH] Write new giturl(7) manpage
Date: Mon, 29 Mar 2010 09:59:52 -0600
Message-ID: <fabb9a1e1003290859p25be2d7aqc7dcb46f3ec7ba4f@mail.gmail.com>
References: <f3271551003290759g154b149fl7877d9b83e1313e6@mail.gmail.com> 
	<alpine.LNX.2.00.1003291140270.14365@iabervon.org> <20100329155523.GA31829@LK-Perkele-V2.elisa-laajakaista.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Daniel Barkalow <barkalow@iabervon.org>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Git Mailing List <git@vger.kernel.org>,
	Gabriel Filion <lelutin@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Michael J Gruber <git@drmicha.warpmail.net>,
	Jonathan Nieder <jrnieder@gmail.com>
To: Ilari Liusvaara <ilari.liusvaara@elisanet.fi>
X-From: git-owner@vger.kernel.org Mon Mar 29 18:00:32 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NwHO8-0007Xj-Mf
	for gcvg-git-2@lo.gmane.org; Mon, 29 Mar 2010 18:00:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754540Ab0C2QAR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 29 Mar 2010 12:00:17 -0400
Received: from mail-bw0-f209.google.com ([209.85.218.209]:58138 "EHLO
	mail-bw0-f209.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754529Ab0C2QAO (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 29 Mar 2010 12:00:14 -0400
Received: by bwz1 with SMTP id 1so3685012bwz.21
        for <git@vger.kernel.org>; Mon, 29 Mar 2010 09:00:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :from:date:received:message-id:subject:to:cc:content-type;
        bh=kRzaRkM5Rb3WtJPZMUbLPIAPeO1xn29fDngDEwap9is=;
        b=iY+3Mh9ARvpWZZVznAkm2NReYEZxdKxDBHvpf3HBlNKS26QqHyupji8ezwgSt6eDn7
         4hHFHnG+HNjld6ZE5IHlLP60ZfvUWcCbnL1Pe+FJarpVgpVjRqLoEqmBFCid65leerLX
         mpORm85jE4YIvmvphblIRJxAs4KcvV0HcnLz4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        b=YHSTPzhnkPANtAu9Es7rjhFGFYHxZtb8DqoD4oGz9iccyg+ootEDKUztGWT+QzxeDz
         Ioql1Sb0U9wZtclojxlkkqauneB3gMy8VwXy+dUz2Fi0m6JeTTlQdW0BLjWaOzpQpgZ1
         h+DAV3aqnNwRotvaEy0jGKVwr9366ehjhU3m8=
Received: by 10.204.142.7 with HTTP; Mon, 29 Mar 2010 08:59:52 -0700 (PDT)
In-Reply-To: <20100329155523.GA31829@LK-Perkele-V2.elisa-laajakaista.fi>
Received: by 10.204.80.36 with SMTP id r36mr1837517bkk.75.1269878412353; Mon, 
	29 Mar 2010 09:00:12 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/143487>

Heya,

On Mon, Mar 29, 2010 at 09:55, Ilari Liusvaara
<ilari.liusvaara@elisanet.fi> wrote:
> AFAICT, urls.txt hasn't been touched since this commit.

Yup, my bad for not updating urls.txt (mainly because I didn't know it
existed :P). I think Ramkumar's patch [0] to fix that is a step in the
right direction :).

[] http://mid.gmane.org/f3271551003290810u4edbbbd0x2432bc7411333800@mail.gmail.com

-- 
Cheers,

Sverre Rabbelier
