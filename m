From: "Christian MICHON" <christian.michon@gmail.com>
Subject: Re: MinGW port - initial work uploaded
Date: Fri, 19 Jan 2007 23:47:07 +0100
Message-ID: <46d6db660701191447w3011908btce140a7bbdeab37b@mail.gmail.com>
References: <200701192148.20206.johannes.sixt@telecom.at>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-From: git-owner@vger.kernel.org Fri Jan 19 23:47:19 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H82Vv-0003VN-Pw
	for gcvg-git@gmane.org; Fri, 19 Jan 2007 23:47:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932788AbXASWrL (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 19 Jan 2007 17:47:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932795AbXASWrL
	(ORCPT <rfc822;git-outgoing>); Fri, 19 Jan 2007 17:47:11 -0500
Received: from nf-out-0910.google.com ([64.233.182.188]:47354 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932788AbXASWrJ (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 19 Jan 2007 17:47:09 -0500
Received: by nf-out-0910.google.com with SMTP id o25so598387nfa
        for <git@vger.kernel.org>; Fri, 19 Jan 2007 14:47:08 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=o8UOWZYJ3gaRE/CX25DYwcfifH9un+yVoA6JWpkEv3lAwpSYbscfpIu4SeJ2pKf2v7RbsxXhtmHO88qS9FjFwhzswhXlE9rZFxlai+f7IsxCt5CWbAwR+2lwQgTjQCuT/RzLWEfhc48Vco1d71ELKyUZ3ILCdEBgt7cWES95SAY=
Received: by 10.48.202.11 with SMTP id z11mr3030904nff.1169246827906;
        Fri, 19 Jan 2007 14:47:07 -0800 (PST)
Received: by 10.78.183.8 with HTTP; Fri, 19 Jan 2007 14:47:07 -0800 (PST)
To: git@vger.kernel.org
In-Reply-To: <200701192148.20206.johannes.sixt@telecom.at>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/37216>

good to know some progress has been done in this direction.
thanks in advance!

quick question: how do I download it from windows, if I do not
have git already installed ? (chicken and egg)

On 1/19/07, Johannes Sixt <johannes.sixt@telecom.at> wrote:
> I've been working on a MinGW port for some time now. I've pushed out what I
> have so far to a git.git fork at repo.or.cz. For details on how and what to
> clone, please look at the top of
>
> http://repo.or.cz/w/git/mingw.git
>
> Thanks go to Johannes Schindelin for his initial work, which gave me quite a
> quick-start.
>
> Status
> ------
> So far I've used the tools only to run the test suite. According to that, all
> tools that are needed to manipulate a repository locally work.
>
> clone, fetch, push does not work yet.
>
> Contributions
> -------------
> If you want to contribute, please consider using the mob branch in this
> repository. That branch is publically writable. Since I assume that
> contributions will not be too frequent, it should be ok that you push your
> patches there (without pulling it first), then notify me, and I download them
> before someone else overwrites them.
>
> -- Hannes
> -
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>


-- 
Christian
--
  << There's a symlink from awk to gawk, if you're using gawk!
If you're not using gawk, there's no symlink from gawk to awk!
Use the standard names, _please_! >> - Rob Landley
