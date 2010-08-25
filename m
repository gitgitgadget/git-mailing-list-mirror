From: Knittl <knittl89@googlemail.com>
Subject: Re: [PATCH re-roll] Do not display 'Switched to a new branch' when
 the branch existed
Date: Wed, 25 Aug 2010 13:51:31 +0200
Message-ID: <AANLkTi=1dRw_rkaAV174r2SVLbxE6v9Wu2NjjzZCZ63T@mail.gmail.com>
References: <AANLkTimaZF1Q6BPB7CN0Wa5-Ov2ejVfPsmL34vps2VqK@mail.gmail.com>
 <AANLkTi=3z9gJdT8LL3NANFyppUjvOVcrszjf5J5zAKPe@mail.gmail.com>
 <20100818091603.GA6263@burratino> <AANLkTikHbj4zA6Kj0wUp6uQUY3w6cM_z0=Pes1jLLTky@mail.gmail.com>
 <AANLkTim7DNasVmaBxWBcUGyGBCZq_HXNdq_=4uKRdxE-@mail.gmail.com> <AANLkTinXKwUwfXuCzghUgiyck=JBoQLrUn=kPRe0X+a5@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Jonathan Nieder <jrnieder@gmail.com>, git@vger.kernel.org,
	Junio C Hamano <gitster@pobox.com>
To: Tay Ray Chuan <rctay89@gmail.com>
X-From: git-owner@vger.kernel.org Wed Aug 25 13:52:05 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OoEWO-0002T2-AT
	for gcvg-git-2@lo.gmane.org; Wed, 25 Aug 2010 13:52:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753127Ab0HYLvx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 25 Aug 2010 07:51:53 -0400
Received: from mail-vw0-f46.google.com ([209.85.212.46]:47648 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752289Ab0HYLvw (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 25 Aug 2010 07:51:52 -0400
Received: by vws3 with SMTP id 3so498340vws.19
        for <git@vger.kernel.org>; Wed, 25 Aug 2010 04:51:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:received:mime-version:received:in-reply-to
         :references:from:date:message-id:subject:to:cc:content-type;
        bh=mBQJKiouLR811P7Mpg/g2J6jQrXKDesjDGeRStCSB3s=;
        b=S5oI9nyNz6pBxCGS4EKAEngXT6eAjotvEuLWr7i9uc7hg+3COxYgvERCn9edAkafY0
         j37pMvzb89ChUAqp5OvmKwxF5YD+APkEkgXkysrG33mgEJyKzTGTkgN5x1FZLRTGNAI7
         NqxwSmCTByGLXW5AkSeOHjvbzW97nhJE8O1Ac=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        b=URj9SE0veK/XFeGTgZfuV0+lJ7hrfT8i15UJeZNv0d/4nSCXsqAZ/ckuLf6JQeFybB
         DGUWGy0MV5Gya5k/awDuW5yJ+qq2AzlBm0ga+NBsB7Sd2bM34yCv1cRJ96d1tO/PwawY
         kzchpClg2IwtkFPMVoct3PQKvbWCAuXNC0fLU=
Received: by 10.220.62.72 with SMTP id w8mr5216222vch.172.1282737111223; Wed,
 25 Aug 2010 04:51:51 -0700 (PDT)
Received: by 10.220.181.10 with HTTP; Wed, 25 Aug 2010 04:51:31 -0700 (PDT)
In-Reply-To: <AANLkTinXKwUwfXuCzghUgiyck=JBoQLrUn=kPRe0X+a5@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/154443>

On Tue, Aug 24, 2010 at 3:06 PM, Tay Ray Chuan <rctay89@gmail.com> wrote:
> Hi,
>
> On Tue, Aug 24, 2010 at 2:50 PM, Knittl <knittl89@googlemail.com> wrote:
>> sorry for the late reply, i hadn't had access to internet for the last
>> week and as it turns i sent my response only to tay
>
> just a heads-up - this has already been fixed since 09a0ec5 in master.


oh. good :)


-- 
typed with http://neo-layout.org
myFtPhp -- visit http://myftphp.sf.net -- v. 0.4.7 released!
