From: Simo Melenius <simo.melenius@iki.fi>
Subject: Re: [PATCH 2/2] branch: don't fail listing branches if one of the 
	commits wasn't found
Date: Fri, 4 Jun 2010 12:48:14 +0300
Message-ID: <AANLkTilGOtScr7AyF_Dsm5ItTm2QBv_aPdBXRUDH29Ad@mail.gmail.com>
References: <20100603065527.GA23439@progeny.tock>
	<1275551282-21557-2-git-send-email-simo.melenius@iki.fi>
	<20100604024344.GB26311@progeny.tock>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Sverre Rabbelier <srabbelier@gmail.com>,
	gitster@pobox.com
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jun 04 11:53:46 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OKTaz-0002I3-PO
	for gcvg-git-2@lo.gmane.org; Fri, 04 Jun 2010 11:53:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754102Ab0FDJxk convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 4 Jun 2010 05:53:40 -0400
Received: from mail-yw0-f187.google.com ([209.85.211.187]:52467 "EHLO
	mail-yw0-f187.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754092Ab0FDJxk convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 4 Jun 2010 05:53:40 -0400
X-Greylist: delayed 323 seconds by postgrey-1.27 at vger.kernel.org; Fri, 04 Jun 2010 05:53:39 EDT
Received: by ywh17 with SMTP id 17so241020ywh.1
        for <git@vger.kernel.org>; Fri, 04 Jun 2010 02:53:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:sender:received
         :in-reply-to:references:date:x-google-sender-auth:message-id:subject
         :from:to:cc:content-type:content-transfer-encoding;
        bh=HAH4Fj9qOG58MNBKRTZ77Ni0eu+LzXU3dI5UZYPIvKo=;
        b=GJUEnGWsRfxU6+i/e3mrbodIK7H9UY9n81iMYdaQ4rzrr0T3QLaUNLkeujsUR2NS7a
         27Zi+VHWCAnuajfkP5F0e81pRtuC2pVxfoQTHi0T0lCmDwuyPtBg6OXdL/HiEF1Cgp1d
         PE96NHJJy6omptjHtRTMRSre73gLEAioF8C4A=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:sender:in-reply-to:references:date
         :x-google-sender-auth:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        b=NZXdryAZnKk15SlqWiYSVrtcUMMQnhRJzsp9xS2bsv0PdRNDqDmWizUFZJFTSay4HD
         vsF+2XBte0gkwJDHsqHpspu2go7gy+txYsNqvhncY90OhOUxLMT0W03SRhQUF+vkYEn+
         Eqcq+L2nLTBQPYQDVA5SCWfQx/ynd6LgQZ8IY=
Received: by 10.150.213.17 with SMTP id l17mr10166295ybg.37.1275644894290; 
	Fri, 04 Jun 2010 02:48:14 -0700 (PDT)
Received: by 10.150.140.20 with HTTP; Fri, 4 Jun 2010 02:48:14 -0700 (PDT)
In-Reply-To: <20100604024344.GB26311@progeny.tock>
X-Google-Sender-Auth: I5o0P52C0wsUY-losPAnBw8aHEE
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/148396>

On 4 June 2010 05:43, Jonathan Nieder <jrnieder@gmail.com> wrote:
> Except as pointed out by Sverre[1],
> =C2=A0Reviewed-by: Jonathan Nieder <jrnieder@gmail.com>

Thanks, I'll now resend the polished versions of these patches.


Simo

--=20
() Today is the car of the cdr of your life.
/\ http://arc.pasp.de/
