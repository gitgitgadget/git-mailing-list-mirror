From: "Catalin Marinas" <catalin.marinas@gmail.com>
Subject: Re: [PATCH 0/4] Proposed patches
Date: Sun, 13 Jul 2008 22:10:36 +0100
Message-ID: <b0943d9e0807131410w2c08d55fg68aeb7070b2063cd@mail.gmail.com>
References: <20080713113853.18845.37686.stgit@localhost.localdomain>
	 <b0943d9e0807130442k36a10747q7bcbd996cdc774dd@mail.gmail.com>
	 <487A5032.9090307@etek.chalmers.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: "=?ISO-8859-1?Q?Lukas_Sandstr=F6m?=" <lukass@etek.chalmers.se>
X-From: git-owner@vger.kernel.org Sun Jul 13 23:11:39 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KI8r3-0006Eo-LE
	for gcvg-git-2@gmane.org; Sun, 13 Jul 2008 23:11:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752917AbYGMVKi convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 13 Jul 2008 17:10:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754672AbYGMVKh
	(ORCPT <rfc822;git-outgoing>); Sun, 13 Jul 2008 17:10:37 -0400
Received: from rv-out-0506.google.com ([209.85.198.233]:17703 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750863AbYGMVKh convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 13 Jul 2008 17:10:37 -0400
Received: by rv-out-0506.google.com with SMTP id k40so5258273rvb.1
        for <git@vger.kernel.org>; Sun, 13 Jul 2008 14:10:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=Rp+LndNkDXvL9gwFxM9clQ3PNfS9WHJBMCqJzcdOHbU=;
        b=Nju0XG+5hQOHHGjaLE6ZN9l8/R/QwJHdMRIroChM1VTFrcKBGBbXRTrgpgrC7wRpf0
         BxjFwIki+4QsVLU8JD9UugR9D90xAAM9kTh/F+Q8ALxiO9K/QCLjfXgMLTFtyGOiTupF
         UR3KN5HDXfD6HKG5Z7uAfClm0pksXNP5riQOM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=W/q+eN3BUUq5V1nHSZXxfeyh02kG2CxcMUDC9KMPrZe98cT0Kj4LXdAjOE6xnvssgB
         zJgNODXCnx/MsXJPms0tZpSC6yczPjebwkB7Y2JH/e/wxUpF595d2bd5ZXw4BfRWLgIn
         pk4DO0GpnZTHj37C5cyjEK8cFeqe6X9jpCWUY=
Received: by 10.114.202.15 with SMTP id z15mr3576550waf.88.1215983436339;
        Sun, 13 Jul 2008 14:10:36 -0700 (PDT)
Received: by 10.114.124.9 with HTTP; Sun, 13 Jul 2008 14:10:36 -0700 (PDT)
In-Reply-To: <487A5032.9090307@etek.chalmers.se>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/88338>

2008/7/13 Lukas Sandstr=F6m <lukass@etek.chalmers.se>:
> Catalin Marinas wrote:
>> 2008/7/13 Catalin Marinas <catalin.marinas@gmail.com>:
>>> A new post of the proposed patches after implementing Karl's commen=
ts.
>>
>> BTW, these are StGIT patches, I forgot to add the prefix in the subj=
ect line.
>>
> If you run "git config format.subjectprefix 'StGIT PATCH'" in your re=
po,
> git format-patch will add the prefix automatically for you.
>
> StGIT might have a similar option.

No, it doesn't, but it would be good to have one. The alternative in
StGIT is to modify the (local) template file.

Thanks,

--=20
Catalin
