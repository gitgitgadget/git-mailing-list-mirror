From: Erik Faye-Lund <kusmabite@googlemail.com>
Subject: Re: Using VC build git (split patch)
Date: Mon, 17 Aug 2009 17:25:18 +0200
Message-ID: <40aa078e0908170825i5d1148ffobc41f59df259983@mail.gmail.com>
References: <1976ea660908170613ibb9a0fdr7ba630671a6b735f@mail.gmail.com>
	 <40aa078e0908170619r3d325e0csee466446df474302@mail.gmail.com>
	 <1976ea660908170814q30c316aek20d44e67bba4a3ab@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, msysGit <msysgit@googlegroups.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Frank Li <lznuaa@gmail.com>
X-From: git-owner@vger.kernel.org Mon Aug 17 17:25:31 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Md45R-00083l-8O
	for gcvg-git-2@lo.gmane.org; Mon, 17 Aug 2009 17:25:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755033AbZHQPZT convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 17 Aug 2009 11:25:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754862AbZHQPZT
	(ORCPT <rfc822;git-outgoing>); Mon, 17 Aug 2009 11:25:19 -0400
Received: from qw-out-2122.google.com ([74.125.92.26]:53730 "EHLO
	qw-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754686AbZHQPZS convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 17 Aug 2009 11:25:18 -0400
Received: by qw-out-2122.google.com with SMTP id 8so1009348qwh.37
        for <git@vger.kernel.org>; Mon, 17 Aug 2009 08:25:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=tnIwuCGtZkt1UKF4AIopLo/qf82Kq1o0DtU/ruScazw=;
        b=ZiYomYfteFzzwOu7mc0Ev3sWgVabVJl16xAYd6OZQzxvyjhO7f+VbXUWcq/Xi+ZLNZ
         og8bIUL9KwSqv7s+kPd3z55XZ6ucIEJHLYqiAY6KpyqQ+vlF7y/wcPNO46jctP545xxQ
         0FyXgMUPlA3hlkMm/WVBeGy3pVQtavReF1DDY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=mkc115MoUcYmY811P4+6TFMlSbuM9No+hrJqousoFXuiGcYBE7+OMwh4yKOysQwzJ7
         8W2Mlb6v71sdMB51HAs6QW093Ru+rWBQjIg1cn8GGG5NFtgvNQ56fmMmGrji5KVpVQLM
         vc49xw0gYA+jTPa55dAgP7lGYrj9vsZmaIabU=
Received: by 10.224.52.170 with SMTP id i42mr4300346qag.285.1250522719020; 
	Mon, 17 Aug 2009 08:25:19 -0700 (PDT)
In-Reply-To: <1976ea660908170814q30c316aek20d44e67bba4a3ab@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/126194>

On Mon, Aug 17, 2009 at 5:14 PM, Frank Li<lznuaa@gmail.com> wrote:
>> Then use send-email, which IS supported in msysgit.
>
> gmail require ssl. =A0ssl.pm miss when I use send-email in msysgit. I
> have submit bug at msysgit

Have a look at http://code.google.com/p/msysgit/wiki/UsingSendEmail to
find out how to use send-email from Windows.



--=20
Erik "kusma" Faye-Lund
kusmabite@gmail.com
(+47) 986 59 656
