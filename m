From: Michael Witten <mfwitten@gmail.com>
Subject: Re: Johannes misbehavior in the wiki, and a request for admin rights 
	(was: wiki "abuse")
Date: Tue, 10 Aug 2010 13:45:34 -0500
Message-ID: <AANLkTim8UCK7qXwWNHesnnM8RCTHFji-7xSTOZfk-8E+@mail.gmail.com>
References: <AANLkTinYqFMZe=ahgyaW-cYJXuBanvCU1A6AYVcVcrPB@mail.gmail.com> 
	<4C613DFC.40006@drmicha.warpmail.net> <20100810123349.GA3921@kytes> 
	<AANLkTi=4fhCMPGvO_zd_hmwXSG3wckJA8vTYwWFMEstx@mail.gmail.com> 
	<AANLkTini7xKkncXxjv=p32PupR4W2FP3Rqm2atnsV1Q_@mail.gmail.com> 
	<AANLkTinktAhPz_zp6Hf7yanxbn4FougPZwQj9msAXUvk@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Sverre Rabbelier <srabbelier@gmail.com>,
	Felipe Contreras <felipe.contreras@gmail.com>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Michael J Gruber <git@drmicha.warpmail.net>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	John Hawley <warthog9@kernel.org>, git <git@vger.kernel.org>,
	Daniele Segato <daniele.bilug@gmail.com>,
	Valeo de Vries <valeo@valeo.co.cc>,
	"Amir E. Aharoni" <amir.aharoni@mail.huji.ac.il>
To: Avery Pennarun <apenwarr@gmail.com>
X-From: git-owner@vger.kernel.org Tue Aug 10 20:46:25 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OitqC-0003VL-Ia
	for gcvg-git-2@lo.gmane.org; Tue, 10 Aug 2010 20:46:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932555Ab0HJSqJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 10 Aug 2010 14:46:09 -0400
Received: from mail-fx0-f46.google.com ([209.85.161.46]:44382 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932491Ab0HJSqF (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 Aug 2010 14:46:05 -0400
Received: by fxm13 with SMTP id 13so905294fxm.19
        for <git@vger.kernel.org>; Tue, 10 Aug 2010 11:46:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:mime-version:received:in-reply-to
         :references:from:date:message-id:subject:to:cc:content-type;
        bh=MyIl9ZIBlBM51Lm0/Zk5/u1FZE07gJOpMCtlIxbLWf8=;
        b=N0aCQXyS6vvEygEY7H98LpmCkCsLT4woDrzDHQ3h+MUO2jQC+bplrAMuypGlEdqhiC
         n++vi8Av6QgaRXxpxj5JNyVSWgNte5SPDhz1TmXuLIsTk1qpsyw9ZzvZ/b0o9A7H5+Yy
         DYGVmqYDjtGIguYKV4hXhIN2kHZfqotCXl0dA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        b=aUul8FcFkmIHjvdMm4AB5POhyRIugpUl1Quy6/jcPES6x9JL2+jamhPsoqiJhhgcbj
         lp+JJLelAaQ4sFR13cxy6FLRuuymSx6yMRqwmghQZpKhupndAHNwU1dnz2WxNY7z4gz4
         pmkWEvinDJVe6325cTThFSmL3DJWlGqOXNKQM=
Received: by 10.239.140.197 with SMTP id y5mr916340hby.78.1281465964369; Tue, 
	10 Aug 2010 11:46:04 -0700 (PDT)
Received: by 10.239.186.139 with HTTP; Tue, 10 Aug 2010 11:45:34 -0700 (PDT)
In-Reply-To: <AANLkTinktAhPz_zp6Hf7yanxbn4FougPZwQj9msAXUvk@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/153137>

On Tue, Aug 10, 2010 at 09:49, Avery Pennarun <apenwarr@gmail.com> wrote:
> I'm hesitant to change the subject line
> and break the thread, however.

The RFCs solved this issue with headers:

    Message-Id
    In-Reply-To
    References

It's a damn shame that they are so poorly used.
