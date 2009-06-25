From: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
Subject: Re: [PATCHv5 1/3] gitweb: refactor author name insertion
Date: Thu, 25 Jun 2009 10:04:34 +0200
Message-ID: <cb7bb73a0906250104u46da8299q198f83acd1291387@mail.gmail.com>
References: <1245878183-2967-1-git-send-email-giuseppe.bilotta@gmail.com>
	 <1245878183-2967-2-git-send-email-giuseppe.bilotta@gmail.com>
	 <200906250939.56361.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Aaron Crane <git@aaroncrane.co.uk>,
	Nanako Shiraishi <nanako3@lavabit.com>
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jun 25 10:04:53 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MJjwt-0004fR-RV
	for gcvg-git-2@gmane.org; Thu, 25 Jun 2009 10:04:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752963AbZFYIEh convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 25 Jun 2009 04:04:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752246AbZFYIEg
	(ORCPT <rfc822;git-outgoing>); Thu, 25 Jun 2009 04:04:36 -0400
Received: from mail-bw0-f213.google.com ([209.85.218.213]:59185 "EHLO
	mail-bw0-f213.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751679AbZFYIEd convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 25 Jun 2009 04:04:33 -0400
Received: by bwz9 with SMTP id 9so1222076bwz.37
        for <git@vger.kernel.org>; Thu, 25 Jun 2009 01:04:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=A1Ozat9LomNBOKx+KwfKo1nt5Kmo1xCzqHzfof3AEIg=;
        b=W5Vi1LwccYYUIwTg6QW0El4zxrxaFELrb1a+l/n5k0jjdxMOMVpuMaJl/5I6ym7NCM
         GxEOlPe60Za3XnAxMnPK1k1Vg/Kt+S90ycv/yNnrrFDCpw1KfXwU7wVh725BgZ2sGL/a
         yjdnPMzcNrJQVCx9y/pCUVazp4+gjStKanpW4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=kKV3o82rGJP1GJv2Xa9cDoHK0vZdTg+i3jqZJhAYbkzJhU+Vhxgbn3lWoAhpyg4euo
         ZoXeIFwB+gE/3Gdu5+/FgZKH2V5+Tld6pSA8fuXFEW7mbLVhMZPaw7eEEtiJlBTyJZ4u
         B9brbbE+fYu8Mwn779VMBx+i0TmaI/rPvq1B8=
Received: by 10.204.53.143 with SMTP id m15mr2219508bkg.119.1245917074443; 
	Thu, 25 Jun 2009 01:04:34 -0700 (PDT)
In-Reply-To: <200906250939.56361.jnareb@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/122183>

2009/6/25 Jakub Narebski <jnareb@gmail.com>:
>
> Could you please state here, in the comments area, what are the
> differences between v4 (previous) and v5 (current) version of patch,
> and if there are any? =A0It helps with patch review...

Sorry. This patch was untouched because I only received your comments
on it this morning. I'm working on it right now so expect and new
patch series soon.

--=20
Giuseppe "Oblomov" Bilotta
