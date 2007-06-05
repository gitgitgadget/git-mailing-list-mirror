From: "Marco Costalba" <mcostalba@gmail.com>
Subject: Re: [ANNOUNCE] qgit new "smart browsing" feature
Date: Tue, 5 Jun 2007 07:50:53 +0200
Message-ID: <e5bfff550706042250q6f4034d0y15c65516375fcf4a@mail.gmail.com>
References: <e5bfff550706031339v5ffda0a6u6f520f0c7b49f442@mail.gmail.com>
	 <200706041309.54279.andyparkins@gmail.com>
	 <e5bfff550706040915v3689e8afwb3dffd5d4caf137a@mail.gmail.com>
	 <200706042004.01819.andyparkins@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, "Pavel Roskin" <proski@gnu.org>,
	"Jan Hudec" <bulb@ucw.cz>
To: "Andy Parkins" <andyparkins@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jun 05 07:51:17 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HvRwl-0004zt-2S
	for gcvg-git@gmane.org; Tue, 05 Jun 2007 07:51:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755142AbXFEFu4 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 5 Jun 2007 01:50:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755121AbXFEFu4
	(ORCPT <rfc822;git-outgoing>); Tue, 5 Jun 2007 01:50:56 -0400
Received: from nz-out-0506.google.com ([64.233.162.234]:15005 "EHLO
	nz-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752694AbXFEFuz (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 5 Jun 2007 01:50:55 -0400
Received: by nz-out-0506.google.com with SMTP id n1so1261409nzf
        for <git@vger.kernel.org>; Mon, 04 Jun 2007 22:50:54 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=OfJBhaBq9XxFo9j/1wsY4gnM2zUqhlA9NYvn3h3fv6IrIliFbO+6NKbNkyv+e5cWAGYbizUeLo45xE9aPpHeUNbRTW+oL+9SaoNh0zXPJflAGnFmB9W4/sfO4h3f/WOQcep8jXd0z1tSeQ0QbJhAcVehtHi9OmerJzhpj7cb3SU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=i3UCUZ2v/2gAn6QOmvyjwF9DA/P5tQ8z27k0GWSMyNzsZ6rCBwXBQu6JtJgEaLlodk7Uqy9yBfvoO7d67nhvjCf0uD4y6S1vFGHI7U8F2vK2OlwgrHlQ2rS0hELwl2571ZmL3qJ+mInO87h1IWYAt3xPlqHzvH/1bAqfkZ01dVw=
Received: by 10.114.151.13 with SMTP id y13mr5649041wad.1181022654013;
        Mon, 04 Jun 2007 22:50:54 -0700 (PDT)
Received: by 10.114.61.9 with HTTP; Mon, 4 Jun 2007 22:50:53 -0700 (PDT)
In-Reply-To: <200706042004.01819.andyparkins@gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/49163>

On 6/4/07, Andy Parkins <andyparkins@gmail.com> wrote:
> On Monday 2007, June 04, Marco Costalba wrote:
>
> > P.S: Your approach is simple and good, the only downside is the
> > screen estate taken by the tab bar. But I agree it's absolutly not a
> > biggie.
>
> Yeah, that is a bit of a drawback.  How about not putting the tabs on
> the top or bottom, but on the left or right?  In fact if you put them
> on the right, they'd be almost exactly where your jump labels would be.
>

Andy, another point scored for you!

I will do exactly that!


Now the only drawback it remains (more "mental" then real) is that the
user already scrolls down to read the message / patch and, at the end,
it's easier to just continue scrolling to jump to next/previous
revision then move the mouse to point the tab, click, and go back to
start scrolling again: a finger against a double hand movment + click.

Yes, I know, I'm veeery lazy ;-)


Marco
