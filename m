From: "=?ISO-8859-1?Q?Marc-Andr=E9_Lureau?=" <marcandre.lureau@gmail.com>
Subject: Re: [PATCH] git-svn: find-rev error message when missing arg
Date: Tue, 11 Mar 2008 10:04:55 +0200
Message-ID: <e29894ca0803110104g62cda988vf933349995673afd@mail.gmail.com>
References: <1205200346-5537-1-git-send-email-marcandre.lureau@gmail.com>
	 <20080311051910.GB9389@hand.yhbt.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: "Eric Wong" <normalperson@yhbt.net>
X-From: git-owner@vger.kernel.org Tue Mar 11 09:06:12 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JYzUT-0004Bt-QI
	for gcvg-git-2@gmane.org; Tue, 11 Mar 2008 09:05:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751461AbYCKIFB convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 11 Mar 2008 04:05:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751388AbYCKIFA
	(ORCPT <rfc822;git-outgoing>); Tue, 11 Mar 2008 04:05:00 -0400
Received: from hs-out-0708.google.com ([64.233.178.244]:45006 "EHLO
	hs-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751096AbYCKIE7 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 11 Mar 2008 04:04:59 -0400
Received: by hs-out-0708.google.com with SMTP id 4so1741538hsl.5
        for <git@vger.kernel.org>; Tue, 11 Mar 2008 01:04:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=+wOX35K1PjXNos5wxp13c8Lsrj1iT588nM8lY/ntnPo=;
        b=bH6txUsmWwcRL8PdhO+7FeSZcACaAgCzYnSaxEbD+DMkDg6ToA1Bxfb+uYyqGon8PUb9vvisM9ZCj2/WBxftivYLA29A/r5Ce0m0Cd88hm24/4QAizuo/NdoiZtgZvLBxxpgqDJtAA1DQh1H9RnqZiO2DZ6mdQRmvSIFiETeN6Q=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=FQSSQZ50ejXq4y7K2ec1r39EYXH4VX9SHoBL0ISKuNRlXoxkQJ5eHWQmjNN3bwCS9wQz41oiD688DL9/13UD17exoQ/4YyAoJ7dF1RncxurATiXx760ug7LF3VPsy1IZB02sDF7zkkp7uhKUsu3KmN6yCD+yIZh5wOcy51TATFA=
Received: by 10.115.73.20 with SMTP id a20mr4514926wal.32.1205222695807;
        Tue, 11 Mar 2008 01:04:55 -0700 (PDT)
Received: by 10.114.60.4 with HTTP; Tue, 11 Mar 2008 01:04:55 -0700 (PDT)
In-Reply-To: <20080311051910.GB9389@hand.yhbt.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/76811>

hi,

On Tue, Mar 11, 2008 at 7:19 AM, Eric Wong <normalperson@yhbt.net> wrot=
e:
>
>  * Minor spelling error noted below.
>  * Please wrap your commit message lines at 72 characters or less.
>  * Sign-off?
>
>  Tentatively-Acked-by: Eric Wong <normalperson@yhbt.net>

oups, I was too tired, I hope this second patch is fine.
Thanks for reviewing :)

Regards,

--=20
Marc-Andr=E9 Lureau
