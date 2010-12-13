From: Sverre Rabbelier <srabbelier@gmail.com>
Subject: Re: Please pull gitk.git master branch
Date: Mon, 13 Dec 2010 09:36:31 +0100
Message-ID: <AANLkTinPqDbvdG9r4UFcKq9BJSw4by4_hJdEN+0oUaJZ@mail.gmail.com>
References: <20101212063135.GA7677@brick.ozlabs.ibm.com> <7vwrne8tow.fsf@alter.siamese.dyndns.org>
 <7v7hfe74ea.fsf@alter.siamese.dyndns.org> <7vbp4q5ddo.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Paul Mackerras <paulus@samba.org>,
	Alexandre Erwin Ittner <alexandre@ittner.com.br>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Dec 13 09:36:58 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PS3tx-0003Ft-1T
	for gcvg-git-2@lo.gmane.org; Mon, 13 Dec 2010 09:36:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754971Ab0LMIgw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 13 Dec 2010 03:36:52 -0500
Received: from mail-yw0-f46.google.com ([209.85.213.46]:35930 "EHLO
	mail-yw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753175Ab0LMIgv (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 13 Dec 2010 03:36:51 -0500
Received: by ywl5 with SMTP id 5so3133439ywl.19
        for <git@vger.kernel.org>; Mon, 13 Dec 2010 00:36:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:mime-version:received:in-reply-to
         :references:from:date:message-id:subject:to:cc:content-type;
        bh=TECYwEJvpCqIri4lXUCqag8SFsfv22NLo/VmV+MzhYI=;
        b=HUX+aBXYq8xclbj10fFF3v9o1dVGrm5otgpKKEXBJSEbG/3SYqrjeP628L3+xjWSfk
         z/NQPqc3Zxwub9BLYJyK5TwdPx0I/PZhzbLPK5+U/fcYR3uOAzqq0pbl0yq2aKT2xQmh
         079hRGhK3F9KxWCE9tOj+YIC8RhIfREAJ1PX4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        b=lpN2RD17jrtqe0Gc8W80ELG4BkzvuzB9/DQiTUjQHsT4reUj2RpHwur4dei3LzaBu7
         wow6xJy7SrDrrMmiWoaiGRq38n+Yxz25WX+KxD+0gkJZfhszydsimuZYglbL6c37Qel7
         PVSwPArB7rALDeFp7dcgc3kwquPP7NyHAvOo8=
Received: by 10.151.6.19 with SMTP id j19mr5431128ybi.211.1292229411115; Mon,
 13 Dec 2010 00:36:51 -0800 (PST)
Received: by 10.151.150.17 with HTTP; Mon, 13 Dec 2010 00:36:31 -0800 (PST)
In-Reply-To: <7vbp4q5ddo.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/163525>

Heya,

On Mon, Dec 13, 2010 at 08:40, Junio C Hamano <gitster@pobox.com> wrote:
>> My _preferred_ outcome is to see that naming the input "po/pt_br.po" and
>> using the output "po/pt_br.msg" is the BCP, but I'd like somebody to find
>> out what the accepted practice would be in the Tcl land first.
>
> I still don't know what the BCP is in the Tcl community (didn't have time
> to check, dealing with other topics), but I'll tentatively apply this on
> top of queue Alexandre's patch and merge the result in 'pu'.

Pardon my ignorance, what is BCP? None of the definitions I could find
seemed likely.

-- 
Cheers,

Sverre Rabbelier
