From: Avery Pennarun <apenwarr@gmail.com>
Subject: Re: Johannes misbehavior in the wiki, and a request for admin rights
 (was: wiki "abuse")
Date: Tue, 10 Aug 2010 14:03:57 -0400
Message-ID: <AANLkTinNnchHQHvN6FnqF_E5NCVxQvE+T_gOD0z2-MUY@mail.gmail.com>
References: <AANLkTinYqFMZe=ahgyaW-cYJXuBanvCU1A6AYVcVcrPB@mail.gmail.com>
 <4C613DFC.40006@drmicha.warpmail.net> <20100810123349.GA3921@kytes>
 <AANLkTi=4fhCMPGvO_zd_hmwXSG3wckJA8vTYwWFMEstx@mail.gmail.com>
 <AANLkTini7xKkncXxjv=p32PupR4W2FP3Rqm2atnsV1Q_@mail.gmail.com>
 <AANLkTinktAhPz_zp6Hf7yanxbn4FougPZwQj9msAXUvk@mail.gmail.com>
 <20100810161940.GF3921@kytes> <AANLkTin9Pnugt4NS_gwHoUsKvFur7CvowdR9Aqkuu6h7@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Ramkumar Ramachandra <artagnon@gmail.com>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Michael J Gruber <git@drmicha.warpmail.net>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	John Hawley <warthog9@kernel.org>, git <git@vger.kernel.org>,
	Daniele Segato <daniele.bilug@gmail.com>,
	Valeo de Vries <valeo@valeo.co.cc>,
	"Amir E. Aharoni" <amir.aharoni@mail.huji.ac.il>
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Tue Aug 10 20:04:32 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OitBg-00080Q-Ft
	for gcvg-git-2@lo.gmane.org; Tue, 10 Aug 2010 20:04:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757631Ab0HJSE1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 10 Aug 2010 14:04:27 -0400
Received: from mail-ew0-f46.google.com ([209.85.215.46]:60733 "EHLO
	mail-ew0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753538Ab0HJSEZ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 Aug 2010 14:04:25 -0400
Received: by ewy23 with SMTP id 23so3994209ewy.19
        for <git@vger.kernel.org>; Tue, 10 Aug 2010 11:04:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:mime-version:received:in-reply-to
         :references:from:date:message-id:subject:to:cc:content-type;
        bh=45P4cqqNLSQp91boWIEpxe1LbuDPSuwFHqsnrORfnA8=;
        b=rxAPEAPIBBi4OBjo38kIK1Ne2nurCe77mZW2kAQHRNXhgMdLz4HR/wFGIeMqWc0O6B
         s7Yqwird+TWoupt6ULKVgn70KO/jBxeMjv8kMqZNU9HLTCXuDuHvp1gc3pmhWLHTKYUC
         XMCaswd5kI0LSbZh/wGTw3av5cJwrM1nd7hzQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        b=Rn0iGXc0b19bxZDijgsjttDFrEIBdQs1W6jjZh6HER5T8A+Q0xqUnvTgrHa0OWGHOS
         bPpVZIdaQlUu2owuR21fzrKAhMAlKgRBnTaTAc6y2BleJtsQUvhkWS2DnQHVGY/4ouQY
         zLBjh5BMB5rU4p5d6obBNI2c+08Ue9+XOz2dU=
Received: by 10.216.11.131 with SMTP id 3mr4195551wex.92.1281463464483; Tue,
 10 Aug 2010 11:04:24 -0700 (PDT)
Received: by 10.216.235.202 with HTTP; Tue, 10 Aug 2010 11:03:57 -0700 (PDT)
In-Reply-To: <AANLkTin9Pnugt4NS_gwHoUsKvFur7CvowdR9Aqkuu6h7@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/153135>

On Tue, Aug 10, 2010 at 1:54 PM, Felipe Contreras
<felipe.contreras@gmail.com> wrote:
> I'm not going to go into details as why I think no warning was issued,
> just that we need this:
> https://git.wiki.kernel.org/index.php/WikiIdeas#Allow_users_to_see_deleted_pages

Keep in mind that 99% of the unwanted crud that gets posted to a wiki
is spam and absolutely doesn't deserve a fair warning before it gets
deleted.  Just based purely on the list of usernames that was posted
earlier, it looked mainly like spammers to me.

If you want to implement a huge big process before deleting/banning
users, you'll want to be sure what you're getting into.

I personally don't think that anything that was done originally was
necessarily wrong, or that the wiki management itself needs to be
fixed.  If it were possible for people to simply look at deleted
pages, this thread would have been "Hey, you deleted me and it was
unwarranted!" -> Someone checks it out -> "No, it was warranted, don't
post swearwords to user pages" -> "Oops, sorry" -> Unbanned.

The thread went on as long as it did simply because verification was
impossible.  Don't over-repair the system and thus introduce new and
improved problems.

Have fun,

Avery
