From: "Deepak Barua" <dbbarua@gmail.com>
Subject: Re: Adding spell checker to GIT
Date: Thu, 25 Jan 2007 20:06:26 +0530
Message-ID: <b5a19cd20701250636i6e3f474bhebb16020e918c155@mail.gmail.com>
References: <b5a19cd20701041246we052685hd700580df2cc120d@mail.gmail.com>
	 <Pine.LNX.4.63.0701052147070.22628@wbgn013.biozentrum.uni-wuerzburg.de>
	 <b5a19cd20701051921j69f1a85bo97e39db7d8401222@mail.gmail.com>
	 <Pine.LNX.4.63.0701161709570.22628@wbgn013.biozentrum.uni-wuerzburg.de>
	 <b5a19cd20701160934s16b8717er69b950cff055a5ae@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Johannes Schindelin" <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Thu Jan 25 15:36:33 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HA5iK-0004YT-UP
	for gcvg-git@gmane.org; Thu, 25 Jan 2007 15:36:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965389AbXAYOga (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 25 Jan 2007 09:36:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965395AbXAYOga
	(ORCPT <rfc822;git-outgoing>); Thu, 25 Jan 2007 09:36:30 -0500
Received: from ug-out-1314.google.com ([66.249.92.170]:60065 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965389AbXAYOg3 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 25 Jan 2007 09:36:29 -0500
Received: by ug-out-1314.google.com with SMTP id 44so468447uga
        for <git@vger.kernel.org>; Thu, 25 Jan 2007 06:36:28 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=gc3Hf3oB1xantpBEiu6wjNmFqW9YmXxm8n/xe5iVj7zUqbvHEnTc3CpFN4Y0cSFfb25fuo0G6GM5KR1bTsmptfcORNBSYL3UyzVjOvnhX9/ZJOrJqTQlXMjLScz5iLXz8NJGUv+mmdWJWRr3DknKY4mSya+R7/i/UYduC/1AtLo=
Received: by 10.82.120.15 with SMTP id s15mr1149692buc.1169735786569;
        Thu, 25 Jan 2007 06:36:26 -0800 (PST)
Received: by 10.78.50.8 with HTTP; Thu, 25 Jan 2007 06:36:26 -0800 (PST)
In-Reply-To: <b5a19cd20701160934s16b8717er69b950cff055a5ae@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/37726>

Hi Johannes,
                    What about the spell checker...?

Regards
Deepak

On 1/16/07, Deepak Barua <dbbarua@gmail.com> wrote:
> Hi Johannes,
>                   It's okay take your time and suggest any changes and
> teach me how to make this code into a proper patch.
>
> Regards
> Deepak
>
> On 1/16/07, Johannes Schindelin <Johannes.Schindelin@gmx.de> wrote:
> > Hi,
> >
> > On Sat, 6 Jan 2007, Deepak Barua wrote:
> >
> > > Hi Johannes,
> > >                    I spell check "//" comments in
> > > in find_ext()
> > >
> > > if($_[0] =~ /\.cc|\.java/) {
> > >
> > >                $start_pattern  = qr!\s/\*\s|\s//\s!;
> > >        }
> > >
> > > and
> > >
> > > $chosen_pattern eq qq!\s//\s! ? $end_pattern=qq!\s\014\s! : "End
> > > Pattern Not Found" ;
> > >
> > > Also yes i didnt include to use spell checking in string literals , i
> > > thought that would be irregular and cumbersome.
> > >
> > > Could you please test the code then i can include it in a seperate file ..?
> >
> > Sorry, I am a little bit stressed at the moment... And I don't have the
> > required dependencies installed.
> >
> > Ciao,
> > Dscho
> >
> >
>
>
> --
> Code Code Code Away
>


-- 
Code Code Code Away
