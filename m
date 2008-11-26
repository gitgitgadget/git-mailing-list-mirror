From: Jean-Francois Veillette <jean_francois_veillette@yahoo.ca>
Subject: Re: French git user
Date: Wed, 26 Nov 2008 09:16:39 -0500
Message-ID: <D5EC3E78-C9BD-4897-A535-85736734FA00@yahoo.ca>
References: <492B9985.10103@morey-chaisemartin.com> <492C2F2E.2050200@morey-chaisemartin.com> <492D0295.6060808@morey-chaisemartin.com> <200811260955.57421.johan@herland.net> <492D1779.8040807@morey-chaisemartin.com>
Mime-Version: 1.0 (Apple Message framework v929.2)
Content-Type: text/plain; charset=ISO-8859-1;
	format=flowed	delsp=yes
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Johan Herland <johan@herland.net>, git@vger.kernel.org
To: devel@morey-chaisemartin.com
X-From: git-owner@vger.kernel.org Wed Nov 26 15:24:47 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L5LJm-0001DT-8Y
	for gcvg-git-2@gmane.org; Wed, 26 Nov 2008 15:24:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752629AbYKZOXW convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 26 Nov 2008 09:23:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752762AbYKZOXW
	(ORCPT <rfc822;git-outgoing>); Wed, 26 Nov 2008 09:23:22 -0500
Received: from smtp123.mail.mud.yahoo.com ([209.191.84.226]:39677 "HELO
	smtp123.mail.mud.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1752403AbYKZOXV convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 26 Nov 2008 09:23:21 -0500
X-Greylist: delayed 402 seconds by postgrey-1.27 at vger.kernel.org; Wed, 26 Nov 2008 09:23:21 EST
Received: (qmail 44000 invoked from network); 26 Nov 2008 14:16:39 -0000
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.ca;
  h=Received:X-YMail-OSG:X-Yahoo-Newman-Property:Cc:Message-Id:From:To:In-Reply-To:Content-Type:Content-Transfer-Encoding:Mime-Version:Subject:Date:References:X-Mailer;
  b=w29W5nygldJzsqhqV6wALXs8FyEOXF8QMjoK0O14ze3zc9Wr08V2tmRwBocdCiIBC25oPM6Y6jGp1EJ+/AZ7TAVk4WT+VB+VcCvj1Wqt8OSQup8lAelBI0Wavk14jVI4pxk1uhPHC1tzOZn8F8zBUFw9vv9aAZ2tfKHFYPoTJTg=  ;
Received: from unknown (HELO ?192.168.3.246?) (jean_francois_veillette@207.96.147.134 with plain)
  by smtp123.mail.mud.yahoo.com with SMTP; 26 Nov 2008 14:16:38 -0000
X-YMail-OSG: BgqttsAVM1mZ57FiOsadPQJqYRQkMVIvm0vUzkbvjlwreDm1RHtDLqkcdRbnZmMck84E1SVmNeWaGlnwUJyuH6SyhB4R_rVyW71U5aBkaXfBDH4amMZoj03Mv6Zh9i2tQWsaa384oGtT0HkUr1p0QFyAdxcWP07RBpoE1CzBF_RM9vMVljveEijL4MwM
X-Yahoo-Newman-Property: ymail-3
In-Reply-To: <492D1779.8040807@morey-chaisemartin.com>
X-Mailer: Apple Mail (2.929.2)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/101737>

I've quickly read the document.
Many thanks Nicolas !

- jfv

Le 08-11-26 =E0 04:31, Nicolas Morey-Chaisemartin a =E9crit :

> Johan Herland a =E9crit :
>> On Wednesday 26 November 2008, Nicolas Morey-Chaisemartin wrote:
>>
>>> I've been allowed to share my presentation:
>>> http://nicolas.morey-chaisemartin.com/git_tuto.pdf
>>>
>>> Please send me any feedback, I'm always glad to imrpove my work.
>>>
>>
>> I have no knowledge of French, but on page 15 the command
>> "git-commit --append" is mentioned. There is no "--append"
>> option. I'm guessing the "--amend" option is meant instead.
>>
>> Also, the very next command is "git-revert COMIT_ID".
>> "COMIT_ID" should probably have an extra "M".
>>
>> Finally, on page 11, you say something about "git foo" vs.
>> "git-foo" (hopefully that the "git-foo" form is deprecated),
>> but in the rest of the presentation you use a mix of "git foo"
>> and "git-foo" (mostly "git-foo"). This seems inconsistent.
>>
>>
>> Have fun! :)
>>
>> ...Johan
>>
>>
>
>
> Thanks, good catch.
> Yes I say in french that git-foo is deprecated.
> However I'm still using it in the following slides because people hav=
e
> directly the good command to look at the man.
> I know it's not really consistent but asI'd rahter keep it that way =20
> and
> insist while presenting it, it should only be used for man pages.
>
> I added your vchanged and updated the pdf.
>
> Thanks
>
> Nicolas
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
