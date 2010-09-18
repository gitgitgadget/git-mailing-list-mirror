From: Jay Soffian <jaysoffian@gmail.com>
Subject: Re: Libcurl
Date: Sat, 18 Sep 2010 05:00:02 -0400
Message-ID: <AANLkTikQQAQnZRRdqoiO=cngbo8Y4U_QAnNZPz=pEit2@mail.gmail.com>
References: <4C943BF9.9040104@ihug.co.nz> <4C947B2B.308@op5.se> <4C947CC7.8030209@ihug.co.nz>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Andreas Ericsson <ae@op5.se>, git@vger.kernel.org
To: Jess McKenzie - JZM Web Development <jessmckenzie@ihug.co.nz>
X-From: git-owner@vger.kernel.org Sat Sep 18 11:00:51 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OwtHv-0001A1-Av
	for gcvg-git-2@lo.gmane.org; Sat, 18 Sep 2010 11:00:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755246Ab0IRJAe convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 18 Sep 2010 05:00:34 -0400
Received: from mail-vw0-f46.google.com ([209.85.212.46]:61327 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755158Ab0IRJAd convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 18 Sep 2010 05:00:33 -0400
Received: by vws3 with SMTP id 3so2086279vws.19
        for <git@vger.kernel.org>; Sat, 18 Sep 2010 02:00:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:mime-version:received:in-reply-to
         :references:from:date:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=tA0KEGkJ8vv47ie5UD0zocOmZ727JqlDmJaSgyo/V74=;
        b=FdjnvzFRq+ij76GW4ONoP5Uy0q9eEUX3+7NlfZhF+3+eubdjZjJgLv3HFwT/yDGXrd
         uxqgzsc5ClY1u2nQDbkoNKPoanVyiOl9FipVK3oK++VUn9qshzf95bxXRTMa4Cvs1tdP
         l9AxQA123dfp/eR2p+zLTy2Unj48Eg+KOynuM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=sSYYOE1Mii4E6h1YNLrwdrGJYQCoXVMpgTrxN3RJ21qwKHwsh5d0hGE1NIukROfUwh
         LUFPuBU53S2kYfSHEDSihq2cD3tYLtgch1nLxsFZkOg2JJh2GyazMaIc54tOgxyscbXz
         t/cYSRxIdJHVsd53e308podXqZoKenHDGblQI=
Received: by 10.220.61.135 with SMTP id t7mr3275335vch.42.1284800432326; Sat,
 18 Sep 2010 02:00:32 -0700 (PDT)
Received: by 10.220.70.141 with HTTP; Sat, 18 Sep 2010 02:00:02 -0700 (PDT)
In-Reply-To: <4C947CC7.8030209@ihug.co.nz>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/156441>

On Sat, Sep 18, 2010 at 4:48 AM, Jess McKenzie - JZM Web Development
<jessmckenzie@ihug.co.nz> wrote:
> =C2=A0The system is cent os 5.5:
>
> I get:
>
> No package libcurl-devel available.

s/libcurl-devel/curl-devel/

j.
