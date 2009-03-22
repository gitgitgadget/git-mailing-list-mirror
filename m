From: Sverre Rabbelier <srabbelier@gmail.com>
Subject: Re: Newbie: Do I need to download the entire repo to work on just 1 
	file?
Date: Mon, 23 Mar 2009 00:00:59 +0100
Message-ID: <fabb9a1e0903221600j22cf028fl903aef8076e53777@mail.gmail.com>
References: <BLU121-W15DB0E5CEBC1DA697E5ED8B4950@phx.gbl>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Anthony Rasmussen <evoluenta@hotmail.com>
X-From: git-owner@vger.kernel.org Mon Mar 23 00:02:48 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LlWgm-00025u-Ak
	for gcvg-git-2@gmane.org; Mon, 23 Mar 2009 00:02:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756454AbZCVXBT convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 22 Mar 2009 19:01:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756371AbZCVXBS
	(ORCPT <rfc822;git-outgoing>); Sun, 22 Mar 2009 19:01:18 -0400
Received: from mail-fx0-f158.google.com ([209.85.220.158]:39296 "EHLO
	mail-fx0-f158.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756312AbZCVXBR convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 22 Mar 2009 19:01:17 -0400
Received: by fxm2 with SMTP id 2so1578077fxm.37
        for <git@vger.kernel.org>; Sun, 22 Mar 2009 16:01:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:date
         :received:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=QW+zfAbRLlmk8Q2TOTqT8FXpizqLoDvZMJQaZkbTqsw=;
        b=wTRvTVy2tbX02vgJSAa8msKdyzTVLGRduj7bC1Lcw9+qCJWIKyJZnvZP+c2djI6jQX
         kj7YwLmagYOmPMxFxAV2U58tWcgVwpUt4kwg+unzwxZ/cZ5tagtKu/C0igkvpLIcZl2l
         Y4kwRCHpW1mD28HKRPypM7dbfRjfQvKq6ECVE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=GYYkurZ078J/BCe+SqAvhbaYUvVeNp8431F8g0ialcFx3p2qqWfIgC74qkJt8iGtg7
         t5fHcc+2zGvOsjtp7z06lzHYpPiC1CskCigSLOBjfzS+WuZLu79LinU+436Y1VPJy/v9
         zEg5C+CXXX0VE5L4zA/wl8sqxj9wL5HAd27K0=
In-Reply-To: <BLU121-W15DB0E5CEBC1DA697E5ED8B4950@phx.gbl>
Received: by 10.103.244.19 with SMTP id w19mr2763823mur.134.1237762874327; 
	Sun, 22 Mar 2009 16:01:14 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/114195>

Heya,

On Sun, Mar 22, 2009 at 23:08, Anthony Rasmussen <evoluenta@hotmail.com=
> wrote:
> Do I have to download the entire rep onto my laptop in order to do th=
is? =A0I have read and read, but I am quite confused :)

Yes, you do, in general though, git repositories are quite compact
compared to, say, a svn checkouts. It is not unheard of that the full
git clone is smaller than the same code as svn checkout.

--=20
Cheers,

Sverre Rabbelier
