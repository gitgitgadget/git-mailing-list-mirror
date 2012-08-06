From: Jiang Xin <worldhello.net@gmail.com>
Subject: Re: [PATCH] merge-recursive: separate message for common ancestors
Date: Tue, 7 Aug 2012 01:04:47 +0800
Message-ID: <CANYiYbE-q82-BmbQ15o8S=0mS2GgURZ1qpX6E1NG80ZNgax_ow@mail.gmail.com>
References: <1344189398-27127-1-git-send-email-ralf.thielow@gmail.com>
	<7vehnl41r2.fsf@alter.siamese.dyndns.org>
	<CAN0XMO+j08fV-5+nNrVQAteB3VStBjqvvjMzRq=6wcbg8OR+xg@mail.gmail.com>
	<7v628x3zjt.fsf@alter.siamese.dyndns.org>
	<CANYiYbFe6LUL+2m-X+Ek8ehFw6D5tvh+FwoGjF_zipcUe_MtMw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Ralf Thielow <ralf.thielow@gmail.com>,
	=?UTF-8?B?VHLhuqduIE5n4buNYyBRdcOibg==?= <vnwildman@gmail.com>,
	Byrial Jensen <byrial@vip.cybercity.dk>,
	=?ISO-8859-1?Q?=C6var_Arnfj=F6r=F0_Bjarmason?= <avarab@gmail.com>,
	Marco Paolone <marcopaolone@gmail.com>,
	Vincent van Ravesteijn <vfr@lyx.org>,
	Marco Sousa <marcomsousa@gmail.com>,
	Peter Krefting <peter@softwolves.pp.se>
X-From: git-owner@vger.kernel.org Mon Aug 06 19:04:55 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SyQje-00032U-CD
	for gcvg-git-2@plane.gmane.org; Mon, 06 Aug 2012 19:04:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756744Ab2HFREt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 6 Aug 2012 13:04:49 -0400
Received: from mail-gg0-f174.google.com ([209.85.161.174]:48912 "EHLO
	mail-gg0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756717Ab2HFREs (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 6 Aug 2012 13:04:48 -0400
Received: by ggnl2 with SMTP id l2so2711335ggn.19
        for <git@vger.kernel.org>; Mon, 06 Aug 2012 10:04:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=hGaanemCyl16NfG+UoZGXzhT+oqL8EfpD6uX20fRNmM=;
        b=xsYFKDr61umLpAhk5OeOeA+/B9FM/ANHFTngJXntaMsqmnqyXv3DyzhaMSX0REk5WQ
         F12HnaNnZfR5mtx7HBOyLjV4EaK3QAzblj+efNZADRuqndJOrDOJQ1s69C28ljPUyTjq
         IgZejkB87+iXbxbc+saYUXiJU9Yk9AKFFICHvubr2VC9+/FrmBie3HFJocGovu2z/N/I
         p0hEMlYZu4i9lXHi68jdKLK7/Od7DpNLLgHBBghqTaxaVhwEGYNIMLuah8d02cMrAiKn
         5eVzE8XvFFUbLeBUhQTZxGGMsDVGQ0VN4u6l5raIvWj/XTuLmJP8ca24MdGdVFY2Oz25
         V5Ew==
Received: by 10.42.106.207 with SMTP id a15mr9581831icp.0.1344272687912; Mon,
 06 Aug 2012 10:04:47 -0700 (PDT)
Received: by 10.50.237.38 with HTTP; Mon, 6 Aug 2012 10:04:47 -0700 (PDT)
In-Reply-To: <CANYiYbFe6LUL+2m-X+Ek8ehFw6D5tvh+FwoGjF_zipcUe_MtMw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/202970>

2012/8/6 Jiang Xin <worldhello.net@gmail.com>:
> 2012/8/6 Junio C Hamano <gitster@pobox.com>:
>> OK, so there was no hidden message behind "At least for better
>> translation".  Will apply this so 1.7.12 can have it.
>
> So I will not wait for Ralf's update on "de.po", he will catch up with next
> round of l10n with this fix. Pull request for this round of l10n:

Next round (maybe last) of translation for git v1.7.12 begins. This time
only 1 message is updated in commit bb2ba06:

    l10n: Update one message in git.pot

    This update comes from commit v1.7.12-rc1-18-ge0453
    (merge-recursive: separate message for common ancestors).

    Signed-off-by: Jiang Xin <worldhello.net@gmail.com>

Fetch this update from the usual place:

    $ git fetch git://github.com/git-l10n/git-po master

-- 
Jiang Xin
