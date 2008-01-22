From: ab_lists@mac.com
Subject: Re: Using email between 2 developers to keep git repositories in sync
Date: Tue, 22 Jan 2008 16:05:24 +0100
Message-ID: <4F8D70B2-B264-46FF-BFBB-01AEF42DD888@mac.com>
References: <7A02F7D1-9EB0-43AB-96F9-DDD71D4EF5FE@mac.com> <alpine.LSU.1.00.0801221255530.5731@racer.site> <m3k5m2klmh.fsf@roke.D-201> <30e4a070801220635q4978fd2fvc469ca00af4e11cc@mail.gmail.com>
Mime-Version: 1.0 (Apple Message framework v915)
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Mark Levedahl <mlevedahl@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jan 22 16:06:54 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JHKhV-0004pj-RX
	for gcvg-git-2@gmane.org; Tue, 22 Jan 2008 16:06:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754058AbYAVPFe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 22 Jan 2008 10:05:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753394AbYAVPFe
	(ORCPT <rfc822;git-outgoing>); Tue, 22 Jan 2008 10:05:34 -0500
Received: from smtpoutm.mac.com ([17.148.16.72]:62536 "EHLO smtpoutm.mac.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753876AbYAVPFd (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 22 Jan 2008 10:05:33 -0500
Received: from mac.com (asmtp008-s [10.150.69.71])
	by smtpoutm.mac.com (Xserve/smtpout009/MantshX 4.0) with ESMTP id m0MF5WGr007185;
	Tue, 22 Jan 2008 07:05:32 -0800 (PST)
Received: from [192.168.42.85] ([80.71.54.130])
	(authenticated bits=0)
	by mac.com (Xserve/asmtp008/MantshX 4.0) with ESMTP id m0MF5QlM006773
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NO);
	Tue, 22 Jan 2008 07:05:29 -0800 (PST)
In-Reply-To: <30e4a070801220635q4978fd2fvc469ca00af4e11cc@mail.gmail.com>
X-Mailer: Apple Mail (2.915)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/71454>

Thank you all for your feedback!

So would it be wise to synchronise the repositories over time using  
the bundles and despite having exchanged email patches or should they  
be used separately?

Thank you again!
Annard

On 22 Jan 2008, at 15:35, Mark Levedahl wrote:

> On Jan 22, 2008 8:53 AM, Jakub Narebski <jnareb@gmail.com> wrote:
>>
>> Besides, after initial setup IMHO it is much better to exchange
>> patches for review. Although usually there are more than two
>> developers in such case...
>>
> Bundles allow you to maintain identical history on two or more
> disconnected servers, and this is a very distinct advantage over
> patches. Absent use of bundles to distribute the integrated changes,
> the development history seen by both parties will diverge.
>
> Mark
