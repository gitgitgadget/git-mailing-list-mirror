From: "Philip Oakley" <philipoakley@iee.org>
Subject: Re: Where can I find the MD5 or SHA1 of git preview client.
Date: Mon, 18 Apr 2016 13:50:50 +0100
Organization: OPDS
Message-ID: <A98E483A4B144C7F9A7690C8619FA16D@PhilipOakley>
References: <CAM8n_hso=ZGa9Mwz4fYuqFz7bGN2gAtCx2CLxVv+onC9ozRTaw@mail.gmail.com> <B8796C21280A4977A9AF3E400C58FDFE@PhilipOakley> <CAM8n_hsD9UC2vnzXN39UWs1u1FDNpvUYqbhydsb-4hiQ4dLNiA@mail.gmail.com> <alpine.DEB.2.20.1604180757410.2967@virtualbox>
Reply-To: "Philip Oakley" <philipoakley@iee.org>
Mime-Version: 1.0
Content-Type: text/plain;
	format=flowed;
	charset="iso-8859-1";
	reply-type=original
Content-Transfer-Encoding: 7bit
Cc: <git@vger.kernel.org>, <git-for-windows@googlegroups.com>
To: "Johannes Schindelin" <Johannes.Schindelin@gmx.de>,
	"bin wu" <idevcod@gmail.com>
X-From: git-owner@vger.kernel.org Mon Apr 18 14:58:37 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1as8lB-0000Hl-7T
	for gcvg-git-2@plane.gmane.org; Mon, 18 Apr 2016 14:58:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752273AbcDRM6c (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 18 Apr 2016 08:58:32 -0400
Received: from a2i861.smtp2go.com ([103.47.207.93]:48195 "EHLO
	a2i861.smtp2go.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752192AbcDRM6c (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 18 Apr 2016 08:58:32 -0400
X-Greylist: delayed 433 seconds by postgrey-1.27 at vger.kernel.org; Mon, 18 Apr 2016 08:58:31 EDT
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=smtpcorp.com; s=a0-2; h=Feedback-ID:X-Smtpcorp-Track:Date:Subject:To:From:
	Reply-To:Message-ID; bh=gdheIjvbXJxsgn8zTXixe/PuaQuttUNK5OCpgGiZUPQ=; b=bcFmf
	H+5aEoFqgovZkyyKx3kIVMVVMiqLXvkQfUGZp+YskcYGdlI9F9T3SJsBQC3uyaZ4ypfZ634Sp+ZJh
	KN0PYPa1Lm9hyWVgOTyKJ6c7XfK9aipUGFLDGw5/+9/Zq0dSC6Wv7RVaaXXGAoO3DSrIUsb072I6H
	Y66RluczRua2TBM3R5IX1YYm/IOflMOGqkCO2N4RjT+Poies5JOGfSgUu/9bz+4dVFxTbOxsB796J
	b7ytg29yaUvXu6fEJhoggWdeKHrUhEt0nOO6vkUq47BBarBBH0fCOy58I6dvBkDA0vo1vNo9C1hZd
	y59d/s601XO6f4lltrb0Rb2F/rq6w==;
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2900.5931
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.6157
X-Smtpcorp-Track: 1as8dseLeuNz3U.Feg7sXjvm
Feedback-ID: 66524m:66524aMf6O2Y:66524s27xJfV6_o:SMTPCORP
X-Report-Abuse: Please forward a copy of this message, including all
 headers, to <abuse@smtp2go.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/291806>

From: "Johannes Schindelin" <Johannes.Schindelin@gmx.de>
> Hi Wu,
>
> On Sun, 17 Apr 2016, bin wu wrote:
>
>> There is still a question.Why not just post the the MD5 and SHA1 on
>> the download page?
>
> We do: https://github.com/git-for-windows/git/releases
>

Thanks, I couldn't see it for looking (I was sure there was one somewhere). 
I've corrected the FAQ and linked wiki release-hashes pages.
--
Philip 
