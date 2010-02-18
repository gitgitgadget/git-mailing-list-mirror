From: Tay Ray Chuan <rctay89@gmail.com>
Subject: Re: A Visual Git Reference
Date: Thu, 18 Feb 2010 20:53:03 +0800
Message-ID: <be6fef0d1002180453j7fa6b663nf4619bcee0c6a185@mail.gmail.com>
References: <ca433831002081134m698f531bwa22f0474db0cdcb@mail.gmail.com>
	 <b4087cc51002171717i3a8052a9jbf8c59b4975c0e1c@mail.gmail.com>
	 <ca433831002171739h7ae0de63hfdaa05841fbd388c@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Michael Witten <mfwitten@gmail.com>, git <git@vger.kernel.org>
To: Mark Lodato <lodatom@gmail.com>
X-From: git-owner@vger.kernel.org Thu Feb 18 13:53:20 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ni5sd-0007cC-M0
	for gcvg-git-2@lo.gmane.org; Thu, 18 Feb 2010 13:53:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758270Ab0BRMxJ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 18 Feb 2010 07:53:09 -0500
Received: from mail-pv0-f174.google.com ([74.125.83.174]:52823 "EHLO
	mail-pv0-f46.google.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1754349Ab0BRMxH convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 18 Feb 2010 07:53:07 -0500
Received: by pvb32 with SMTP id 32so48821pvb.19
        for <git@vger.kernel.org>; Thu, 18 Feb 2010 04:53:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=0qh63hiO8/cb9mW10F2FMaBTYDn/AXMCdmuPhS0meYo=;
        b=EMIVinkCE1ViOdJHgD8hNDzj0d2m3RVQ3oXxnsk9Z4q8Qi+2uKbIjoxXFyYbdxZAT9
         04KGq9FQD2snsIPDfwaxGM4yXkKbP53njfp250nWjuqoBzcxf0BS3DKgQeEBucpPOj2B
         3bCQ0vF29UGAYNYN/YEp8D2twBRk7EkgtZQpA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=KqdSo8QUZKZ2EqxGQ22tjFPnerQDcuWDxIk2WzJGIbtEWWuFnU3Y5Nj8JC5np+o4u6
         ck00Wf7CWbEY8hNTYdMm49lzkhLsRoz7p+4hMmskGKbTWzzsGD1CTrUhJFQVUs8TyL0+
         UHgpBzYCiq8hr2IKEUcNlHgw8vQU9VF2BzUjA=
Received: by 10.142.56.16 with SMTP id e16mr6395090wfa.109.1266497583348; Thu, 
	18 Feb 2010 04:53:03 -0800 (PST)
In-Reply-To: <ca433831002171739h7ae0de63hfdaa05841fbd388c@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/140336>

Hi,

On Thu, Feb 18, 2010 at 9:39 AM, Mark Lodato <lodatom@gmail.com> wrote:
> The first paragraph has a link to an SVG version of the page. =A0It's
> not the default since SVG support varies greatly between browsers.

Chrome 4 gives some parsing errors for the SVG files.

  Error: Problem parsing d=3D""

=46or example, line 5 of conventions.svg.

--=20
Cheers,
Ray Chuan
