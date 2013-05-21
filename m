From: Magnus =?iso-8859-1?Q?B=E4ck?= <baeck@google.com>
Subject: Re: your mail
Date: Tue, 21 May 2013 09:13:35 -0400
Message-ID: <20130521131334.GB634@google.com>
References: <CAED3JAZa8iB=rZqZ9sUfAqqtzHaMS3-6m0r=TnaBBRtYTF0XMw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: ASHISH VERMA <ashunew1989@gmail.com>
X-From: git-owner@vger.kernel.org Tue May 21 15:13:42 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UemNp-0002Kw-Ts
	for gcvg-git-2@plane.gmane.org; Tue, 21 May 2013 15:13:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754512Ab3EUNNh convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 21 May 2013 09:13:37 -0400
Received: from mail-qc0-f202.google.com ([209.85.216.202]:50816 "EHLO
	mail-qc0-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754472Ab3EUNNg (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 21 May 2013 09:13:36 -0400
Received: by mail-qc0-f202.google.com with SMTP id d1so50811qcz.5
        for <git@vger.kernel.org>; Tue, 21 May 2013 06:13:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=L3T2xsM+vj2Ivrsf8R9LkBI0M6lk2QCMc+yDaA9M9N8=;
        b=NLSqZ5d3GjGaUSxUTE68wfe7Qx2HKeeLJTjb7eaL98+4OUsQ7AwCG/v4EEadVkQwf8
         jEzy1lP9VQmczuGDYvnoZqAAqf+RKQpa6t40kLAy3yNpm483DjJIvREB+2TM7kS2G27l
         /8F4tTKxRhmdnCxgwnfkLVPULLoCi3bKRJG/MrzUYDdW6sAr6BDIs5O8RPBnwJhbwTP3
         /9bvE/wwbvUHSt6Nlog/xeFuEdP3AiNs3GaZYUVHibCjaoPyleVx9sqV3Y0TGFdrTN2j
         87nD13dqYMesH0Arixwy2c/ggWatwmQpORlZm+sBT5HHTS3k2f0qJS3ydD3IlNdzb+8Y
         7vHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent:x-gm-message-state;
        bh=L3T2xsM+vj2Ivrsf8R9LkBI0M6lk2QCMc+yDaA9M9N8=;
        b=RZGDUbvCz8TnU2l5eCMMLGJBAfKJVStcdc7RJtl39aCYPlNl70Ee9gE5QbwVvl8wQ3
         l8SNsFTt8P+Dwr68Whh4UMoOAV28czOcM+RNptO2fYkhCyWgiWp5qdikIdv93efoWXq7
         0bFLBaL74K2TQ94GtdYWNKUvNUvY983Tmn6i0+Z1De7Ebl4rW1YTGNraLJnSDerEHrun
         FRaTUhXIZ8FzwbAaalRQjmUtKxJYxBXyQAdsrH722DtWcqx+LUC+EJHCUbr8MjIDgFkR
         ZCryIB7Jkv8aCUViZR1zH2vF3F1s3Q3sD/rrqIb6+0qbo1JCy/NJnYOG5LBvHupERuPc
         cN/A==
X-Received: by 10.236.141.37 with SMTP id f25mr1166944yhj.50.1369142015987;
        Tue, 21 May 2013 06:13:35 -0700 (PDT)
Received: from corp2gmr1-2.hot.corp.google.com (corp2gmr1-2.hot.corp.google.com [172.24.189.93])
        by gmr-mx.google.com with ESMTPS id u47si234814yhe.0.2013.05.21.06.13.35
        for <multiple recipients>
        (version=TLSv1.1 cipher=AES128-SHA bits=128/128);
        Tue, 21 May 2013 06:13:35 -0700 (PDT)
Received: from valle.nyc.corp.google.com (valle.nyc.corp.google.com [172.26.78.170])
	by corp2gmr1-2.hot.corp.google.com (Postfix) with ESMTP id DBD0A5A42D2;
	Tue, 21 May 2013 06:13:35 -0700 (PDT)
Received: by valle.nyc.corp.google.com (Postfix, from userid 159662)
	id 76E1040783; Tue, 21 May 2013 09:13:35 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <CAED3JAZa8iB=rZqZ9sUfAqqtzHaMS3-6m0r=TnaBBRtYTF0XMw@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Gm-Message-State: ALoCoQkMem5tSRbtCy6NGhP6mbMULaOC5WFJuolmVh3Oz68J9GTonKz2HB7Txvlc4Wd9LgQbeCPCeLkoo/l/ea6mwLd7BlSnbsHAUR+i6tCZyYK3n7mJONCEDYL8KMlEUpxI75iSahQCGqQD4YBj86e4GTkaiTstj21cabo6dz7XfKIiEc8JU2K3BX2DMONQzvKno+A8U+Zc
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/225029>

On Friday, May 17, 2013 at 14:02 EDT,
     ASHISH VERMA <ashunew1989@gmail.com> wrote:

> Hi,  i am using git to push my code from eclipse to heroku , but
> recently iam  getting error like::
>=20
> master:master rejected:non fast forward
>=20
> and i am not able to resolve it .I tried a git pull but that says -
> conflicts shud be resolved before git pull can be implemented.I can;t
> find the solution Please help ASAP...

Resolve the conflicts by either hand-editing the files (you'll see the
markers where the conflicts are) add running 'git add' to tell git that
you're done resolving them, or set up Git to use a graphical tool like
kdiff3. When you're done, run 'git commit' to create the merge commit.
After that you'll be able to push to your upstream (unless things have
moved again while you were resolving the initial conflict).

This guide to merge conflicts looks pretty good:
http://gitguru.com/2009/02/22/integrating-git-with-a-visual-merge-tool/

--=20
Magnus B=E4ck
baeck@google.com
