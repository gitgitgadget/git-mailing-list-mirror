From: Sverre Rabbelier <srabbelier@gmail.com>
Subject: Re: Wierd git over http behaviour
Date: Fri, 20 Feb 2009 07:39:36 +0100
Message-ID: <bd6139dc0902192239i3c5f196qf890c8b0a6f9ff46@mail.gmail.com>
References: <1d3f23370902192213g560020b3h7a2459c1439e5e5c@mail.gmail.com>
	 <bd6139dc0902192219m21c6b4e6ne9bcd2ca4ef6a9b5@mail.gmail.com>
	 <1d3f23370902192224g71270880p84e150af9640dec6@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Git Mailinglist <git@vger.kernel.org>
To: John Williams <john.williams@petalogix.com>
X-From: git-owner@vger.kernel.org Fri Feb 20 07:41:37 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LaP4q-0002ha-JM
	for gcvg-git-2@gmane.org; Fri, 20 Feb 2009 07:41:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751995AbZBTGjj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 20 Feb 2009 01:39:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751626AbZBTGji
	(ORCPT <rfc822;git-outgoing>); Fri, 20 Feb 2009 01:39:38 -0500
Received: from fg-out-1718.google.com ([72.14.220.158]:37590 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751125AbZBTGji (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 20 Feb 2009 01:39:38 -0500
Received: by fg-out-1718.google.com with SMTP id 16so1665128fgg.17
        for <git@vger.kernel.org>; Thu, 19 Feb 2009 22:39:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:sender:received:in-reply-to
         :references:date:x-google-sender-auth:message-id:subject:from:to:cc
         :content-type:content-transfer-encoding;
        bh=Ys1MrF9XeBx6PCrXyKfdVbWa8775s8tZu7+G2ucVzQk=;
        b=X/KfnmgCkpa8qLrG6gwTue7gLuhOmXta1+j34bkCAzwaQzXNc5bnEOswTb4LygRcdy
         qcbOWt6B4M9ahBepLCKVKuEOpcZcZhE48G2t4W1eA3qD7xwxalaC97ofitxbEp/36Hor
         hx28AMaoHxODcuuyJz1FdfgF35iybOAFnlAss=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:sender:in-reply-to:references:date
         :x-google-sender-auth:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        b=RPlg0XlkBGkthnEd0XgItIlzxYA/72AwVhyRtawB1ZqliBVnmoIZ7mg5PaowUD/PHp
         4+dWasVQyz8SiuTQIPZbEqGVHqsfgdKM1Y473bCqUvymVT5zOrxq3v9Uu2zwyG/RT72F
         LLGF6l50uYqq7dujxAt9bCucu9lKoFiXBpp9Q=
Received: by 10.86.94.11 with SMTP id r11mr852233fgb.53.1235111976515; Thu, 19 
	Feb 2009 22:39:36 -0800 (PST)
In-Reply-To: <1d3f23370902192224g71270880p84e150af9640dec6@mail.gmail.com>
X-Google-Sender-Auth: e4f581d5ace870d5
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/110805>

Heya,

On Fri, Feb 20, 2009 at 07:24, John Williams
<john.williams@petalogix.com> wrote:
> On Fri, Feb 20, 2009 at 4:19 PM, Sverre Rabbelier <srabbelier@gmail.com> wrote:
>> This url seems to be broken/dead?
>
> bah - append .git :(
>
> http://developer.petalogix.com/git2/linux-2.6-microblaze.git

Ok, that works :).

-- 
Cheers,

Sverre Rabbelier
