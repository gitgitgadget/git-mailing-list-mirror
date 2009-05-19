From: Sverre Rabbelier <srabbelier@gmail.com>
Subject: Re: [PATCH 2/3] parse-options: add PARSE_OPT_CUSTOM_ARGH for 
	complicated argh's
Date: Tue, 19 May 2009 07:09:03 +0200
Message-ID: <fabb9a1e0905182209r2c6ae99fh491a35337abbe548@mail.gmail.com>
References: <1242557224-8411-1-git-send-email-bebarino@gmail.com> 
	<1242557224-8411-2-git-send-email-bebarino@gmail.com> <7vd4a7ey4h.fsf@alter.siamese.dyndns.org> 
	<4A11096B.8020208@gmail.com> <7vmy9aetc8.fsf@alter.siamese.dyndns.org> 
	<4A1116FF.8030008@gmail.com> <m3vdnyja8i.fsf@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Stephen Boyd <bebarino@gmail.com>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Tue May 19 07:09:41 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M6Ha7-0005gD-FW
	for gcvg-git-2@gmane.org; Tue, 19 May 2009 07:09:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753415AbZESFJY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 19 May 2009 01:09:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753359AbZESFJX
	(ORCPT <rfc822;git-outgoing>); Tue, 19 May 2009 01:09:23 -0400
Received: from mail-fx0-f158.google.com ([209.85.220.158]:63200 "EHLO
	mail-fx0-f158.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753072AbZESFJW (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 May 2009 01:09:22 -0400
Received: by fxm2 with SMTP id 2so3636323fxm.37
        for <git@vger.kernel.org>; Mon, 18 May 2009 22:09:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :from:date:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=GjPSrkehhFhCLLCpMvPmYk7QSrx6Fc4DFyRsVmc66Pg=;
        b=Tn3J/aNOvignnGlbCcaJI/wAgwO9rRqvwl0fwHoOmWBxsKnIGbnLxda+eCSFBwfrIq
         WHbxdRIR/H5m88IYPptvGaW4ImroCzmnJBY2BZaXT5F/b1tuBPn1FTmU9lh9exUrrKh9
         eI9g61OstUwCLxyY93KXO1tEWhq/chdM1c2fg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=ejblvURTREv675fuhG2Oi6L2BfFecxZMN7vINcgDuw2smbKxQopvbkKXMsu4MMGQ2W
         4lMInOEB3/EhBjAp6qK6NAmq3Ncd2cj+HkIn+I0O3JJq0knBuRb2O400/9V1p9jAcdAd
         btGlvzWre4ubHh2glSuhzNDhIODrSvyfTr8co=
Received: by 10.103.225.11 with SMTP id c11mr1816994mur.43.1242709763129; Mon, 
	18 May 2009 22:09:23 -0700 (PDT)
In-Reply-To: <m3vdnyja8i.fsf@localhost.localdomain>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/119491>

Heya,

On Tue, May 19, 2009 at 00:52, Jakub Narebski <jnareb@gmail.com> wrote:
> Well, 'ARGH' sounds a bit strange. I think I'd prefer ARGHELP. :-)

Yarr, it be reminding me of a patch from ye ol' mentor summit!

-- 
Cheers,

Sverre Rabbelier
