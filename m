From: Pascal Obry <pascal@obry.net>
Subject: Re: Reverting a specific commit
Date: Thu, 23 Sep 2010 11:05:23 +0200
Message-ID: <AANLkTinogubdAZkA272ryG9qr9D=T5H9PwHPth3ThoQ9@mail.gmail.com>
References: <1285226023268-5561992.post@n2.nabble.com>
	<AANLkTi=8gfw3FbReaCmf=tVnu2CEajCLmW-7whn27cya@mail.gmail.com>
	<1285228861635-5562096.post@n2.nabble.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: milindkanchan <milindkanchan@gmail.com>
X-From: git-owner@vger.kernel.org Thu Sep 23 11:05:33 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OyhkC-0004n1-Ap
	for gcvg-git-2@lo.gmane.org; Thu, 23 Sep 2010 11:05:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753718Ab0IWJFZ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 23 Sep 2010 05:05:25 -0400
Received: from mail-qy0-f181.google.com ([209.85.216.181]:44751 "EHLO
	mail-qy0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752213Ab0IWJFY convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 23 Sep 2010 05:05:24 -0400
Received: by qyk33 with SMTP id 33so2055994qyk.19
        for <git@vger.kernel.org>; Thu, 23 Sep 2010 02:05:23 -0700 (PDT)
Received: by 10.224.28.207 with SMTP id n15mr1081841qac.50.1285232723240; Thu,
 23 Sep 2010 02:05:23 -0700 (PDT)
Received: by 10.229.95.75 with HTTP; Thu, 23 Sep 2010 02:05:23 -0700 (PDT)
In-Reply-To: <1285228861635-5562096.post@n2.nabble.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/156859>

On Thu, Sep 23, 2010 at 10:01 AM, milindkanchan <milindkanchan@gmail.co=
m> wrote:
>
> But will it affect the commits done after that

No. It is a revert. I will create a new commit that revert the work
done for the given commit.

Pascal.

--=20

--|------------------------------------------------------
--| Pascal Obry=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=A0 T=
eam-Ada Member
--| 45, rue Gabriel Peri - 78114 Magny Les Hameaux FRANCE
--|------------------------------------------------------
--|=A0 =A0 =A0 =A0 =A0 =A0 =A0 http://www.obry.net
--| "The best way to travel is by means of imagination"
--|
--| gpg --keyserver wwwkeys.pgp.net --recv-key C1082595
