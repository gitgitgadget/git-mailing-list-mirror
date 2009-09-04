From: Mark Struberg <struberg@yahoo.de>
Subject: Re: [JGIT] Request for help
Date: Fri, 4 Sep 2009 14:49:59 +0000 (GMT)
Message-ID: <585278.66341.qm@web27802.mail.ukl.yahoo.com>
References: <ed88cb980909040744k2fa372fapb7ee457c745b9aa0@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jonas Fonseca <jonas.fonseca@gmail.com>, git@vger.kernel.org,
	Gabe McArthur <gabriel.mcarthur@gmail.com>
To: Douglas Campos <douglas@theros.info>
X-From: git-owner@vger.kernel.org Fri Sep 04 16:50:25 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Mja7K-0000M9-EV
	for gcvg-git-2@lo.gmane.org; Fri, 04 Sep 2009 16:50:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933225AbZIDOt7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 4 Sep 2009 10:49:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932346AbZIDOt7
	(ORCPT <rfc822;git-outgoing>); Fri, 4 Sep 2009 10:49:59 -0400
Received: from web27802.mail.ukl.yahoo.com ([217.146.182.7]:28256 "HELO
	web27802.mail.ukl.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S932184AbZIDOt6 (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 4 Sep 2009 10:49:58 -0400
Received: (qmail 66420 invoked by uid 60001); 4 Sep 2009 14:49:59 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.de; s=s1024; t=1252075799; bh=gVmkJThzPJ9mpcMGSuzkJXcibbR1UshHrXJXUf0nj5s=; h=Message-ID:X-YMail-OSG:Received:X-Mailer:Date:From:Subject:To:Cc:In-Reply-To:MIME-Version:Content-Type; b=ezu9C+oJS5DOTVND2z5v3iho4a+6JacPEwC+6fbyoqZ+HK9N/MWZ72Lyv6d8zoaS+FPJFpCUwtCECeyARvgY0BgYELzHvS3dK578JZH9ANt5dXkkCsnj5Crx5dq2wvzkiX759MhI2vBUUzB2hInGfKtdZlRDVhyBVc8Eg+Ld94o=
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.de;
  h=Message-ID:X-YMail-OSG:Received:X-Mailer:Date:From:Subject:To:Cc:In-Reply-To:MIME-Version:Content-Type;
  b=iDPwL2fTZ4mjvbxUVQkmHyeqw7I//VHX39XuA0ldBFv8kXCE1IN/pKX7Kd+l+DczjoDuwR6lbNpIxuKDdBwxU87F24WJphiIiBtDP8g4P3m8yk5QspJYuKp5mtXlgYbplkCovceIeOUPFRimdLmm9LoxB+TfiSjZr/Msb4j7FHU=;
X-YMail-OSG: NXH83QoVM1lvhFXdwSgGI_g5uyiUytN2xdepuUZ0PegnuaxOoAW.teZ4aWr2WfNXzEqgsF9QYxHxq45Mh2C.zFTLdUtOKOA9A9CFyZvK8GWOS4SUvgg8oNcehdV6u2hiuDMLhtxkOTbTWEqLDqQh4VOTB.dbWEXukgLPnL.F.qarQBARdy19IE.6jbVRwMzScuVc1Iqdc07_n5HYXQGwuX.FtXvyB7PWQMbQF9SvtjqDygUWFLNngCpi6pc96.mJAnGxBQlbBZpalTwSsVr2MRUSnl1pQ_HxVdhD9GDDoO71PSY4xOjIU5a9
Received: from [81.16.153.112] by web27802.mail.ukl.yahoo.com via HTTP; Fri, 04 Sep 2009 14:49:59 GMT
X-Mailer: YahooMailClassic/6.1.2 YahooMailWebService/0.7.338.2
In-Reply-To: <ed88cb980909040744k2fa372fapb7ee457c745b9aa0@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/127736>

Hi Douglas!

http://github.com/sonatype/JGit

The branch will be called mavenizing or so.

Will post this after I got the tests running.

LieGrue,
strub

--- On Fri, 9/4/09, Douglas Campos <douglas@theros.info> wrote:

> From: Douglas Campos <douglas@theros.info>
> Subject: Re: [JGIT] Request for help
> To: "Mark Struberg" <struberg@yahoo.de>
> Cc: "Jonas Fonseca" <jonas.fonseca@gmail.com>, git@vger.kernel.org, "Gabe McArthur" <gabriel.mcarthur@gmail.com>
> Date: Friday, September 4, 2009, 4:44 PM
> On Fri, Sep 4, 2009
> at 9:47 AM, Mark Struberg <struberg@yahoo.de>
> wrote:
> 
> 
> as an old saying tells us: how to climb a mountain? step
> after step! ;)
> 
> 
> 
> I suggest we create a fresh branch based on the Shawns
> current version and add all the features incrementally.
> 
> 
> 
> please point out where this branch will happen, I want to
> give some help too.
> 
> 


      
