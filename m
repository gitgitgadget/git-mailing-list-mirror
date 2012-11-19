From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH v3 0/6] completion: test consolidations
Date: Mon, 19 Nov 2012 23:58:13 +0100
Message-ID: <CAMP44s2=Tk0Yc9sNBP_wAzfGjdA+N429Xtexb2qK7kB0wJi1OA@mail.gmail.com>
References: <1353235917-13059-1-git-send-email-felipe.contreras@gmail.com>
	<7v6251xrfb.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder@ira.uka.de>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Nov 19 23:58:30 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TaaIP-0003iM-9J
	for gcvg-git-2@plane.gmane.org; Mon, 19 Nov 2012 23:58:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752950Ab2KSW6O (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 19 Nov 2012 17:58:14 -0500
Received: from mail-oa0-f46.google.com ([209.85.219.46]:42048 "EHLO
	mail-oa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752446Ab2KSW6N (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 19 Nov 2012 17:58:13 -0500
Received: by mail-oa0-f46.google.com with SMTP id h16so5373638oag.19
        for <git@vger.kernel.org>; Mon, 19 Nov 2012 14:58:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=21a5S6yghSE/4t/jTUIPjkM7RJfyqqNSlbdlcFraIJY=;
        b=ULSBp1AT4UMZmauRfoHxHx3XySweL53XBj/bpM6j0AruhOhPzU7w6Asxhfcsm8YbmT
         OQUaq1trO6J13BpHE/HNxhx6PaYuldGTHjFFvqkAptEJgKrxdmnDBOugqx2kmGzEmCDZ
         l2eNMXizPpkTFTLrecXYMLzwFvfmMYooLAuX/1raX110TvrRvB95EuuxM8ifRZ+lf4YZ
         QnqmYv6o1ZipCkf3dqS0zo9LDF2zXN1il70wMcrc5bPh1TJ8HslEgGbfsX0nXTyCPzYX
         3Pgz99mtErSBLtKHmw03G7jYy1xpotflCAMnbwzeXDLCSvJ3fPuOwXXd9K2JlZze9Im8
         FImg==
Received: by 10.60.12.225 with SMTP id b1mr11925137oec.96.1353365893187; Mon,
 19 Nov 2012 14:58:13 -0800 (PST)
Received: by 10.60.4.74 with HTTP; Mon, 19 Nov 2012 14:58:13 -0800 (PST)
In-Reply-To: <7v6251xrfb.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/210061>

On Mon, Nov 19, 2012 at 9:34 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Felipe Contreras <felipe.contreras@gmail.com> writes:
>
>> These started from a discussion with SZEDER, but then I realized there were
>> many improvements possible.
>
> Thanks; I'd loop him in and wait for his acks/reviews.

I thought my series-cc-cmd would add him. Maybe I'm using a version of
'git send-email' that doesn't have that.

Either way, we already know what he will say, to the previous series
he said he was against consolidation of test scripts. So I don't see
how the situation would change.

Cheers.

-- 
Felipe Contreras
