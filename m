From: Philippe Vaucher <philippe.vaucher@gmail.com>
Subject: Re: Copying Git repository from Linux to Windows.
Date: Thu, 16 Jun 2011 10:17:21 +0200
Message-ID: <BANLkTinT8oH+aBnn+zqFYyFbcU+PNPVeVA@mail.gmail.com>
References: <4DF87B42.1020004@st.com> <m3ei2vv0nw.fsf@localhost.localdomain>
 <4DF891CC.1040700@st.com> <BANLkTik+oUb1QpVTwJfB30_8FsW=4ZVTxA@mail.gmail.com>
 <4DF89F56.3060200@st.com> <4DF8A896.7080708@op5.se> <4DF97998.7070604@st.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Andreas Ericsson <ae@op5.se>,
	"kusmabite@gmail.com" <kusmabite@gmail.com>,
	Jakub Narebski <jnareb@gmail.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>,
	Shiraz HASHIM <shiraz.hashim@st.com>,
	Vipin KUMAR <vipin.kumar@st.com>
To: viresh kumar <viresh.kumar@st.com>
X-From: git-owner@vger.kernel.org Thu Jun 16 10:18:03 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QX7m6-0007qC-8h
	for gcvg-git-2@lo.gmane.org; Thu, 16 Jun 2011 10:18:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752045Ab1FPIR4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 16 Jun 2011 04:17:56 -0400
Received: from mail-qw0-f46.google.com ([209.85.216.46]:53528 "EHLO
	mail-qw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751049Ab1FPIRx (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 16 Jun 2011 04:17:53 -0400
Received: by qwk3 with SMTP id 3so570688qwk.19
        for <git@vger.kernel.org>; Thu, 16 Jun 2011 01:17:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-type;
        bh=wtWhId8PPyJTWX8r+/8pIBaASnmVp4b6zlX5dVTy4u0=;
        b=cvI+5Ms3izhmWy+HZ91QDLAHReP2cm/Fh5jSAS0ry7UX4yn3z/AMSWtLFpZeRSgYrS
         P3Ddet7yd1kqcm4m3a+wJw3O3NI5E5N4Z4a/ocNjdghVVHevt5FaMott7Bj+tnj87bPa
         X/qW+OV+oYWfvm1tCBV3POQUN747YiBqXVe9o=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        b=Hd8MiS/oHsX0Ec5mPDpGt20oNmBlQCduDPO6uML+4q7pUweFZgd39ObaVWcxk01pP6
         TXceZG8opKiMhtgcbMtmsWH+nFrmqKGrB2y+gLdwsK+zvlwgZvtCLwf50pIzCUD9TvoK
         lx/JtPixTElBsuAixYevVKcwhiz+L79CHmM0w=
Received: by 10.229.68.138 with SMTP id v10mr449312qci.204.1308212272571; Thu,
 16 Jun 2011 01:17:52 -0700 (PDT)
Received: by 10.229.251.21 with HTTP; Thu, 16 Jun 2011 01:17:21 -0700 (PDT)
In-Reply-To: <4DF97998.7070604@st.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/175883>

> I can't simply install Linux on my office laptop (company policies, support, etc) :(

Why not use something like VirtualBox?

Philippe
