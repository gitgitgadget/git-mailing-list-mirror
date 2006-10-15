From: "Jon Smirl" <jonsmirl@gmail.com>
Subject: Re: VCS comparison table
Date: Sat, 14 Oct 2006 20:34:22 -0400
Message-ID: <9e4733910610141734h581afdc9r4d330d6a5a5bd1aa@mail.gmail.com>
References: <9e4733910610140807p633f5660q49dd2d2111c9f5fe@mail.gmail.com>
	 <egrgqe$1i9$1@sea.gmane.org>
	 <9e4733910610141606g749d268eudd85791620e1363a@mail.gmail.com>
	 <BAYC1-PASMTP08F9B6EA71E7C83DD93E8DAE080@CEZ.ICE>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: "Jakub Narebski" <jnareb@gmail.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Oct 15 02:35:19 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GYtyD-0003Xb-0n
	for gcvg-git@gmane.org; Sun, 15 Oct 2006 02:35:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752304AbWJOAeY (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 14 Oct 2006 20:34:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751452AbWJOAeY
	(ORCPT <rfc822;git-outgoing>); Sat, 14 Oct 2006 20:34:24 -0400
Received: from py-out-1112.google.com ([64.233.166.179]:4239 "EHLO
	py-out-1112.google.com") by vger.kernel.org with ESMTP
	id S1752304AbWJOAeX (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 14 Oct 2006 20:34:23 -0400
Received: by py-out-1112.google.com with SMTP id n25so1725013pyg
        for <git@vger.kernel.org>; Sat, 14 Oct 2006 17:34:23 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=JzapE4WQJ2rL6fmjubj6K+rFDqwoLY4mjnOHlUfZl8OIlAs+17ZwIEl++fVaI3YwtZ1HmFErlbki09UtvaxWkFsc1eH6bytmNSK2cSqgmaxv7epfbLumHf+K9DJEjo5tCZvYkD6P+hiGbsHjJTEEJCoTpVmOFFy29U2Av0LPAtE=
Received: by 10.35.113.12 with SMTP id q12mr9243525pym;
        Sat, 14 Oct 2006 17:34:22 -0700 (PDT)
Received: by 10.35.60.14 with HTTP; Sat, 14 Oct 2006 17:34:22 -0700 (PDT)
To: Sean <seanlkml@sympatico.ca>
In-Reply-To: <BAYC1-PASMTP08F9B6EA71E7C83DD93E8DAE080@CEZ.ICE>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/28898>

On 10/14/06, Sean <seanlkml@sympatico.ca> wrote:
> On Sat, 14 Oct 2006 19:06:10 -0400
> "Jon Smirl" <jonsmirl@gmail.com> wrote:
>
> > Top two git issues effecting Mozilla choosing it
> > 1) some way to avoid the initial 450MB download
>
> Why not split the repository up after you import it?  Break it into
> two repositories, last year or two, and then everything else.

That is possible but I wish git had tools supporting this. What do you
do about core developers that want the full repo syncing to other
developers that only have a partial copy?

>
> > 2) better windows support
>
> Hard to imagine native windows support existing in time to be used by
> the Mozilla folks, maybe in time for 3.0 :o)
>
> Sean
>


-- 
Jon Smirl
jonsmirl@gmail.com
