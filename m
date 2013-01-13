From: =?windows-1251?B?0fLu6ffuINHr5e/27uI=?= 
	<stoycho.sleptsov@gmail.com>
Subject: Re: git list files
Date: Sun, 13 Jan 2013 21:18:22 +0200
Message-ID: <CAGL0X-rD7DF8ddCUYvBfb5-YZuKx8cDBQo_xR1e7F2+WqmNeYw@mail.gmail.com>
References: <CAGL0X-rfrwtbtdN7O0=iMhVRYv1m0_czW8zmgT5QA3irkaeu5Q@mail.gmail.com>
	<20130113175602.GD5973@elie.Belkin>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1251
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Sun Jan 13 20:25:58 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TuTBq-0007Cd-BD
	for gcvg-git-2@plane.gmane.org; Sun, 13 Jan 2013 20:25:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755658Ab3AMTZe convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 13 Jan 2013 14:25:34 -0500
Received: from mail-la0-f50.google.com ([209.85.215.50]:34610 "EHLO
	mail-la0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755484Ab3AMTZe convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 13 Jan 2013 14:25:34 -0500
Received: by mail-la0-f50.google.com with SMTP id fs13so3224898lab.9
        for <git@vger.kernel.org>; Sun, 13 Jan 2013 11:25:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=+KaEhvH16H+lm82Q1Vv44iG9C7kXxNjLoR7oBw0r2JI=;
        b=vG5CR6LxMyCvu1R4ptjdSJif3tV5CZ1SXcNLGdNfOO9RbVZdDurs2Ncd8GDKZrxHMO
         egNe65MeGBCEx9ot2RoVt9S82NGvHjMpMH8U2BpBZgnq9wYLRbxnnzPNPKfu9Bhx+Ibp
         flVxFoY5a3SwBfgwtLmioZ8s8l7DlRtvc29OVczbP0drd36hOlOOtuqGM8pQtbIH8NDD
         qtxeCmmheEYuneIHi8VkTXozkSrDkMCk9nF+eJmC/MHKRZinhdPomGGZxmir+pvDGvJH
         tinEyO2B1Ee7SVE7y0kxKJBHMzqKFMsK6cUh3xoF0+EfmoRHWGJn8vfwDdJqwOxD2YQP
         GSEw==
Received: by 10.112.10.232 with SMTP id l8mr34151832lbb.69.1358104702982; Sun,
 13 Jan 2013 11:18:22 -0800 (PST)
Received: by 10.112.60.36 with HTTP; Sun, 13 Jan 2013 11:18:22 -0800 (PST)
In-Reply-To: <20130113175602.GD5973@elie.Belkin>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/213397>

thanks alot, Jonathan,
I'll try to search through those scripts.

Blind.

2013/1/13 Jonathan Nieder <jrnieder@gmail.com>:
> Hi,
>
> =D1=F2=EE=E9=F7=EE =D1=EB=E5=EF=F6=EE=E2 wrote:
>
>> lets, say the equivalent of the $ls -d b* within git.git root direct=
ory
>> would look like:
>>
>> ----------------
>> 98746061 jrnieder 2010-08-12 17:11 Standardize-do-.-while-0-style   =
base85.c
>> c43cb386 pclouds  2012-10-26 22:53 Move-estimate_bisect_steps-to-li =
bisect.c
>> efc7df45 pclouds  2012-10-26 22:53 Move-print_commit_list-to-libgit =
bisect.h
>> 837d395a barkalow 2010-01-18 13:06 Replace-parse_blob-with-an-expla =
blob.c
>> 837d395a barkalow 2010-01-18 13:06 Replace-parse_blob-with-an-expla =
blob.h
>> ebcfa444 gitster  2012-07-23 20:56 Merge-branch-jn-block-sha1       =
block-sha1
>
> You might like Peff's or Jakub's tree blame script.  The newest versi=
on
> I can find is
>
>  http://thread.gmane.org/gmane.comp.version-control.git/168323
>
> If you use it, let us know how it goes.
>
> Thanks for some food for thought,
> Jonathan
