From: Sverre Rabbelier <srabbelier@gmail.com>
Subject: Re: [ANNOUNCE] JGit 0.7.1 / EGit 0.7.1
Date: Mon, 29 Mar 2010 20:51:49 -0500
Message-ID: <fabb9a1e1003291851i73bc1389hadc6380a2884b678@mail.gmail.com>
References: <20100330012323.GD32653@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git <git@vger.kernel.org>
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Tue Mar 30 03:52:17 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NwQcq-00021V-N5
	for gcvg-git-2@lo.gmane.org; Tue, 30 Mar 2010 03:52:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754976Ab0C3BwL convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 29 Mar 2010 21:52:11 -0400
Received: from mail-bw0-f209.google.com ([209.85.218.209]:33662 "EHLO
	mail-bw0-f209.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754842Ab0C3BwL convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 29 Mar 2010 21:52:11 -0400
Received: by bwz1 with SMTP id 1so4025331bwz.21
        for <git@vger.kernel.org>; Mon, 29 Mar 2010 18:52:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :from:date:received:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=xp5XbBzxMaziQWxMYWr7notaul4yaSRNGO3rpz1qeGM=;
        b=GSIp5KYACi/v8pcRwndFVoAVuxUcz6YvFncGXR0x/b6Os7hCtSWS8DCIsr3ALXrEIq
         tUobjbiVtFzB1hMDYIWeiBRKiTvNcvR7D/h37zsvHUPxlM+wIh/b7rmmniegC+maYfX5
         aIRFrhG29zNHraptFWTRLw+en42ZTBMpYETWI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=jfbvQPNj6dQjQRFCzmgZDhR6sSectlbmPSUNN5bfNtg3AvUxZq1M12aZyzoC9Cq18A
         NQkO8YngHdR9GH61H6uHJuQo1elOkQEHzn7IoHSMHkRhpvaEZ78/RTlA4bLWO1LQDqtM
         5xikc5pYsOj4xEgd1sJ9wD0SK4rcmTiOz/9rA=
Received: by 10.204.142.7 with HTTP; Mon, 29 Mar 2010 18:51:49 -0700 (PDT)
In-Reply-To: <20100330012323.GD32653@spearce.org>
Received: by 10.204.36.199 with SMTP id u7mr4199841bkd.212.1269913929121; Mon, 
	29 Mar 2010 18:52:09 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/143535>

Heya,

On Mon, Mar 29, 2010 at 20:23, Shawn O. Pearce <spearce@spearce.org> wr=
ote:
> In mid-2009 the EGit and JGit projects started to move to the
> Eclipse Foundation. =A0Last week both projects shipped version 0.7.1,
> which is our first release since 0.5.0 in June 2009.

Congratulations!

> But most of the release was us figuring out how to navigate the
> Eclipse Foundation's processes, so there aren't many new features
> relative to 0.5.0.

I hope the next release will be easier on you guys :).

--=20
Cheers,

Sverre Rabbelier
