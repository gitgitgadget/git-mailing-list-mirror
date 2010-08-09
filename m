From: A Large Angry SCM <gitzilla@gmail.com>
Subject: Re: wiki "abuse"
Date: Mon, 09 Aug 2010 19:18:10 -0400
Message-ID: <4C608CB2.8000602@gmail.com>
References: <AANLkTimyyh+MyS6zpJp1_RfCOoj6yr4LHXXM_7ZiWgzf@mail.gmail.com> <AANLkTi=wxre8pEDPQBeA4FvGcFHKS-kBdCqDv11o=x1c@mail.gmail.com> <AANLkTi=GmOokrPoevARoxe16ZLpHKzaBy0tBfycJM5J2@mail.gmail.com> <alpine.DEB.1.00.1008091820320.8314@intel-tinevez-2-302> <AANLkTinEEpvJv6z1WNgoMujoZyhU8zON597mY+Bp7nV8@mail.gmail.com> <AANLkTin5q5WZFUXkZQ3V5Z1fQjYU2QOi5mFpn-Rb7m04@mail.gmail.com> <4C606E1B.6020800@lsrfire.ath.cx> <AANLkTikNDdi1gDaoWdHsiUPLW2CtZMP0J2c94DpLA=AV@mail.gmail.com> <AANLkTi=dhmxBpTehFFMZGnbTVccbMJLmzKy2V0uj9R6r@mail.gmail.com> <AANLkTi=dGWaRa3HR4nb6Ka1+0CovrBMnyZts5d8RZW1c@mail.gmail.com> <AANLkTimr8vDeyRLLjM+J2Z1zmdiXjwZEw2JAXeXvzNt6@mail.gmail.com> <alpine.DEB.1.00.1008100051440.2983@bonsai2>
Reply-To: gitzilla@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Felipe Contreras <felipe.contreras@gmail.com>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	=?UTF-8?B?UmVuw6kgU2NoYXJmZQ==?= <rene.scharfe@lsrfire.ath.cx>,
	John 'Warthog9' Hawley <warthog9@kernel.org>,
	=?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
	Tay Ray Chuan <rctay89@gmail.com>,
	Git List <git@vger.kernel.org>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Tue Aug 10 01:18:29 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Oibbr-00031I-Jo
	for gcvg-git-2@lo.gmane.org; Tue, 10 Aug 2010 01:18:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757105Ab0HIXST (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 9 Aug 2010 19:18:19 -0400
Received: from mail-vw0-f46.google.com ([209.85.212.46]:59649 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754288Ab0HIXSS (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 9 Aug 2010 19:18:18 -0400
Received: by vws3 with SMTP id 3so7150098vws.19
        for <git@vger.kernel.org>; Mon, 09 Aug 2010 16:18:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id
         :disposition-notification-to:date:from:reply-to:user-agent
         :mime-version:to:cc:subject:references:in-reply-to:content-type
         :content-transfer-encoding;
        bh=71M/T7CVnuKqFMSUpetlqURzxZ+jiMYnP+8JeGhw33M=;
        b=GujH5Moc3/mEPoWJ/FfqEeAEFzYBg4LsBNbDDg4Vy7g3OstaKAKk8FVWGTrsvdpwMS
         /DNXSwSFmL80lNufn9aJUzy+hKsy1liXR+OtmQkINhkAME7uyQMGBUck/HGbqwb6IDRG
         5h3QlnMJleX/MD/Z7edYXsyN7TlRdPNie0cPg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:disposition-notification-to:date:from:reply-to
         :user-agent:mime-version:to:cc:subject:references:in-reply-to
         :content-type:content-transfer-encoding;
        b=NN3+IqueYovSjGA57hW9zz3ou50ocvMPkVpZrv3IG5EmWEIQlkxbcF8dV8HxxKaMmo
         X0WU4tdvZ0EwxjQRY5aRNvHvhWZcaWb67fcUn3lHq2VNec59yrMVpue39qPtrss9UuWr
         uHAd86C2DYlajsY2e4l1C4KysfvdDK2t/7pxM=
Received: by 10.220.88.224 with SMTP id b32mr9977124vcm.77.1281395897593;
        Mon, 09 Aug 2010 16:18:17 -0700 (PDT)
Received: from [192.168.1.4] (cpe-67-248-185-165.nycap.res.rr.com [67.248.185.165])
        by mx.google.com with ESMTPS id m30sm2356049vbr.19.2010.08.09.16.18.15
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 09 Aug 2010 16:18:16 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.1.10) Gecko/20100620 Icedove/3.0.5
In-Reply-To: <alpine.DEB.1.00.1008100051440.2983@bonsai2>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/153052>

On 08/09/2010 07:00 PM, Johannes Schindelin wrote:
> On Tue, 10 Aug 2010, Felipe Contreras wrote:
>
>> Here's a useful Wikipedia guideline: assume good faith:
>> http://en.wikipedia.org/wiki/Wikipedia:Assume_good_faith
>
> For the dear love of God.
>
> Just assume -- hypothetically -- for one second that you, Felipe
> Contreras, tried to create a user page on
> http://subversion.tigris.org/wiki/ reading like this:
>
> -- snip --
> Felipe E. Contreras, a proud Git user.
>
> * [http://felipec.wordpress.com/ Felipe Contreras]
> ** [http://felipec.wordpress.com/tag/git/ Keep an open mind]
> ** [http://whygitisbetterthanx.com/ Git is better]
> -- snap --
>
> only that the last link was to one of your blog posts and was not well
> researched.
>
> If you still think that such a completely unbiased and uncontroversial
> user page was a good idea, well, you should take over the monitoring of
> the Git Wiki, I guess, and make sure you remove all link spam. Actually, I
> like that idea. Can you do that, please? Can you watch the recent changes
> of the Git Wiki and keep it a place where information is king? Thank you
> so much in advance!

Dscho: Thank you for the excellent job you _are_ doing keeping the spam 
on the git wiki under control. Please continue.

Warthog9: Please take this as another vote to disable the user pages.

Everyone else: Most of this thread was/is well intentioned but there is 
a significant problem with spam on high profile wiki sites (like ours) 
and the information readily available (from what I've read on this 
thread) to the _volunteer_ wiki admin slash spam fighter fit the pattern 
of a spammer. If you believe that Johannes is not doing an acceptable 
job policing the wiki _AND_ you are willing and able to do the job then 
speak up with that information.
