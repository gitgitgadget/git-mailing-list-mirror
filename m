From: "Philip Oakley" <philipoakley@iee.org>
Subject: Re: How to mark a complete sub-directory assume-unchanged/skip-worktree?
Date: Fri, 28 Feb 2014 08:38:09 -0000
Organization: OPDS
Message-ID: <96570BB66BDF4E96B2A967CF9E5842A8@PhilipOakley>
References: <3A9AA61FDE124808AA25DE3511CF99F1@PhilipOakley> <CACsJy8DV2uCQbfCP=Mf2qajVAtpTZvKKeCS2H4_o6LA3B96QAA@mail.gmail.com> <DAC4EA00279649D6B3F4DB1B3D662BA6@PhilipOakley> <CACsJy8BJRixFno=Mb-3PGi-+JTq6RO19GdkveGdApdW8G9nKNQ@mail.gmail.com>
Reply-To: "Philip Oakley" <philipoakley@iee.org>
Mime-Version: 1.0
Content-Type: text/plain;
	format=flowed;
	charset="UTF-8";
	reply-type=original
Content-Transfer-Encoding: 7bit
Cc: "Git List" <git@vger.kernel.org>
To: "Duy Nguyen" <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Fri Feb 28 09:38:19 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WJIxT-0007WA-G3
	for gcvg-git-2@plane.gmane.org; Fri, 28 Feb 2014 09:38:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751443AbaB1IiL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 28 Feb 2014 03:38:11 -0500
Received: from out1.ip01ir2.opaltelecom.net ([62.24.128.237]:9021 "EHLO
	out1.ip01ir2.opaltelecom.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751164AbaB1IiK (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 28 Feb 2014 03:38:10 -0500
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: An8ZAG1KEFNZ8YaD/2dsb2JhbABagwY7g1qFPrhOBAEBAgEBgRIXdGkBAYEfAQEUAQQBAQUIAQEZFR4BARUMCwIDBQIBAw4HAwICBSECAhQBBAgSBgcXBhMIAgECAwGFOAcBggcNAxUJqjGZXQ0KhxmBKYsWghaCdTWBFASPMIccjlCFSIMtPA
X-IPAS-Result: An8ZAG1KEFNZ8YaD/2dsb2JhbABagwY7g1qFPrhOBAEBAgEBgRIXdGkBAYEfAQEUAQQBAQUIAQEZFR4BARUMCwIDBQIBAw4HAwICBSECAhQBBAgSBgcXBhMIAgECAwGFOAcBggcNAxUJqjGZXQ0KhxmBKYsWghaCdTWBFASPMIccjlCFSIMtPA
X-IronPort-AV: E=Sophos;i="4.97,560,1389744000"; 
   d="scan'208";a="456667878"
Received: from host-89-241-134-131.as13285.net (HELO PhilipOakley) ([89.241.134.131])
  by out1.ip01ir2.opaltelecom.net with SMTP; 28 Feb 2014 08:38:09 +0000
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2900.5931
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.6157
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/242906>

From: "Duy Nguyen" <pclouds@gmail.com>
> On Fri, Feb 28, 2014 at 6:46 AM, Philip Oakley <philipoakley@iee.org> 
> wrote:
>> Is there a particular bit of code I'd be worth studying for the 
>> partial
>> index example to see how well it might fit my ideas?
>
> My last attempt was
> http://git.661346.n2.nabble.com/PATCH-00-17-Narrow-clone-v3-was-subtree-clone-tt5499879.html
> If you're interested in the index part then see 15/17 and maybe 03/17
> and 04/17. I can try to rebase and publish the series somewhere if you
> want to try it out.
> -- 
> Duy
> --
Thanks for that pointer.  I'll look it out and see how well it matched 
my ideas, and reflect on any differences to pick up learning points 
early!

Philip 
