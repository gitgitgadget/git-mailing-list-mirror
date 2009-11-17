From: Sylvain Rabot <sylvain@abstraction.fr>
Subject: Re: Make Gitweb behave like Apache mod_userdir
Date: Tue, 17 Nov 2009 23:54:57 +0100
Message-ID: <7fce93be0911171454i61e995a1ob0bf80013bcb0727@mail.gmail.com>
References: <7fce93be0911150204h259b7424md251c54186d05b7d@mail.gmail.com>
	 <7vhbssewm7.fsf@alter.siamese.dyndns.org>
	 <7fce93be0911171224r1cfc438ay7b38b81646154a23@mail.gmail.com>
	 <7vd43gerak.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git <git@vger.kernel.org>, Jakub Narebski <jnareb@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Nov 17 23:56:38 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NAWyT-0005nD-GR
	for gcvg-git-2@lo.gmane.org; Tue, 17 Nov 2009 23:56:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756652AbZKQWyx convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 17 Nov 2009 17:54:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756635AbZKQWyw
	(ORCPT <rfc822;git-outgoing>); Tue, 17 Nov 2009 17:54:52 -0500
Received: from mail-yx0-f187.google.com ([209.85.210.187]:43955 "EHLO
	mail-yx0-f187.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756632AbZKQWyw convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 17 Nov 2009 17:54:52 -0500
Received: by yxe17 with SMTP id 17so530121yxe.33
        for <git@vger.kernel.org>; Tue, 17 Nov 2009 14:54:57 -0800 (PST)
Received: by 10.101.106.40 with SMTP id i40mr758629anm.193.1258498497643; Tue, 
	17 Nov 2009 14:54:57 -0800 (PST)
X-Originating-IP: [82.233.66.33]
In-Reply-To: <7vd43gerak.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/133107>

On Tue, Nov 17, 2009 at 23:10, Junio C Hamano <gitster@pobox.com> wrote=
:
> Sylvain Rabot <sylvain@abstraction.fr> writes:
>
>>> Wouldn't it be a good idea to somehow make this work well together =
with
>>> the --user-path feature of git-daemon?
>>>
>>> Perhaps the recommended name given in the example shouldn't be ~/gi=
tweb,
>>> but more like ~/public_git, as this is like ~/public_html but for g=
it
>>> repositories. =A0Then the end users will browse
>>
>> As I said, it's configuration :)
>
> Wrong answer.
>

Am I passing a test ?

> Exactly because it is configurable, the document that outlines the
> recommended practice should suggest the best convention. =A0My point =
was
> that it is likely to be tied to "git"-ness of the specified directory
> under $HOME/, not limited to "gitweb"-ness, and it is wrong to recomm=
end a
> name tied to "gitweb"-ness in this document.

Again, git is a brand new world for me and I don't know any of his
conventions yet.
I am not trying to impose my own conventions, I am just proposing an id=
ea.
If you like it and want to make it more "git world compliant", please d=
o so.
