From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH v1 18/25] contrib: remove 'emacs'
Date: Fri, 09 May 2014 03:29:36 -0500
Message-ID: <536c91f079e71_2bf0e952f0a@nysa.notmuch>
References: <1399597116-1851-1-git-send-email-felipe.contreras@gmail.com>
 <1399597116-1851-19-git-send-email-felipe.contreras@gmail.com>
 <CAFcZeCqbF54-KjHU1R3pC6XgWi21KcpRGB7HcbfSGyvTScQU2A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Alexandre Julliard <julliard@winehq.org>,
	=?UTF-8?B?RGF2aWQgS8OlZ2VkYWw=?= <davidk@lysator.liu.se>,
	=?UTF-8?B?SmFrdWIgTmFyxJlic2tp?= <jnareb@gmail.com>
To: =?UTF-8?B?RGF2aWQgS8OlZ2VkYWw=?= <david@kagedal.org>,
	Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Fri May 09 10:29:50 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WigBf-0006Yc-T5
	for gcvg-git-2@plane.gmane.org; Fri, 09 May 2014 10:29:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756129AbaEII3n convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 9 May 2014 04:29:43 -0400
Received: from mail-oa0-f43.google.com ([209.85.219.43]:46325 "EHLO
	mail-oa0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753542AbaEII3l convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 9 May 2014 04:29:41 -0400
Received: by mail-oa0-f43.google.com with SMTP id l6so4526368oag.16
        for <git@vger.kernel.org>; Fri, 09 May 2014 01:29:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:message-id:in-reply-to:references:subject
         :mime-version:content-type:content-transfer-encoding;
        bh=5z0OXU2BXncyrq5RL7sIKOfIaoYD3MMIVbuj/5FVnhk=;
        b=bz2SK6Bb3B6w0Hv4nQ5SHf8LbMUloG0Fb7slc4KuAdycOqjXed9tRjQxRbC65FZca7
         xAxFjqsD6KpC8HmsnaSKPv/Op8oR0rnCyRJ5+5wLu7C1adVa9U9uK9xfNhj8sGyrS7oc
         9MV/IF8Q464+95K18lgCrvIP1cJcTdOqMVpc0TSI11LyAmMT6t2eM8ACA0Rlu3UipJVk
         BXSv0ec4+4GJf9vaXBwgnwUClPPaJ+3S/rRzAlzQRqBSLVKK5Gyb3Vu+4+ngJxQ2wfkP
         7b4hamv3dkQzWr5qVL7XIr5UBxLQwTGXLpdk7EEPeq6WNkLoVVJJTbo06XMXHWAWVoPI
         lLDQ==
X-Received: by 10.182.72.227 with SMTP id g3mr11265508obv.28.1399624181392;
        Fri, 09 May 2014 01:29:41 -0700 (PDT)
Received: from localhost (189-211-224-40.static.axtel.net. [189.211.224.40])
        by mx.google.com with ESMTPSA id cu7sm13912131oec.12.2014.05.09.01.29.38
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 09 May 2014 01:29:40 -0700 (PDT)
In-Reply-To: <CAFcZeCqbF54-KjHU1R3pC6XgWi21KcpRGB7HcbfSGyvTScQU2A@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/248532>

David K=C3=A5gedal wrote:
> What problem does this removal solve?

Please do not top post.

  a) What problem does it solve by staying?
  b) Where are the tests?
  c) Why it cannot be moved to an outside repository like may other
     git-related tools?

> 2014-05-09 2:58 GMT+02:00 Felipe Contreras <felipe.contreras@gmail.co=
m>:
>=20
> > No activity since 2012, no tests, and no chance of ever graduating.
> >
> > Also, probably better out-of-tree tools out there.
> >
> > Cc: Alexandre Julliard <julliard@winehq.org>
> > Cc: David K=C3=A5gedal <davidk@lysator.liu.se>
> > Cc: Jakub Nar=C4=99bski <jnareb@gmail.com>
> > Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>

A: Because it messes up the order in which people normally read text.
Q: Why is top-posting such a bad thing?
A: Top-posting.
Q: What is the most annoying thing in e-mail?

--=20
=46elipe Contreras