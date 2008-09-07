From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: Git User's Survey 2008 partial summary, part 4 - how do we use Git
Date: Sun, 7 Sep 2008 10:44:29 +0200
Message-ID: <200809071044.30804.jnareb@gmail.com>
References: <200809031607.19722.jnareb@gmail.com> <200809070017.09463.jnareb@gmail.com> <48C39145.9020709@op5.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Stephan Beyer <s-beyer@gmx.net>
To: Andreas Ericsson <ae@op5.se>
X-From: git-owner@vger.kernel.org Sun Sep 07 10:44:29 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KcFsc-0000ta-Uj
	for gcvg-git-2@gmane.org; Sun, 07 Sep 2008 10:44:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752560AbYIGIm7 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 7 Sep 2008 04:42:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752593AbYIGIm7
	(ORCPT <rfc822;git-outgoing>); Sun, 7 Sep 2008 04:42:59 -0400
Received: from fg-out-1718.google.com ([72.14.220.158]:12354 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752305AbYIGIm6 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 7 Sep 2008 04:42:58 -0400
Received: by fg-out-1718.google.com with SMTP id 19so1118310fgg.17
        for <git@vger.kernel.org>; Sun, 07 Sep 2008 01:42:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=8OtIdtCvtK9fp9BxMpuBe8hUVrnhdjCi92uIFJqfI9c=;
        b=SikOAqXlR0xYNHO70Y65txCt1Sf3mNhJidnPPhgjTXycUb/ho8oPbTYqsKil9Hy0h+
         GH5fawC4TW7NsvsX1a7OniTVHxT9fR/gwrt2pFowAYIr3NZhBzSOw0wEB4gbMmFP23Kh
         1BLlSyDj4D+DgrtwFjlPlSqdVv5GpNaDswtkU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=skCsJoCe7ucv6sI1X8TzQw654FbiEqkzL6BnK0vrLKnCgTridzIcKjbhbibDgoN6BZ
         ZwuePHnb5LDQcSqqssFyEogMQMdk6YoHHle/HOA23qA7S4T5j5dzERpE8O6mGXuDdOJq
         BGcMibt8YoOfAAJUfiKbZZvJu0xruIpKbdwao=
Received: by 10.86.31.18 with SMTP id e18mr10230926fge.52.1220776976274;
        Sun, 07 Sep 2008 01:42:56 -0700 (PDT)
Received: from ?192.168.1.11? ( [83.8.213.144])
        by mx.google.com with ESMTPS id d6sm3014457fga.2.2008.09.07.01.42.54
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 07 Sep 2008 01:42:55 -0700 (PDT)
User-Agent: KMail/1.9.3
In-Reply-To: <48C39145.9020709@op5.se>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/95129>

Andreas Ericsson wrote:
> Jakub Narebski wrote:
>>=20
>> Analysis: strangely "git add + git commit" is slightly more used tha=
n
>> "git commit -a"; I would suspect that "git commit -a" would dominate=
 a
>> bit over other forms of committing.
>=20
> I believe people have finally gotten to grasp with the index. Besides=
,
> those answers are probably a bit skewed, as people that use git as ju=
st
> a faster and better cvs/svn aren't likely to be those who answer the
> survey.


=46rom "Git User's Survey 2008 partial summary, part 3" subthread:
Message-Id: <200809060422.34779.jnareb@gmail.com>

>> 10. Rate your own proficiency with Git
>>
>> Here again the distribution is almost perfectly symmetric. =A0Most
>> people say that they are proficient with Git enough for everyday use
>> (44%), slightly more (23%) can offer advice than selected 'casual,
>> needs advice', while slightly more (7%) thinks themself novices than
>> people who think that know Git very well (4%).
>>
>> For this survey it seems to imply that results would not be biased
>> (skewed) by people who know Git well to very well.

So it doesn't seem that answers are skewed much...

--=20
Jakub Narebski
Poland
