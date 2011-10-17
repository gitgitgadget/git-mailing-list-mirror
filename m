From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: [PATCH 6/6] revert: Simplify passing command-line arguments around
Date: Mon, 17 Oct 2011 15:40:34 +0530
Message-ID: <CALkWK0msrEYPzpR1rgx0BzHpGiBiP9+doDKV+2N5mEruzhPqUg@mail.gmail.com>
References: <1318095407-26429-1-git-send-email-artagnon@gmail.com>
 <1318095407-26429-7-git-send-email-artagnon@gmail.com> <CALUzUxo=xN735+=Yz9eS_VSW3fpiTeng9s-66qM0Jno40-DPXQ@mail.gmail.com>
 <CALkWK0kA=zhpsmYhjMwv11xyHNhA0Ps=BjUDao0+HFLMKnADUg@mail.gmail.com>
 <20111009085306.GA9209@elie.hsd1.il.comcast.net> <CALkWK0niwg1Ogs+xBr8NHEce-MUUzPc_Upn0ZKRi3iCZ6fA4BQ@mail.gmail.com>
 <20111009092432.GB29150@elie.hsd1.il.comcast.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Tay Ray Chuan <rctay89@gmail.com>, Git List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>,
	Jeff King <peff@peff.net>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Christian Couder <chriscool@tuxfamily.org>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Mon Oct 17 12:11:02 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RFk9s-0001Z9-HB
	for gcvg-git-2@lo.gmane.org; Mon, 17 Oct 2011 12:11:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755235Ab1JQKK4 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 17 Oct 2011 06:10:56 -0400
Received: from mail-wy0-f174.google.com ([74.125.82.174]:39817 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751720Ab1JQKKz convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 17 Oct 2011 06:10:55 -0400
Received: by wyg36 with SMTP id 36so2018731wyg.19
        for <git@vger.kernel.org>; Mon, 17 Oct 2011 03:10:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=Ink14UvQAWkrAfleMHJBhrQlEH4F6GJaKWLmRagTftI=;
        b=EcQp5mKfm1ZNs0pw3rCw2058VGDj9JsJ3zr0YLKP45paAvyZRCzXRjEMx0qr3CEeiR
         wJCTNWlgccktcNhveFYpHT3DaEQT4eQUTSu9JO4+Gi5g9InMRTckrNdAtz+neNidQ6nr
         ockweb2HZdyf7VoT7RD5An6mT3trEK77gq5tY=
Received: by 10.216.203.69 with SMTP id e47mr3537574weo.60.1318846254110; Mon,
 17 Oct 2011 03:10:54 -0700 (PDT)
Received: by 10.216.51.75 with HTTP; Mon, 17 Oct 2011 03:10:34 -0700 (PDT)
In-Reply-To: <20111009092432.GB29150@elie.hsd1.il.comcast.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/183790>

Hi Jonathan,

Jonathan Nieder writes:
> Thanks, but I shouldn't have had to ask. =C2=A0Care to fix the commit
> message? :)

Ah, yes- my persistent lack of clarity in commit messages :|
Hopefully, the next iteration will have better commit messages.

-- Ram
