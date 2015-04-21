From: FusionX86 <fusionx86@gmail.com>
Subject: Re: git-p4 Question
Date: Tue, 21 Apr 2015 07:23:51 -0600
Message-ID: <CAFcBi88CwmJ=bxf92BWKLB2m25jnJFD6jpFPYog9Hdneen38DQ@mail.gmail.com>
References: <CAFcBi89YqRGqigR1VCJJQtu1D206rP2T8Y-10KvFnvDjXYaN_g@mail.gmail.com>
	<5535443C.1060600@vilain.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org
To: Sam Vilain <sam@vilain.net>
X-From: git-owner@vger.kernel.org Tue Apr 21 15:23:59 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YkY9d-0006y2-GD
	for gcvg-git-2@plane.gmane.org; Tue, 21 Apr 2015 15:23:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753194AbbDUNXw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 21 Apr 2015 09:23:52 -0400
Received: from mail-ig0-f169.google.com ([209.85.213.169]:34474 "EHLO
	mail-ig0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751973AbbDUNXv (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 21 Apr 2015 09:23:51 -0400
Received: by iget9 with SMTP id t9so85487654ige.1
        for <git@vger.kernel.org>; Tue, 21 Apr 2015 06:23:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=Ub8qtMTFZgd/c8MiuE48vQUxrHxHkJ0SSHKiybg/BOg=;
        b=eOF4inAunmqbSuIpPAwzwOuQjuT7XeClhYJXNEXK0ipWkKnNDv/cQN4D+QEq7K2Jks
         70cQMRngOr1OlL0ifeBZgTwkLsNwBqV+8HU6DvTSUsC+9jCmpfvIUlH6SxSPSgiJZBY6
         GuUxMP+OIiUwq9ldAt+KbwTsl0oJ6Uf2LH/kMSiBKMRcZhls7esDdGAbNgEIv6/IQWSu
         9FEyYTP6IiXezIJ1H7KwPNsHyhLtkgnEHWQDdtbfb5ynqoSbDwXaaVoDph9q2srbECg8
         rkzvQ7upF/J9uaoGsuofZjLYLBdkd+F0x6zCwM3icqa+otRDTVw9MR7skDtAAbh93vcq
         KKLQ==
X-Received: by 10.107.47.26 with SMTP id j26mr28085536ioo.36.1429622631274;
 Tue, 21 Apr 2015 06:23:51 -0700 (PDT)
Received: by 10.107.4.2 with HTTP; Tue, 21 Apr 2015 06:23:51 -0700 (PDT)
In-Reply-To: <5535443C.1060600@vilain.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/267527>

Thanks Sam, I'll check it out.

On Mon, Apr 20, 2015 at 12:23 PM, Sam Vilain <sam@vilain.net> wrote:
> On 04/20/2015 09:41 AM, FusionX86 wrote:
>>
>> Hopefully this is an appropriate place to ask questions about git-p4.
>>
>> I started at a company that wants to migrate from Perforce to Git. I'm
>> new to Perforce and have been trying to learn just enough about it to
>> get through this migration.
>
>
> You might also like to check out my git-p4raw project which imports directly
> from the raw repository files into a git repo using git fast-import
>
>     http://github.com/samv/git-p4raw
>
> Apparently it's my most popular github project :-).  YMMV.
>
> Sam.
