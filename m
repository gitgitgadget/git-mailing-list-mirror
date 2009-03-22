From: Sverre Rabbelier <srabbelier@gmail.com>
Subject: Re: Newbie: Do I need to download the entire repo to work on just 1 
	file?
Date: Mon, 23 Mar 2009 00:10:48 +0100
Message-ID: <fabb9a1e0903221610p3b11f09ctc6a9f4d38b1bda3e@mail.gmail.com>
References: <BLU121-W15DB0E5CEBC1DA697E5ED8B4950@phx.gbl> <fabb9a1e0903221600j22cf028fl903aef8076e53777@mail.gmail.com> 
	<20090322231002.GA12974@vidovic>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Nicolas Sebrecht <nicolas.s-dev@laposte.net>
X-From: git-owner@vger.kernel.org Mon Mar 23 00:12:38 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LlWqL-0004TW-Uw
	for gcvg-git-2@gmane.org; Mon, 23 Mar 2009 00:12:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756497AbZCVXLJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 22 Mar 2009 19:11:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756268AbZCVXLH
	(ORCPT <rfc822;git-outgoing>); Sun, 22 Mar 2009 19:11:07 -0400
Received: from mail-fx0-f158.google.com ([209.85.220.158]:57957 "EHLO
	mail-fx0-f158.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755800AbZCVXLG (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 22 Mar 2009 19:11:06 -0400
Received: by fxm2 with SMTP id 2so1579997fxm.37
        for <git@vger.kernel.org>; Sun, 22 Mar 2009 16:11:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:date
         :received:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=4VZ1SjbbRnAV8KIRSDy0/KmHY2lS8lhWQ5gLR1onf00=;
        b=QBViUahLTxHpMz6ScB9G8YXIW8iJyJTlHQHAZZMJ9z8UkuXMwms+UrDbaih4elGulE
         A2HTogL9gj/P1aVtNoIsevof+s5dSF13qReW6fKdfef8OeuJUjZLoHeoFX9IYnv21BJY
         X4FYXHftxfxL4N5xgCZK/SV59u4eoXAFkrwjE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=FbWsKbIpU7AkiyUYqvf7Il+4NaFyWXcsfD4veQKqdSO6wN150ySmW4SThlVK2OzKOJ
         Z4THudTvT+/E9eIpWQrbxmEUTSm9Ql5UyKNi3PVAKWelFmGlk5BVkWgyBez+LjdI7bd6
         iRXD1OdHNLBB/9CPG3bgdFj6rmP/4whx2MdTY=
In-Reply-To: <20090322231002.GA12974@vidovic>
Received: by 10.103.240.5 with SMTP id s5mr2764399mur.133.1237763463348; Sun, 
	22 Mar 2009 16:11:03 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/114198>

Heya,

On Mon, Mar 23, 2009 at 00:10, Nicolas Sebrecht
<nicolas.s-dev@laposte.net> wrote:
> No, you don't. Why not use the '--depth <depth>' option of 'git clone' ?

That depends on if he wants to push back to the original repo or not, right?

-- 
Cheers,

Sverre Rabbelier
