From: "Paolo Ciarrocchi" <paolo.ciarrocchi@gmail.com>
Subject: Re: [PATCH] Further changes, thanks to <tp@lists.linux.it>
Date: Thu, 9 Aug 2007 00:36:40 +0200
Message-ID: <4d8e3fd30708081536t1ca75203xad14a2437ce07994@mail.gmail.com>
References: <20070808172739.5647a81b@paolo-desktop>
	 <200708082304.53867.barra_cuda@katamail.com>
	 <4d8e3fd30708081450n142bfea6tb30f063da0559f2e@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Michael <barra_cuda@katamail.com>
X-From: git-owner@vger.kernel.org Thu Aug 09 00:36:53 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IIu96-0006Kj-3Q
	for gcvg-git@gmane.org; Thu, 09 Aug 2007 00:36:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932918AbXHHWgo (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 8 Aug 2007 18:36:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932960AbXHHWgn
	(ORCPT <rfc822;git-outgoing>); Wed, 8 Aug 2007 18:36:43 -0400
Received: from nz-out-0506.google.com ([64.233.162.228]:22668 "EHLO
	nz-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932918AbXHHWgl (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 8 Aug 2007 18:36:41 -0400
Received: by nz-out-0506.google.com with SMTP id s18so154597nze
        for <git@vger.kernel.org>; Wed, 08 Aug 2007 15:36:41 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=Xv9VL9fe7/gLgy/FMSqZeq5a6sWHD4prrF9zfujyPSJ7WZFik4kW3gY4Kt4zK3AavXFKsH33NbYBW5dF0wgJSefbn4ftu1r126VXJ3wFAXeTMWjvidVaMSnJnHcoQzWMvaMx100bMdjZ8qoZnSWw55QmT5nqufW10XAB4kWFakg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=cTyVPoH3fxYhORCw/EMg4q61quUIpgFBnWU1+tDClRNog+f+c8ncdo7rRINbi3Rkwd3pPlTf0E9BTdy9mRfFVfg/V5NsxnV1p+rF7BRYhavIMpvjY+fz38RILnPYPEFVQe1vO/xXcMMo+y82nWzDvfSaA2CQfb/F+V1NtDLBd4E=
Received: by 10.142.212.19 with SMTP id k19mr471687wfg.1186612600423;
        Wed, 08 Aug 2007 15:36:40 -0700 (PDT)
Received: by 10.143.163.10 with HTTP; Wed, 8 Aug 2007 15:36:40 -0700 (PDT)
In-Reply-To: <4d8e3fd30708081450n142bfea6tb30f063da0559f2e@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/55384>

On 8/8/07, Paolo Ciarrocchi <paolo.ciarrocchi@gmail.com> wrote:
> On 8/8/07, Michael <barra_cuda@katamail.com> wrote:
> > On Wednesday 08 August 2007 17:27, Paolo Ciarrocchi wrote:
> > > Further changes, thanks to <tp@lists.linux.it>
> > >
> > > Signed-off-by: Paolo Ciarrocchi <paolo.ciarrocchi@gmail.com>
> > > ---
> >
> > Is it just me, or this patch is corrupted?

I pushed to the mob branch a new patch and sent to the list a new email.

Out of curiosity, what MUA do you use/suggest?
I use sylpheed-claws 1.0.5 but it ois not very gmail friendly, it
complains that it is not possible to deliver the message even if the
message is correctly delivered :-(

 [00:38:16] ESMTP< 250 ENHANCEDSTATUSCODES
 [00:38:16] ESMTP> [AUTH PLAIN]
 [00:38:16] ESMTP< 235 2.7.0 Accepted
 [00:38:16] ESMTP> MAIL FROM:<paolo.ciarrocchi@gmail.com> SIZE=360
 [00:38:16] SMTP< 250 2.1.0 OK
 [00:38:16] SMTP> RCPT TO:<paolo.ciarrocchi@gmail.com>
 [00:38:17] SMTP< 250 2.1.5 OK
 [00:38:17] SMTP> DATA
 [00:38:17] SMTP< 354 Go ahead
 [00:38:17] SMTP> . (EOM)
 [00:38:23] SMTP< 250 2.0.0 OK 1186612547 w28sm1037333uge
 [00:38:23] SMTP> QUIT
** Error occurred while sending the message.

Ciao,
-- 
Paolo
http://paolo.ciarrocchi.googlepages.com/
