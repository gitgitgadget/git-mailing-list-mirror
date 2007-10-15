From: "David Symonds" <dsymonds@gmail.com>
Subject: Re: [PATCH 0/7] Bisect dunno
Date: Mon, 15 Oct 2007 16:15:19 +1000
Message-ID: <ee77f5c20710142315j192b9f65m22d7980769a46cec@mail.gmail.com>
References: <20071014142826.8caa0a9f.chriscool@tuxfamily.org>
	 <F32B0EEF-496C-4D6D-BD9A-B6A0C04E0EE3@wincent.com>
	 <854pgtonp5.fsf@lola.goethe.zz>
	 <200710141709.51579.chriscool@tuxfamily.org>
	 <4712400C.2080900@lsrfire.ath.cx> <85y7e5ll38.fsf@lola.goethe.zz>
	 <522E90CF-FC15-472F-B0A8-91C310CAF9BF@wincent.com>
	 <471250BC.7070307@trolltech.com> <85d4vhlh8y.fsf@lola.goethe.zz>
	 <471302D2.6010405@trolltech.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "David Kastrup" <dak@gnu.org>,
	"Christian Couder" <chriscool@tuxfamily.org>,
	"Wincent Colaiuta" <win@wincent.com>,
	"=?ISO-8859-1?Q?Ren=E9_Scharfe?=" <rene.scharfe@lsrfire.ath.cx>,
	"Junio Hamano" <junkio@cox.net>,
	"Johannes Schindelin" <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
To: "Marius Storm-Olsen" <marius@trolltech.com>
X-From: git-owner@vger.kernel.org Mon Oct 15 08:15:34 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IhJEh-0006jy-2h
	for gcvg-git-2@gmane.org; Mon, 15 Oct 2007 08:15:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753262AbXJOGPV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 15 Oct 2007 02:15:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753523AbXJOGPV
	(ORCPT <rfc822;git-outgoing>); Mon, 15 Oct 2007 02:15:21 -0400
Received: from rv-out-0910.google.com ([209.85.198.185]:4396 "EHLO
	rv-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751549AbXJOGPT (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 Oct 2007 02:15:19 -0400
Received: by rv-out-0910.google.com with SMTP id k20so1363674rvb
        for <git@vger.kernel.org>; Sun, 14 Oct 2007 23:15:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=E5AdW60jETUx0/+MF4q02dCOSbFyom5vanHEqk8aowQ=;
        b=tBYKkZikzrOde04b70EOfhDk/uLEUEMTbmXD8mq9Fxjxz/UM85g/H6FuC9f/IdyCKG/lyujPkyQd1+v37CRjGu6RKtOeG0Zd+p4HqU1JvyZ2hXB13KL+WijynRF14oRwE+Sd9eEMYXI3wICc4YftSxNGC9KbIW20XLMLewi8afY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=LsZYCaEJSXZ6+vPNM2M8oq/AO0kxEP2U8aeNIvQcnY/j6z5hDXeym0/Imya8/u7nOXjvl1beew227U1SMPSgzruR2kBG/G38ik1f+0gdjSdbNb16uYMBlhJ2rpx2evGApFJj76KVbhB1FY4D7V1XIHcn7WjD0ibIoSWp8ASLmPs=
Received: by 10.141.128.19 with SMTP id f19mr2536628rvn.1192428919407;
        Sun, 14 Oct 2007 23:15:19 -0700 (PDT)
Received: by 10.141.153.4 with HTTP; Sun, 14 Oct 2007 23:15:19 -0700 (PDT)
In-Reply-To: <471302D2.6010405@trolltech.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/60951>

On 15/10/2007, Marius Storm-Olsen <marius@trolltech.com> wrote:
> David Kastrup said the following on 14.10.2007 19:48:
> >
> > "unknown" clearly is much better than "dunno" though even if my own
> > favorite would be "undecided".
>
> What then about a good'ol programming favorite, "void"? :-)

"skip"? That would make semantic sense, right?


Dave.
