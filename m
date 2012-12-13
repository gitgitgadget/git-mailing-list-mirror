From: Max Horn <postbox@quendi.de>
Subject: Re: What's cooking in git.git (Dec 2012, #03; Wed, 12)
Date: Thu, 13 Dec 2012 13:04:32 +0100
Message-ID: <BF9B1394-0321-4F1C-AD1B-F40D02DBE71A@quendi.de>
References: <7vhanq257s.fsf@alter.siamese.dyndns.org> <CAMP44s2DAuhk5FkDm0-cYsikY0o6vuZ4FyAnXhbtsgqKQF1dpg@mail.gmail.com> <7vvcc6z801.fsf@alter.siamese.dyndns.org> <CAMP44s3uyC0V6ycTv78mG36_i7ugMLwwNk2cqNZatEJuL7Ee1w@mail.gmail.com>
Mime-Version: 1.0 (Apple Message framework v1283)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Thu Dec 13 13:05:22 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Tj7XV-0002hW-Bi
	for gcvg-git-2@plane.gmane.org; Thu, 13 Dec 2012 13:05:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753373Ab2LMMFA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 13 Dec 2012 07:05:00 -0500
Received: from wp256.webpack.hosteurope.de ([80.237.133.25]:36760 "EHLO
	wp256.webpack.hosteurope.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752802Ab2LMME7 convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 13 Dec 2012 07:04:59 -0500
Received: from fb07-alg-gast1.math.uni-giessen.de ([134.176.24.161]); authenticated
	by wp256.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	id 1Tj7X4-0007K4-NG; Thu, 13 Dec 2012 13:04:54 +0100
In-Reply-To: <CAMP44s3uyC0V6ycTv78mG36_i7ugMLwwNk2cqNZatEJuL7Ee1w@mail.gmail.com>
X-Mailer: Apple Mail (2.1283)
X-bounce-key: webpack.hosteurope.de;postbox@quendi.de;1355400299;9a105ee9;
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/211448>


On 13.12.2012, at 11:08, Felipe Contreras wrote:

> On Thu, Dec 13, 2012 at 2:11 AM, Junio C Hamano <gitster@pobox.com> wrote:
>> Felipe Contreras <felipe.contreras@gmail.com> writes:
> 
>>>> New remote helper for bzr (v3).  With minor fixes, this may be ready
>>>> for 'next'.
>>> 
>>> What minor fixes?
>> 
>> Lookng at the above (fixup), $gmane/210744 comes to mind
> 
> That doesn't matter. The code and the tests would work just fine.


It doesn't matter? I find that statement hard to align with what the maintainer of git, and thus the person who decides whether your patch series gets merged or not, wrote just above? In fact, it seems to me that what Junio said matters a great deal...

This is a very strange attitude...

In another email, you complained about nobody reviewing your patches respectively nobody voicing any constructive criticism. Yet Junio did just that, and again in $gmane/210745 -- and you replied to neither, and acted on neither (not even by refuting the points brought up), and now summarily dismiss them as irrelevant. I find that quite disturbing :-(.

> 
>> but there may be others.  It is the responsibility of a contributor to keep
>> track of review comments others give to his or her patches and
>> reroll them, so I do not recall every minor details, sorry.
> 
> There is nothing that prevents remote-bzr from being merged.

Well, I think that is up to Junio to decide in the end, though :-). He wrote 


Cheers,
Max