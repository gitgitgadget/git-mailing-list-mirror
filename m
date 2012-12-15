From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: What's cooking in git.git (Dec 2012, #03; Wed, 12)
Date: Sat, 15 Dec 2012 15:44:37 +0700
Message-ID: <CACsJy8A=-3-C29LKQasfUih24cSZrRuQRJ28WjP0zKg=NaFuUA@mail.gmail.com>
References: <7vhanq257s.fsf@alter.siamese.dyndns.org> <CAMP44s2DAuhk5FkDm0-cYsikY0o6vuZ4FyAnXhbtsgqKQF1dpg@mail.gmail.com>
 <7vvcc6z801.fsf@alter.siamese.dyndns.org> <CAMP44s3uyC0V6ycTv78mG36_i7ugMLwwNk2cqNZatEJuL7Ee1w@mail.gmail.com>
 <BF9B1394-0321-4F1C-AD1B-F40D02DBE71A@quendi.de> <CAMP44s3Es-rLjwe6sgOi9OmwQouM4AbFKAbGB5UgS6sUtYRgKQ@mail.gmail.com>
 <F151B265-7E3E-4989-AA16-EB7CAC298126@quendi.de> <CAMP44s0r_KAKt7Lm1cdumN1cOWzjab3ruYqxp-s6OR1g1qqbcQ@mail.gmail.com>
 <50CC2244.4040103@alum.mit.edu> <CAMP44s0=R3rdnD-Zpzz_7wY6HKKsAL1sPVYh4pc3z1CBbX2ODg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Michael Haggerty <mhagger@alum.mit.edu>,
	Max Horn <postbox@quendi.de>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Sat Dec 15 09:45:43 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TjnNI-0005Y2-Dm
	for gcvg-git-2@plane.gmane.org; Sat, 15 Dec 2012 09:45:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751038Ab2LOIpJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 15 Dec 2012 03:45:09 -0500
Received: from mail-oa0-f46.google.com ([209.85.219.46]:35862 "EHLO
	mail-oa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750903Ab2LOIpI (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 15 Dec 2012 03:45:08 -0500
Received: by mail-oa0-f46.google.com with SMTP id h16so4370270oag.19
        for <git@vger.kernel.org>; Sat, 15 Dec 2012 00:45:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=OzGxvzinuTD8vqXdaAkqetTfoldkpFABJbDIwlZB0vg=;
        b=a4UabIC1KVEP8IfYWFm6/vuW0rAdVGZIgojmru0PyRQqsvUzXEdsVudbkQUOY3a+5O
         OZZaoNYiLy0/qT+0aZ91NR4cAEzD1cUwj76FMEsQ29PkRkjqjAbmvOg8Pu9RKuWDNnAc
         LkkKI4KRqJLn25LBrl0bE8pARnAzXXtl7o95bgyL30x7X+2TXiCDBV04c5HfIUebedZt
         qUP0tBqB/FAOf2oRH0+/E3GtGG3pFFG6D6OaxRl73yubM5UbIIO2PNFI3Wpio4mMfyYf
         heIjd+cgDdzjG7NAlSWPKuFwOE6X8KDbCvqVnoUFTYQtWChmVQMd71l0BC2EObzDDVI4
         ZbaA==
Received: by 10.182.41.6 with SMTP id b6mr6835444obl.23.1355561108018; Sat, 15
 Dec 2012 00:45:08 -0800 (PST)
Received: by 10.182.41.229 with HTTP; Sat, 15 Dec 2012 00:44:37 -0800 (PST)
In-Reply-To: <CAMP44s0=R3rdnD-Zpzz_7wY6HKKsAL1sPVYh4pc3z1CBbX2ODg@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/211524>

On Sat, Dec 15, 2012 at 2:45 PM, Felipe Contreras
<felipe.contreras@gmail.com> wrote:
> Couple of facts first:
> a) This code was already merged
> b) This code is for a test
> c) I'm the only developer so far
>
>> Cruft in the codebase is a problem for git *developers* because it makes
>> the code harder to maintain and extend.
>
> A problem big enough to warrant the rejection of the patch series? No.

May I suggest you maintain remote-bzr as a separate project? You have
total control that way without anyone's disagreeing with you. So you
may be more productive and we have less of these emails back and
forth. And speaking from someone whose series may take months to get
in, why the rush?
-- 
Duy
