From: Raman Gupta <rocketraman@fastmail.fm>
Subject: Re: [PATCHv3] Add branch management for releases to gitworkflows
Date: Sat, 14 Nov 2009 12:27:30 -0500
Message-ID: <4AFEE882.4030208@fastmail.fm>
References: <1258055164-11876-1-git-send-email-rocketraman@fastmail.fm>	<1258055164-11876-2-git-send-email-rocketraman@fastmail.fm>	<20091114071946.6117@nanako3.lavabit.com>	<4AFDE421.5050307@fastmail.fm>	<20091114081040.6117@nanako3.lavabit.com>	<4AFE41AF.8050802@fastmail.fm> <20091114180123.6117@nanako3.lavabit.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, trast@student.ethz.ch, gitster@pobox.com
To: Nanako Shiraishi <nanako3@lavabit.com>
X-From: git-owner@vger.kernel.org Sat Nov 14 18:27:45 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N9MPY-0004n5-3T
	for gcvg-git-2@lo.gmane.org; Sat, 14 Nov 2009 18:27:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755604AbZKNR1c (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 14 Nov 2009 12:27:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755596AbZKNR1c
	(ORCPT <rfc822;git-outgoing>); Sat, 14 Nov 2009 12:27:32 -0500
Received: from smtp126.rog.mail.re2.yahoo.com ([206.190.53.31]:48967 "HELO
	smtp126.rog.mail.re2.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1755582AbZKNR1c (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 14 Nov 2009 12:27:32 -0500
Received: (qmail 20773 invoked from network); 14 Nov 2009 17:27:37 -0000
Received: from CPE000db9166236-CM00186845d2ae.cpe.net.cable.rogers.com (rocketraman@99.224.155.40 with login)
        by smtp126.rog.mail.re2.yahoo.com with SMTP; 14 Nov 2009 09:27:37 -0800 PST
X-Yahoo-SMTP: 5CKRlKeswBAtrcX.EVB04BFKSgZiN0yKOK0iylIm064Zdzo-
X-YMail-OSG: 5bBeXS0VM1kH5gXyJNLvzzA.pi7n9EE1CMV5rU9o.Uq7AK8I9OBE.GO_qKfqpmAAeA--
X-Yahoo-Newman-Property: ymail-3
Received: from localhost (localhost.localdomain [127.0.0.1])
	by apollo.rocketraman.com (Postfix) with ESMTP id B34B521C05CC;
	Sat, 14 Nov 2009 12:27:36 -0500 (EST)
X-Virus-Scanned: amavisd-new at rocketraman.com
Received: from apollo.rocketraman.com ([127.0.0.1])
	by localhost (apollo.rocketraman.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id K8PWag2vmhEn; Sat, 14 Nov 2009 12:27:30 -0500 (EST)
Received: from [192.168.1.5] (zeus.rocketraman.com [192.168.1.5])
	by apollo.rocketraman.com (Postfix) with ESMTP id 7AFD421C05CB;
	Sat, 14 Nov 2009 12:27:30 -0500 (EST)
User-Agent: Thunderbird 2.0.0.23 (X11/20090825)
In-Reply-To: <20091114180123.6117@nanako3.lavabit.com>
X-Enigmail-Version: 0.95.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/132877>

Nanako Shiraishi wrote:
> Quoting Raman Gupta <rocketraman@fastmail.fm>
> 
>> Ok, another dumb question: since you have now submitted a patch on top
>> of my patch, what is the proper etiquette for proceeding? Who
>> maintains this patch series until it is committed? Since your patch
>> applies on top of mine I can't really make any more changes without
>> affecting your patch right? I can't find any guidance in the
>> SubmittingPatches document.
> 
> What usually happens is that we wait now.
> 
> In this case we are in agreement that it is a good idea to apply 
> both of our patches (mine was only repeating what Junio said in 
> his comments), so if I were you, I would anticipate that Junio 
> would apply both of them and start preparing incremental updates 
> on top of them now, and send them when the patches appear in his 
> 'pu' branch.
> 
> Junio has gone quiet for the past few days; maybe he is too busy
> to read or respond to either of our patch. Instead of preparing 
> the final text you write in the document in a patch format, it 
> may be a better to bring up your ideas here and discuss them 
> first. What changes do you have in mind? I think the new section 
> now already is in a reasonable shape.

No specific changes -- it was a hypothetical question...

Cheers,
Raman
