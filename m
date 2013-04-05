From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: Composing git repositories
Date: Fri, 5 Apr 2013 16:27:43 +1100
Message-ID: <CACsJy8DX8xAc_CUFLYtGX9Ynm-kzgrbfCRFXaZaGd_+G4_imsg@mail.gmail.com>
References: <CALkWK0=CsuAWQwk5Guf0pbC4_ZEoZiwQpamcRvBGz5LJ0QGKHg@mail.gmail.com>
 <7vmwtqt8rs.fsf@alter.siamese.dyndns.org> <CALkWK0kNH2A4eLML22RTofarR3MB++OECiNXMi-bWLLMWK1GAg@mail.gmail.com>
 <7vvc8comj5.fsf@alter.siamese.dyndns.org> <CALkWK0nARWAtC-D3UiNLccuaSwjR6meJb+Cu590N=8Ti8O7OMg@mail.gmail.com>
 <51537A7B.7050206@web.de> <CALkWK0nfNCu775MBB-Y28=V93RkV24kbTLTDKWO2dZ-0yxX=Sw@mail.gmail.com>
 <5154AACC.7050006@web.de> <CALkWK0k=g3iFjmpUQA1VkuH2kZsVX1_Hpo=LZ7CuotwHz_1++g@mail.gmail.com>
 <20130331225747.GB11704@elie.Belkin> <7v7gkkern9.fsf@alter.siamese.dyndns.org>
 <7v7gkilry2.fsf@alter.siamese.dyndns.org> <CACsJy8C_dRqdPvAUW19zVLrJQGqFCRu_TaPMnRbkfgq+H9V2dw@mail.gmail.com>
 <7vwqshefyk.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Jens Lehmann <Jens.Lehmann@web.de>,
	Git List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Apr 05 07:28:43 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UNzCc-0008Po-QO
	for gcvg-git-2@plane.gmane.org; Fri, 05 Apr 2013 07:28:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161312Ab3DEF2O (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 5 Apr 2013 01:28:14 -0400
Received: from mail-ob0-f181.google.com ([209.85.214.181]:50018 "EHLO
	mail-ob0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1161033Ab3DEF2N (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 5 Apr 2013 01:28:13 -0400
Received: by mail-ob0-f181.google.com with SMTP id ni5so3342070obc.26
        for <git@vger.kernel.org>; Thu, 04 Apr 2013 22:28:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:mime-version:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type;
        bh=eqI34bZrwbPX9oKOFf4tDLyb1GWEeNsNmbneRpOf7HE=;
        b=eQ1+tPsbGXMedhugnNTqJFJEQvyZ9wRAOG0jIMUnpgu2Qy+gXhuBtpmQ7jnlm0ublh
         Q+6OAvf0Rb67YnwuCZ8RTqES+ckAP5rvHE/W7dwD54KGxjpbXxedyqxbJhnf3ES7IhFJ
         +7uvpJMPV9CaGwbM+OAARV/jWJ4PG3+/vjNWItFxpcLitkt1tLKrkxKn/rPjVm/LhtWr
         d/IVTY5S4pepzkErjhJRK2Uw60p2a/2Q2CKKF/NwnEErckXrFXXJZ15AiFT3buEX+w2n
         c8VWvRenK9JN+9nzOIWP6U5tVRpecsGVx6ae1Hc2hT7Csups6cqeTj6F9BnBPFbU8r9z
         04ZQ==
X-Received: by 10.182.32.1 with SMTP id e1mr6768330obi.90.1365139693294; Thu,
 04 Apr 2013 22:28:13 -0700 (PDT)
Received: by 10.76.27.137 with HTTP; Thu, 4 Apr 2013 22:27:43 -0700 (PDT)
In-Reply-To: <7vwqshefyk.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/220143>

On Fri, Apr 5, 2013 at 3:53 PM, Junio C Hamano <gitster@pobox.com> wrote:
>> A brief summary or outcome from these links in the comment would
>> be nice.
>
> A summary of what to consider in Documentation/technical/ somewhere
> may be a very welcome addition.  Thanks for volunteering ;-).

No thanks :-) I did not really follow this thread to make such
contribution. Still have some work to do with other topics.
--
Duy
