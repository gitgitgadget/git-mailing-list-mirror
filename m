From: John Tapsell <johnflux@gmail.com>
Subject: Re: [PATCH] Documentation - More examples for git bisect
Date: Fri, 6 Mar 2009 02:50:49 +0000
Message-ID: <43d8ce650903051850o49f94398re09bb2bab793e925@mail.gmail.com>
References: <1236256574-24764-1-git-send-email-johnflux@gmail.com>
	 <200903052244.35702.chriscool@tuxfamily.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>
To: Christian Couder <chriscool@tuxfamily.org>
X-From: git-owner@vger.kernel.org Fri Mar 06 03:52:45 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LfQB1-0000eK-DZ
	for gcvg-git-2@gmane.org; Fri, 06 Mar 2009 03:52:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751613AbZCFCuw convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 5 Mar 2009 21:50:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751464AbZCFCuw
	(ORCPT <rfc822;git-outgoing>); Thu, 5 Mar 2009 21:50:52 -0500
Received: from rv-out-0506.google.com ([209.85.198.227]:13699 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751409AbZCFCuv convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 5 Mar 2009 21:50:51 -0500
Received: by rv-out-0506.google.com with SMTP id g37so258021rvb.1
        for <git@vger.kernel.org>; Thu, 05 Mar 2009 18:50:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=5gGgrRoxjLbBns96hgsYxmSwDkefRLgzatpEtPYQv0E=;
        b=drnvm56Sn2UtFmtRGI3oSZb8e4OLJfVVs0Ye1fZjLKzCmgS5EPm2UcLFwhOQgr5xTa
         cjySsCET2xZta8+0Q8WDsE0fbc9bpSIFS5zJ5Ha2woX1MN1dcNKhNilGaR7alz5XmOFc
         cMdsveqb3gRuHiNo3AoNjnILIE7KGBrKJn6F4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=YKmYa71zzRSrqxo5LWi2S+PpY615yOgLzrgVRIzD3DMA9qHpEptaUI7+zYyKGWn2zX
         SU0jxNrkIreJD+GWL+uhFkjEuAyuBr7kBgvJl9fD9RXhMAZK9PAmTpR+jnmfVXrhQ0EG
         gxtdMKtZWIyOJY99tNJk+FESA8uAT3UY6YOsE=
Received: by 10.142.214.11 with SMTP id m11mr850869wfg.125.1236307849981; Thu, 
	05 Mar 2009 18:50:49 -0800 (PST)
In-Reply-To: <200903052244.35702.chriscool@tuxfamily.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/112370>

2009/3/5 Christian Couder <chriscool@tuxfamily.org>:
> Le jeudi 5 mars 2009, John Tapsell a =C3=A9crit :
>> Including passing parameters to the programs, and running more
>> complicated checks without requiring a seperate shell script.
>>
>> Signed-off-by: John Tapsell
>
> That looks good to me, except perhaps that your signed-off-by has no =
email
> address, but I don't know if it's a problem or not.

Opps.  Signed-off-by: John Tapsell <johnflux@gmail.com>

>
> Acked-by: Christian Couder <chriscool@tuxfamily.org>
>
> Thanks,
> Christian.
>
